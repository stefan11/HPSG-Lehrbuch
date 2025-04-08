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
   (loc:cat:(head:(coord,
                   spec:(loc:(cat:Cat,
                              cont:(ltop:LH,
                                    ind:LI)),
                         nonloc:Nonloc)),
             spr:[],
             arg_st:[(loc:(cat:Cat,
                           cont:(ltop:RH,
                                 ind:RI)),
                      nonloc:Nonloc,
                      trace:minus)]),
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


x_conj_y_coord_phrase :=
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

x_conj_y rule (@x_conj_y_coord_phrase,
                  dtrs:[Dtr1,Dtr2])
  ===>
cat> Dtr1,
cat> Dtr2.
