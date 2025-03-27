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
 cat:subcat:[].


determiner_word *>
 (%saturated_word Diese Information steht in der signatur
  cat:head:det).

determiner(Case,Numerus,Genus) :=
(%determiner_word,
 cat:head:(case:Case,
           num:Numerus,
           gen:Genus)).


determiner *> 
 (%determiner_word
  cat:head:spec:cont:nucleus:Cont,
  cont:(nucleus:(Quant,
                 restind:Cont),
        qstore:[Quant])).

det(Case,Numerus,Genus,Quant) :=
(@determiner(Case,Numerus,Genus),
 determiner,
 cont:nucleus:Quant).

possessive *>
 (%determiner_word
  cat:head:spec:cont:nucleus:(ind:NInd,
                              restr:NRestr),
  cont:(nucleus:(ind:Ind,
                 restr:[]),
        qstore:[(def,
                 restind:(ind:NInd,
                          restr:[(besitzen,
                                  arg2:Ind,
                                  arg3:NInd)|NRestr]))])).

possessive(Case,Person,Numerus,Genus,NNumerus,NGenus) :=
 (@determiner(Case,NNumerus,NGenus),
  possessive,
  cont:nucleus:ind:(per:Person,
                    num:Numerus,
                    gen:Genus)).


% Die folgenden XP-Makros werden als Abkürzung in Valenzrahmen
% verwendet.

np :=
  (cat:(head:noun,
        subcat:[])).

np(Ind) :=
  (@np,
   cont:nucleus:ind:Ind).

np(Case,Ind) :=
  (@np(Ind),
   cat:head:case:Case).

nbar(Ind) :=
  (cat:(head:noun,
        subcat:[_]),
   cont:nucleus:ind:Ind).



pp(Ind) :=
  (cat:(head:prep,
        subcat:[]),
   cont:nucleus:ind:Ind).

pp(PForm,Case) :=
  (cat:(head:(prep,
              pform:PForm,
              case:Case),
        subcat:[])).



% alle Nomina
noun_word *>
 (%word
  cat:head:noun).

% alle einfachen Nomina (ohne Argument)
simple_noun *>
 (%noun_word,
  cat:(head:case:Case,
       subcat:[(cat:(head:(det,
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
        qstore:QStore)).

noun(Case,Genus,Numerus,Relation) :=
 (simple_noun,
  cat:head:case:Case,
  cont:nucleus:(ind:(num:Numerus,
                     gen:Genus),
                restr:[Relation])).


pers_pronoun *>
 (%noun_word,
  %saturated_word
  cont:(nucleus:restr:[],
        qstore:[])).

pers_pronoun(Case,Person,Numerus,Genus) :=
 (pers_pronoun,
  cat:head:case:Case,
  cont:nucleus:ind:(per:Person,
                    num:Numerus,
                    gen:Genus)).



verb_word *>
 (%word,
  cat:(head:(verb,
             vform:fin),
       subcat:Subcat),
  cont:qstore:collectQStores(Subcat)).


intrans_verb *>
 (%verb,
  cat:subcat:hd: @np(nom,Ind),
  cont:nucleus:arg1:Ind).

strict_intrans_verb *>
  cat:subcat:[_].

intrans_verb(Relation) :=
 (strict_intrans_verb,
  cont:nucleus:Relation).



np_pp_verb *> 
 (%intrans_verb,
  cat:subcat:tl:[ @pp(Ind2) ],
  cont:nucleus:arg2:Ind2).


np_pp_verb(PForm,Case,Relation) :=
 (np_pp_verb,
  cat:subcat:tl:hd: @pp(PForm,Case),
  cont:nucleus:Relation).


subjlos_verb *>
 (%verb,
  cat:subcat:[ @np(Ind) ],
  cont:nucleus:arg2:Ind).

subjlos_verb(Case,Relation) :=
 (subjlos_verb,
  cat:subcat:[ @np(Case,_Ind) ],
  cont:nucleus:Relation).

trans_verb *>
 (%verb,
  cat:subcat:[ @np(nom,Ind1), @np(acc,Ind2) |_ ],
  cont:nucleus:(arg1:Ind1,
                arg2:Ind2)).

strict_trans_verb *>
 (%trans_verb,
  cat:subcat:[ _, _ ]).

trans_verb(Relation) :=
 (strict_trans_verb,
  cont:nucleus:Relation).


ditrans_verb *>
 (%trans_verb,
  cat:subcat:[ _, _, @np(dat,Ind3) ],
  cont:nucleus:arg3:Ind3).

ditrans_verb(Relation) :=
 (ditrans_verb,
  cont:nucleus:Relation).

preposition_word *>
(%word,
 cat:(head:prep,
      subcat:[ @np ] )).

comp_preposition *>
 (%preposition_word,
  cat:(head:case:Cas,
       subcat:[(cat:head:case:Cas,
                cont:Cont) ] ),
  cont:Cont).

comp_prep(PForm) :=
 (comp_preposition,
  cat:head:pform:PForm).


n_modifier *>
(cat:head:mod: @nbar(Ind),
 cont:nucleus:ind:Ind).

isect_n_modifier *>
(%n_modifier,
 cat:head:mod:cont:nucleus:restr:Restr,
 cont:nucleus:restr:tl:Restr).

n_modifier_word *>
 (%word,
  cat:(head:mod:cont:qstore:[Q],
       subcat:Subcat),
  cont:qstore:[Q|collectQStores(Subcat)]).
     
attr_adjective_word *>
 (%n_modifier_word,
  cat:head:attr_adj).

% klug
simple_attr_adj *>
 (%intersective_adj
  cat:subcat:[],
  cont:nucleus:(ind:Ind,
                restr:hd:arg1:Ind)).

attr_adj(Relation) :=
 (simple_attr_adj,
  cont:nucleus:restr:hd:Relation).

% treu
attr_np_adj *>
 (%intersective_adj
  cat:subcat:[@np(Ind2)],
  cont:nucleus:(ind:Ind,
                restr:hd:(arg1:Ind,
                          arg2:Ind2))).

attr_adj_np(Relation,Case) :=
 (attr_np_adj,
  cat:subcat:[@np(Case,_Ind2)],
  cont:nucleus:restr:hd:Relation).

% mutmaßlich
scopal_adj *>
 (cat:head:mod:cont:nucleus:restr:Restr,
  cont:nucleus:restr:[psoa_arg:Restr]).

scopal_attr_adj(Relation) :=
 (scopal_adj,
  cont:nucleus:restr:[Relation]).

mod_preposition *>
 (%preposition_word,
  cat:head:mod_prep).

noun_mod_preposition *>
 (%mod_preposition
  %isect_n_modifier_word
  cat:(head:mod:cont:nucleus:ind:Ind,
       subcat:[ @np(Ind2) ] ),
  cont:nucleus:(ind:Ind,
                restr:hd:(arg1:Ind,
                          arg2:Ind2))).

location_noun_mod_prep *>
 (%noun_mod_preposition
  cat:subcat:[ @np(dat,_) ] ).

location_noun_mod_prep(Relation) :=
 (location_noun_mod_prep,
  cont:nucleus:restr:hd:Relation).






