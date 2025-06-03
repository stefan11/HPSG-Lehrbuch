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

das ---> @det(nom_or_acc,sg,mas_or_neu,strong,def_q).


der ---> @det(nom,sg,mas,strong,def_q).

% wir gedenken der Frau
% wir helfen der Frau
der ---> @det(gen_or_dat,sg,fem,strong,def_q).


% dem Mann/Buch
dem --->  @det(dat,sg,mas_or_neu,strong,def_q).

% den Mann
den ---> @det(acc,sg,mas,strong,def_q).


des ---> @det(gen,sg,mas_or_neu,strong,def_q).

die ---> @det(nom_or_acc,sg,fem,strong,def_q).


die ---> @det(nom_or_acc,pl,strong,def_q).
den ---> @det(dat,       pl,strong,def_q).
der ---> @det(gen,       pl,strong,def_q).


ein   ---> @det(nom,       sg,mas,       weak,  exists_q).
ein   ---> @det(nom_or_acc,sg,neu,       weak,  exists_q).
eine  ---> @det(nom_or_acc,sg,fem,       strong,exists_q).
einen ---> @det(acc,       sg,mas,       strong,exists_q).
einem ---> @det(dat,       sg,mas_or_neu,strong,exists_q).

einer ---> @det(gen_or_dat,sg,fem,       strong,exists_q).
eines ---> @det(gen,       sg,mas_or_neu,strong,exists_q).


jede  ---> @det(nom_or_acc,sg,fem,strong,every_q).
jeder ---> @det(gen_or_dat,sg,fem,strong,every_q).
jeder ---> @det(nom,       sg,mas,strong,every_q).



die    ---> @rel_pronoun(nom_or_acc,third,sg,fem).
der    ---> @rel_pronoun(gen_or_dat,third,sg,fem).

der    ---> @rel_pronoun(nom,third,sg,mas).

dessen ---> @rel_pronoun(gen,third,sg,mas_or_neu).
dem    ---> @rel_pronoun(dat,third,sg,mas_or_neu).

den    ---> @rel_pronoun(acc,third,sg,mas).

das    ---> @rel_pronoun(nom_or_acc,third,sg,neu).


dessen ---> @possessive_rel_pronoun(mas_or_neu,sg).
deren  ---> @possessive_rel_pronoun(fem,sg).


% Nomina neutr

buch    ---> @noun(nom_or_dat_or_acc,neu,sg,buch_rel).
buches  ---> @noun(gen,              neu,sg,buch_rel).
bücher  ---> @noun(nom_or_gen_or_acc,neu,pl,buch_rel).
büchern ---> @noun(dat,              neu,pl,buch_rel).

kind   ---> @noun(nom_or_dat_or_acc,neu,sg,kind_rel).
kindes ---> @noun(gen,              neu,sg,kind_rel).
kinder ---> @noun(nom_or_gen_or_acc,neu,pl,kind_rel).
kindern ---> @noun(dat,             neu,pl,kind_rel).


beispiel ---> @noun(nom_or_dat_or_acc,neu,sg,beispiel_rel).

bild   ---> @relational_noun(nom_or_dat_or_acc,neu,sg,bild_rel).

buch   ---> @noun(nom_or_dat_or_acc,neu,sg,buch_rel).
buches ---> @noun(gen,neu,sg,buch_rel).

einhorn ---> @noun(nom_or_dat_or_acc,neu,sg,einhorn_rel).
einhorns ---> @noun(gen,neu,sg,einhorn_rel).

fahrrad  ---> @noun(nom_or_dat_or_acc,neu,sg,fahrrad_rel).
fahrrads ---> @noun(gen,              neu,sg,fahrrad_rel).

lied   ---> @noun(nom_or_dat_or_acc,neu,sg,lied_rel).
liedes ---> @noun(gen,              neu,sg,lied_rel).

märchen  ---> @noun(nom_or_dat_or_acc,neu,sg,märchen_rel).
märchens ---> @noun(gen,              neu,sg,märchen_rel).


% Achtung! Mädchen hat das Genus Neutrum, für Pronomenbindung
% ist allerdings feminin oder neutrum möglich.
% Das Mädchen ... Sie/es ...

mädchen  ---> @noun(nom_or_dat_or_acc,neu,  fem_or_neu,sg,mädchen_rel).
mädchens ---> @noun(gen,              neu,  fem_or_neu,sg,mädchen_rel).
mädchen  ---> @noun(case,             genus,fem_or_neu,pl,mädchen_rel).


% Nomina mask

affe   ---> @noun(nom_or_acc,mas,sg,affe_rel).
affens ---> @noun(gen,       mas,sg,affe_rel).
affen  ---> @noun(dat_or_acc,mas,sg,affe_rel).
affen  ---> @noun(case,      mas,pl,affe_rel).

aufsatz   ---> @noun(nom_or_dat_or_acc,mas,sg,aufsatz_rel).
aufsatzes ---> @noun(gen,              mas,sg,aufsatz_rel).
aufsätze  ---> @noun(nom_or_gen_or_acc,mas,pl,aufsatz_rel).
aufsätzen ---> @noun(dat,              mas,pl,aufsatz_rel).

ball   ---> @noun(nom_or_dat_or_acc,mas,sg,ball_rel).
balls  ---> @noun(gen,              mas,sg,ball_rel).
bälle  ---> @noun(nom_or_gen_or_acc,mas,pl,ball_rel).
bällen ---> @noun(dat,              mas,pl,ball_rel).

film   ---> @noun(nom_or_dat_or_acc,mas,sg,film_rel).
films  ---> @noun(gen,              mas,sg,film_rel).
filme  ---> @noun(nom_or_gen_or_acc,mas,pl,film_rel).
filmen ---> @noun(dat,              mas,pl,film_rel).

mann    ---> @noun(nom_or_dat_or_acc,mas,sg,mann_rel).
mannes  ---> @noun(gen,              mas,sg,mann_rel).
männer  ---> @noun(nom_or_gen_or_acc,mas,pl,mann_rel).
männern ---> @noun(dat,              mas,pl,mann_rel).

mitarbeiter  ---> @noun(nom_or_dat_or_acc,mas,sg,mitarbeiter_rel).
mitarbeiters ---> @noun(gen,              mas,sg,mitarbeiter_rel).
mitarbeiter  ---> @noun(nom_or_gen_or_acc,mas,pl,mitarbeiter_rel).
mitarbeitern ---> @noun(dat,              mas,pl,mitarbeiter_rel).

mörder  ---> @noun(nom_or_dat_or_acc,mas,sg,mörder_rel).
mörders ---> @noun(gen,              mas,sg,mörder_rel).
mörder  ---> @noun(nom_or_gen_or_acc,mas,pl,mörder_rel).
mördern ---> @noun(dat,              neu,pl,mörder_rel).

roman   ---> @noun(nom_or_dat_or_acc,mas,sg,roman_rel).
romans  ---> @noun(gen,              mas,sg,roman_rel).
romane  ---> @noun(nom_or_gen_or_acc,mas,pl,roman_rel).
romanen ---> @noun(dat,              mas,pl,roman_rel).


stock    ---> @noun(nom_or_dat_or_acc,mas,sg,stock_rel).
stockes  ---> @noun(gen,              mas,sg,stock_rel).
stöcker  ---> @noun(nom_or_gen_or_acc,mas,pl,stock_rel).
stöckern ---> @noun(dat,              mas,pl,stock_rel).

tofu  ---> @noun(nom_or_dat_or_acc,mas,sg,tofu_rel).
tofus ---> @noun(gen,              mas,sg,tofu_rel).



% Nomina fem

frau   ---> @noun(case,fem,sg,frau_rel).
frauen ---> @noun(case,fem,pl,frau_rel).

speisekammer  ---> @noun(case,fem,sg,speisekammer_rel).
speisekammern ---> @noun(case,fem,pl,speisekammer_rel).

tochter  ---> @relational_noun(case,             fem,sg,tochter_rel).
töchter  ---> @relational_noun(nom_or_gen_or_acc,fem,pl,tochter_rel).
töchtern ---> @relational_noun(dat,              fem,pl,tochter_rel).

wurst   ---> @noun(case,fem,sg,wurst_rel).
würste  ---> @noun(nom_or_gen_or_acc,fem,pl,wurst_rel).
würsten ---> @noun(dat,              fem,pl,wurst_rel).


% adjektivisch flektierte Nomina
% Die Flexionsinformation ist identisch mit der der Adjektive,
% außer daß das Genus nie neutrum ist, da Beamte immer mas
% oder fem sind.
%
% Auskommentierte Formen werden nicht gebraucht. Bei Adjektiven sind
% sie notwendig, da der Artikel wegfallen kann:
%
% Er rechnet mit frischer Milch.
%
% Für den Nominativ & Akkusativ braucht man die Formen aber, da in Kopulakonstruktionen
% der Artikel wegfallen kann zulässig ist.
% 
% Er ist Beamter.
% Er ließ ihn Beamten werden.


beamte ---> @adj_noun(nom_or_acc,fem,        sg,dtype, beamter_rel).
beamte ---> @adj_noun(nom,       mas,        sg,strong,beamter_rel).
beamte ---> @adj_noun(nom_or_acc,fem_or_mas, pl,weak,  beamter_rel).

beamten ---> @adj_noun(gen_or_dat,fem_or_mas,sg,strong,beamter_rel).
%beamten ---> @adj_noun(gen,       mas,       sg,weak,  beamter_rel).  % nicht gebraucht
beamten ---> @adj_noun(case,      fem_or_mas,pl,strong,beamter_rel).
beamten ---> @adj_noun(acc,       mas,       sg,dtype, beamter_rel).
beamten ---> @adj_noun(gen,       mas,       pl,weak,  beamter_rel).
beamten ---> @adj_noun(dat,       fem_or_mas,pl,weak,  beamter_rel).

%beamtem ---> @adj_noun(dat,       mas,       sg,weak,  beamter_rel).  % nicht gebraucht


%
%beamter ---> @noun(gen_or_dat,fem,       sg,weak,  beamter_rel).      % nicht gebraucht

beamter ---> @adj_noun(nom,       mas,       sg,weak,  beamter_rel).
beamter ---> @adj_noun(gen,       fem_or_mas,pl,weak,  beamter_rel).




% Personalpronomina

ich    ---> @pers_pronoun(nom,first,sg).
meiner ---> @pers_pronoun(gen,first,sg).
mir    ---> @pers_pronoun(dat,first,sg).
mich   ---> @pers_pronoun(acc,first,sg).


du     ---> @pers_pronoun(nom,second,sg).
deiner ---> @pers_pronoun(gen,second,sg).
dir    ---> @pers_pronoun(dat,second,sg).
dich   ---> @pers_pronoun(acc,second,sg).


er     ---> @pers_pronoun(nom,third,sg,mas).
seiner ---> @pers_pronoun(gen,third,sg,mas_or_neu).
ihm    ---> @pers_pronoun(dat,third,sg,mas_or_neu).
ihn    ---> @pers_pronoun(acc,third,sg,mas).

sie   ---> @pers_pronoun(nom_or_acc,third,sg,fem).
ihrer ---> @pers_pronoun(gen,       third,sg,fem).
ihr   ---> @pers_pronoun(dat,       third,sg,fem).

es    ---> @pers_pronoun(nom_or_acc,third,sg,neu).


wir     ---> @pers_pronoun(nom,       first,pl).
unserer ---> @pers_pronoun(gen,       first,pl).
uns     ---> @pers_pronoun(dat_or_acc,first,pl).


ihr   ---> @pers_pronoun(nom,       second,pl).
eurer ---> @pers_pronoun(gen,       second,pl).
euch  ---> @pers_pronoun(dat_or_acc,second,pl).


sie   ---> @pers_pronoun(nom_or_acc,third,pl).
ihrer ---> @pers_pronoun(gen,       third,pl).
ihnen ---> @pers_pronoun(dat,       third,pl).


% Possessivpronomina

% Syntaktische Eigenschaften erst, dann semantische sein = mas, ihr = fem

mein   ---> @possessive(nom,       first, sg,genus,     sg,mas,       weak).
mein   ---> @possessive(nom_or_acc,first, sg,genus,     sg,neu,       weak).
meine  ---> @possessive(nom_or_acc,first, sg,genus,     sg,fem,       strong).
meine  ---> @possessive(nom_or_acc,first, sg,genus,     pl,genus,     strong).

meinen ---> @possessive(acc,       first, sg,genus,     sg,mas,       strong).
meinen ---> @possessive(dat,       first, sg,genus,     pl,genus,     strong).

meinem ---> @possessive(dat,       first, sg,genus,     sg,mas_or_neu,strong).

meiner ---> @possessive(gen_or_dat,first, sg,genus,     sg,fem,       strong).
meiner ---> @possessive(gen,       first, sg,genus,     pl,genus,     strong).

meines ---> @possessive(gen,       first, sg,genus,     sg,mas_or_neu,strong).

dein   ---> @possessive(nom,       second,sg,genus,     sg,mas,       weak).
dein   ---> @possessive(nom_or_acc,second,sg,genus,     sg,neu,       weak).
deine  ---> @possessive(nom_or_acc,second,sg,genus,     sg,fem,       strong).
deine  ---> @possessive(nom_or_acc,second,sg,genus,     pl,genus,     strong).

deinen ---> @possessive(acc,       second,sg,genus,     sg,mas,       strong).
deinen ---> @possessive(dat,       second,sg,genus,     pl,genus,     strong).

deinem ---> @possessive(dat,       second,sg,genus,     sg,mas_or_neu,strong).

deiner ---> @possessive(gen_or_dat,second,sg,genus,     sg,fem,       strong).
deiner ---> @possessive(gen,       second,sg,genus,     pl,genus,     strong).

deines ---> @possessive(gen,       second, sg,genus,    sg,mas_or_neu,strong).

sein   ---> @possessive(nom,       third, sg,mas_or_neu,sg,mas,       weak).
sein   ---> @possessive(nom_or_acc,third, sg,mas_or_neu,sg,neu,       weak).
seine  ---> @possessive(nom_or_acc,third, sg,mas_or_neu,sg,fem,       strong).
seine  ---> @possessive(nom_or_acc,third, sg,mas_or_neu,pl,genus,     strong).

seinen ---> @possessive(acc,       third, sg,mas_or_neu,sg,mas,       strong).
seinen ---> @possessive(dat,       third, sg,mas_or_neu,pl,genus,     strong).

seinem ---> @possessive(dat,       third, sg,mas_or_neu,sg,mas_or_neu,strong).

seiner ---> @possessive(gen_or_dat,third, sg,mas_or_neu,sg,fem,       strong).
seiner ---> @possessive(gen,       third, sg,mas_or_neu,pl,genus,     strong).

seines ---> @possessive(gen,       third, sg,mas_or_neu,sg,mas_or_neu,strong).



aicke ---> @proper_noun(fem_or_mas,'Aicke').

% Verben

belle    ---> @intrans_verb(first, sg, bellen_rel).
bellst   ---> @intrans_verb(second,sg, bellen_rel).
bellt    ---> @intrans_verb(third, sg, bellen_rel).

bellen   ---> @intrans_verb(first_or_third, pl, bellen_rel).
bellt    ---> @intrans_verb(second,         pl, bellen_rel).

bellen   ---> @intrans_verb(bse, bellen_rel).

lache    ---> @intrans_verb(first, sg, lachen_rel).
lachst   ---> @intrans_verb(second,sg, lachen_rel).
lacht    ---> @intrans_verb(third, sg, lachen_rel).

lachen   ---> @intrans_verb(first_or_third, pl, lachen_rel).
lacht    ---> @intrans_verb(second,         pl, lachen_rel).

lachen   ---> @intrans_verb(bse, lachen_rel).

schlafe  ---> @intrans_verb(first, sg, schlafen_rel).
schläfst ---> @intrans_verb(second,sg, schlafen_rel).
schläft  ---> @intrans_verb(third, sg, schlafen_rel).

schlafen ---> @intrans_verb(first_or_third, pl, schlafen_rel).
schlaft  ---> @intrans_verb(second,         pl, schlafen_rel).

schlafen ---> @intrans_verb(bse, schlafen_rel).

spiele  ---> @intrans_verb(first,  sg, spielen_rel).
spielst ---> @intrans_verb(second, sg, spielen_rel).
spielt  ---> @intrans_verb(third,  sg, spielen_rel).

spielen ---> @intrans_verb(first_or_third, pl, spielen_rel).
spielt  ---> @intrans_verb(second,         pl, spielen_rel).

spielen ---> @intrans_verb(bse, spielen_rel).

graut    ---> @subjlos_verb(fin,dat,grauen_rel).
grauen   ---> @subjlos_verb(bse,dat,grauen_rel).

helfe    ---> @np_np_dat_verb(first, sg, helfen_rel).
hilfst   ---> @np_np_dat_verb(second,sg, helfen_rel).
hilft    ---> @np_np_dat_verb(third, sg, helfen_rel).

helfen   ---> @np_np_dat_verb(first_or_third, pl, helfen_rel).
helft    ---> @np_np_dat_verb(second,         pl, helfen_rel).

helfen   ---> @np_np_dat_verb(bse, helfen_rel).

jage     ---> @trans_verb(first, sg, jagen_rel).
jagst    ---> @trans_verb(second,sg, jagen_rel).
jagt     ---> @trans_verb(third, sg, jagen_rel).

jagen    ---> @trans_verb(first_or_third, pl, jagen_rel).
jaget    ---> @trans_verb(second,         pl, jagen_rel).

jagen    ---> @trans_verb(bse, jagen_rel).


kenne    ---> @trans_verb(first, sg, kennen_rel).
kennst   ---> @trans_verb(second,sg, kennen_rel).
kennt    ---> @trans_verb(third, sg, kennen_rel).

kennen   ---> @trans_verb(first_or_third, pl, kennen_rel).
kennt    ---> @trans_verb(second,         pl, kennen_rel).

kennen   ---> @trans_verb(bse, kennen_rel).

lese     ---> @trans_verb(first, sg, lesen_rel).
liest    ---> @trans_verb(second,sg, lesen_rel).
liest    ---> @trans_verb(third, sg, lesen_rel).

lesen    ---> @trans_verb(first_or_third, pl, lesen_rel).
lest     ---> @trans_verb(second,         pl, lesen_rel).

lesen    ---> @trans_verb(bse, lesen_rel).


liebe    ---> @trans_verb(first, sg, lieben_rel).
liebst   ---> @trans_verb(second,sg, lieben_rel).
liebt    ---> @trans_verb(third, sg, lieben_rel).

lieben   ---> @trans_verb(first_or_third, pl, lieben_rel).
liebt    ---> @trans_verb(second,         pl, lieben_rel).

lieben   ---> @trans_verb(bse, lieben_rel).


nehme  ---> @trans_verb(first, sg, nehmen_rel).
nimmst ---> @trans_verb(second,sg, nehmen_rel).
nimmt  ---> @trans_verb(third, sg, nehmen_rel).

nehmen ---> @trans_verb(first_or_third, pl, nehmen_rel).
nehmt  ---> @trans_verb(second,         pl, nehmen_rel).

nehmen ---> @trans_verb(bse, nehmen_rel).

singe  ---> @trans_verb(first, sg, singen_rel).
singst ---> @trans_verb(second,sg, singen_rel).
singt  ---> @trans_verb(third, sg, singen_rel).

singen ---> @trans_verb(first_or_third, pl, singen_rel).
singt  ---> @trans_verb(second,         pl, singen_rel).

singen ---> @trans_verb(bse, singen_rel).


gebe  ---> @ditrans_verb(first, sg, geben_rel).
gibst ---> @ditrans_verb(second,sg, geben_rel).
gibt  ---> @ditrans_verb(third, sg, geben_rel).

geben   ---> @trans_verb(first_or_third, pl, geben_rel).
gebt    ---> @trans_verb(second,         pl, geben_rel).

gab   ---> @ditrans_verb(first_or_third, sg, geben_rel).

geben   ---> @trans_verb(bse, geben_rel).


erzähle  ---> @ditrans_verb(first, sg, erzählen_rel).
erzählst ---> @ditrans_verb(second,sg, erzählen_rel).
erzählt  ---> @ditrans_verb(third, sg, erzählen_rel).

erzählen ---> @trans_verb(first_or_third, pl, erzählen_rel).
erzählt  ---> @trans_verb(second,         pl, erzählen_rel).

erzählte ---> @ditrans_verb(first_or_third, sg, erzählen_rel).

erzählen ---> @ditrans_verb(bse,erzählen_rel).



denke  ---> @np_pp_verb(first, sg, an_pform,acc,denken_an_rel).
denkst ---> @np_pp_verb(second,sg, an_pform,acc,denken_an_rel).
denkt  ---> @np_pp_verb(third, sg, an_pform,acc,denken_an_rel).

denken ---> @np_pp_verb(first_or_third, pl, an_pform,acc,denken_an_rel).
denkt  ---> @np_pp_verb(second,         pl, an_pform,acc,denken_an_rel).

denken ---> @np_pp_verb(bse, an_pform,acc,denken_an_rel).


glaube  ---> @glauben_denken_verb(first, sg,glauben_rel).
glaubst ---> @glauben_denken_verb(second,sg,glauben_rel).
glaubt  ---> @glauben_denken_verb(third,sg,glauben_rel).

glauben ---> @glauben_denken_verb(first_or_third,pl,glauben_rel).
glaubt  ---> @glauben_denken_verb(second,        pl,glauben_rel).

glauben ---> @glauben_denken_verb(bse,glauben_rel).


% Modalverben

darf   ---> @modal_verb(first_or_third,sg,dürfen_rel).
darfst ---> @modal_verb(second,        sg,dürfen_rel).

dürfen ---> @modal_verb(first_or_third,pl,dürfen_rel).
dürft  ---> @modal_verb(second,        pl,dürfen_rel).

dürfen ---> @modal_verb(bse,dürfen_rel).

kann   ---> @modal_verb(first_or_third,sg,können_rel).
kannst ---> @modal_verb(second,        sg,können_rel).

können ---> @modal_verb(first_or_third,pl,können_rel).
könnt  ---> @modal_verb(second,        pl,können_rel).

können ---> @modal_verb(bse,können_rel).

muss    ---> @modal_verb(first_or_third,sg,müssen_rel).
musst   ---> @modal_verb(second,        sg,müssen_rel).

müssen ---> @modal_verb(first_or_third,pl,müssen_rel).
müsst  ---> @modal_verb(second,        pl,müssen_rel).

müssen ---> @modal_verb(bse,müssen_rel).


will   ---> @modal_verb(first_or_third,sg,wollen_rel).
willst ---> @modal_verb(second,        sg,wollen_rel).

wollen ---> @modal_verb(first_or_third,pl,wollen_rel).
wollt  ---> @modal_verb(second,        pl,wollen_rel).

wollen ---> @modal_verb(bse,wollen_rel).


% Hilfsverben

werde ---> @futur_aux_verb(first,  sg).
wirst ---> @futur_aux_verb(second, sg).
wird  ---> @futur_aux_verb(third,  sg).

werden ---> @futur_aux_verb(first_or_third, pl).
werdet ---> @futur_aux_verb(second,         pl).

habe  ---> @prefect_aux_verb(first, sg).
hast  ---> @prefect_aux_verb(second,sg).
hat   ---> @prefect_aux_verb(third, sg).
haben ---> @prefect_aux_verb(first_or_third, pl).
habt  ---> @prefect_aux_verb(second        , pl).

haben ---> @perfect_aux_verb(bse).


an  ---> @comp_prep(an_pform,acc).
von ---> @comp_prep(an_pform,dat).


in ---> @location_noun_mod_prep(in_rel).
in ---> @location_verb_mod_prep(in_rel).




interessante ---> @attr_adj(nom_or_acc,fem,sg,dtype, interessant_rel).
interessante ---> @attr_adj(nom,       mas,sg,strong,interessant_rel).
interessante ---> @attr_adj(nom_or_acc,neu,sg,strong,interessant_rel).
interessante ---> @attr_adj(nom_or_acc,    pl,weak,  interessant_rel).

interessanten ---> @attr_adj(gen_or_dat,genus,     sg,strong,interessant_rel).
interessanten ---> @attr_adj(case,      genus,     pl,strong,interessant_rel).
interessanten ---> @attr_adj(acc,       mas,       sg,dtype, interessant_rel).
interessanten ---> @attr_adj(gen,       mas,       sg,weak,  interessant_rel).
interessanten ---> @attr_adj(dat,       genus,     pl,weak,  interessant_rel).

interessantem ---> @attr_adj(dat,       mas_or_neu,sg,weak,  interessant_rel).

interessanter ---> @attr_adj(nom,       mas,       sg,weak,  interessant_rel).
interessanter ---> @attr_adj(gen_or_dat,fem,       sg,weak,  interessant_rel).
interessanter ---> @attr_adj(gen,       genus,     pl,weak,  interessant_rel).

interessantes ---> @attr_adj(nom_or_acc,neu,       sg,weak,  interessant_rel).


kluge ---> @attr_adj(nom_or_acc,fem,sg,dtype, klug_rel).
kluge ---> @attr_adj(nom,       mas,sg,strong,klug_rel).
kluge ---> @attr_adj(nom_or_acc,neu,sg,strong,klug_rel).
kluge ---> @attr_adj(nom_or_acc,    pl,weak,  klug_rel).

klugen ---> @attr_adj(gen_or_dat,genus,     sg,strong,klug_rel).
klugen ---> @attr_adj(case,      genus,     pl,strong,klug_rel).
klugen ---> @attr_adj(acc,       mas,       sg,dtype, klug_rel).
klugen ---> @attr_adj(gen,       mas_or_neu,sg,weak,  klug_rel).
klugen ---> @attr_adj(dat,       genus,     pl,weak,  klug_rel).

klugem ---> @attr_adj(dat,       mas_or_neu,sg,weak,  klug_rel).

kluger ---> @attr_adj(nom,       mas,       sg,weak,  klug_rel).
kluger ---> @attr_adj(gen_or_dat,fem,       sg,weak,  klug_rel).
kluger ---> @attr_adj(gen,       genus,     pl,weak,  klug_rel).


kluges ---> @attr_adj(nom_or_acc,neu,       sg,weak,  klug_rel).

kleine ---> @attr_adj(nom_or_acc,fem,sg,dtype, klein_rel).
kleine ---> @attr_adj(nom,       mas,sg,strong,klein_rel).
kleine ---> @attr_adj(nom_or_acc,neu,sg,strong,klein_rel).
kleine ---> @attr_adj(nom_or_acc,    pl,weak,  klein_rel).

kleinen ---> @attr_adj(gen_or_dat,genus,     sg,strong,klein_rel).
kleinen ---> @attr_adj(case,      genus,     pl,strong,klein_rel).
kleinen ---> @attr_adj(acc,       mas,       sg,dtype, klein_rel).
kleinen ---> @attr_adj(gen,       mas_or_neu,sg,weak,  klein_rel).
kleinen ---> @attr_adj(dat,       genus,     pl,weak,  klein_rel).

kleinem ---> @attr_adj(dat,       mas_or_neu,sg,weak,  klein_rel).

kleiner ---> @attr_adj(nom,       mas,       sg,weak,  klein_rel).
kleiner ---> @attr_adj(gen_or_dat,fem,       sg,weak,  klein_rel).
kleiner ---> @attr_adj(gen,       genus,     pl,weak,  klein_rel).

kleines ---> @attr_adj(nom_or_acc,neu,       sg,weak,  klein_rel).


schöne ---> @attr_adj(nom_or_acc,fem,sg,dtype, schön_rel).
schöne ---> @attr_adj(nom,       mas,sg,strong,schön_rel).
schöne ---> @attr_adj(nom_or_acc,neu,sg,strong,schön_rel).
schöne ---> @attr_adj(nom_or_acc,    pl,weak,  schön_rel).

schönen ---> @attr_adj(gen_or_dat,genus,     sg,strong,schön_rel).
schönen ---> @attr_adj(case,      genus,     pl,strong,schön_rel).
schönen ---> @attr_adj(acc,       mas,       sg,dtype, schön_rel).
schönen ---> @attr_adj(gen,       mas_or_neu,sg,weak,  schön_rel).
schönen ---> @attr_adj(dat,       genus,     pl,weak,  schön_rel).

schönem ---> @attr_adj(dat,       mas_or_neu,sg,weak,  schön_rel).

schöner ---> @attr_adj(nom,       mas,       sg,weak,  schön_rel).
schöner ---> @attr_adj(gen_or_dat,fem,       sg,weak,  schön_rel).
schöner ---> @attr_adj(gen,       genus,     pl,weak,  schön_rel).

schönes ---> @attr_adj(nom_or_acc,neu,       sg,weak,  schön_rel).


schwierige ---> @attr_adj(nom_or_acc,fem,sg,dtype, schwierig_rel).
schwierige ---> @attr_adj(nom,       mas,sg,strong,schwierig_rel).
schwierige ---> @attr_adj(nom_or_acc,neu,sg,strong,schwierig_rel).
schwierige ---> @attr_adj(nom_or_acc,    pl,weak,  schwierig_rel).

schwierigen ---> @attr_adj(gen_or_dat,genus,     sg,strong,schwierig_rel).
schwierigen ---> @attr_adj(case,      genus,     pl,strong,schwierig_rel).
schwierigen ---> @attr_adj(acc,       mas,       sg,dtype, schwierig_rel).
schwierigen ---> @attr_adj(gen,       mas_or_neu,sg,weak,  schwierig_rel).
schwierigen ---> @attr_adj(dat,       genus,     pl,weak,  schwierig_rel).

schwierigem ---> @attr_adj(dat,       mas_or_neu,sg,weak,  schwierig_rel).

schwieriger ---> @attr_adj(nom,       mas,       sg,weak,  schwierig_rel).
schwieriger ---> @attr_adj(gen_or_dat,fem,       sg,weak,  schwierig_rel).
schwieriger ---> @attr_adj(gen,       genus,     pl,weak,  schwierig_rel).

schwieriges ---> @attr_adj(nom_or_acc,neu,       sg,weak,  schwierig_rel).


treue ---> @attr_adj_np(nom_or_acc,fem,sg,dtype, treu_rel,dat).
treue ---> @attr_adj_np(nom,       mas,sg,strong,treu_rel,dat).
treue ---> @attr_adj_np(nom_or_acc,neu,sg,strong,treu_rel,dat).
treue ---> @attr_adj_np(nom_or_acc,    pl,weak,  treu_rel,dat).

treuen ---> @attr_adj_np(gen_or_dat,genus,     sg,strong,treu_rel,dat).
treuen ---> @attr_adj_np(case,      genus,     pl,strong,treu_rel,dat).
treuen ---> @attr_adj_np(acc,       mas,       sg,dtype, treu_rel,dat).
treuen ---> @attr_adj_np(gen,       mas_or_neu,sg,weak,  treu_rel,dat).
treuen ---> @attr_adj_np(dat,       genus,     pl,weak,  treu_rel,dat).

treuem ---> @attr_adj_np(dat,       mas_or_neu,sg,weak,  treu_rel,dat).

treuer ---> @attr_adj_np(nom,       mas,       sg,weak,  treu_rel,dat).
treuer ---> @attr_adj_np(gen_or_dat,fem,       sg,weak,  treu_rel,dat).
treuer ---> @attr_adj_np(gen,       genus,     pl,weak,  treu_rel,dat).


treues ---> @attr_adj_np(nom_or_acc,neu,       sg,weak,  treu_rel,dat).


mutmaßliche ---> @scopal_attr_adj(nom_or_acc,fem,sg,dtype, mutmaßlich_rel).
mutmaßliche ---> @scopal_attr_adj(nom,       mas,sg,strong,mutmaßlich_rel).
mutmaßliche ---> @scopal_attr_adj(nom_or_acc,neu,sg,strong,mutmaßlich_rel).
mutmaßliche ---> @scopal_attr_adj(nom_or_acc,    pl,weak,  mutmaßlich_rel).

mutmaßlichen ---> @scopal_attr_adj(gen_or_dat,genus,     sg,strong,mutmaßlich_rel).
mutmaßlichen ---> @scopal_attr_adj(case,      genus,     pl,strong,mutmaßlich_rel).
mutmaßlichen ---> @scopal_attr_adj(acc,       mas,       sg,dtype, mutmaßlich_rel).
mutmaßlichen ---> @scopal_attr_adj(gen,       mas_or_neu,sg,weak,  mutmaßlich_rel).
mutmaßlichen ---> @scopal_attr_adj(dat,       genus,     pl,weak,  mutmaßlich_rel).

mutmaßlichem ---> @scopal_attr_adj(dat,       mas_or_neu,sg,weak,  mutmaßlich_rel).

mutmaßlicher ---> @scopal_attr_adj(nom,       mas,       sg,weak,  mutmaßlich_rel).
mutmaßlicher ---> @scopal_attr_adj(gen_or_dat,fem,       sg,weak,  mutmaßlich_rel).
mutmaßlicher ---> @scopal_attr_adj(gen,       genus,     pl,weak,  mutmaßlich_rel).


mutmaßliches ---> @scopal_attr_adj(nom_or_acc,neu,       sg,weak,  mutmaßlich_rel).




angeblich ---> @scopal_adv(angeblich_rel).

nicht ---> @scopal_adv(nicht_rel).

wahrscheinlich ---> @scopal_adv(wahrscheinlich_rel).

morgen ---> @isect_adv(morgen_rel).

oft ---> @isect_adv(oft_rel).


dass ---> @complementizer(dass).


/*
% Die alte zyklische Verbspur. Im Prinzip bräuchte man nicht mal die Information darüber, dass es ein Verb und final ist.
empty
   (trace,
    loc:(Loc,
         cat:head:(verb,
                   initial:minus,
                   dsl:Loc)),
    nonloc:slash:[],
    trace:vm).
*/

empty
   (trace,
    synsem:(loc:(cat:(head:(verb,
                            initial:minus,
                            dsl:(cat:(spr:Spr,
                                      comps:Comps),
                                 cont:Cont)),
                      spr:Spr,
                      comps:Comps),
                 cont:Cont),
            nonloc:slash:[],
            trace:vm)).


empty 
   (trace,
    synsem:(loc:Loc,
            nonloc:slash:[Loc],
            trace:extraction)).


empty 
    (empty_determiner,
     @det(pl,weak,udef_q)).
