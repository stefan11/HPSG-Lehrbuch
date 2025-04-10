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
            rhandle:RH,
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
%  dtrs:[phon:ne_list,phon:ne_list].

% Ohne diese Einschränkung könnten zwei V1-Verben koordiniert werden, es sollen aber erst die
% Verbletztverben koordiniert werden und dann die V1-Regel angewendet werden. Würde man das nicht
% machen, käme eine nicht wohlgeformte MRS heraus, denn die hooks der beiden Verben würden
% identifiziert, weil die CAT-Werte identifiziert werden und in denen ist der DSL drin und damit
% auch CONT.
(head_complement_phrase,
 dtrs:hd:loc:cat:head:coord) *> dtrs:tl:hd: @not(verb_initial_rule).


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
