% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexicon.pl,v $
%%  $Revision: 1.8 $
%%      $Date: 2006/02/26 18:08:11 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile '--->'/2.

das ---> @det(nom_or_acc,sg,neu,def).


der ---> @det(nom,sg,mas,def).

% wir gedenken der Frau
% wir helfen der Frau
der ---> @det(gen_or_dat,sg,fem,def).


% dem Mann/Buch
dem --->  @det(dat,sg,mas_or_neu,def).

% den Mann
den ---> @det(acc,sg,mas,def).


des ---> @det(gen,sg,mas_or_neu,def).

die ---> @det(nom_or_acc,sg,fem,def).

 
buch   ---> @noun(nom_or_dat_or_acc,neu,sg,buch).

buches ---> @noun(gen,neu,sg,buch).


mann    ---> @noun(nom_or_dat_or_acc,mas,sg,mann).

mannes  ---> @noun(gen,mas,sg,mann).


mörder  ---> @noun(nom_or_dat_or_acc,mas,sg,mörder).

mörders ---> @noun(gen,mas,sg,mörder).


frau ---> @noun(case,fem,sg,frau).

speisekammer ---> @noun(case,fem,sg,speisekammer).

wurst ---> @noun(case,fem,sg,wurst).



er     ---> @pers_pronoun(nom,third,sg,mas).
seiner ---> @pers_pronoun(gen,third,sg,mas_or_neu).
ihm    ---> @pers_pronoun(dat,third,sg,mas_or_neu).
ihn    ---> @pers_pronoun(acc,third,sg,mas).

sie   ---> @pers_pronoun(nom_or_acc,third,sg,fem).
ihrer ---> @pers_pronoun(gen,       third,sg,fem).
ihr   ---> @pers_pronoun(dat,       third,sg,fem).

es    ---> @pers_pronoun(nom_or_acc,third,sg,neu).


meine  ---> @possessive(nom_or_acc,first, sg,genus,     sg,fem).
deine  ---> @possessive(nom_or_acc,second,sg,genus,     sg,fem).
seine  ---> @possessive(nom_or_acc,third, sg,mas_or_neu,sg,fem).
seiner ---> @possessive(gen_or_dat,third, sg,mas_or_neu,sg,fem).


die    ---> @rel_pronoun(nom_or_acc,third,sg,fem).
der    ---> @rel_pronoun(gen_or_dat,third,sg,fem).

der    ---> @rel_pronoun(nom,third,sg,mas).

dessen ---> @rel_pronoun(gen,third,sg,mas_or_neu).
dem    ---> @rel_pronoun(dat,third,sg,mas_or_neu).

den    ---> @rel_pronoun(acc,third,sg,mas).

das    ---> @rel_pronoun(nom_or_acc,third,sg,neu).

dessen ---> @possessive_rel_pronoun(sg,mas_or_neu).
deren  ---> @possessive_rel_pronoun(sg,fem).



bellt   ---> @intrans_verb(bellen).

lacht   ---> @intrans_verb(lachen).

schläft ---> @intrans_verb(schlafen).

graut   ---> @subjlos_verb(dat,grauen).


jagt  ---> @trans_verb(jagen).

kennt ---> @trans_verb(kennen).

liebt ---> @trans_verb(lieben).


gab   ---> @ditrans_verb(geben).

gibt  ---> @ditrans_verb(geben).


denkt ---> @np_pp_verb(an_pform,acc,denken_an).



an ---> @comp_prep(an_pform).



interessante ---> @attr_adj(interessant).

kluge        ---> @attr_adj(klug).


treue        ---> @attr_adj_np(treu,dat).


mutmaßliche  ---> @scopal_attr_adj(mutmaßlich).


in ---> @location_noun_mod_prep(in).

in ---> @location_verb_mod_prep(in).


nicht ---> @scopal_adv(nicht).

oft   ---> @scopal_adv(oft).


morgen ---> @temp_adv(morgen).

daß ---> @complementizer(daß_cform).



empty
   (trace,
    synsem:(loc:(Loc,
                 cat:head:(verb,
                           initial:minus,
                           dsl:Loc)),
            nonloc:slash:[],
            trace:vm
            )).

empty 
   (trace,
    synsem:(loc:Loc,
            nonloc:slash:[Loc],
            trace:extraction)).








