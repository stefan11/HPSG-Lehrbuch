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
    %relational_arg0_word,
    %nö non_scopal_le,
    loc:(cat:(head:(coord,
                    spec:loc:(cat:Cat,
                              cont:(ltop:LHandle,
                                    ind:LInd))),
              spr:[],
              arg_st:[(loc:(cat:(Cat,
                                 head:dsl:none),  % auskommentieren bei zyklischer Verbspur.
                            cont:(ltop:RHandle, 
                             % =\=LH\), % Nicht mehr nötig
                                % Wenn zwei Verben zu V1-Verben werden, haben sie LBL und IND
                                % innerhalb ihrer DSL-Werte. Bei der Koordinatoin werden diese
                                % identifiziert. Der Dominanzgraph ist dann nicht wohlgeformt. Man
                                % kann die Analyse schon hier durch eine Ungleichheitsbedingung
                                % ausschließen. Hätte man den KEY in CONT, würden die beiden KEYs
                                % nicht kompatibel sein. Ausnahme: Schläft und schläft Aicke? Für
                                % diesen Fall hilft nur die Ungleichheitsbedingung.
                                  ind:RInd)),
                       trace:minus)]),
         cont:(rels:coord_sem(LInd,RInd,LHandle,RHandle,HCons),
               hcons:HCons)).


fun coord_sem(+,+,+,+,-,+).
%coord_sem(Ind1,Ind2,LHandle,RHandle,Ind,LTop,Rels,HCons)

coord_sem(Ind1,Ind2,LHandle,RHandle,Rels,HCons) if
  when((Ind1=(index;event),
        Ind2=(index;event))
      ,undelayed_coord_sem(Ind1,Ind2,LHandle,RHandle,Rels,HCons)).


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

% koordinierte Ereignisse
undelayed_coord_sem(Ind1,(event,
                          Ind2),LHandle,RHandle,
         [(%und_rel,
           %lbl:ConjHandle, % Label und Index werden durch conj_word über Vererbung geteilt.
           arg0:(%Ind0,
                 event),
           lindex:Ind1,
           rindex:Ind2,
           lhandle:LHandle,
           rhandle:RHandle)
          ],
         []) if true.


conj_word(Relation) :=
  (conj_word,
   loc:cont:rels:hd:Relation).

und ---> @conj_word(und_rel).

coord_phrase *>
  dtrs:[(phon:ne_list,
         trace:minus),
        trace:minus].

coord_phrase *>
  (loc:(cat:Cat,
        cont:(ltop:LTop,
              ind:Ind)),
   dtrs:[(Spec,
          loc:cat:Cat),
         (loc:(cat:(head:(coord,
                          spec:Spec),
                    comps:[]),
               cont:(ltop:LTop,
                     ind:Ind)))]).

x_conj_y rule (coord_phrase,
                  dtrs:[Dtr1,Dtr2])
  ===>
cat> Dtr1,
cat> Dtr2.
