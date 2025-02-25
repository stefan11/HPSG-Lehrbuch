% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexicon.pl,v $
%%  $Revision: 1.15 $
%%      $Date: 2007/03/05 11:26:29 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile '--->'/2.


das ---> @det(nom_or_acc,sg,neu,strong,def).


der ---> @det(nom,sg,mas,strong,def).

% wir gedenken der Frau
% wir helfen der Frau
der ---> @det(gen_or_dat,sg,fem,strong,def).


% dem Mann/Buch
dem --->  @det(dat,sg,mas_or_neu,strong,def).

% den Mann
den ---> @det(acc,sg,mas,strong,def).


des ---> @det(gen,sg,mas_or_neu,strong,def).

die ---> @det(nom_or_acc,sg,fem,strong,def).


die ---> @det(nom_or_acc,pl,strong,def).
den ---> @det(dat,       pl,strong,def).
der ---> @det(gen,       pl,strong,def).


ein   ---> @det(nom,       sg,mas,       weak,  ein).
ein   ---> @det(nom_or_acc,sg,neu,       weak,  ein).
eine  ---> @det(nom_or_acc,sg,fem,       strong,ein).
einen ---> @det(acc,       sg,mas,       strong,ein).
einem ---> @det(dat,       sg,mas_or_neu,strong,ein).

einer ---> @det(gen_or_dat,sg,fem,       strong,ein).
eines ---> @det(gen,       sg,mas_or_neu,strong,ein).



% Nomina neutr

buch    ---> @noun(nom_or_dat_or_acc,neu,sg,buch).
buches  ---> @noun(gen,              neu,sg,buch).
bücher  ---> @noun(nom_or_gen_or_acc,neu,pl,buch).
büchern ---> @noun(dat,              neu,pl,buch).


kind    ---> @noun(nom_or_dat_or_acc,neu,sg,kind).
kindes  ---> @noun(gen,              neu,sg,kind).
kinder  ---> @noun(nom_or_gen_or_acc,neu,pl,kind).
kindern ---> @noun(dat,              neu,pl,kind).

lied    ---> @noun(nom_or_dat_or_acc,neu,sg,lied).
liedes  ---> @noun(gen,              neu,sg,lied).
lieder  ---> @noun(nom_or_gen_or_acc,neu,pl,lied).
liedern ---> @noun(dat,              neu,pl,lied).

märchen   ---> @noun(nom_or_dat_or_acc,neu,sg,märchen).
märchenes ---> @noun(gen,              neu,sg,märchen).
märchen   ---> @noun(case,             neu,pl,märchen).


% Achtung! Mädchen hat das Genus Neutrum, für Pronomenbindung
% ist allerdings feminin oder neutrum möglich.
% Das Mädchen ... Sie/es ...

mädchen  ---> @noun(nom_or_dat_or_acc,neu,  fem_or_neu,sg,mädchen).
mädchens ---> @noun(gen,              neu,  fem_or_neu,sg,mädchen).
mädchen  ---> @noun(case,             genus,fem_or_neu,pl,mädchen).

% Nomina mask


aufsatz   ---> @noun(nom_or_dat_or_acc,mas,sg,aufsatz).
aufsatzes ---> @noun(gen,              mas,sg,aufsatz).
aufsatze  ---> @noun(nom_or_gen_or_acc,mas,pl,aufsatz).
aufsätzen ---> @noun(dat,              neu,pl,aufsatz).

lügner  ---> @noun(nom_or_dat_or_acc,mas,sg,lügner).
lügners ---> @noun(gen,              mas,sg,lügner).
lügner  ---> @noun(nom_or_gen_or_acc,mas,pl,lügner).
lügnern ---> @noun(dat,              neu,pl,lügner).


mann    ---> @noun(nom_or_dat_or_acc,mas,sg,mann).
mannes  ---> @noun(gen,              mas,sg,mann).
männer  ---> @noun(nom_or_gen_or_acc,mas,pl,mann).
männern ---> @noun(dat,              neu,pl,mann).


mörder  ---> @noun(nom_or_dat_or_acc,mas,sg,mörder).
mörders ---> @noun(gen,              mas,sg,mörder).
mörder  ---> @noun(nom_or_gen_or_acc,mas,pl,mörder).
mördern ---> @noun(dat,              neu,pl,mörder).




% Nomina fem

frau   ---> @noun(case,fem,sg,frau).
frauen ---> @noun(case,fem,pl,frau).

geschichte  ---> @noun(case,fem,sg,geschichte).
geschichten ---> @noun(case,fem,pl,geschichte).

speisekammer  ---> @noun(case,fem,sg,speisekammer).
speisekammern ---> @noun(case,fem,pl,speisekammer).

tochter ---> @noun(case,fem,sg,tochter).
töchter ---> @noun(case,fem,pl,tochter).

wurst   ---> @noun(case,fem,sg,wurst).
würste  ---> @noun(nom_or_gen_or_acc,fem,pl,wurst).
würsten ---> @noun(dat,              fem,pl,wurst).


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


beamte ---> @adj_noun(nom_or_acc,fem,        sg,dtype, beamter).
beamte ---> @adj_noun(nom,       mas,        sg,strong,beamter).
beamte ---> @adj_noun(nom_or_acc,fem_or_mas, pl,weak,  beamter).

beamten ---> @adj_noun(gen_or_dat,fem_or_mas,sg,strong,beamter).
%beamten ---> @adj_noun(gen,       mas,       sg,weak,  beamter).  % nicht gebraucht
beamten ---> @adj_noun(case,      fem_or_mas,pl,strong,beamter).
beamten ---> @adj_noun(acc,       mas,       sg,dtype, beamter).
beamten ---> @adj_noun(gen,       mas,       pl,weak,  beamter).
beamten ---> @adj_noun(dat,       fem_or_mas,pl,weak,  beamter).

%beamtem ---> @adj_noun(dat,       mas,       sg,weak,  beamter).  % nicht gebraucht


%
%beamter ---> @noun(gen_or_dat,fem,       sg,weak,  beamter).      % nicht gebraucht

beamter ---> @adj_noun(nom,       mas,       sg,weak,  beamter).
beamter ---> @adj_noun(gen,       fem_or_mas,pl,weak,  beamter).



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




% Relativpronomina

die    ---> @rel_pronoun(nom_or_acc,third,sg,fem).
der    ---> @rel_pronoun(gen_or_dat,third,sg,fem).

der    ---> @rel_pronoun(nom,third,sg,mas).

dessen ---> @rel_pronoun(gen,third,sg,mas_or_neu).
dem    ---> @rel_pronoun(dat,third,sg,mas_or_neu).

den    ---> @rel_pronoun(acc,third,sg,mas).

das    ---> @rel_pronoun(nom_or_acc,third,sg,neu).


dessen ---> @possessive_rel_pronoun(sg,mas_or_neu).
deren  ---> @possessive_rel_pronoun(sg,fem).


% Verben



belle    ---> @intrans_verb(first, sg, bellen).
bellst   ---> @intrans_verb(second,sg, bellen).
bellt    ---> @intrans_verb(third, sg, bellen).

bellen   ---> @intrans_verb(first_or_third, pl, bellen).
bellt    ---> @intrans_verb(second,         pl, bellen).

bellen   ---> @intrans_verb(bse, bellen).

lache    ---> @intrans_verb(first, sg, lachen).
lachst   ---> @intrans_verb(second,sg, lachen).
lacht    ---> @intrans_verb(third, sg, lachen).

lachen   ---> @intrans_verb(first_or_third, pl, lachen).
lacht    ---> @intrans_verb(second,         pl, lachen).

lachen   ---> @intrans_verb(bse, lachen).

schlafe  ---> @intrans_verb(first, sg, schlafen).
schläfst ---> @intrans_verb(second,sg, schlafen).
schläft  ---> @intrans_verb(third, sg, schlafen).

schlafen ---> @intrans_verb(first_or_third, pl, schlafen).
schlaft  ---> @intrans_verb(second,         pl, schlafen).

schlafen ---> @intrans_verb(bse, schlafen).

graut    ---> @subjlos_verb(fin,dat,grauen).
grauen   ---> @subjlos_verb(bse,dat,grauen).


helfe    ---> @np_np_verb(first, sg, dat, helfen).
hilfst   ---> @np_np_verb(second,sg, dat, helfen).
hilft    ---> @np_np_verb(third, sg, dat, helfen).

helfen   ---> @np_np_verb(first_or_third, pl, dat, helfen).
helft    ---> @np_np_verb(second,         pl, dat, helfen).

helfen   ---> @np_np_verb(bse, dat, helfen).


jage     ---> @trans_verb(first, sg, jagen).
jagst    ---> @trans_verb(second,sg, jagen).
jagt     ---> @trans_verb(third, sg, jagen).

jagen    ---> @trans_verb(bse, jagen).


kenne    ---> @trans_verb(first, sg, kennen).
kennst   ---> @trans_verb(second,sg, kennen).
kennt    ---> @trans_verb(third, sg, kennen).

kennen   ---> @trans_verb(first_or_third, pl, kennen).
kennt    ---> @trans_verb(second,         pl, kennen).

kennen   ---> @trans_verb(bse, kennen).


lese    ---> @trans_verb(first, sg, lesen).
liest   ---> @trans_verb(second,sg, lesen).

lesen   ---> @trans_verb(first_or_third, pl, lesen).
lest    ---> @trans_verb(second,         pl, lesen).

lesen   ---> @trans_verb(bse, lesen).

liebe    ---> @trans_verb(first, sg, lieben).
liebst   ---> @trans_verb(second,sg, lieben).
liebt    ---> @trans_verb(third, sg, lieben).

lieben   ---> @trans_verb(first_or_third, pl, lieben).
liebt    ---> @trans_verb(second,         pl, lieben).

lieben   ---> @trans_verb(bse, lieben).

singe    ---> @trans_verb(first, sg, singen).
singst   ---> @trans_verb(second,sg, singen).
singt    ---> @trans_verb(third, sg, singen).

singen   ---> @trans_verb(first_or_third, pl, singen).
singt    ---> @trans_verb(second,         pl, singen).

singen   ---> @trans_verb(bse, singen).


gebe   ---> @ditrans_verb(first, sg, geben).
gibst  ---> @ditrans_verb(second,sg, geben).
gibt   ---> @ditrans_verb(third, sg, geben).

geben  ---> @ditrans_verb(first_or_third, pl, geben).
gebt   ---> @ditrans_verb(second,         pl, geben).


gab    ---> @ditrans_verb(first_or_third, sg, geben).

geben  ---> @ditrans_verb(bse, geben).

erzählt  --->  @ditrans_verb(third, sg, erzählen).

erzählen --->  @ditrans_verb(bse, erzählen).



denke  ---> @np_pp_verb(first, sg, an_pform,acc,denken_an).
denkst ---> @np_pp_verb(second,sg, an_pform,acc,denken_an).
denkt  ---> @np_pp_verb(third, sg, an_pform,acc,denken_an).

denken   ---> @np_pp_verb(first_or_third, pl, an_pform,acc,denken_an).
denkt    ---> @np_pp_verb(second,         pl, an_pform,acc,denken_an).

denken   ---> @np_pp_verb(bse, an_pform,acc,denken_an).


% Modalverben

darf   ---> @modal_verb(first_or_third,sg,dürfen).
darfst ---> @modal_verb(second,        sg,dürfen).

dürfen ---> @modal_verb(first_or_third,pl,dürfen).
dürft  ---> @modal_verb(second,        pl,dürfen).

dürfen ---> @modal_verb(bse,dürfen).

kann   ---> @modal_verb(first_or_third,sg,können).
kannst ---> @modal_verb(second,        sg,können).

können ---> @modal_verb(first_or_third,pl,können).
könnt  ---> @modal_verb(second,        pl,können).

können ---> @modal_verb(bse,können).

muß    ---> @modal_verb(first_or_third,sg,müssen).
mußt   ---> @modal_verb(second,        sg,müssen).

müssen ---> @modal_verb(first_or_third,pl,müssen).
müßt   ---> @modal_verb(second,        pl,müssen).

müssen ---> @modal_verb(bse,müssen).


will   ---> @modal_verb(first_or_third,sg,wollen).
willst ---> @modal_verb(second,        sg,wollen).

wollen ---> @modal_verb(first_or_third,pl,wollen).
wollt  ---> @modal_verb(second,        pl,wollen).

wollen ---> @modal_verb(bse,wollen).


% Hilfsverben

werde ---> @futur_aux_verb(first,  sg).
wirst ---> @futur_aux_verb(second, sg).
wird  ---> @futur_aux_verb(third,  sg).

werden ---> @futur_aux_verb(first_or_third, pl).
werdet ---> @futur_aux_verb(second,         pl).


haben ---> @perfect_aux_verb(bse).

an ---> @comp_prep(an_pform).



interessante ---> @attr_adj(nom_or_acc,fem,sg,dtype, interessant).
interessante ---> @attr_adj(nom,       mas,sg,strong,interessant).
interessante ---> @attr_adj(nom_or_acc,neu,sg,strong,interessant).
interessante ---> @attr_adj(nom_or_acc,    pl,weak,  interessant).

interessanten ---> @attr_adj(gen_or_dat,genus,     sg,strong,interessant).
interessanten ---> @attr_adj(case,      genus,     pl,strong,interessant).
interessanten ---> @attr_adj(acc,       mas,       sg,dtype, interessant).
interessanten ---> @attr_adj(gen,       mas_or_neu,pl,weak,  interessant).
interessanten ---> @attr_adj(dat,       genus,     pl,weak,  interessant).

interessantem ---> @attr_adj(dat,       mas_or_neu,sg,weak,  interessant).

interessanter ---> @attr_adj(nom,       mas,       sg,weak,  interessant).
interessanter ---> @attr_adj(gen_or_dat,fem,       sg,weak,  interessant).
interessanter ---> @attr_adj(gen,       genus,     pl,weak,  interessant).


interessantes ---> @attr_adj(nom_or_acc,neu,       sg,weak,  interessant).


kluge ---> @attr_adj(nom_or_acc,fem,sg,dtype, klug).
kluge ---> @attr_adj(nom,       mas,sg,strong,klug).
kluge ---> @attr_adj(nom_or_acc,neu,sg,strong,klug).
kluge ---> @attr_adj(nom_or_acc,    pl,weak,  klug).

klugen ---> @attr_adj(gen_or_dat,genus,     sg,strong,klug).
klugen ---> @attr_adj(case,      genus,     pl,strong,klug).
klugen ---> @attr_adj(acc,       mas,       sg,dtype, klug).
klugen ---> @attr_adj(gen,       mas_or_neu,pl,weak,  klug).
klugen ---> @attr_adj(dat,       genus,     pl,weak,  klug).

klugem ---> @attr_adj(dat,       mas_or_neu,sg,weak,  klug).

kluger ---> @attr_adj(nom,       mas,       sg,weak,  klug).
kluger ---> @attr_adj(gen_or_dat,fem,       sg,weak,  klug).
kluger ---> @attr_adj(gen,       genus,     pl,weak,  klug).


kluges ---> @attr_adj(nom_or_acc,neu,       sg,weak,  klug).



schöne ---> @attr_adj(nom_or_acc,fem,sg,dtype, schön).
schöne ---> @attr_adj(nom,       mas,sg,strong,schön).
schöne ---> @attr_adj(nom_or_acc,neu,sg,strong,schön).
schöne ---> @attr_adj(nom_or_acc,    pl,weak,  schön).

schönen ---> @attr_adj(gen_or_dat,genus,     sg,strong,schön).
schönen ---> @attr_adj(case,      genus,     pl,strong,schön).
schönen ---> @attr_adj(acc,       mas,       sg,dtype, schön).
schönen ---> @attr_adj(gen,       mas_or_neu,pl,weak,  schön).
schönen ---> @attr_adj(dat,       genus,     pl,weak,  schön).

schönem ---> @attr_adj(dat,       mas_or_neu,sg,weak,  schön).

schöner ---> @attr_adj(nom,       mas,       sg,weak,  schön).
schöner ---> @attr_adj(gen_or_dat,fem,       sg,weak,  schön).
schöner ---> @attr_adj(gen,       genus,     pl,weak,  schön).


schönes ---> @attr_adj(nom_or_acc,neu,       sg,weak,  schön).


treue ---> @attr_adj_np(nom_or_acc,fem,sg,dtype, treu,dat).
treue ---> @attr_adj_np(nom,       mas,sg,strong,treu,dat).
treue ---> @attr_adj_np(nom_or_acc,neu,sg,strong,treu,dat).
treue ---> @attr_adj_np(nom_or_acc,    pl,weak,  treu,dat).

treuen ---> @attr_adj_np(gen_or_dat,genus,     sg,strong,treu,dat).
treuen ---> @attr_adj_np(case,      genus,     pl,strong,treu,dat).
treuen ---> @attr_adj_np(acc,       mas,       sg,dtype, treu,dat).
treuen ---> @attr_adj_np(gen,       mas_or_neu,pl,weak,  treu,dat).
treuen ---> @attr_adj_np(dat,       genus,     pl,weak,  treu,dat).

treuem ---> @attr_adj_np(dat,       mas_or_neu,sg,weak,  treu,dat).

treuer ---> @attr_adj_np(nom,       mas,       sg,weak,  treu,dat).
treuer ---> @attr_adj_np(gen_or_dat,fem,       sg,weak,  treu,dat).
treuer ---> @attr_adj_np(gen,       genus,     pl,weak,  treu,dat).


treues ---> @attr_adj_np(nom_or_acc,neu,       sg,weak,  treu,dat).




mutmaßliche  ---> @scopal_attr_adj(nom_or_acc,fem,sg,dtype,mutmaßlich).
mutmaßliche ---> @scopal_attr_adj(nom,       mas,sg,strong,mutmaßlich).
mutmaßliche ---> @scopal_attr_adj(nom_or_acc,neu,sg,strong,mutmaßlich).
mutmaßliche ---> @scopal_attr_adj(nom_or_acc,    pl,weak,  mutmaßlich).

mutmaßlichen ---> @scopal_attr_adj(gen_or_dat,genus,     sg,strong,mutmaßlich).
mutmaßlichen ---> @scopal_attr_adj(case,      genus,     pl,strong,mutmaßlich).
mutmaßlichen ---> @scopal_attr_adj(acc,       mas,       sg,dtype, mutmaßlich).
mutmaßlichen ---> @scopal_attr_adj(gen,       mas_or_neu,pl,weak,  mutmaßlich).
mutmaßlichen ---> @scopal_attr_adj(dat,       genus,     pl,weak,  mutmaßlich).

mutmaßlichem ---> @scopal_attr_adj(dat,       mas_or_neu,sg,weak,  mutmaßlich).

mutmaßlicher ---> @scopal_attr_adj(nom,       mas,       sg,weak,  mutmaßlich).
mutmaßlicher ---> @scopal_attr_adj(gen_or_dat,fem,       sg,weak,  mutmaßlich).
mutmaßlicher ---> @scopal_attr_adj(gen,       genus,     pl,weak,  mutmaßlich).


mutmaßliches ---> @scopal_attr_adj(nom_or_acc,neu,       sg,weak,  mutmaßlich).



in ---> @location_noun_mod_prep(in).

in ---> @location_verb_mod_prep(in).


nicht ---> @scopal_adv(nicht).

oft   ---> @scopal_adv(oft).


morgen ---> @temp_adv(morgen).

daß ---> @complementizer(daß_cform).




empty
   v_trace.

empty 
   e_trace.

empty 
    (empty_determiner,
     @det(pl,weak,abstr_rel)).







