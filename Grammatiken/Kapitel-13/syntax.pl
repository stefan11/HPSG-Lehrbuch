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

:- multifile if/2.
:- discontiguous if/2.


%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (synsem:loc:cat:head:Head,
    head_dtr:synsem:loc:cat:head:Head).

%% Das Valenzprinzip

head_complement_phrase *>
   (synsem:loc:cat:comps:append(Comps1,Comps2),                       % = Comps1 + Comps2
    head_dtr:synsem:loc:cat:comps:append(Comps1,[NonHeadDtr|Comps2]), % = Comps1 + [NonHeadDtr] + Comps2
    non_head_dtrs:[synsem:NonHeadDtr]).


head_specifier_phrase *>
   (synsem:loc:cat:spr:Spr,
    head_dtr:synsem:loc:cat:(spr:[NonHeadDtr|Spr],
                  comps:[]),
    non_head_dtrs:[synsem:NonHeadDtr]).

head_non_complement_phrase *>
   (synsem:loc:cat:comps:Comps,
    head_dtr:synsem:loc:cat:comps:Comps).

head_non_specifier_phrase *>
   (synsem:loc:cat:spr:Spr,
    head_dtr:synsem:loc:cat:spr:Spr).


head_adjunct_phrase *>
   (head_dtr:synsem:HD,
    non_head_dtrs:[synsem:loc:cat:(head:mod:HD,
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
word *> synsem:loc:cat:(spr:Spr,
                        comps:Comps,
                        arg_st:append(Spr,Comps)).


% Semantik

phrase *>
  (rels:collect_rels(Dtrs),
   dtrs:Dtrs).

phrase *>
  (hcons:collect_hcons(Dtrs),
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
   (synsem:loc:cont:ind:Ind,
    head_dtr:synsem:loc:cont:ind:Ind).

% head_complement_phrase, head_specifier_phrase, head_filler_phrase
head_non_adjunct_phrase *>
   (synsem:loc:cont:ltop:LTop,
    head_dtr:synsem:loc:cont:ltop:LTop).

head_adjunct_phrase *>
   (synsem:loc:cont:ltop:LTop,
    non_head_dtrs:[synsem:loc:cont:ltop:LTop]).

% Wegen „ein scheinbar schwieriges Beispiel“ kann sich „schwieriges“ nicht im Lexikon den LTop-Wert
% von „Beispiel“ nehmen, denn der LTop-Wert von „Beispiel“ muss mit dem von „scheinbar schwieriges“ gleichgesetzt werden.
(head_adjunct_phrase,
 non_head_dtrs:[synsem:loc:cat:head:scopal:minus]) *>
 (head_dtr:synsem:loc:cont:ltop:LTop,
  non_head_dtrs:[synsem:loc:cont:ltop:LTop]).

(headed_phrase,
 non_head_dtrs:[synsem:loc:cat:head:spec:synsem]) *>
 (head_dtr:synsem:Spec,
  non_head_dtrs:[synsem:loc:cat:head:spec:Spec]).


% die Verbbewegungsanalyse

% Das ist eine unär verzweigende Regel und keine Lexikonregel,
% da sie auch auf koordinierte Verben angewendet werden kann.
% Siehe auch coordination.pl.
verb_initial_rule *>
( %complementizer_like_sign
  synsem:(loc:(cat:(head:(verb,
                          vform:fin),
                    spr:[],
                    comps:[loc:(cat:head:dsl:Loc,
                                cont:(ind:Ind,
                                      ltop:LTop))]),
               cont:(ind:Ind,
                     ltop:LTop)),
          nonloc:Nonloc),
  dtrs:[synsem:(loc:(Loc,
                     cat:head:(verb,
                               vform:fin,
                               initial:minus)),
                nonloc:Nonloc,
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

% Auch * [[Den Roman kennt] und [schläft]] er.

(verb_initial_rule,
 dtrs:[coord_phrase]) *> dtrs:hd:dtrs:[synsem:phrase:minus,              % X
                                       dtrs:tl:hd:synsem:phrase:minus].  % Y



headed_phrase *> synsem:phrase:plus.

word *> synsem:phrase:minus.

% Da coord_phrase nicht Untertyp von headed_phrase ist,
% ist der PHRASE-Wert unterspezifiziert.

% [Ihn kennt und schläft] er.
% Ist dennoch ausgeschlossen, da die obige Implikation
% dafür sorgt, daß der DSL-Wert von `ihn kennt' none ist.
% Damit hat die Konjunktion auch den DSL-Wert none und kann
% dann nicht mehr Tochter der V1-Regel sein.

% Sätze mit Verb in Erststellung können Imperativsätze oder auch Interrogativsätze sein.
% Die beiden folgenden Sätze unterscheiden sich nur hinsichtlich ihrer Flexion:
%
%     Gib   Du mir das Buch!
%     Gibst Du mir das Buch?
%
% Die genaue Auflösung der Relation erfolgt erst in der Grammatik für Kapitel 16,
% da dort erst eine Morphologiekomponente eingeführt wird.

% Konditionalsätze werden ignoriert.


(verb_initial_rule,
 synsem:loc:cat:comps:[nonloc:slash:[]])      *> synsem:loc:cont:ind:mode:imperative_or_interrogative.

% Hier spielt das Element in SLASH eine entscheidende Rolle.
% Ist es eine Interrogativphrase, muss ein entsprechender Operator angenommen
% werden. Da die vorliegende Grammatik keine Interrogativpronomina enthält,
% wird die Fallunterscheidung nicht gemacht.
% Jetzt gib ihm das Buch!
% Du kommst morgen?
% Du kommst morgen.
%
% Alles außer Konditional: Kämest Du morgen, könnten wir ...
%
(verb_initial_rule,
 synsem:loc:cat:comps:[nonloc:slash:ne_list]) *> synsem:loc:cont:ind:mode:assertion_or_imperative_or_interrogative.


% Linearisierungsregeln: Wenn der Initial-Wert plus ist, steht die Kopf-Tochter vor der
% Nicht-Kopf-Tochter, sonst danach.
head_complement_phrase *> (head_dtr:HD,
                            non_head_dtrs:[NHD],
                            ( head_dtr:synsem:loc:cat:head:initial:plus,
                              dtrs:[HD,NHD]
                            ; head_dtr:synsem:loc:cat:head:initial:minus,
                              dtrs:[NHD,HD]
                            )).

% Wenn der Pre-Modifier-Wert plus ist, steht die Adjunkt-Tochter vor der
% Kopf-Tochter, sonst danach.
head_adjunct_phrase *> (head_dtr:HD,
                           non_head_dtrs:[NHD],
                           ( non_head_dtrs:[synsem:loc:cat:head:pre_modifier:minus],
                               dtrs:[HD,NHD]
                           ; non_head_dtrs:[synsem:loc:cat:head:pre_modifier:plus],
                               dtrs:[NHD,HD]
                           )).

% Der Spezifikator steht vor dem Kopf.
head_specifier_phrase *>
             (dtrs:[NonHeadDtr,HeadDtr],
              head_dtr:HeadDtr,
              non_head_dtrs:[NonHeadDtr]).

% Der Filler steht vor dem Kopf.
head_filler_phrase *> (dtrs:[NonHeadDtr,HeadDtr],
                       head_dtr:HeadDtr,
                       non_head_dtrs:[NonHeadDtr]).

% Relativsätze (unheaded) und V2-Sätze mit Kopf.
filler_phrase *>
   (synsem:nonloc:slash:[],
    dtrs:[synsem:(loc:Slash,
                  nonloc:slash:[]),
          synsem:(loc:cat:(head:(verb,
                                 vform:fin,
                                 dsl:none),
                           spr:[],
                           comps:[]),
                  nonloc:slash:[Slash])]).

head_filler_phrase *>
   (v2:plus,
    head_dtr:synsem:loc:cat:head:initial:plus).

%%
head_non_filler_phrase *>
   (synsem:nonloc:slash:(append(Slash1,Slash2),
                         list_with_zero_or_one_element), % The ordering of the two constraints is important.
                                                         % If list_with ... is stated first, rule computation does not terminate.
                                                         % This seems to be a bug. (St. Mü. 01.04.2025)
       head_dtr:synsem:nonloc:slash:Slash1,
       non_head_dtrs:[synsem:nonloc:slash:Slash2]).

%% Der Kopf kann nicht extrahiert werden.
%% Ein Problem stellt hierbei das Verb in PVP-Konstellationen
%% dar (siehe Müller, 1999)
%% "Helfen wird er ihm morgen."
headed_phrase *>
   (head_dtr:synsem:trace:minus_or_vm).


% Adjunkte sind Extraktionsinseln
(headed_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *>
      head_dtr:synsem:loc:cat:head:mod:none.


% Das entspricht auch der Analyse von Frey 2004 und Fanselow 2003. Die gehen davon
% aus, daß das höchste Element im Mittelfeld ins Vorfeld vorangestellt werden kann.
% Die pragmatischen Eigenschaften der vorangestellten Konstituente entsprechen dabei
% denen, die sie im Mittelfeld in Initialstellung haben würde.

% Die folgenden Beschränkungen stellen sicher, daß immer das letzte verbleibende
% Argument extrahiert wird, d.h. wenn Extraktion stattgefunden hat kann ein Kopf
% nicht mehr projiziert werden.

% Diese Beschränkung kann aus technischen Gründen nicht mit Bezug auf SUBCAT gemacht
% werden, da sonst del/3 deblockiert werden würde, was nicht erwünscht ist, da die
% SUBCAT-Liste bis zur Kombination mit dem Verb in Erststellung unterspezifiziert ist.
%
% Mit der auskommentierten Beschränkung gibt es für den folgenden Satz 55 Kanten.
%
%   Das Buch gibt er ihr oft.
%
% Mit der verwendeten Beschränkung jedoch nur 48. Das liegt daran, daß `er ihr'
% + Trace dazu führt, daß folgende Abfolgen in der SUBCAT-Liste der Verbspur berechnet
% werden: < Trace, er, ihr >, < er, Trace, ihr >, < er, ihr, Trace >
% Nur eine dieser Abfolgen liegt aber in der SUBCAT-Liste des Verbs in Erststellung
% vor.
   
%(head_complement_phrase,
% non_head_dtrs:[trace:extraction]) *> loc:cat:comps:[].

% Wenn die Nicht-Kopftochter eine Extraktionsspur ist, ist die gesamte
% Phrase maximal.
(head_complement_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *> synsem:max_:plus.

% Maximale Phrasen können keine Köpfe in Kopf-Argumentstrukturen sein, da sie ja maximal sind.
% Durch die beiden Beschränkungen wird Maximalität erneut und ohne Bezug auf SUBCAT definiert.
% Wie gesagt, nur ein technischer Trick.
head_complement_phrase *> head_dtr:synsem:max_:minus.


headed_phrase *>
  (synsem:nonloc:rel:(list_with_zero_or_one_element,
                      append(Rel1,Rel2)),
       head_dtr:synsem:nonloc:rel:Rel1,
       non_head_dtrs:[synsem:nonloc:rel:Rel2]).

% Relativsätze Laut ERG 2025-04-04 wird das LTOP aus NONLOC|REL mit dem LTOP des modifizierten
% Nomens geteilt.  Dadurch kann das Possessivpronomen in Relativsätzen konjunktiv mit dem
% modifizierten Nomen verknüpft werden. "Der Mann, dessen Kind schläft, lacht."
rc *>
 (%isect_n_modifier,
  %filler_phrase
  synsem:(loc:(cat:(head:(relativizer,
                          mod:loc:cont:(ind:Ind,
                                        ltop:LTop)),
                    spr:[],
                    comps:[]),
               cont:Cont),
%      (ind:Ind,
%             ltop:LTop),
          nonloc:rel:[]),
  dtrs:[synsem:nonloc:rel:[(ind:Ind,
                            ltop:LTop)],
        synsem:(loc:(cat:head:initial:minus,
                     cont:(Cont,
                           ltop:LTop)),
                nonloc:rel:[],
                                % Der finite Satz selbst darf nicht extrahiert werden.
                                % Das könnte man auch durch loc:Loc, Loc =/= Slash erzwingen.
                trace:minus)]).


% Kasusprinzip

(word,
 synsem:loc:cat:(head:verb,
                 arg_st:hd:loc:cat:head:case:case_type:str)) *> (synsem:loc:cat:arg_st:hd:loc:cat:head:case:morph_case:nom).


Rest^(word,
 synsem:loc:cat:(head:verb,
                 arg_st:tl:Rest)) *> (bot) goal (assign_accusative(Rest)).


assign_accusative(List) if
       when(
            List=(e_list;ne_list)
           , undelayed_assign_accusative(List)
           ).

undelayed_assign_accusative([]) if true.
undelayed_assign_accusative([(@np_str,
                              loc:cat:head:case:morph_case:acc)|Rest])  if assign_accusative(Rest).
undelayed_assign_accusative([@np_lex|Rest])                             if assign_accusative(Rest).
undelayed_assign_accusative([@no_noun|Rest])                            if assign_accusative(Rest).



root :=
 synsem:(loc:cat:(head:dsl:none,
                  spr:[],
                  comps:[]),
         nonloc:slash:[]).

initial_fin_verb :=
 (@root,
  synsem:loc:cat:head:(verb,
                       initial:plus,
                       vform:fin)).

% interrogative
interrog :=
 (@initial_fin_verb,
  synsem:loc:cont:ind:mode:interrogative).

% Funktioniert nicht, weil das oberste Element eine Konjunktion sein kann:
% Paul ist ein Idiot und warum merkt das außer mir niemand?

% assertion
decl :=
 (@initial_fin_verb,
  synsem:loc:cont:ind:mode:assertion,
  v2:plus).

% imparative = v1 oder v2 mit Ausrufezeichen
imp :=
 (@initial_fin_verb,
  synsem:loc:cont:ind:mode:imperative).
