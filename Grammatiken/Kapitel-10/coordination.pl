% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexrules.pl,v $
%%  $Revision: 1.4 $
%%      $Date: 2005/03/03 15:11:24 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile '--->'/2.
:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile rule/2.
:- multifile '*>'/2.
:- discontiguous '*>'/2.
:- multifile if/2.
:- multifile fun/1.

% Koordination von verbalen Projektionen

conj_word *>
   (%relational_arg0_word,
    %nö non_scopal_le,
    %overt_word,
    %empty_rel_word
    loc:(cat:(head:(coord,
                    spec:(loc:(cat:Cat,
                               cont:(ltop:LHandle,
                                     ind:LInd)),
                          nonloc:Nonloc)),
              spr:[],
              arg_st:[(loc:(cat:Cat,
                            cont:(ltop:(RHandle,
                                        =\=LHandle), % ohne das loopt Ein Affe nimmt einen Stock und ein Affe lacht.
                                  ind:RInd)),
                       nonloc:Nonloc,
                       trace:minus)]),
         cont:Cont),
     rels:coord_sem(LInd,RInd,LHandle,RHandle,Cont,HCons),
     hcons:HCons).


/*
rels:[(lhandle:LH,
            rhandle:(RH,
                     =\=LH),  % Wenn zwei Verben zu V1-Verben werden, haben sie LBL und IND
                              % innerhalb ihrer DSL-Werte. Bei der Koordinatoin werden diese
                              % identifiziert. Der Dominanzgraph ist dann nciht wohlgeformt. Man
                              % kann die Analyse schon hier durch eine Ungleichheitsbedingung
                              % ausschließen. Hätte man den KEY in CONT, würden die beiden KEYs
                              % nicht kompatibel sein. Ausnahme: Schläft und schläft Aicke? Für
                              % diesen Fall hilft nur die Ungleichheitsbedingung.
            lindex:LI,
            rindex:RI)]).

*/

fun coord_sem(+,+,+,+,+,-,+).
%coord_sem(Ind1,Ind2,LHandle,RHandle,Cont,Rels,HCons)

coord_sem(Ind1,Ind2,LHandle,RHandle,Cont,Rels,HCons) if
  when((Ind1=(index;event),
        Ind2=(index;event))
      ,undelayed_coord_sem(Ind1,Ind2,LHandle,RHandle,Cont,Rels,HCons)).


% What about scope of the quantifiers in the coordinated NP?
%
% Alle Studenten lesen ein Buch und eine Zeitung.
%
% exists x buch(x) exists y Zeitung(y) alle studenten lesen x+y.
%
% exists x buch(x) alle studenten exists y Zeitung(y) lesen x+y.

% The nominal case with `and' we get a plural Index
undelayed_coord_sem(Ind1,(index,
                          Ind2),_LHandle,_RHandle,
          (ind:Ind0,
           ltop:ConjHandle),
         [(%und_rel
           lbl:ConjHandle,
           arg0:(Ind0,
                 per:third,
                 num:pl),
           lindex:Ind1,
           rindex:Ind2
% In the case of nouns, it is not the handle of the noun that is plugged in here.          
%           ,l_handle:LHandle,
%           r_handle:RHandle
          ),
          (udef_q,        
           lbl:_QHandle,
           arg0:Ind0,
           rstr:Restr)          
          ],

         [(qeq,
           harg:Restr,
           larg:ConjHandle)]) if true.

undelayed_coord_sem(Ind1,(event,
                          Ind2),LHandle,RHandle,
          (ind:Ind0,
           ltop:ConjHandle),
         [(%und_rel,
           lbl:ConjHandle,
           arg0:(Ind0,
                 event),
           lindex:Ind1,
           rindex:Ind2,
           lhandle:LHandle,
           rhandle:RHandle)
          ],
         []) if true.



conj_word(Relation) :=
  (conj_word,
   rels:hd:Relation).

und ---> @conj_word(und_rel).

coord_phrase *>
  dtrs:[(phon:ne_list,
         trace:minus),
        trace:minus].

% Unklar warum bei EFD-Berechnungt 4 x conj y phrasen lizenziert werden.
%coord_phrase *>
%  non_head_dtrs:[phon:ne_list,phon:ne_list].

% Ohne diese Einschränkung könnten zwei V1-Verben koordiniert werden, es sollen aber erst die
% Verbletztverben koordiniert werden und dann die V1-Regel angewendet werden. Würde man das nicht
% machen, käme eine nicht wohlgeformte MRS heraus, denn die hooks der beiden Verben würden
% identifiziert, weil die CAT-Werte identifiziert werden und in denen ist der DSL drin und damit
% auch CONT.
(head_complement_phrase,
 dtrs:hd:loc:cat:head:coord) *> dtrs:tl:hd: @not(verb_initial_rule).

%coord_phrase *> dtrs:hd: @not(verb_initial_rule).

coord_phrase *>
  (coord_phrase,
   loc:(cat:Cat,
        cont:Cont),
   nonloc:Nonloc,
   dtrs:[(Spec,
          loc:cat:Cat,
          nonloc:Nonloc),
         (loc:(cat:(head:(coord,
                          spec:Spec),
                    comps:[]),
               cont:Cont))]).

x_conj_y rule (coord_phrase,
                  dtrs:[Dtr1,Dtr2])
  ===>
cat> Dtr1,
cat> Dtr2.
