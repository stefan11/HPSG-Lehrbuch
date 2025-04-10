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
                     rhandle:RH,
                     lindex:LI,
                     rindex:RI)]).

conj_word(Relation) :=
  (conj_word,
   loc:cont:rels:hd:Relation).

und ---> @conj_word(und_rel).

% spped und Regelberechnung
coord_phrase *>
  dtrs:[(phon:ne_list,
         trace:minus),
        trace:minus].

% Ohne diese Einschränkung könnten zwei V1-Verben koordiniert werden, es sollen aber erst die
% Verbletztverben koordiniert werden und dann die V1-Regel angewendet werden. Würde man das nicht
% machen, käme eine nicht wohlgeformte MRS heraus, denn die hooks der beiden Verben würden
% identifiziert, weil die CAT-Werte identifiziert werden und in denen ist der DSL drin und damit
% auch CONT.
(head_complement_phrase,
 dtrs:hd:loc:cat:head:coord) *> dtrs:tl:hd: @not(verb_initial_rule).


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
