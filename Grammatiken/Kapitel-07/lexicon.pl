% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexicon.pl,v $
%%  $Revision: 1.11 $
%%      $Date: 2006/03/20 19:58:41 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: 
%%   Language: Trale
%      System: TRALE 2.3.7 under Sicstus 3.9.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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




er  ---> @pers_pronoun(nom,third,sg,mas).

ihm ---> @pers_pronoun(dat,third,sg,mas).

ihn ---> @pers_pronoun(acc,third,sg,mas).


sie ---> @pers_pronoun(nom_or_acc,third,sg,fem).




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

großem ---> (cat:(head:mod:(cat:(head:noun,
                                subcat:[(cat:head:det)]),
                           cont:nucleus:(ind:Ind,
                                 restr:Restr)),
                 subcat:[]),
               cont:nucleus:(ind:Ind,
                     restr:[(groß,
                             arg1:Ind)|Restr])
           ).

seine  ---> @possessive(nom_or_acc,third, sg,mas_or_neu,sg,fem).
seiner ---> @possessive(gen_or_dat,third, sg,mas_or_neu,sg,fem).

