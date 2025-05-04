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

% complementizer_like_sign erbt hiervon.
% V1-Regel und Komplementierer.
spr_saturated_sign *>
  loc:cat:spr:[].

saturated_word *>
 loc:cat:arg_st:[].

% Für Artikelwörter und das Possessivpronomen.  Die RELS-Liste ist offen, so dass entweder nur die
% Information über einen Quantor darin enthalten sein kann oder aber noch weitere Relationen. Damit
% wird Beschreibung von Determinatoren und Possessivpronomen möglich.
determiner_word *>
 (%saturated_word Diese Information steht in der signatur
  loc:(cat:head:(det,
                 spec:loc:cont:(ind:Ind,
                                ltop:NLTop)),
       cont:(rels:hd:(% eine Relation eines Quantors z.B. exists_q
                      arg0:Ind,
                      rstr:Restr),
             hcons:[(qeq,
                     harg:Restr,
                     larg:NLTop)]))).


determiner(Case,Numerus,Genus) :=
(%determiner_word,
 loc:cat:head:(case:Case,
               num:Numerus,
               gen:Genus)).

% Genau ein Element in der RELS- und HCONS-Liste.
% Ließe sich mit rels:tl:e_liste effizienter aufschreiben. Aber weniger lesbar.
determiner *> 
 (%determiner_word
  loc:cont:rels:[_]).

det(Case,Numerus,Genus,Quant) :=
(@determiner(Case,Numerus,Genus),
 determiner,
 loc:cont:rels:hd:Quant).

possessive *>
 (%determiner_word
  loc:(cat:head:spec:loc:cont:(ind:Ind2,
                               ltop:NLTop),
       cont:(ind:(Ind,
                  index),
%        ltop:LTop,
             rels:[def_q,
                   (poss_rel,
                       lbl:NLTop,
                       arg0:event,
                       arg1:Ind,
                       arg2:Ind2)]))).

possessive(Case,NNumerus,NGenus,Person,Numerus,Genus) :=
 (@determiner(Case,NNumerus,NGenus),
  possessive,
  loc:cont:ind:(per:Person,
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
  loc:cont:hcons:[].

% expletives and markers
non_relational_le *>
  loc:cont:rels:[].

% complement prepositions and some complementizers.
transparent_head_le *>
 loc:(cat:arg_st:[loc:cont:(ind:Ind,
                            ltop:LTop) ],
      cont:(ind:Ind,
            ltop:LTop)).


arg0_le *>
  loc:cont:(ind:Ind,
            rels:hd:arg0:Ind).

ltop_lbl_le *>
  loc:cont:(ltop:Lbl,
            rels:hd:lbl:Lbl).

% alle Nomina
noun_word *>
 (%word
  loc:cat:head:(noun,
                initial:plus)).

% Nomen mit Determinator
det_noun_word *>
(%noun_word,
  %non_scopal_le
  %relational_arg0_word,  % enthält auch lbl:LTop
  loc:(cat:(head:case:Case,
            spr:[_],
            % Das erste Element der ARG-ST-Liste ist der Determinator.
            arg_st:hd:loc:cat:(head:(det,
                                     case:Case,
                                     num:Numerus,
                                     gen:Genus),
                               spr:[],
                               comps:[])),
       cont:ind:(               % Der Typ index folgt aus der Anwesneheit der Merkmale per, num, gen
                                per:third,
                                num:Numerus,
                                gen:Genus) )).
 

% alle einfachen Nomina (ohne Argument)
simple_noun *>
 (%det_noun_word,
  loc:cat:arg_st:tl:e_list ).

noun(Case,Genus,Numerus,Relation) :=
 (simple_noun,
  loc:(cat:head:case:Case,
       cont:(ind:(num:Numerus,
                  gen:Genus),
             rels:[Relation]))).


relational_noun *>
 (%det_noun_word
  loc:(cat:arg_st:tl:[loc:(cat:(head:(noun,
                                      case:gen),
                                spr:[],
                                comps:[]),
                           cont:ind:Ind2) ],
       cont:rels:hd:arg2:Ind2)).


relational_noun(Case,Genus,Numerus,Relation) :=
 (relational_noun,
  loc:(cat:head:case:Case,
       cont:(ind:(num:Numerus,
                  gen:Genus),
             rels:[Relation]))).


/*
pers_pronoun *>
 (%noun_word,
  %saturated_word
  loc:cont:ind:ref).
*/

pers_pronoun(Case,Person,Numerus,Genus) :=
 (pers_pronoun,
  loc:(cat:head:case:Case,
       cont:ind:(per:Person,
                 num:Numerus,
                 gen:Genus))).

proper_noun *>
 (%noun_word,
  %saturated_word
  loc:cont:(ind:Ind,
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
  loc:cont:(ind:gen:Genus,
            rels:tl:hd:name:(a_ Name))).

verb_word *>
 (%word,
  %arg0_ltop_lbl_le
  loc:(cat:(head:(verb,
                  vform:fin,
                  initial:minus),
            spr:[]),
       cont:ind:event)).


intrans_verb *>
 (%verb_word,
  loc:(cat:arg_st:hd: @np(nom,Ind),
       cont:rels:[arg1:Ind])).

strict_intrans_verb *>
 (%non_scopal_intrans_verb
  loc:cat:arg_st:[_]).

intrans_verb(Relation) :=
 (strict_intrans_verb,
  loc:cont:rels:hd:Relation).

np_pp_verb *> 
 (%non_scopal_intrans_verb,
  %bi_or_more_val_verb, 
  loc:cat:arg_st:tl:[ @pp ]).

np_pp_verb(PForm,Case,Relation) :=
 (np_pp_verb,
  loc:(cat:arg_st:tl:hd: @pp(PForm,Case),
       cont:rels:hd:Relation)).


subjlos_verb *>
 (%non_scopal_verb_word,
  loc:(cat:arg_st:[ @np(Ind) ],
       cont:rels:[arg2:Ind])).

subjlos_verb(Case,Relation) :=
 (subjlos_verb,
  loc:(cat:arg_st:[ @np(Case,_Ind) ],
       cont:rels:hd:Relation)).

% kennen, helfen verbs with at least two arguments and a nominative
bi_or_more_val_verb *>
 (%non_scopal_verb_word,
  loc:(cat:arg_st:[ @np(nom,Ind1), @xp(Ind2) |_ ],
       cont:rels:[(arg1:Ind1,
                   arg2:Ind2)])).

% kennen
strict_trans_verb *>
 (%trans_verb = bi_or_more_val_verb
  loc:cat:arg_st:[ _, @np(acc,_) ]).

trans_verb(Relation) :=
 (strict_trans_verb,
  loc:cont:rels:hd:Relation).

ditrans_verb *>
 (%trans_verb = bi_or_more_val_verb
  loc:(cat:arg_st:[ _, @np(dat,_),@np(acc,Ind3)  ],
       cont:rels:hd:arg3:Ind3)).

ditrans_verb(Relation) :=
 (ditrans_verb,
  loc:cont:rels:hd:Relation).

glauben_denken_verb *>
 (%intrans_verb,
  loc:(cat:arg_st:[ _,
                   (loc:(cat:(head:(comp,
                                    cform:dass),
                              spr:[],
                              comps:[]),
                         cont:ltop:Larg)) ],
       cont:(rels:[arg2:Harg],
             hcons:[(qeq,
                     harg:Harg,
                     larg:Larg)]))).


glauben_denken_verb(Relation) :=
 (glauben_denken_verb,
  loc:cont:rels:hd:Relation).

preposition_word *>
(%word,
 %non_scopal_le
 loc:cat:(head:(prep,
                initial:plus),
%          spr:[],
          arg_st:[ @np ] )).

comp_preposition *>
 (%preposition_word,
  %transparent_head_le % Shares IND and LTOP with argument.
  loc:cat:(head:case:Case,
           arg_st:[loc:cat:head:case:Case])).

comp_prep(PForm) :=
 (comp_preposition,
  loc:cat:head:pform:PForm).


n_modifier *>
 loc:cat:head:mod: @nbar.

% Das LBL wird vom Adjunkt im Schema beigesteuert.
% Adjektive und Adverbien
isect_modifier_le *>
(%non_scopal_le,
 loc:(cat:head:(scopal:minus,
                mod:loc:cont:ind:Ind),
      cont:(ind:Ind,
            rels:[arg1:Ind]))).
 
attr_adjective_word *>
 (%n_modifier_word,
  loc:cat:(head:attr_adj,
           spr:[])).

% klug
simple_attr_adj *>
 (%intersective_adj
  loc:cat:arg_st:[]).

attr_adj(Relation) :=
 (simple_attr_adj,
  loc:cont:rels:hd:Relation).

% treu
attr_np_adj *>
 (%intersective_adj
  loc:(cat:arg_st:[@np(Ind2)],
       cont:rels:hd:arg2:Ind2)).

attr_adj_np(Relation,Case) :=
 (attr_np_adj,
  loc:(cat:arg_st:[@np(Case,_Ind2)],
       cont:rels:hd:Relation)).


scopal_modifier_le *>
  (%ltop_lbl_le
   loc:(cat:head:(mod:loc:cont:ltop:VLTop,
                  scopal:plus),
        cont:(ltop:LTop,
              rels:[(lbl:LTop,
                     arg1:Arg1)],
              hcons:[(qeq,
                      harg:Arg1,
                      larg:VLTop)]))).

% mutmaßlich
scopal_adj *>
 (%saturated_word
  %attr_adjective_word
  %scopal_modifier_le
  loc:(cat:head:mod:loc:cont:ind:Ind,
       cont:ind:Ind)).

scopal_attr_adj(Relation) :=
 (scopal_adj,
  loc:cont:rels:[Relation]).

v_modifier *>
 loc:cat:head:mod:loc:cat:head:(adj_or_verb,
                                initial:minus).

adv_word *>
 loc:cat:head:adv.

% wahrscheinlich
scopal_adv(Relation) :=
 (scopal_adv_word,
  loc:cont:rels:[Relation]).   

isect_adv(Relation) :=
 (isect_adv_word,
  loc:cont:rels:[Relation]).

mod_preposition *>
 (%preposition_word,
  loc:cat:head:mod_prep).

noun_mod_preposition *>
 (%mod_preposition
  %isect_n_modifier_word
  loc:(cat:(head:(mod:loc:cont:ind:Ind,
                  pre_modifier:minus),
            arg_st:[ @np(Ind2) ] ),
       cont:(ind:Ind,
             rels:hd:(arg1:Ind,
                      arg2:Ind2)))).

location_noun_mod_prep *>
 (%noun_mod_preposition
  loc:cat:arg_st:[ @np(dat,_) ] ).

location_noun_mod_prep(Relation) :=
 (location_noun_mod_prep,
  loc:cont:rels:hd:Relation).


complementizer_like_sign *>
 (%transparent_head_le
  %spr_saturated_le
  loc:cat:(head:initial:plus,
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
  loc:cat:(head:comp,
           arg_st:[loc:cat:head:dsl:none])).

complementizer(CForm) :=
 (complementizer_word,
  loc:cat:head:cform:CForm).



