% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: le_macros.pl,v $
%%  $Revision: 1.16 $
%%      $Date: 2007/03/05 11:26:28 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile ':='/2.
:- discontiguous ':='/2.

:- multifile '*>'/2.
:- discontiguous '*>'/2.


non_slashed_word *>
 (%simple_word,
  synsem:nonloc:slash:[]).


overt_word *>
 (%non_slashed_word,
  phon:ne_list,
  synsem:trace:minus).

non_rel_sign *>
 (%sign,
  synsem:nonloc:rel:[]).

non_overt_word *>
  (%non_rel_word,
   phon:[]).

trace *>
  synsem:trace:extraction_or_vm.

rel_pronoun *>
 (%overt_word,
  synsem:(loc:cont:nucleus:ind:Ind,
          nonloc:rel:[Ind])).

sc_saturated_word *>
  synsem:loc:cat:subcat:[].

spr_saturated_word *>
  synsem:loc:cat:spr:[].


determiner_word *>
 (%saturated_word Diese Information steht in der signatur
  synsem:loc:cat:head:det).

determiner(Numerus,DType) :=
 (synsem:loc:cat:head:(num:Numerus,
                       dtype:DType)).

determiner(Case,Numerus,Genus,DType) :=
(%determiner_word,
 @determiner(Numerus,DType),
 synsem:loc:cat:head:(case:Case,
                      gen:Genus)).


% leerer Determinator und overte Determinatoren
det(Numerus,DType,Quant) :=
 (@determiner(Numerus,DType),
  synsem:loc:cont:nucleus:Quant).

determiner *> 
 (%determiner_word
  synsem:loc:(cat:head:spec:loc:cont:nucleus:Cont,
              cont:(nucleus:(Quant,
                             restind:Cont),
                    qstore:[Quant]))).

% Determinatoren mit Genus
det(Case,Numerus,Genus,DType,Quant) :=
(@determiner(Case,Numerus,Genus,DType),
 overt_determiner,
 @det(Numerus,DType,Quant)).

% Determinatoren ohne Genus
det(Case,Numerus,DType,Quant) :=
  @det(Case,Numerus,genus,DType,Quant).

possessive *>
 (%determiner_word
  synsem:loc:(cat:head:spec:loc:cont:nucleus:(ind:NInd,
                                              restr:NRestr),
              cont:(nucleus:(ind:Ind,
                             restr:[]),
                    qstore:[(def,
                             restind:(ind:NInd,
                                      restr:[(besitzen,
                                              arg2:Ind,
                                              arg3:NInd)|NRestr]))]))).

possessive(Case,Person,Numerus,Genus,NNumerus,NGenus,DType) :=
 (@determiner(Case,NNumerus,NGenus,DType),
  simple_possessive,
  synsem:loc:cont:nucleus:ind:(per:Person,
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

np_(Per,Num) :=
 (@np,
  loc:cont:nucleus:ind:(per:Per,
                        num:Num)).


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
  synsem:loc:cat:head:noun.

% alle einfachen Nomina (ohne Argument)
simple_noun *>
 (%noun_word,
  synsem:loc:(cat:(head:case:Case,
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




% Bei Mädchen, Weib usw. sind SynGenus und SemGenus
% verschieden.
noun(Case,SynGenus,SemGenus,Numerus,Relation) :=
 (simple_noun,
  synsem:loc:(cat:(head:case:Case,
                   spr:[loc:cat:head:gen:SynGenus]),
              cont:nucleus:(ind:(num:Numerus,
                                 gen:SemGenus),
                            restr:[Relation]))).

% Normalerweise sind die Genus-Werte aber gleich.
% Haus
noun(Case,Genus,Numerus,Relation) :=
 (@noun(Case,Genus,Genus,Numerus,Relation)).


% Beamter, Verwandter
adj_noun(Case,Genus,Numerus,DType,Relation) :=
 (@noun(Case,Genus,Genus,Numerus,Relation),
  synsem:loc:cat:spr:[loc:cat:head:dtype:DType]).


pronoun *>
 (%saturated_word
  synsem:loc:cont:nucleus:restr:[]).

nominal_pronoun *>
 (%noun_word,
  %pronoun
  synsem:loc:cont:qstore:[]).

pronoun(Case,Person,Numerus,Genus) :=
 (synsem:loc:(cat:head:case:Case,
              cont:nucleus:ind:(per:Person,
                                num:Numerus,
                                gen:Genus))).

pers_pronoun(Case,Person,Numerus,Genus) :=
 (pers_pronoun,
  @pronoun(Case,Person,Numerus,Genus)).

% ich, du haben kein spezifiziertes Genus
pers_pronoun(Case,Person,Numerus) :=
  (@pers_pronoun(Case,Person,Numerus,genus)).

% der, die, das
rel_pronoun(Case,Person,Numerus,Genus) :=
 (nominal_rel_pronoun,
  @pronoun(Case,Person,Numerus,Genus)).


% dessen, deren
possessive_rel_pronoun(Numerus,Genus) :=
 (possessive_rel_pronoun,
  @pronoun(_Case,third,Numerus,Genus)).

verb_word *>
 (%spr_saturated_sc_incomplete_word
  synsem:loc:(cat:(head:(verb,
                         initial:minus),
                   subcat:Subcat),
              cont:qstore:collectQStores(Subcat))).


intrans_verb *>
 (%verb_word,
  synsem:loc:(cat:subcat:hd: @np(nom,Ind),
              cont:nucleus:arg1:Ind)).

% schlafen
strict_intrans_verb *>
  synsem:loc:cat:subcat:[_].

verb(Per,Num) :=
 (synsem:loc:cat:(head:vform:fin,
                  subcat:hd: @np_(Per,Num))).

intrans_verb(Per,Num,Relation) :=
 (strict_intrans_verb,
  @verb(Per,Num),
  synsem:loc:cont:nucleus:Relation).


% denken an
np_pp_verb *> 
 (%intrans_verb,
  synsem:loc:(cat:subcat:tl:[ @pp(Ind2) ],
              cont:nucleus:arg2:Ind2)).


np_pp_verb(Per,Num,PForm,Case,Relation) :=
 (np_pp_verb,
  @verb(Per,Num),
  synsem:loc:(cat:subcat:tl:hd: @pp(PForm,Case),
              cont:nucleus:Relation)).

% helfen
np_np_verb *>
 (%intrans_verb,
  synsem:loc:(cat:subcat:tl: [ @np(Ind2) ],
              cont:nucleus:arg2:Ind2)).

% helfen
np_np_verb(Per,Num,Case,Relation) :=
 (np_np_verb,
  @verb(Per,Num),
  synsem:loc:(cat:subcat:tl: [ @np(Case,_Ind2) ],
              cont:nucleus:Relation)).

% grauen
subjlos_verb *>
 (%verb,
  synsem:loc:(cat:subcat:[ @np(Ind) ],
              cont:nucleus:arg2:Ind)).

subjlos_verb(Case,Relation) :=
 (subjlos_verb,
  synsem:loc:(cat:subcat:[ @np(Case,_Ind) ],
              cont:nucleus:Relation)).


% lieben, geben
trans_verb *>
 (%verb,
  synsem:loc:(cat:subcat:[ @np(nom,Ind1), @np(acc,Ind2) |_ ],
              cont:nucleus:(arg1:Ind1,
                            arg2:Ind2))).

% lieben
strict_trans_verb *>
 (%trans_verb,
  synsem:loc:cat:subcat:[ _, _ ]).

trans_verb(Per,Num,Relation) :=
 (strict_trans_verb,
  @verb(Per,Num),
  synsem:loc:cont:nucleus:Relation).


% geben
ditrans_verb *>
 (%trans_verb,
  synsem:loc:(cat:subcat:[ _, _, @np(dat,Ind3) ],
              cont:nucleus:arg3:Ind3)).

ditrans_verb(Per,Num,Relation) :=
 (ditrans_verb,
  @verb(Per,Num),
  synsem:loc:cont:nucleus:Relation).




preposition_word *>
(%word,
 synsem:loc:(cat:(head:(prep,
                        initial:plus),
                  subcat:[ (@np,
                            nonloc:slash:[]) ] ))).

comp_preposition *>
 (%preposition_word,
  synsem:loc:(cat:(head:case:Cas,
                   subcat:[loc:(cat:head:case:Cas,
                                cont:Cont) ] ),
              cont:Cont)).

comp_prep(PForm) :=
 (comp_preposition,
  synsem:loc:cat:head:pform:PForm).


n_modifier *>
 synsem:loc:(cat:head:mod: @nbar(Ind),
             cont:nucleus:ind:Ind).

isect_n_modifier *>
(%n_modifier,
 synsem:loc:(cat:head:mod:loc:cont:nucleus:restr:Restr,
             cont:nucleus:restr:tl:Restr)).

n_modifier_word *>
 (%word,
  synsem:loc:(cat:(head:mod:loc:cont:qstore:[Q],
                   subcat:Subcat),
              cont:qstore:[Q|collectQStores(Subcat)])).
     
attr_adjective_word *>
 (%n_modifier_word,
  synsem:loc:cat:head:attr_adj).

general_attr_adj(Case,Genus,Num,DType) :=
 (synsem:loc:cat:head:mod:loc:cat:spr:[loc:cat:head:(case:Case,
                                                     gen:Genus,
                                                     num:Num,
                                                     dtype:DType)]).


% klug
simple_attr_adj *>
 (%intersective_adj
  synsem:loc:(cat:subcat:[],
              cont:nucleus:(ind:Ind,
                            restr:hd:arg1:Ind))).

attr_adj(Case,Genus,Num,DType,Relation) :=
 (simple_attr_adj,
  @general_attr_adj(Case,Genus,Num,DType),
  synsem:loc:cont:nucleus:restr:hd:Relation).


% für Pluralformen
attr_adj(Case,Num,DType,Relation) :=
 (simple_attr_adj,
  @general_attr_adj(Case,genus,Num,DType),
  synsem:loc:cont:nucleus:restr:hd:Relation).

% treu
attr_np_adj *>
 (%intersective_adj
  synsem:loc:(cat:subcat:[@np(Ind2)],
              cont:nucleus:(ind:Ind,
                            restr:hd:(arg1:Ind,
                                      arg2:Ind2)))).
 
attr_adj_np(Case,Genus,Num,DType,Relation,GCase) :=
 (attr_np_adj,
  @general_attr_adj(Case,Genus,Num,DType),
  synsem:loc:(cat:subcat:[@np(GCase,_Ind2)],
              cont:nucleus:restr:hd:Relation)).

attr_adj_np(Case,Num,DType,Relation,GCase) :=
 (attr_np_adj,
  @general_attr_adj(Case,genus,Num,DType),
  synsem:loc:(cat:subcat:[@np(GCase,_Ind2)],
              cont:nucleus:restr:hd:Relation)).


% mutmaßlich
scopal_adj *>
 synsem:loc:(cat:head:mod:loc:cont:nucleus:restr:Restr,
             cont:nucleus:restr:[psoa_arg:Restr]).

scopal_attr_adj(Case,Genus,Num,DType,Relation) :=
 (scopal_adj,
  @general_attr_adj(Case,Genus,Num,DType),
  synsem:loc:cont:nucleus:restr:[Relation]).

scopal_attr_adj(Case,Num,DType,Relation) :=
 (scopal_adj,
  @general_attr_adj(Case,genus,Num,DType),
  synsem:loc:cont:nucleus:restr:[Relation]).

mod_preposition *>
 (%preposition_word,
  synsem:loc:cat:head:mod_prep).

noun_mod_preposition *>
 (%mod_preposition
  %isect_n_modifier_word
  synsem:loc:(cat:(head:(pre_modifier:minus,
                         mod:loc:cont:nucleus:ind:Ind),
                   subcat:[ @np(Ind2) ] ),
              cont:nucleus:(ind:Ind,
                            restr:hd:(arg1:Ind,
                                      arg2:Ind2)))).
 
location_noun_mod_prep *>
 (%noun_mod_preposition
  synsem:loc:cat:subcat:[ @np(dat,_) ] ).

location_noun_mod_prep(Relation) :=
 (location_noun_mod_prep,
  synsem:loc:cont:nucleus:restr:hd:Relation).





v_modifier_word *>
  (%word,
   synsem:loc:cat:head:(pre_modifier:plus,
                        mod:loc:cat:head:(verb,
                                          initial:minus))).


isect_v_modifier_word *>
  (%v_modifier_word,
   synsem:loc:(cat:head:mod:loc:cont:nucleus:Cont,
               cont:nucleus:(und,
                             arg1:Cont,
                             arg2:arg1:Cont))).

scopal_v_modifier_word *>
 (%v_modifier_word,
  synsem:loc:(cat:head:mod:loc:cont:nucleus:Cont,
              cont:nucleus:arg1:Cont)).


adverb_word *>
 (%v_modifier_word
  synsem:loc:(cat:(head:(adv,
                         mod:loc:cont:qstore:QStore)),
              cont:qstore:QStore)).


scopal_adv(Relation) :=
 (scopal_adverb,
  synsem:loc:cont:nucleus:Relation).


intersect_adv(Relation) :=
 (intersective_adverb,
  synsem:loc:cont:nucleus:arg2:Relation).

temp_adv(Relation) :=
  @intersect_adv(Relation).



location_verb_mod_prep *>
  synsem:loc:cat:subcat:[ @np(dat,_Ind2) ].

location_verb_mod_prep(Relation) :=
 (location_verb_mod_prep,
  synsem:loc:cont:nucleus:arg2:Relation).


% Komplementierer und das Verb in Erststellung
complementizer_like_sign *>
 (%spr_saturated_word
  synsem:loc:(cat:(head:(dsl:none,
                         initial:plus),
                   subcat:[ (loc:(cat:(head:(verb,
                                             vform:fin,
                                             initial:minus),
                                       subcat:[]),
                                  cont:(nucleus:Nuc,
                                        qstore:QStore)),
                                trace:minus) ]),
              cont:(nucleus:arg3:Nuc,
                    qstore:QStore))).

complementizer_word *> 
 (%spr_saturated_word
  %complementizer_like_word
  synsem:loc:(cat:(head:comp,
                   subcat:hd:loc:cat:head:dsl:none),
              cont:nucleus:assertion)).


complementizer(CForm) :=
 (complementizer_word,
  synsem:loc:cat:head:cform:CForm).









