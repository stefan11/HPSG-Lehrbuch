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

trace *>
  (%empty_rel_word,
   phon:[]).

overt_sign *>
 (%sign,
  synsem:nonloc:slash:[]).

overt_word *>
 (%overt_sign,
  %word,
  phon:ne_list,
  synsem:trace:minus).

empty_rel_sign *>
 (%sign,
  synsem:nonloc:rel:[]).

rel_pronoun *>
 (%overt_word,
  synsem:(loc:cont:ind:Ind,
          nonloc:rel:[ind:Ind])).

% complementizer_like_sign erbt hiervon.
% V1-Regel und Komplementierer.
spr_saturated_sign *>
  synsem:loc:cat:spr:[].

saturated_word *>
 synsem:loc:cat:arg_st:[].

% Für Artikelwörter und das Possessivpronomen.
% Die RELS- und HCONS-Liste ist offen, so dass
% entweder nur die Information über einen Quantor darin
% enthalten sein kann oder aber noch weitere Relationen und HANDLE-Constraints.
determiner_word *>
 (%saturated_word Diese Information steht in der signatur
  synsem:loc:cat:head:(det,
                       spec:loc:cont:(ind:Ind,
                                      ltop:NLTop)),
  rels:hd:(% eine Relation eines Quantors z.B. exists_q
           arg0:Ind,
           rstr:Restr),
  hcons:[(qeq,
          harg:Restr,
          larg:NLTop)]).


determiner(Case,Numerus,Genus) :=
(%determiner_word,
 synsem:loc:cat:head:(case:Case,
                      num:Numerus,
                      gen:Genus)).

% Genau ein Element in der RELS- und HCONS-Liste.
% Ließe sich mit rels:tl:e_liste effizienter aufschreiben. Aber weniger lesbar.
determiner *> 
 (%determiner_word
  rels:[_]).

det(Case,Numerus,Genus,Quant) :=
(@determiner(Case,Numerus,Genus),
 determiner,
 rels:hd:Quant).


% Sowohl für normale Possessiva als auch für possessive Relativpronomina.
possessive *>
 (%determiner_word
  synsem:loc:(cat:head:spec:loc:cont:ind:Ind2,
              cont:(ind:Ind,
                    ltop:LTop)),
  rels:[def_q,
        (poss_rel,
            lbl:LTop,
            arg0:event,
            arg1:Ind,
            arg2:Ind2)]).

% sein Affe: Der LTOP ist mit dem LTOP des Nomens identisch.  Bei possessiven Relativpronomina wie
% in Der Affe, dessen Kind schläft, lacht.  wird der LTOP-Wert nicht mit dem des Nomens
% identifiziert, sondern mit dem des Relativsatzes und dann mit dem des modifizierten Nomens. Siehe unten.
% Idee aus ERG 2025-04-04
simple_possessive *>
 (%possessive,
  synsem:loc:(cat:head:spec:loc:cont:ltop:NLTop,
              cont:ltop:NLTop)).


possessive(Case,NNumerus,NGenus,Person,Numerus,Genus) :=
 (@determiner(Case,NNumerus,NGenus),
  simple_possessive,
  synsem:loc:cont:ind:(per:Person,
                       num:Numerus,
                       gen:Genus)).


% Die folgenden XP-Makros werden als Abkürzung in Valenzrahmen
% verwendet.

xp :=
  (loc:cat:(spr:[],
            comps:[])).

% kennen, helfen, denken an
xp(Ind) :=
  (@xp,
   loc:cont:ind:Ind).

np :=
  (@xp,
   loc:cat:head:noun).

np(Ind) :=
  (@np,
   loc:cont:ind:Ind).

np(Case,Ind) :=
  (@np(Ind),
   loc:cat:head:case:Case).

nbar :=
  (loc:cat:(head:noun,
            spr:[_],
            comps:[])).

nbar(Ind) :=
  (@nbar,
   loc:cont:ind:Ind).

pp :=
  (@xp,
   loc:cat:head:prep).

pp(Ind) :=
  (@pp,
   loc:(cat:head:prep,
        cont:ind:Ind)).

pp(PForm,Case) :=
  (@pp,
   loc:cat:head:(pform:PForm,
                 case:Case)).


non_scopal_le *>
  hcons:[].

% expletives and markers
non_relational_le *>
  rels:[].

% complement prepositions and some complementizers.
transparent_head_le *>
 synsem:loc:(cat:arg_st:[loc:cont:(ind:Ind,
                                   ltop:LTop) ],
             cont:(ind:Ind,
                   ltop:LTop)).


arg0_le *>
  (synsem:loc:cont:ind:Ind,
   rels:hd:arg0:Ind).

ltop_lbl_le *>
  (synsem:loc:cont:ltop:Lbl,
   rels:hd:lbl:Lbl).

% alle Nomina
noun_word *>
 (%word
  synsem:loc:cat:head:(noun,
                       initial:plus)).

% Nomen mit Determinator
det_noun_word *>
(%noun_word,
  %non_scopal_le
  %relational_arg0_word,  % enthält auch lbl:LTop
  synsem:loc:(cat:(head:case:Case,
                   spr:[_],
                   % Das erste Element der ARG-ST-Liste ist der Determinator.
                   arg_st:hd:loc:cat:(head:(det,
                                            case:Case,
                                            num:Numerus,
                                            gen:Genus),
                                      spr:[],
                                      comps:[])),
              cont:ind:(        % Der Typ index folgt aus der Anwesneheit der Merkmale per, num, gen
                                per:third,
                                num:Numerus,
                                gen:Genus) )).
 

% alle einfachen Nomina (ohne Argument)
simple_noun *>
 (%det_noun_word,
  synsem:loc:cat:arg_st:tl:e_list ).

noun(Case,Genus,Numerus,Relation) :=
 (simple_noun,
  synsem:loc:(cat:head:case:Case,
              cont:ind:(num:Numerus,
                        gen:Genus)),
  rels:[Relation]).


relational_noun *>
 (%det_noun_word
  synsem:loc:cat:arg_st:tl:[loc:(cat:(head:(noun,
                                            case:gen),
                                      spr:[],
                                      comps:[]),
                                 cont:ind:Ind2) ],
  rels:hd:arg2:Ind2).


relational_noun(Case,Genus,Numerus,Relation) :=
 (relational_noun,
  synsem:loc:(cat:head:case:Case,
              cont:ind:(num:Numerus,
                        gen:Genus)),
  rels:[Relation]).

pronoun(Case,Person,Numerus,Genus) :=
  (synsem:loc:(cat:head:case:Case,
               cont:ind:(per:Person,
                         num:Numerus,
                         gen:Genus))).

% pers_pronoun *>
%  (%noun_word,
%   %saturated_word
%   loc:cont:ind:Ind,
%   rels:[(pronoun_q,
%          arg0:Ind,
%          rstr:Restr),(pronoun_rel,
%                       lbl:PronounRel,
%                       arg0:Ind)],
%   hcons:[(qeq,
%           harg:Restr,
%           larg:PronounRel)]).

/*
pers_pronoun *>
 (%noun_word,
  %saturated_word
  loc:cont:ind:ref).
*/

pers_pronoun(Case,Person,Numerus,Genus) :=
 (pers_pronoun,
  @pronoun(Case,Person,Numerus,Genus)).



% der, die, das
rel_pronoun(Case,Person,Numerus,Genus) :=
 (nominal_rel_pronoun,
  @pronoun(Case,Person,Numerus,Genus)).

% LTOP wird hochgereicht und dann mit dem des modifizeirten Nomens identfiziert.
% ERG 2025-04-04
possessive_rel_pronoun *>
 (%possessive
  synsem:(loc:cont:ltop:LTop,
          nonloc:rel:[ltop:LTop])).

% dessen Kind, dessen Blume, dessen Roman referiert auf Maskulinum/Neutrum
% deren Kind, deren Blume, deren Roman refereirt auf Femininum oder Plural
possessive_rel_pronoun(Genus,Numerus) :=
 (possessive_rel_pronoun,
  synsem:loc:cont:ind:(per:third,
                       num:Numerus,
                       gen:Genus)).


proper_noun *>
 (%noun_word,
  %saturated_word
  synsem:loc:cont:ind:Ind,
  rels:[(proper_q,
         arg0:Ind,
         rstr:Restr),(named_rel,
                      lbl:NamedRel,
                      arg0:Ind)],
  hcons:[(qeq,
          harg:Restr,
          larg:NamedRel)]).


proper_noun(Genus,Name) :=
 (proper_noun,
  synsem:loc:cont:ind:gen:Genus,
  rels:tl:hd:name:(a_ Name)).

verb_word *>
 (%word,
  %arg0_ltop_lbl_le
  synsem:loc:(cat:(head:(verb,
                         vform:fin,
                         initial:minus),
                   spr:[]),
              cont:ind:event)).


intrans_verb *>
 (%verb_word,
  synsem:loc:cat:arg_st:hd: @np(nom,Ind),
  rels:[arg1:Ind]).

strict_intrans_verb *>
 (%non_scopal_intrans_verb
  synsem:loc:cat:arg_st:[_]).

intrans_verb(Relation) :=
 (strict_intrans_verb,
  rels:hd:Relation).

np_pp_verb *> 
 (%non_scopal_intrans_verb,
  %bi_or_more_val_verb, 
  synsem:loc:cat:arg_st:tl:[ @pp ]).

np_pp_verb(PForm,Case,Relation) :=
 (np_pp_verb,
  synsem:loc:cat:arg_st:tl:hd: @pp(PForm,Case),
  rels:hd:Relation).


subjlos_verb *>
 (%non_scopal_verb_word,
  synsem:loc:cat:arg_st:[ @np(Ind) ],
  rels:[arg2:Ind]).

subjlos_verb(Case,Relation) :=
 (subjlos_verb,
  synsem:loc:cat:arg_st:[ @np(Case,_Ind) ],
  rels:hd:Relation).

% kennen, helfen verbs with at least two arguments and a nominative
bi_or_more_val_verb *>
 (%non_scopal_verb_word,
  synsem:loc:cat:arg_st:[ @np(nom,Ind1), @xp(Ind2) |_ ],
  rels:[(arg1:Ind1,
         arg2:Ind2)]).

% kennen
strict_trans_verb *>
 (%trans_verb = bi_or_more_val_verb
  synsem:loc:cat:arg_st:[ _, @np(acc,_) ]).

trans_verb(Relation) :=
 (strict_trans_verb,
  rels:hd:Relation).

ditrans_verb *>
 (%trans_verb = bi_or_more_val_verb
  synsem:loc:cat:arg_st:[ _, @np(dat,_),@np(acc,Ind3)  ],
  rels:[arg3:Ind3]).

ditrans_verb(Relation) :=
 (ditrans_verb,
  rels:hd:Relation).

glauben_denken_verb *>
 (%intrans_verb,
  synsem:loc:cat:arg_st:[ _,
                          (loc:(cat:(head:(comp,
                                           cform:dass),
                                     spr:[],
                                     comps:[]),
                                cont:ltop:Larg)) ],
  rels:[arg2:Harg],
  hcons:[(qeq,
          harg:Harg,
          larg:Larg)]).


glauben_denken_verb(Relation) :=
 (glauben_denken_verb,
  rels:hd:Relation).

preposition_word *>
(%word,
 %non_scopal_le
 synsem:loc:cat:(head:(prep,
                       initial:plus),
      %          spr:[],
                 arg_st:[ @np ] )).

comp_preposition *>
 (%preposition_word,
  %transparent_head_le % Shares IND and LTOP with argument.
  synsem:loc:cat:(head:case:Case,
                  arg_st:[loc:cat:head:case:Case])).

comp_prep(PForm) :=
 (comp_preposition,
  synsem:loc:cat:head:pform:PForm).

isect_modifier *>
 synsem:loc:(cat:head:(scopal:minus,
                       mod:loc:cont:ind:Ind),
             cont:ind:Ind).

n_modifier *>
 synsem:loc:cat:head:mod: @nbar.

% Das LBL wird vom Adjunkt im Schema beigesteuert.
% Adjektive und Adverbien
isect_modifier_le *>
(%non_scopal_le,
 %isect_modifier
 synsem:loc:cont:ind:Ind,
 rels:[arg1:Ind]).
 
attr_adjective_word *>
 (%n_modifier_word,
  synsem:loc:cat:(head:attr_adj,
                  spr:[])).

% klug
simple_attr_adj *>
 (%intersective_adj
  synsem:loc:cat:arg_st:[]).

attr_adj(Relation) :=
 (simple_attr_adj,
  rels:hd:Relation).

% treu
attr_np_adj *>
 (%intersective_adj
  synsem:loc:cat:arg_st:[@np(Ind2)],
  rels:hd:arg2:Ind2).

attr_adj_np(Relation,Case) :=
 (attr_np_adj,
  synsem:loc:cat:arg_st:[@np(Case,_Ind2)],
  rels:hd:Relation).


scopal_modifier_le *>
  (%ltop_lbl_le
   synsem:loc:(cat:head:(mod:loc:cont:ltop:VLTop,
                         scopal:plus),
               cont:ltop:LTop),
   rels:[(lbl:LTop,
          arg1:Arg1)],
   hcons:[(qeq,
           harg:Arg1,
           larg:VLTop)]).

% mutmaßlich
scopal_adj *>
 (%saturated_word
  %attr_adjective_word
  %scopal_modifier_le
  synsem:loc:(cat:head:mod:loc:cont:ind:Ind,
              cont:ind:Ind)).

scopal_attr_adj(Relation) :=
 (scopal_adj,
  rels:[Relation]).

v_modifier *>
 synsem:loc:cat:head:mod:loc:cat:head:(adj_or_verb,
                                       initial:minus).

adv_word *>
 synsem:loc:cat:head:adv.

% wahrscheinlich
scopal_adv(Relation) :=
 (scopal_adv_word,
  rels:[Relation]).   

isect_adv(Relation) :=
 (isect_adv_word,
  rels:[Relation]).

mod_preposition *>
 (%preposition_word,
  synsem:loc:(cat:(head:mod:loc:cont:ind:Ind,
                   arg_st:[ @np(Ind2) ] ),
              cont:ind:Ind),
  rels:[(arg1:Ind,
         arg2:Ind2)]).

noun_mod_preposition *>
 (%mod_preposition
  %isect_n_modifier_word
  synsem:loc:cat:head:pre_modifier:minus).

location_noun_mod_prep *>
 (%noun_mod_preposition
  synsem:loc:cat:arg_st:[ @np(dat,_) ] ).

location_noun_mod_prep(Relation) :=
 (location_noun_mod_prep,
  rels:hd:Relation).

location_verb_mod_prep *>
 (%verb_mod_preposition
  synsem:loc:cat:arg_st:[ @np(dat,_Ind2) ]).

location_verb_mod_prep(Relation) :=
 (location_verb_mod_prep,
  rels:hd:Relation).


complementizer_like_sign *>
 (%transparent_head_le
  %spr_saturated_le
  synsem:loc:cat:(head:initial:plus,
           % Die Verwendung von COMPS statt ARG-ST ist ein interessanter Trick:
           % Wenn die V1-Regel syntaktisch ist, gilt das Argumentrealisierungsprinzip nicht.
           % Die Beschränkungen müssen aber auch für vorangestellte Verben in COMPS landen.
           % Für Wörter sorgt dann das Argumentrealisierungsprinzip dafür, dass die COMPS-Information
           % identisch mit der ARG-ST ist.
                  comps:[(loc:cat:(head:(verb,
                                         vform:fin,
                                         initial:minus),
                                   spr:[],
                                   comps:[]),
                          trace:minus) ] )).

complementizer_word *>
 (%complementizer_like_sign
  synsem:loc:cat:(head:comp,
                  arg_st:[loc:cat:head:dsl:none])).

complementizer(CForm) :=
 (complementizer_word,
  synsem:loc:cat:head:cform:CForm).



