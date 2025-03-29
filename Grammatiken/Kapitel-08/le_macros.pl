% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: le_macros.pl,v $
%%  $Revision: 1.22 $
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



sc_saturated_word *>
  loc:cat:subcat:[].

spr_saturated_sign *>
  loc:cat:spr:[].


determiner_word *>
 (%saturated_word Diese Information steht in der signatur
  loc:cat:head:det).

determiner(Case,Numerus,Genus) :=
(%determiner_word,
 loc:cat:head:(case:Case,
               num:Numerus,
               gen:Genus)).


determiner *> 
 (%determiner_word
  loc:(cat:head:spec:loc:cont:nucleus:Cont,
       cont:(nucleus:(Quant,
                      restind:Cont),
             qstore:[Quant]))).

det(Case,Numerus,Genus,Quant) :=
(@determiner(Case,Numerus,Genus),
 determiner,
 loc:cont:nucleus:Quant).

possessive *>
 (%determiner_word
  loc:(cat:head:spec:loc:cont:nucleus:(ind:NInd,
                                       restr:NRestr),
       cont:(nucleus:(ind:Ind,
                      restr:[]),
             qstore:[(def,
                      restind:(ind:NInd,
                               restr:[(besitzen,
                                       arg2:Ind,
                                       arg3:NInd)|NRestr]))]))).
 
possessive(Case,Person,Numerus,Genus,NNumerus,NGenus) :=
 (@determiner(Case,NNumerus,NGenus),
  possessive,
  loc:cont:nucleus:ind:(per:Person,
                        num:Numerus,
                        gen:Genus)).


% Die folgenden XP-Makros werden als Abkürzung in Valenzrahmen
% verwendet.

np :=
  (loc:cat:(head:noun,
            spr:[],
            subcat:[])).

np(Ind) :=
  (@np,
   loc:cont:nucleus:ind:Ind).

np(Case,Ind) :=
  (@np(Ind),
   loc:cat:head:case:Case).

nbar(Ind) :=
  loc:(cat:(head:noun,
            spr:[_],
            subcat:[]),
       cont:nucleus:ind:Ind).



pp(Ind) :=
  loc:(cat:(head:prep,
            subcat:[]),
       cont:nucleus:ind:Ind).

pp(PForm,Case) :=
  loc:(cat:(head:(prep,
                  pform:PForm,
                  case:Case),
            subcat:[])).



% alle Nomina
noun_word *>
  %word
  loc:cat:head:noun.

% alle einfachen Nomina (ohne Argument)
simple_noun *>
 (%noun_word,
  loc:(cat:(head:case:Case,
            spr:[loc:(cat:(head:(det,
                                 case:Case,
                                 num:Numerus,
                                 gen:Genus),
                           subcat:[] ),
                      cont:qstore:QStore)]),
       cont:(nucleus:(ind:(Ind,
                           per:third,
                           num:Numerus,
                           gen:Genus),
                      restr:[arg1:Ind]),
             qstore:QStore))).

noun(Case,Genus,Numerus,Relation) :=
 (simple_noun,
  loc:(cat:head:case:Case,
       cont:nucleus:(ind:(num:Numerus,
                          gen:Genus),
                     restr:[Relation]))).
 

pers_pronoun *>
 (%noun_word,
  %saturated_word
  loc:cont:(nucleus:restr:[],
            qstore:[])).

pers_pronoun(Case,Person,Numerus,Genus) :=
 (pers_pronoun,
  loc:(cat:head:case:Case,
       cont:nucleus:ind:(per:Person,
                         num:Numerus,
                         gen:Genus))).



verb_word *>
 (%spr_saturated_sc_incomplete_word
  loc:(cat:(head:(verb,
                  initial:minus,
                  vform:fin),
            subcat:Subcat),
       cont:qstore:collectQStores(Subcat))).


intrans_verb *>
 (%verb_word,
  loc:(cat:subcat:hd: @np(nom,Ind),
       cont:nucleus:arg1:Ind)).

strict_intrans_verb *>
  loc:cat:subcat:[_].

intrans_verb(Relation) :=
 (strict_intrans_verb,
  loc:cont:nucleus:Relation).



np_pp_verb *> 
 (%intrans_verb,
  loc:(cat:subcat:tl:[ @pp(Ind2) ],
       cont:nucleus:arg2:Ind2)).


np_pp_verb(PForm,Case,Relation) :=
 (np_pp_verb,
  loc:(cat:subcat:tl:hd: @pp(PForm,Case),
       cont:nucleus:Relation)).


subjlos_verb *>
 (%verb,
  loc:(cat:subcat:[ @np(Ind) ],
       cont:nucleus:arg2:Ind)).

subjlos_verb(Case,Relation) :=
 (subjlos_verb,
  loc:(cat:subcat:[ @np(Case,_Ind) ],
       cont:nucleus:Relation)).


trans_verb *>
 (%verb,
  loc:(cat:subcat:[ @np(nom,Ind1), @np(acc,Ind2) |_ ],
       cont:nucleus:(arg1:Ind1,
                     arg2:Ind2))).

strict_trans_verb *>
 (%trans_verb,
  loc:cat:subcat:[ _, _ ]).

trans_verb(Relation) :=
 (strict_trans_verb,
  loc:cont:nucleus:Relation).


ditrans_verb *>
 (%trans_verb,
  loc:(cat:subcat:[ _, _, @np(dat,Ind3) ],
       cont:nucleus:arg3:Ind3)).

ditrans_verb(Relation) :=
 (ditrans_verb,
  loc:cont:nucleus:Relation).




preposition_word *>
(%word,
 loc:(cat:(head:(prep,
                 initial:plus),
           subcat:[ @np ] ))).

comp_preposition *>
 (%preposition_word,
  loc:(cat:(head:case:Cas,
            subcat:[loc:(cat:head:case:Cas,
                         cont:Cont) ] ),
       cont:Cont)).

comp_prep(PForm) :=
 (comp_preposition,
  loc:cat:head:pform:PForm).


n_modifier *>
(loc:(cat:head:mod: @nbar(Ind),
      cont:nucleus:ind:Ind)).

isect_n_modifier *>
(%n_modifier,
 loc:(cat:head:mod:loc:cont:nucleus:restr:Restr,
      cont:nucleus:restr:tl:Restr)).

n_modifier_word *>
 (%word,
  loc:(cat:(head:mod:loc:cont:qstore:[Q],
            subcat:Subcat),
       cont:qstore:[Q|collectQStores(Subcat)])).
     
attr_adjective_word *>
 (%n_modifier_word,
  loc:cat:head:attr_adj).

% klug
simple_attr_adj *>
 (%intersective_adj
  loc:(cat:subcat:[],
       cont:nucleus:(ind:Ind,
                     restr:hd:arg1:Ind))).

attr_adj(Relation) :=
 (simple_attr_adj,
  loc:cont:nucleus:restr:hd:Relation).

% treu
attr_np_adj *>
 (%intersective_adj
  loc:(cat:subcat:[@np(Ind2)],
       cont:nucleus:(ind:Ind,
                     restr:hd:(arg1:Ind,
                               arg2:Ind2)))).
 
attr_adj_np(Relation,Case) :=
 (attr_np_adj,
  loc:(cat:subcat:[@np(Case,_Ind2)],
       cont:nucleus:restr:hd:Relation)).

% mutmaßlich
scopal_adj *>
 (loc:(cat:head:mod:loc:cont:nucleus:restr:Restr,
       cont:nucleus:restr:[psoa_arg:Restr])).

scopal_attr_adj(Relation) :=
 (scopal_adj,
  loc:cont:nucleus:restr:[Relation]).

mod_preposition *>
 (%preposition_word,
  loc:cat:head:mod_prep).

noun_mod_preposition *>
 (%mod_preposition
  %isect_n_modifier_word
  loc:(cat:(head:(pre_modifier:minus,
                  mod:loc:cont:nucleus:ind:Ind),
            subcat:[ @np(Ind2) ] ),
       cont:nucleus:(ind:Ind,
                     restr:hd:(arg1:Ind,
                               arg2:Ind2)))).
 
location_noun_mod_prep *>
 (%noun_mod_preposition
  loc:cat:subcat:[ @np(dat,_) ] ).

location_noun_mod_prep(Relation) :=
 (location_noun_mod_prep,
  loc:cont:nucleus:restr:hd:Relation).








adverb_word *>
 (%saturated_word,
  loc:(cat:(head:(adv,
                  mod:loc:(cat:head:(verb,
                                     initial:minus),
                           cont:qstore:QStore))),
       cont:qstore:QStore)).

scopal_adverb *>
 (%adverb_word,
  loc:(cat:head:mod:loc:cont:nucleus:Cont,
       cont:nucleus:arg1:Cont)).

scopal_adv(Relation) :=
 (scopal_adverb,
  loc:cont:nucleus:Relation).

intersective_adverb *>
 (%adverb_word,
  loc:(cat:head:mod:loc:cont:nucleus:Cont,
       cont:nucleus:(und,
                     arg1:Cont,
                     arg2:arg1:Cont))).

intersect_adv(Relation) :=
 (intersective_adverb,
  loc:cont:nucleus:arg2:Relation).

temp_adv(Relation) :=
  @intersect_adv(Relation).


% Komplementierer und das Verb in Erststellung
complementizer_like_sign *>
 (%spr_saturated_sign
  loc:(cat:(head:(dsl:none,
                  initial:plus),
            subcat:[ (loc:(cat:(head:(verb,
                                      vform:fin,
                                      initial:minus),
                                subcat:[]),
                           cont:Cont),
                         trace:minus) ]),
       cont:Cont)).

complementizer_word *> 
 (%spr_saturated_sign
  %complementizer_like_sign
  loc:cat:(head:comp,
           subcat:hd:loc:cat:head:dsl:none)).



complementizer(CForm) :=
 (complementizer_word,
  loc:cat:head:cform:CForm).

