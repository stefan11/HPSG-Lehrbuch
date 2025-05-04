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

% Koordination von verbalen Projektionen

conj_word *>
    loc:(cat:(head:(coord,
                    spec:loc:(cat:Cat,
                              cont:(ltop:LH,
                                    ind:LI))),
              spr:[],
              arg_st:[(loc:(cat:Cat,
                            cont:(ltop:RH,
                                  ind:RI)),
                       trace:minus)]),
         cont:rels:[(lhandle:LH,
                     rhandle:(RH,
                              =\=LH), % Wenn zwei Verben zu V1-Verben werden, haben sie LBL und IND
                                % innerhalb ihrer DSL-Werte. Bei der Koordinatoin werden diese
                                % identifiziert. Der Dominanzgraph ist dann nciht wohlgeformt. Man
                                % kann die Analyse schon hier durch eine Ungleichheitsbedingung
                                % ausschließen. Hätte man den KEY in CONT, würden die beiden KEYs
                                % nicht kompatibel sein. Ausnahme: Schläft und schläft Aicke? Für
                                % diesen Fall hilft nur die Ungleichheitsbedingung.
                     lindex:LI,
                     rindex:RI)]).

conj_word(Relation) :=
  (conj_word,
   loc:cont:rels:hd:Relation).

und ---> @conj_word(und_rel).

coord_phrase *>
  dtrs:[(phon:ne_list,
         trace:minus),
        trace:minus].

x_conj_y_coord_phrase :=
  (coord_phrase,
   loc:(cat:Cat,
        cont:(ltop:LTop,
              ind:Ind)),
   dtrs:[(Spec,
          loc:cat:Cat),
         (loc:(cat:(head:(coord,
                          spec:Spec),
                    comps:[]),
               cont:(ltop:LTop,
                     ind:Ind)))]).

x_conj_y rule (@x_conj_y_coord_phrase,
                  dtrs:[Dtr1,Dtr2])
  ===>
cat> Dtr1,
cat> Dtr2.
