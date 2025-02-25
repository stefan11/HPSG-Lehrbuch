% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.14 $
%%      $Date: 2006/06/15 21:00:41 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile '*>'/2.
:- discontiguous '*>'/2.



%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (loc:cat:head:Head,
    head_dtr:loc:cat:head:Head).


%% Valenzprinzip
head_argument_phrase *>
   (loc:cat:subcat:append(Subcat1,Subcat2),                       % = Subcat1 + Subcat2
    head_dtr:loc:cat:subcat:append(Subcat1,[NonHeadDtr|Subcat2]), % = Subcat1 + [NonHeadDtr] + Subcat2
    non_head_dtrs:[NonHeadDtr]).

head_non_argument_phrase *>
   (loc:cat:subcat:Subcat,
    head_dtr:loc:cat:subcat:Subcat).


%% Semantikprinzip

head_non_adjunct_phrase *>
   (loc:cont:Cont,
    head_dtr:loc:cont:Cont).

head_adjunct_phrase *>
   (loc:cont:Cont,
    non_head_dtrs:[loc:cont:Cont]).



%% Kopf-Adjunkt-Strukturen


head_adjunct_phrase *>
   (head_dtr:Head,
    non_head_dtrs:[loc:cat:(head:mod:Head,
                            spr:[],
                            subcat:[])]).


%% Spezifikatorprinzip

(headed_phrase,
 non_head_dtrs:[loc:cat:head:spec:sign]) *>
   (head_dtr:Head,
    non_head_dtrs:[loc:cat:head:spec:Head]).


head_specifier_phrase *> 
   (loc:cat:spr:[],
    head_dtr:loc:cat:(spr:[Spr],
                      subcat:[]),
    non_head_dtrs:[Spr]).

head_non_specifier_phrase *> 
   (loc:cat:spr:Spr,
    head_dtr:loc:cat:spr:Spr).


% Teil der Verbbewegungsanalyse


% Das ist eine unär verzweigende Regel und keine Lexikonregel,
% da sie auch auf koordinierte Verben angewendet werden kann.
% Siehe auch coordination.pl.
verb_initial_rule *>
( %complementizer_like_sign
  loc:cat:(head:(verb,
                 vform:fin),
           subcat:[loc:cat:head:dsl:Loc]),
  nonloc:slash:(Slash, 
                []),
  non_head_dtrs:[(loc:(Loc,
                       cat:head:(verb,
                                 vform:fin,
                                 initial:minus)),
                  nonloc:slash:Slash,
                  trace:minus,
                  % nur koordinierte Wörter dürfen zu V1-Verben umkategorisiert werden.
                  phrase:minus)]).


% * Er schläft schläft.
%
(headed_phrase,
 head_dtr:(word,
           phon:ne_list)) *> head_dtr:loc:cat:head:dsl:none.


headed_phrase *> phrase:plus.

% Da coord_phrase nicht Untertyp von headed_phrase ist,
% ist der PHRASE-Wert unterspezifiziert.

% [Ihn kennt und schläft] er.
% Ist dennoch ausgeschlossen, da die obige Implikation
% dafür sorgt, daß der DSL-Wert von `ihn kennt' none ist.
% Damit hat die Konjunktion auch den DSL-Wert none und kann
% dann nicht mehr Tochter der V1-Regel sein.



head_filler_phrase *>
   (nonloc:slash:[],
    v2:plus,
    head_dtr:(loc:cat:(head:(verb,
                             initial:plus),
                       subcat:[]),
              nonloc:slash:[Slash]),
       non_head_dtrs:[loc:Slash]).

%%
head_non_filler_phrase *>
   (nonloc:slash:(list_with_zero_or_one_element,
                  append(Slash1,Slash2)),
       head_dtr:nonloc:slash:Slash1,
       non_head_dtrs:[nonloc:slash:Slash2]).

%% Der Kopf kann nicht extrahiert werden.
%% Ein Problem stellt hierbei das Verb in PVP-Konstellationen
%% dar (siehe Müller, 1999)
%% "Helfen wird er ihm morgen."
headed_phrase *>
   (head_dtr:trace:minus_or_vm).


% Adjunkte sind Extraktionsinseln
(headed_phrase,
 non_head_dtrs:[trace:extraction]) *>
      (head_dtr:loc:cat:head:mod:none).



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
   
%(head_argument_phrase,
% non_head_dtrs:[trace:extraction]) *> loc:cat:subcat:[].

% Wenn die Nicht-Kopftochter eine Extraktionsspur ist, ist die gesamte
% Phrase maximal.
(head_argument_phrase,
 non_head_dtrs:[trace:extraction]) *> max_:plus.

% Maximale Phrasen können keine Köpfe in Kopf-Argumentstrukturen sein, da sie ja maximal sind.
% Durch die beiden Beschränkungen wird Maximalität erneut und ohne Bezug auf SUBCAT definiert.
% Wie gesagt, nur ein technischer Trick.
head_argument_phrase *> head_dtr:max_:minus.




root :=
 (loc:cat:(head:dsl:none,
           spr:[],
           subcat:[]),
  nonloc:slash:[]).

initial_fin_verb :=
 (@root,
  loc:cat:head:(verb,
                initial:plus,
                vform:fin)).

interrog :=
 @initial_fin_verb.

decl :=
 (@initial_fin_verb,
  v2:plus).
