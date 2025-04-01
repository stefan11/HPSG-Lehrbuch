% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexicon.pl,v $
%%  $Revision: 1.7 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile '--->'/2.

das ---> @det(nom_or_acc,sg,neu,def_q).

die ---> @det(nom_or_acc,sg,fem,def_q).

% wir gedenken der Frau
% wir helfen der Frau
der ---> @det(gen_or_dat,sg,fem,def_q).

der ---> @det(nom,sg,mas,def_q).

% dem Mann/Buch
dem --->  @det(dat,sg,mas_or_neu,def_q).

% den Mann
den ---> @det(acc,sg,mas,def_q).

des ---> @det(gen,sg,mas_or_neu,def_q).

jede ---> @det(nom_or_acc,sg,fem,every_q).

jeder ---> @det(gen_or_dat,sg,fem,every_q).

jeder ---> @det(nom,sg,mas,every_q).


ein ---> @det(nom,sg,mas_or_neu,exists_q).

ein ---> @det(acc,sg,neu,exists_q).

eines ---> @det(gen,sg,mas_or_neu,exists_q).

% Syntaktische Eigenschaften erst, dann semantische sein = mas, ihr = fem
sein   ---> @possessive(nom_or_acc,sg,neu,third,sg,mas_or_neu).
sein   ---> @possessive(nom,       sg,mas,third,sg,mas_or_neu).
seine  ---> @possessive(nom_or_acc,sg,fem,third,sg,mas_or_neu).
seiner ---> @possessive(gen_or_dat,sg,fem,third,sg,mas_or_neu).


interessante ---> @attr_adj(interessant_rel).

kleine       ---> @attr_adj(klein_rel).

kluge        ---> @attr_adj(klug_rel).

treue        ---> @attr_adj_np(treu_rel,dat).

mutmaßliche  ---> @scopal_attr_adj(mutmaßlich_rel).

schwierige   ---> @attr_adj(schwierig_rel).



affe   ---> @noun(nom_or_acc,mas,sg,affe_rel).

affens ---> @noun(dat,mas,sg,affe_rel).

affen  ---> @noun(dat,mas,sg,affe_rel).

beispiel ---> @noun(nom_or_dat_or_acc,neu,sg,beispiel_rel).

buch   ---> @noun(nom_or_dat_or_acc,neu,sg,buch_rel).

buches ---> @noun(gen,neu,sg,buch_rel).

einhorn ---> @noun(nom_or_dat_or_acc,neu,sg,einhorn_rel).

einhorns ---> @noun(gen,neu,sg,einhorn_rel).

frau ---> @noun(case,fem,sg,frau_rel).

kind   ---> @noun(nom_or_dat_or_acc,neu,sg,kind_rel).

kindes ---> @noun(gen,neu,sg,kind_rel).

mann ---> @noun(nom_or_dat_or_acc,mas,sg,mann_rel).

mannes ---> @noun(gen,mas,sg,mann_rel).

mörder  ---> @noun(nom_or_dat_or_acc,mas,sg,mörder_rel).

mörders ---> @noun(gen,mas,sg,mörder_rel).

mitarbeiter ---> @noun(nom_or_dat_or_acc,mas,sg,mitarbeiter_rel).

mitarbeiters ---> @noun(gen,mas,sg,mitarbeiter_rel).

roman ---> @noun(nom_or_dat_or_acc,mas,sg,roman_rel).

romans ---> @noun(gen,mas,sg,roman_rel).

speisekammer ---> @noun(case,fem,sg,speisekammer_rel).

stock   ---> @noun(nom_or_dat_or_acc,mas,sg,stock_rel).

stockes ---> @noun(gen,mas,sg,stock_rel).

tochter ---> @relational_noun(case,fem,sg,tochter_rel).

tofu   ---> @noun(nom_or_dat_or_acc,mas,sg,tofu_rel).

tofus ---> @noun(gen,mas,sg,tofu_rel).

wurst ---> @noun(case,fem,sg,wurst_rel).


er  ---> @pers_pronoun(nom,third,sg,mas).

ihm ---> @pers_pronoun(dat,third,sg,mas).

ihn ---> @pers_pronoun(acc,third,sg,mas).

sie ---> @pers_pronoun(nom_or_acc,third,sg,fem).

aicke ---> @proper_noun(fem_or_mas,'Aicke').


bellt   ---> @intrans_verb(bellen_rel).

lacht   ---> @intrans_verb(lachen_rel).

schläft ---> @intrans_verb(schlafen_rel).

graut   ---> @subjlos_verb(dat,grauen_rel).


jagt  ---> @trans_verb(jagen_rel).

kennt ---> @trans_verb(kennen_rel).

liebt ---> @trans_verb(lieben_rel).


gab   ---> @ditrans_verb(geben_rel).

gibt  ---> @ditrans_verb(geben_rel).


denkt ---> @np_pp_verb(an_pform,acc,denken_an_rel).


an ---> @comp_prep(an_pform).

in ---> @location_noun_mod_prep(in_rel).

glaubt ---> @glauben_denken_verb(glauben_rel).



angeblich ---> @scopal_adv(angeblich_rel).

nicht ---> @scopal_adv(nicht_rel).

wahrscheinlich ---> @scopal_adv(wahrscheinlich_rel).

morgen ---> @isect_adv(morgen_rel).

oft ---> @isect_adv(oft_rel).


dass ---> @complementizer(dass).


empty
   (word,
    phon:[],
    loc:(Loc,
         cat:head:(verb,
                   initial:minus,
                   dsl:Loc)),
    rels:[],
    hcons:[],
    trace:vm).
