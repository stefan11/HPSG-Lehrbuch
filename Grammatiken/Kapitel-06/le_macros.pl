% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: le_macros.pl,v $
%%  $Revision: 1.4 $
%%      $Date: 2007/03/05 11:26:29 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile ':='/2.
:- discontiguous ':='/2.

:- multifile '*>'/2.
:- discontiguous '*>'/2.


saturated_word *>
 cat:arg_st:[].

% Für Artikelwörter und das Possessivpronomen.  Die RELS-Liste ist offen, so dass entweder nur die
% Information über einen Quantor darin enthalten sein kann oder aber noch weitere Relationen. Damit
% wird Beschreibung von Determinatoren und Possessivpronomen möglich.
determiner_word *>
 (%saturated_word Diese Information steht in der signatur
  cat:head:(det,
            spec:cont:(ind:Ind,
                       ltop:NLTop)),
  cont:(rels:hd:(% eine Relation eines Quantors z.B. exists_q
                 arg0:Ind,
                 rstr:Restr),
        hcons:[(qeq,
                harg:Restr,
                larg:NLTop)])).


determiner(Case,Numerus,Genus) :=
(%determiner_word,
 cat:head:(case:Case,
           num:Numerus,
           gen:Genus)).

% Genau ein Element in der RELS- und HCONS-Liste.
% Ließe sich mit rels:tl:e_liste effizienter aufschreiben. Aber weniger lesbar.
determiner *> 
 (%determiner_word
  cont:rels:[_]).

det(Case,Numerus,Genus,Quant) :=
(@determiner(Case,Numerus,Genus),
 determiner,
 cont:rels:hd:Quant).

possessive *>
 (%determiner_word
  cat:head:spec:cont:(ind:Ind2,
                      ltop:NLTop),
  cont:(ind:Ind,
%        ltop:LTop,
        rels:[_,         % Die erste Relation kommt vom Obertyp.
              (poss_rel,
               lbl:NLTop,
               arg0:event,
               arg1:Ind,
               arg2:Ind2)])).

possessive(Case,NNumerus,NGenus,Person,Numerus,Genus) :=
 (@determiner(Case,NNumerus,NGenus),
  possessive,
  cont:ind:(per:Person,
            num:Numerus,
            gen:Genus)).


% Die folgenden XP-Makros werden als Abkürzung in Valenzrahmen
% verwendet.

xp :=
  (cat:(spr:[],
        comps:[])).

% kennen, helfen, denken an
xp(Ind) :=
  (@xp,
   cont:ind:Ind).

np :=
  (@xp,
   cat:head:noun).

np(Ind) :=
  (@np,
   cont:ind:Ind).

np(Case,Ind) :=
  (@np(Ind),
   cat:head:case:Case).

nbar(Ind) :=
  (cat:(head:noun,
        spr:[_],
        comps:[]),
   cont:ind:Ind).

pp :=
  (@xp,
   cat:head:prep).

pp(Ind) :=
  (@pp,
   cat:head:prep,
   cont:ind:Ind).

pp(PForm,Case) :=
  (@pp,
   cat:head:(pform:PForm,
             case:Case)).


non_scopal_le *>
  cont:hcons:[].

% expletives and markers
non_relational_le *>
  cont:rels:[].

% complement prepositions and some complementizers.
transparent_head_le *>
 (cat:arg_st:[cont:(ind:Ind,
                    ltop:LTop) ],
  cont:(ind:Ind,
        ltop:LTop)).


arg0_le *>
  cont:(ind:Ind,
        rels:hd:arg0:Ind).

ltop_lbl_le *>
  cont:(ltop:Lbl,
        rels:hd:lbl:Lbl).

% alle Nomina
noun_word *>
 (%word
  cat:head:noun).

% Nomen mit Determinator
det_noun_word *>
(%noun_word,
  %non_scopal_le
  %relational_arg0_word,  % enthält auch lbl:LTop
  cat:(head:case:Case,
       spr:[_],
       % Das erste Element der ARG-ST-Liste ist der Determinator.
       arg_st:hd:cat:(head:(det,
                            case:Case,
                            num:Numerus,
                            gen:Genus),
                      spr:[],
                      comps:[])),
  cont:ind:(% Der Typ index folgt aus der Anwesneheit der Merkmale per, num, gen
            per:third,
            num:Numerus,
            gen:Genus) ).
 

% alle einfachen Nomina (ohne Argument)
simple_noun *>
 (%det_noun_word,
  cat:arg_st:tl:e_list ).

noun(Case,Genus,Numerus,Relation) :=
 (simple_noun,
  cat:head:case:Case,
  cont:(ind:(num:Numerus,
             gen:Genus),
        rels:[Relation])).


relational_noun *>
 (%det_noun_word
  cat:arg_st:tl:[(cat:(head:(noun,
                             case:gen),
                       spr:[],
                       comps:[]),
                  cont:ind:Ind2) ],
  cont:rels:hd:arg2:Ind2).


relational_noun(Case,Genus,Numerus,Relation) :=
 (relational_noun,
  cat:head:case:Case,
  cont:(ind:(num:Numerus,
             gen:Genus),
        rels:[Relation])).


/*
pers_pronoun *>
 (%noun_word,
  %saturated_word
  cont:ind:ref).
*/

pers_pronoun(Case,Person,Numerus,Genus) :=
 (pers_pronoun,
  cat:head:case:Case,
  cont:ind:(per:Person,
            num:Numerus,
            gen:Genus)).

proper_noun *>
 (%noun_word,
  %saturated_word
  cont:(ind:Ind,
        rels:[(proper_q,
               arg0:Ind,
               rstr:Restr),(named_rel,
                            lbl:NamedRel,
                            arg0:Ind)],
        hcons:[(qeq,
                harg:Restr,
                larg:NamedRel)])).


proper_noun(Genus,Name) :=
 (proper_noun,
  cont:(ind:gen:Genus,
        rels:tl:hd:name:(a_ Name))).


verb_word *>
 (%word,
  %arg0_ltop_lbl_le
  cat:(head:(verb,
             vform:fin),
       spr:[]),
  cont:ind:event).


intrans_verb *>
 (%verb_word,
  cat:arg_st:hd: @np(nom,Ind),
  cont:rels:[arg1:Ind]).

strict_intrans_verb *>
 (%non_scopal_intrans_verb
  cat:arg_st:[_]).

intrans_verb(Relation) :=
 (strict_intrans_verb,
  cont:rels:hd:Relation).

np_pp_verb *> 
 (%non_scopal_intrans_verb,
  %bi_or_more_val_verb, 
  cat:arg_st:tl:[ @pp ]).

np_pp_verb(PForm,Case,Relation) :=
 (np_pp_verb,
  cat:arg_st:tl:hd: @pp(PForm,Case),
  cont:rels:hd:Relation).


subjlos_verb *>
 (%non_scopal_verb_word,
  cat:arg_st:[ @np(Ind) ],
  cont:rels:hd:arg2:Ind).

subjlos_verb(Case,Relation) :=
 (subjlos_verb,
  cat:arg_st:[ @np(Case,_Ind) ],
  cont:rels:hd:Relation).

% kennen, helfen verbs with at least two arguments and a nominative
bi_or_more_val_verb *>
 (%non_scopal_verb_word,
  cat:arg_st:[ @np(nom,Ind1), @xp(Ind2) |_ ],
  cont:rels:hd:(arg1:Ind1,
                arg2:Ind2)).

% kennen
strict_trans_verb *>
 (%trans_verb = bi_or_more_val_verb
  cat:arg_st:[ _, @np(acc,_) ]).

trans_verb(Relation) :=
 (strict_trans_verb,
  cont:rels:hd:Relation).

ditrans_verb *>
 (%trans_verb = bi_or_more_val_verb
  cat:arg_st:[ _, @np(dat,_), @np(acc,Ind3) ],
  cont:rels:hd:arg3:Ind3).

ditrans_verb(Relation) :=
 (ditrans_verb,
  cont:rels:hd:Relation).

glauben_denken_verb *>
 (%intrans_verb,
  cat:arg_st:[ _,
               (cat:(head:(comp,
                           cform:dass),
                      spr:[],
                      comps:[]),
                 cont:ltop:Larg) ],
  cont:(rels:[arg2:Harg],
        hcons:[(qeq,
                harg:Harg,
                larg:Larg)])).


glauben_denken_verb(Relation) :=
 (glauben_denken_verb,
  cont:rels:hd:Relation).

preposition_word *>
(%word,
 %non_scopal_le
 cat:(head:prep,
      spr:[],
      arg_st:[ @np ] )).

comp_preposition *>
 (%preposition_word,
  %transparent_head_le % Shares IND and LTOP with argument.
  cat:(head:case:Case,
       arg_st:[cat:head:case:Case])).

comp_prep(PForm) :=
 (comp_preposition,
  cat:head:pform:PForm).


n_modifier *>
(cat:head:mod: @nbar(Ind),
 cont:ind:Ind).

 
isect_modifier_le *>
(%sign,
 cat:head:scopal:minus).

/* 
n_modifier_word *>
 (%n_modifier,
  %relational_word,
  cat:(head:mod:cont:qstore:[Q],
       arg_st:Arg_st),
  cont:qstore:[Q|collectQStores(Arg_st)]).
*/
 
attr_adjective_word *>
 (%n_modifier_word,
  cat:(head:attr_adj,
       spr:[])).

% klug
simple_attr_adj *>
 (%intersective_adj
  cat:arg_st:[],
  cont:(ind:Ind,
        rels:[arg1:Ind])).

attr_adj(Relation) :=
 (simple_attr_adj,
  cont:rels:hd:Relation).

% treu
attr_np_adj *>
 (%intersective_adj
  cat:arg_st:[@np(Ind2)],
  cont:(ind:Ind,
        rels:hd:(arg1:Ind,
                 arg2:Ind2))).

attr_adj_np(Relation,Case) :=
 (attr_np_adj,
  cat:arg_st:[@np(Case,_Ind2)],
  cont:rels:hd:Relation).


scopal_modifier_le *>
  (%ltop_lbl_le
   cat:head:(mod:cont:ltop:VLTop,
             scopal:plus),
   cont:(ltop:LTop,
         rels:[(lbl:LTop,
                arg1:Arg1)],
         hcons:[(qeq,
                 harg:Arg1,
                 larg:VLTop)])).

% mutmaßlich
scopal_adj *>
 (%saturated_word
  %attr_adjective_word
  %scopal_modifier_le
  cat:head:mod:cont:ind:Ind,
  cont:ind:Ind).

scopal_attr_adj(Relation) :=
 (scopal_adj,
  cont:rels:[Relation]).

v_modifier *>
 cat:head:mod:cat:head:adj_or_verb.

adv_word *>
 cat:head:adv.

% wahrscheinlich
scopal_adv(Relation) :=
 (scopal_adv_word,
  cont:rels:[Relation]).   


mod_preposition *>
 (%preposition_word,
  cat:head:mod_prep).

noun_mod_preposition *>
 (%mod_preposition
  %isect_n_modifier_word
  cat:(head:mod:cont:ind:Ind,
       arg_st:[ @np(Ind2) ] ),
  cont:(ind:Ind,
        rels:[(arg1:Ind,
               arg2:Ind2)])).

location_noun_mod_prep *>
 (%noun_mod_preposition
  cat:arg_st:[ @np(dat,_) ] ).

location_noun_mod_prep(Relation) :=
 (location_noun_mod_prep,
  cont:rels:hd:Relation).


complementizer(CForm) :=
 (word,
  cat:(head:(comp,
             cform:CForm),
       spr:[],
       arg_st:[(cat:(head:(verb,
                           vform:fin),
                     spr:[],
                     comps:[]),
                cont:(ltop:LTop,
                      ind:Ind)) ] ),
   cont:(ltop:LTop,
         ind:Ind,
         rels:[],
         hcons:[])).



