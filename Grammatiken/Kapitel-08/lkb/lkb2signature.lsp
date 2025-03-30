;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; $Id: lkb2signature.lsp,v 1.2 2006/03/10 14:41:01 stefan Exp $
;
; Author: Detmar Meurers, dm@ling.osu.edu
; Purpose: This file contains some utilities for working with lkb, in
;          particular (print_signature type) a function which takes a
;          type (and assumes an lkb grammar has been compiled) and
;          extracts a signature in the controll/trale format. It does
;          some cleaning up of the signature, which is needed since
;          the lkb signature compiler is suboptimal when it introduces
;          glbtypes; see "Note on output_old_type and output_new_type"
;          below. Finally, in order to be sure the output is
;          well-formed prolog, we quote all feature and type names
;          (alternatively, one could parse the names and transform
;          them into atoms (e.g. map - to _, etc.)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; 03.06.2007 replaced type-local-constraint with ltype-local-constraint
;; The code now works with the most recent versions of the LKB. St. Mü.


; Top level predicate:  (print_signature  type)
;
; For a given type print the type hierarchy below that type including
; all appropriateness conditions in the controll/trale signature format

(defvar already-output)
(defvar subtyping-hash)


(defun print_signature (type)
  (if (is-valid-type type)
      (progn  (format t "type_hierarchy~%")
	      (setq already-output nil)
	      (setq subtyping-hash (make-hash-table))
	      (print_signature_aux nil type 0)
	      (format t ".~&")
	      t)
      (error "~%~A is not a valid type" type)))


; (print_signature_aux  supertype type depth)
;
; - already-output is the list of types already output, i.e.  if it
;   occurrs again, it is an instance of multiple inheritance.
; - depth is the embedding depth in the hierarchy

(defun print_signature_aux (supertype type depth)
  (if (member type already-output)
      ;;  output this multiply inheriting type
      (output_old_type supertype type depth)
    (progn 
      ;;  output this type and its appropriate attributes/values
      (output_new_type supertype type depth 
		       (let ((local-fs 
			      (ltype-local-constraint 
			       (get-type-entry type)))) 
			 (when local-fs 
			     (dag-arcs local-fs))))
      ;;  take care of the subtypes:
      (dolist (subtype (retrieve-daughters type))
	(print_signature_aux type subtype (+ depth 1))))))



; Note on output_old_type and output_new_type: The lkb signature
; compiler introduces glb types in a way that additionally specifies
; the subtypes of the gbltype as sisters of the glbtype - which defies
; the purpose of creating a unique glb. We use a hash to store the
; ancestors of a type we've already output, so when we get to the same
; type again, we check whether in the current output attempt the
; supertype is part of the hashed ancestors.

; output_old_type: multiple inheritance -> only type output
(defun output_old_type (supertype type depth)
;; Don't output again if this type was aleady output as a descendant
;; of this supertype :
  (unless (member supertype (gethash type subtyping-hash))
    (write_spaces depth)
    (format t "&~(~A~)~%" type)))

; output_new_type -> type feature:tvalue ... output
(defun output_new_type (supertype type depth feat-val-pairs)
;; keep record of all types output so far
  (setq already-output (cons type already-output))
;; keep record of ancestors of all types output so far
  (setf (gethash type subtyping-hash) 
	(cons type (gethash supertype subtyping-hash)))
;; create the output
  (write_spaces depth)			; indentation spaces (meaningful!)
  (format t "~(~A~)" type)		; type name
  (mapcar #'(lambda (fv) (output_feat_val_pair type fv))  feat-val-pairs)
  (terpri))				; newline

; auxiliary output function
(defun write_spaces (n)
  (do ((i 0 (+ i 1))) ((= i n)) (write "  " :escape nil)))
 
; deal with output of feature:value pairs 
(defun output_feat_val_pair (type feat-val-pair)
  (let* ((feat (car feat-val-pair))
	 (val (cdr feat-val-pair))
	 (tval (type-of-fs val)))
    (unless (some (lambda (supertype) 
		    (supertype_has_more_specific_value supertype feat tval))
		  (retrieve-ancestors type))
      ;; added the following line to get propper output for strings
      ;; St.Mü. 09.03.2006
      (when (equal tval 'string)
        (setq tval "(a_ _)"))
      (format t " ~(~A~):~(~A~)" feat tval))))

;
; (supertype_has_more_specific_value type-record feat tval)
;
; The function supertype_has_more_specific_value is nil iff
; a) supertype introduces no new features, or
; b) the feature we're looking for is not among the introduced features, or
; c) the input feature value tval is a subtype of that of the
;    supertype for that feature
; else, it returns the value of that feature appropriate for the ancestor

; Note that we're not using (appropriate-features-of typename) here
; since that alwyas lists all appropriate features, not just the ones
; that are introduced at this type. We instead make use of
; (ltype-local-constraint type-record) to pick out what is locally defined.

(defun supertype_has_more_specific_value (type-record feat tval)
  (let ((loc-constr (ltype-local-constraint type-record)))
    ;; a) get the local constraint of the supertype, if any
    (when loc-constr
      (let ((dag-value (get-dag-value loc-constr feat)))
	;; b) get the value of feat, if any
	(when dag-value
	      (let ((ancestor-feat-val (type-of-fs dag-value)))
		;; c) unless tval is subtype of ancestor-feat-val
		(unless (subtype-p tval ancestor-feat-val)
		  ancestor-feat-val)))))))    



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Some other useful top-level functions (independent of code above):
;;;    (print_non_common_subtypes type1 type2)
;;;    (print_common_subtypes type1 type2)


; get_non_common_subtypes returns the list of all subtypes of <type1>
; which are not a subtype of <type2>

(defun print_non_common_subtypes  (type1 type2)
  (mapcar #'print_typelist (sort (get_non_common_subtypes type1 type2) #'string-lessp))
  t)

(defun print_typelist (element)
  (format t "~(~s~)~%" element))


(defun get_non_common_subtypes  (type1 type2)
  (get_ncommon_subtypes (retrieve-descendants type1)
                        (cons (get-type-entry type2) 
                              (retrieve-descendants type2))))

(defun get_ncommon_subtypes (tlist1 tlist2)
  (if tlist1
      (if (or (ltype-glbp (car tlist1))
              (member (car tlist1) tlist2 :test #'equal))
	  (get_ncommon_subtypes (cdr tlist1) tlist2)
	  (cons (string (ltype-name (car tlist1))) (get_ncommon_subtypes (cdr tlist1) tlist2)))))


; iterative version for the other way around: get_common_subtypes

(defun print_common_subtypes  (type1 type2)
  (mapcar #'print_typelist (sort (get_common_subtypes type1 type2) #'string-lessp))
  t)

(defun get_common_subtypes  (type1 type2)
  (get_common_subtypes_aux (retrieve-descendants type1)
                           (retrieve-descendants type2)))


(defun get_common_subtypes_aux (tlist1 tlist2)
  (let ((returnlist nil))
    (dolist (each tlist1)
      (when (and (not (ltype-glbp each))
                 (member each tlist2 :test #'equal))
	(push (string (ltype-name each)) returnlist)))
    returnlist))

