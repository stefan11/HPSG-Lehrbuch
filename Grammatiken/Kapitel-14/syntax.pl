% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.13 $
%%      $Date: 2006/08/14 18:59:35 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile '*>'/2.
:- discontiguous '*>'/2.
:- multifile if/2.
:- discontiguous if/2.



%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (synsem:loc:cat:head:Head,
    head_dtr:synsem:loc:cat:head:Head).


%% Valenzprinzip

head_argument_phrase *>
   (synsem:loc:cat:subcat:del(NonHeadDtr,Subcat),
    head_dtr:synsem:loc:cat:subcat:Subcat,
    non_head_dtrs:[synsem:NonHeadDtr]).

head_non_argument_phrase *>
   (synsem:loc:cat:subcat:Subcat,
    head_dtr:synsem:loc:cat:subcat:Subcat).


%% Semantikprinzip

head_non_adjunct_phrase *>
   (synsem:loc:cont:Cont,
    head_dtr:synsem:loc:cont:Cont).

head_adjunct_phrase *>
   (synsem:loc:cont:Cont,
    non_head_dtrs:[synsem:loc:cont:Cont]).




%% Kopf-Adjunkt-Strukturen


head_adjunct_phrase *>
   (head_dtr:synsem:HeadSynsem,
    non_head_dtrs:[synsem:loc:cat:(head:mod:HeadSynsem,
                                   subcat:[])]).


%% Spezifikatorprinzip

(headed_phrase,
 non_head_dtrs:[synsem:loc:cat:head:spec:synsem]) *>
   (head_dtr:synsem:Head,
    non_head_dtrs:[synsem:loc:cat:head:spec:Head]).


head_specifier_phrase *> 
   (synsem:loc:cat:spr:[],
    head_dtr:synsem:loc:cat:(spr:[Spr],
                             subcat:[]),
    non_head_dtrs:[synsem:Spr]).

head_non_specifier_phrase *> 
   (synsem:loc:cat:spr:Spr,
    head_dtr:synsem:loc:cat:spr:Spr).



% Teil der Verbbewegungsanalyse

% Das ist eine unär verzweigende Regel und keine Lexikonregel,
% da sie auch auf koordinierte Verben angewendet werden kann.
% Siehe auch coordination.pl.
verb_initial_rule *>
( %complementizer_like_sign
  synsem:(loc:cat:(head:(verb,
                         vform:fin),
                   subcat:[loc:cat:head:dsl:Loc]),
          nonloc:slash:(Slash, 
                        [])),
  non_head_dtrs:[synsem:(loc:(Loc,
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
           phon:ne_list)) *> (head_dtr:synsem:loc:cat:head:dsl:none).


headed_phrase *> synsem:phrase:plus.


head_filler_phrase *>
   (synsem:nonloc:slash:[],
       head_dtr:synsem:(loc:cat:(head:(verb,
                                      initial:plus),
                                 subcat:[]),
                        nonloc:slash:[Slash]),
       non_head_dtrs:[synsem:(loc:Slash,
                              nonloc:(rel:[], % "In der hat er geschlafen." hätte sonst zwei Strukturen.
                                      slash:[]))]).

%%
head_non_filler_phrase *>
   (synsem:nonloc:slash:(list_with_zero_or_one_element,
                         append(Slash1,Slash2)),
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
      (head_dtr:synsem:loc:cat:head:mod:none).


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
% non_head_dtrs:[trace:extraction]) *> synsem:loc:cat:subcat:[].

% Wenn die Nicht-Kopftochter eine Extraktionsspur ist, ist die gesamte
% Phrase maximal.
(head_argument_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *> synsem:max_:plus.

% Maximale Phrasen können keine Köpfe in Kopf-Argumentstrukturen sein, da sie ja maximal sind.
% Durch die beiden Beschränkungen wird Maximalität erneut und ohne Bezug auf SUBCAT definiert.
% Wie gesagt, nur ein technischer Trick.
head_argument_phrase *> head_dtr:synsem:max_:minus.


headed_phrase *>
  (synsem:nonloc:rel:(list_with_zero_or_one_element,
                      append(Rel1,Rel2)),
      head_dtr:synsem:nonloc:rel:Rel1,
      non_head_dtrs:[synsem:nonloc:rel:Rel2]).

% Relativsätze
rc *>
 (%isect_n_modifier,
  synsem:(loc:(cat:(head:(relativizer,
                          mod:loc:cont:qstore:[Q]),
                    subcat:[]),
               cont:(nucleus:(ind:Ind,
                              restr:hd:RCCont), %[RCCont|_NP_CONT],
                     qstore:[Q|QStore])),
          nonloc:(rel:[],
                  slash:[])),
  non_head_dtrs:[synsem:(loc:Slash,
                         nonloc:(rel:[Ind],
                                 slash:[])),
                 synsem:(loc:(cat:(head:(verb,
                                         dsl:none,
                                         initial:minus,
                                         vform:fin),
                                   subcat:[]),
                              cont:(nucleus:RCCont,
                                    qstore:QStore)),
                         nonloc:(rel:[],
                                 slash:[Slash]),
                                % Der finite Satz selbst darf nicht extrahiert werden.
                                % Das könnte man auch durch loc:Loc, Loc =/= Slash erzwingen.
                         trace:minus)]).





% Kasusprinzip

(word,
 synsem:loc:cat:(head:verb,
                 subcat:hd:loc:cat:head:case:case_type:str)) *> (synsem:loc:cat:subcat:hd:loc:cat:head:case:morph_case:nom).


Rest^(word,
 synsem:loc:cat:(head:verb,
                 subcat:tl:Rest)) *> (bot) goal (assign_accusative(Rest)).


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
 (synsem:(loc:cat:(head:dsl:none,
                   spr:[],
                   subcat:[]),
          nonloc:slash:[])).

initial_fin_verb :=
 (@root,
  synsem:loc:cat:head:(verb,
                       initial:plus,
                       vform:fin)).

interrog :=
 @initial_fin_verb.

decl :=
 (@initial_fin_verb,
  synsem:v2:plus).
