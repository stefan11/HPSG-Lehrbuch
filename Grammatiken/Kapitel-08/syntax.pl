% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.3 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- multifile '*>'/2.

:- multifile ':='/2.
:- discontiguous ':='/2.

%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (loc:cat:head:Head,
    head_dtr:loc:cat:head:Head).

%% Das Valenzprinzip

head_complement_phrase *>
   (loc:cat:comps:append(Comps1,Comps2),                       % = Comps1 + Comps2
    head_dtr:loc:cat:comps:append(Comps1,[NonHeadDtr|Comps2]), % = Comps1 + [NonHeadDtr] + Comps2
    non_head_dtrs:[NonHeadDtr]).


head_specifier_phrase *>
   (loc:cat:spr:Spr,
    head_dtr:loc:cat:(spr:[NonHeadDtr|Spr],
                  comps:[]),
    non_head_dtrs:[NonHeadDtr]).

head_non_complement_phrase *>
   (loc:cat:comps:Comps,
    head_dtr:loc:cat:comps:Comps).

head_non_specifier_phrase *>
   (loc:cat:spr:Spr,
    head_dtr:loc:cat:spr:Spr).


head_adjunct_phrase *>
   (head_dtr:HD,
    non_head_dtrs:[loc:cat:(head:mod:HD,
                            spr:[],
                            comps:[])]).
       

% for headed structures the head daughter is appended to the non-head daughters to give a list of all daughters.
% This daughters list can be used to collect RELS, HCONS and so on.
% See rules.pl. The dtrs are ordered according to surface order in rules.pl.

%headed_phrase *>
%   head_dtr:HD,
%   non_head_dtrs:NHDtrs,
%   dtrs:[HD|NHDtrs].


% Argumentrealisierungsprinzip
word *> loc:cat:(spr:Spr,
                 comps:Comps,
                 arg_st:append(Spr,Comps)).


% Semantik

phrase *>
  (loc:cont:rels:collect_rels(Dtrs),
   dtrs:Dtrs).

phrase *>
  (loc:cont:hcons:collect_hcons(Dtrs),
   dtrs:Dtrs).



/* GTop wird nicht wirklich gebraucht. 
headed_phrase *>
   (cont:(ind:Ind,
          gtop:GTop),
    head_dtr:cont:(ind:Ind,
                   gtop:GTop),
    non_head_dtrs:[cont:gtop:GTop]).
*/

headed_phrase *>
   (loc:cont:ind:Ind,
    head_dtr:loc:cont:ind:Ind).

% head_complement_phrase, head_specifier_phrase
head_non_adjunct_phrase *>
   (loc:cont:ltop:LTop,
    head_dtr:loc:cont:ltop:LTop).

head_adjunct_phrase *>
   (loc:cont:ltop:LTop,
    non_head_dtrs:[loc:cont:ltop:LTop]).

% Wegen „ein scheinbar schwieriges Beispiel“ kann sich „schwieriges“ nicht im Lexikon den LTop-Wert
% von „Beispiel“ nehmen, denn der LTop-Wert von „Beispiel“ muss mit dem von „scheinbar schwieriges“ gleichgesetzt werden.
(head_adjunct_phrase,
 non_head_dtrs:[loc:cat:head:scopal:minus]) *>
 (head_dtr:loc:cont:ltop:LTop,
  non_head_dtrs:[loc:cont:ltop:LTop]).

(headed_phrase,
 non_head_dtrs:[loc:cat:head:spec:sign]) *>
 (head_dtr:Spec,
  non_head_dtrs:[loc:cat:head:spec:Spec]).


% die Verbbewegungsanalyse

% Das ist eine unär verzweigende Regel und keine Lexikonregel,
% da sie auch auf koordinierte Verben angewendet werden kann.
% Siehe auch coordination.pl.
verb_initial_rule *>
( %complementizer_like_sign
  loc:(cat:(head:(verb,
                  vform:fin),
            spr:[],
            comps:[loc:(cat:head:dsl:Loc,
                        cont:(ind:Ind,
                              ltop:LTop))]),
       cont:(ind:Ind,
             ltop:LTop,
             rels:[],
             hcons:[])),
  dtrs:[(loc:(Loc,
              cat:head:(verb,
                        vform:fin,
                        initial:minus)),
              trace:minus,
              % nur koordinierte Wörter dürfen zu V1-Verben umkategorisiert werden.
              phrase:minus)]).


% [einen Mann _i] und schläft kann koordiniert werden.
% dabei muss "einen Mann" irgendwo in der COMPS-Liste von _i auftreten.
% Bei der Koordination wird die COMPS-Liste von [einen Mann _i] mit der von schläft identifiziert.
% Damit ist die COMPS-Liste der Spur < NP[nom], NP[acc] > und die zweite NP durch "einen Mann" realisiert.
% Die Spur hat diese Info auch in DSL. Weil schläft aber als Verbletztverb noch einen offenen DSL-Wert hat,
% kann es mit [ein Mannen _i] koordiniert werden. Das Ergebnis ist eine Projektion mit einer einstelligen
% Valenz und einem zweistelligen DSL-Wert. Diese kann nie verwendet werden, denn entweder ist das Verb hinten
% overt, dann passt der DSL-Wert nicht, oder die Spur identifiziert LOC mit DSL. Dann wird auch in
% [ein Mann _i] und schläft der LOC-Wert mit DSL identifiziert, was aber nicht möglich ist, weil DSL zweistellig,
% die koordinierte Phrase aber einstellig ist.

%[V1 [coord_phrase [ X [ und Y]]

% Schließt auch
% Den Roman kennt und schläft er
% aus, wenn Verbletztverben DSL none sind.

(verb_initial_rule,
 dtrs:[coord_phrase]) *> dtrs:hd:dtrs:[phrase:minus,              % X
                                       dtrs:tl:hd:phrase:minus].  % Y

/*
% alt für zyklische Verbspur.
% * Er schläft schläft.
%
(headed_phrase,
 head_dtr:(word,
           phon:ne_list)) *> head_dtr:loc:cat:head:dsl:none.

*/

% Da coord_phrase nicht Untertyp von headed_phrase ist,
% ist der PHRASE-Wert unterspezifiziert.

% [Ihn kennt und schläft] er.
% Ist dennoch ausgeschlossen, da die obige Implikation
% dafür sorgt, daß der DSL-Wert von `ihn kennt' none ist.
% Damit hat die Konjunktion auch den DSL-Wert none und kann
% dann nicht mehr Tochter der V1-Regel sein.

headed_phrase *> phrase:plus.



% Linearisierungsregeln: Wenn der Initial-Wert plus ist, steht die Kopf-Tochter vor der
% Nicht-Kopf-Tochter, sonst danach.
head_complement_phrase *> (head_dtr:HD,
                            non_head_dtrs:[NHD],
                            ( head_dtr:loc:cat:head:initial:plus,
                              dtrs:[HD,NHD]
                            ; head_dtr:loc:cat:head:initial:minus,
                              dtrs:[NHD,HD]
                            )).

% Wenn der Pre-Modifier-Wert plus ist, steht die Adjunkt-Tochter vor der
% Kopf-Tochter, sonst danach.
head_adjunct_phrase *> (head_dtr:HD,
                           non_head_dtrs:[NHD],
                           ( non_head_dtrs:[loc:cat:head:pre_modifier:minus],
                               dtrs:[HD,NHD]
                           ; non_head_dtrs:[loc:cat:head:pre_modifier:plus],
                               dtrs:[NHD,HD]
                           )).

% Der Spezifikator steht vor dem Kopf.
head_specifier_phrase *>
             (dtrs:[NonHeadDtr,HeadDtr],
              head_dtr:HeadDtr,
              non_head_dtrs:[NonHeadDtr]).



root :=
 (loc:cat:(head:dsl:none,
           spr:[],
           comps:[])).

initial_fin_verb :=
 (@root,
  loc:cat:head:(verb,
                initial:plus,
                vform:fin)).


interrog :=
 @initial_fin_verb.

decl :=
 @initial_fin_verb.
