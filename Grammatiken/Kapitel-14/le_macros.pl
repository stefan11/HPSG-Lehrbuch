% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: le_macros.pl,v $
%%  $Revision: 1.19 $
%%      $Date: 2007/03/05 11:26:29 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile if/2.
:- discontiguous if/2.
:- multifile fun/1.
:- discontiguous fun/1.

:- multifile '*>'/2.
:- discontiguous '*>'/2.

non_slashed_word *>
 (%simple_word,
  synsem:nonloc:slash:[]).


overt_word *>
 (%non_slashed_word,
  phon:ne_list,
  synsem:trace:minus).

non_rel_word *>
 (%simple_word,
  synsem:nonloc:rel:[]).

non_overt_word *>
  (%non_rel_word,
   phon:[]).

trace *>
  % non_overt_word
  synsem:trace:extraction_or_vm.

e_trace *>
 (%trace,
  synsem:(loc:Loc,
          nonloc:slash:[Loc],
          trace:extraction)).

v_trace *>
 (%trace,
  %non_slashed_word
  synsem:(loc:(Loc,
               cat:head:(verb,
                         initial:minus,
                         dsl:Loc)),
          trace:vm)).

% normale Wörter selegieren nie DSL:local-Elemente.
% Nur über LR abgeleitete Wörter tun dies.
% Beschränkung wird gebraucht, um die Einbettung einer
% Verbspur unter ein Hilfs- oder Modalverb auszuschließen.
%
% * Der Frau den Aufsatz _v will er.

overt_word *>
  synsem:loc:cat:subcat:list_of_non_dsl_synsems.

fun list_of_non_dsl_synsems(-).
list_of_non_dsl_synsems(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_non_dsl_synsems(L) ).

undelayed_list_of_non_dsl_synsems([]) if true.
undelayed_list_of_non_dsl_synsems([loc:cat:head:dsl:none|T]) if
   list_of_non_dsl_synsems(T).


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
 synsem:loc:cat:head:(case:morph_case:Case,
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

% Eine NP mit strukturellem Kasus
np_str :=
  (@np,
   loc:cat:head:case:case_type:str).

np_lex :=
  (@np,
   loc:cat:head:case:case_type:lex).


np_str(Ind) :=
  (@np_str,
   loc:cont:nucleus:ind:Ind).

np_str(Per,Num) :=
  (@np_str,
   loc:cont:nucleus:ind:(per:Per,
                         num:Num)).

lex(Case) :=
 (case_type:lex,
  morph_case:Case).

np(Ind) :=
  (@np,
   loc:cont:nucleus:ind:Ind).

np(Case,Ind) :=
  (@np(Ind),
   loc:cat:head:case: @lex(Case)).


np_(Per,Num) :=
 (@np,
  loc:cont:nucleus:ind:(per:Per,
                        num:Num)).

no_noun :=
  (loc:cat:head: @not(noun)).

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
                  case:morph_case:Case),
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
  synsem:loc:(cat:(head:case:morph_case:Case,
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
 (synsem:loc:(cat:head:case:morph_case:Case,
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
 (%spr_saturated
  synsem:loc:(cat:(head:(verb,
                         initial:minus
                         %dsl:none  
                        ),
                   subcat:Subcat),
              cont:qstore:collectQStores(Subcat))).


% finite Verben
fin_verb(Per,Num) :=
 (synsem:loc:cat:(head:vform:fin
                  ,subcat:subj_verb_agreement(Per,Num)
                 )).

fin_verb(Per,Num,Relation) :=
 (@fin_verb(Per,Num),
  synsem:loc:cont:nucleus:Relation).

% Infinite Verben
verb(VForm) :=
  (synsem:loc:cat:head:vform:VForm).



verb(VForm,Relation) :=
 (@verb(VForm),
  synsem:loc:cont:nucleus:Relation).

% alle Verben außer Modalverben und `haben'
non_flip_verb_word *>
  synsem:loc:cat:head:flip:minus.


intrans_verb *>
 (%verb_word,
  synsem:loc:(cat:subcat:Subcat,
              cont:nucleus:arg1:Ind))
       goal last(Subcat,@np_str(Ind)).

% schlafen
strict_intrans_verb *>
  synsem:loc:cat:subcat:[_].


intrans_verb(Per,Num,Relation) :=
 (strict_intrans_verb,
  @fin_verb(Per,Num,Relation)).

intrans_verb(VForm,Relation) :=
 (strict_intrans_verb,
  @verb(VForm,Relation)).

% denken an
np_pp_verb *> 
 (%intrans_verb,
  synsem:loc:(cat:subcat:[ @pp(Ind2), _ ],
              cont:nucleus:arg2:Ind2)).


np_pp_verb(Per,Num,PForm,Case,Relation) :=
 (np_pp_verb,
  @fin_verb(Per,Num,Relation),
  synsem:loc:cat:subcat:hd: @pp(PForm,Case)).

np_pp_verb(VForm,PForm,Case,Relation) :=
 (np_pp_verb,
  @verb(VForm,Relation),
  synsem:loc:cat:subcat:hd: @pp(PForm,Case)).

% helfen
np_np_verb *>
 (%intrans_verb,
  synsem:loc:(cat:subcat:[ @np(Ind2), _ ],
              cont:nucleus:arg2:Ind2)).

% helfen
np_np_verb(Per,Num,Case,Relation) :=
 (np_np_verb,
  @fin_verb(Per,Num,Relation),
  synsem:loc:cat:subcat:hd: @np(Case,_Ind2) ).

np_np_verb(VForm,Case,Relation) :=
 (np_np_verb,
  @verb(VForm,Relation),
  synsem:loc:cat:subcat:hd: @np(Case,_Ind2)).

% grauen
subjlos_verb *>
 (%verb,
  synsem:loc:(cat:subcat:[ @np(Ind) ],
              cont:nucleus:arg2:Ind)).

% grauen, auch finit, ohne Subjekt-Verb-Kongruenz
subjlos_verb(VForm,Case,Relation) :=
 (subjlos_verb,
  synsem:loc:(cat:(head:vform:VForm,
                   subcat:[ @np(Case,_Ind) ]),
              cont:nucleus:Relation)).


% lieben, geben
trans_verb *>
 (%verb,
  synsem:loc:(cat:subcat:append(_, [ @np_str(Ind2), @np_str(Ind1) ]),
              cont:nucleus:(arg1:Ind1,
                            arg2:Ind2))).

% lieben
strict_trans_verb *>
 (%trans_verb,
  synsem:loc:cat:subcat:[ _, _ ]).

trans_verb(Per,Num,Relation) :=
 (strict_trans_verb,
  @fin_verb(Per,Num,Relation)).

trans_verb(VForm,Relation) :=
 (strict_trans_verb,
  @verb(VForm,Relation)).

% geben
ditrans_verb *>
 (%trans_verb,
  synsem:loc:(cat:subcat:[ @np(dat,Ind3), _, _ ],
              cont:nucleus:arg3:Ind3)).

ditrans_verb(Per,Num,Relation) :=
 (ditrans_verb,
  @fin_verb(Per,Num,Relation)).


ditrans_verb(VForm,Relation) :=
 (ditrans_verb,
  @verb(VForm,Relation)).



% Das sind die Beschränkungen, die nötig sind, damit
% keine eingebetteten Köpfe von komplexbildenden Prädikate angezogen werden.
%
% * weil er das Buch lesen [können wird]
%
% Komplexbildende Prädikate müssen immer direkt mit ihrem
% eingebetteten Kopf verbunden werden:
%
% weil er das Buch [[lesen können] wird]


non_complex_forming_synsem :=
  (loc:cat:subcat:[],
   lex:minus).

fun list_of_non_complex_forming_synsems(-).
list_of_non_complex_forming_synsems(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_non_complex_forming_synsems(L) ).

undelayed_list_of_non_complex_forming_synsems([]) if true.
undelayed_list_of_non_complex_forming_synsems([(@non_complex_forming_synsem)|T]) if
   list_of_non_complex_forming_synsems(T).


optionally_coherent_word *>
  (synsem:loc:cat:subcat:[loc:cat:(head:verb,
                                   subcat:Subcat)|(list_of_non_complex_forming_synsems,
                                                   Subcat)]).

argument_raising_verb *>
 (%optionally_coherent_verb,
  synsem:loc:(cat:subcat:hd:(loc:cont:nucleus:VCont,
                             lex:plus),
              cont:nucleus:arg3:VCont)).

argument_raising_verb(Relation) :=
 (argument_raising_verb,
  synsem:loc:cont:nucleus:Relation).

argument_raising_verb(GovVForm,Relation) :=
 (@argument_raising_verb(Relation),
  synsem:loc:cat:subcat:hd:loc:cat:head:vform:GovVForm).


modal_verb *>
 (%argument_raising_verb
  synsem:loc:cat:subcat:hd:loc:cat:head:(vform:bse,
                                         flip:minus)).    % [ dürfen _Extraction ]     % nur für Geschwindigkeit


modal_verb(Per,Num,Relation) :=
 (modal_verb,
  @fin_verb(Per,Num,Relation)).

modal_verb(VForm,Relation) :=
 (modal_verb,
  @verb(VForm,Relation)).

% daß er das Lied hat singen müssen
modal_flip_verb(Relation) :=
 (modal_verb,
  synsem:loc:cat:head:flip:plus,
  @verb(ppp,Relation)).

futur_aux_verb(Per,Num) :=
 (non_flip_argument_raising_verb,
  @fin_verb(Per,Num),
  @argument_raising_verb(bse,futur)).

futur_aux_verb(VForm) :=
 (non_flip_argument_raising_verb,
  @verb(VForm),
  @argument_raising_verb(bse,futur)).

general_prefect_aux_verb :=
 (@argument_raising_verb(ppp,perfect),
  synsem:loc:cat:(head:flip:Flip,
                  subcat:hd:loc:cat:head:flip:Flip)).


prefect_aux_verb(Per,Num) :=
 (@fin_verb(Per,Num),
  @general_prefect_aux_verb).

perfect_aux_verb(VForm) :=
 (@verb(VForm),
  @general_prefect_aux_verb).




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
 (synsem:loc:cat:head:mod:loc:cat:spr:[loc:cat:head:(case:morph_case:Case,
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
complementizer_like_word *>
 (%spr_saturated_sc_incomplete_word
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
 (%spr_saturated_sc_incomplete_word
  %complementizer_like_word
  synsem:loc:(cat:(head:comp,
                   subcat:hd:loc:cat:head:dsl:none),
              cont:nucleus:assertion)).


complementizer(CForm) :=
 (complementizer_word,
  synsem:loc:cat:head:cform:CForm).









