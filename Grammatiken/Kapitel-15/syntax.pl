% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.15 $
%%      $Date: 2007/06/23 14:36:58 $
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
:- multifile fun/1.
:- discontiguous fun/1.



%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (synsem:loc:cat:head:Head,
    head_dtr:synsem:loc:cat:head:Head).


%% Valenzprinzip

head_argument_phrase *>
   (synsem:loc:cat:subcat:del(NonHeadDtr,Subcat),
    head_dtr:synsem:loc:cat:subcat:Subcat,
    non_head_dtrs:[synsem:NonHeadDtr]).

head_cluster_phrase *>
 (synsem:loc:cat:subcat:Subcat,
  head_dtr:synsem:loc:cat:subcat:[CHead|Subcat],
  non_head_dtrs:[synsem:CHead]).

head_non_argument_non_cluster_phrase *>
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

% * Er schläft schläft.
%
(headed_phrase,
 head_dtr:(%word,           % should be sufficient, seems to be a TRALE bug.
           (simple_word;
            complex_word),
           phon:ne_list)) *> (head_dtr:synsem:loc:cat:head:dsl:none).


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



% In Argumentpositionen dürfen nur phrasale Einheiten
% stehen. Das wird gebraucht, da ausgeschlossen werden muß,
% daß "lachen wird" mit dem Kopf-Argument-Schema kombiniert
% wird. `wird' verlangt von seinem Argument, daß es LEX+ ist,
% und das Kopf-Argument-Schema spezifiziert LEX aber als -.
% Somit kann nur das Verbalkomplexschema angewendet werden.
% Bei adjazentem eingebetteten Verb würden unechte Mehrdeutigkeiten
% entstehen und bei nicht-adjazentem eingebetteten Verb ungrammatische
% Sätze zugelassen:
%
% * daß lesen er den Aufsatz wird
% * daß er lesen den Aufsatz wird
%
head_argument_phrase *> non_head_dtrs:[synsem:lex:minus].



%% Der Kopf kann nicht extrahiert werden.
%% Ein Problem stellt hierbei das Verb in PVP-Konstellationen
%% dar (siehe Müller, 1999)
%% "Helfen wird er ihm morgen."
headed_phrase *>
   head_dtr:synsem:trace:minus_or_vm.


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


% Die Beschränkung auf Initial:minus für die Nicht-Kopftochter ist in dieser
% Grammatik noch nicht relevant, da es keine Kopulakonstruktionen gibt und somit
% auch keine Nominalphrasen, die einen Komplex bilden könnten, allerdings
% hilft diese Beschränkung bereits, wenn eine Verbspur mit einer Extraktionsspur
% kombiniert worden ist, denn danach könnte dieser Komplex mit jedem beliebigen
% Wort kombiniert werden. Da aber Nomina initial:plus sind, scheiden sie aus.
%
% Die Beschränkung der Kopftochter auf `word' ist zu stark, da dadurch
% Koordination wie "lieben will und muß" ausgeschlossen werden.
% Damit man diese erfassen kann, muß man ein weiteres binäres Merkmal
% einführen.
% Da Adjunkte nur an LEX+ Projektionen gehen und der LEX-Wert von
% Kopf-Adjunktstrukturen nicht spezifiziert wird, wären sonst Adjunkte
% im Verbalkomplex zugelassen.


head_cluster_phrase *> (head_dtr:word,
                        non_head_dtrs:[synsem:loc:cat:head:initial:minus]).

head_argument_phrase  *> (synsem:lex:minus).
head_filler_phrase    *> (synsem:lex:minus).
head_specifier_phrase *> (synsem:lex:minus).



% Geht durch eine Liste und gibt dem letzten Element die
% Person und Numerus-Merkmale, wenn die Liste mit einer NP_str
% endet. Ansonsten muß das Verb dritte Perosn sg sein.

% Dieses Constraint wird gebraucht, da Modalverben
% nicht wissen, ob sie ein Subjekt haben.

fun subj_verb_agreement(-,+,+).
subj_verb_agreement(X,Per,Num) if
  when( X=(e_list;ne_list)
      , subj_verb_agreement1(X,Per,Num)
      ).

% subject verb agreement
% []                wird gearbeitet
% [np_lex]          dürsten
% [np_str]          schlafen
% [np_lex, np_str]  helfen
% [cp]              stimmen
% [np_lex, cp]      auffallen


% there is no argument at all
subj_verb_agreement1([],third,sg) if true.

% there is a list of arguments
% the last one may be a subject. If it is a subject, i.e. np_str_nom
% it has to agree with the verb.
% If the last element is not a noun or has lexical case, the verb
% has to be third sg.
% As a side effect the constraint assigns accusative to all nouns
% that are not initial
subj_verb_agreement1([H|T],Per,Num) if
  when( T=(e_list;ne_list)
      , undelayed_subj_verb_agreement_([H|T],Per,Num)
      ).

undelayed_subj_verb_agreement_([@np_str(Per,Num)],         Per,  Num) if true.
undelayed_subj_verb_agreement_([@np_lex],                  third,sg)  if true.
undelayed_subj_verb_agreement_([loc:cat:head:(@not(noun))],third,sg)  if true.
undelayed_subj_verb_agreement_(tl:T1,Per,Num) if
  subj_verb_agreement2(T1,Per,Num).

subj_verb_agreement2(L,Per,Num) if
  when( L=(e_list;ne_list)
      , undelayed_subj_verb_agreement_(L,Per,Num)
      ).


% Kasusprinzip (vorläufige Version, zur endgültigen Version siehe Kapitel 17)

(word,
 synsem:loc:cat:head:verb) *> (synsem:loc:cat:subcat:Subcat) goal assign_case_verb(Subcat).


fun assign_case_verb(-).
assign_case_verb(List) if
       when( List=(e_list;ne_list)
           , assign_case_verb2(List)
           ).

assign_case_verb2([H|T]) if
       when( T=(e_list;ne_list)
           , undelayed_assign_case_verb([H|T])
           ).

% Die letzte NP mit strukturellem Kasus bekommt Nominativ.
undelayed_assign_case_verb([(@np_str,
                             loc:cat:head:case:morph_case:nom)])  if true.

undelayed_assign_case_verb([@np_lex])                             if true.
undelayed_assign_case_verb([loc:cat:head: @not(noun)])            if true.

% Alle anderen NPen mit strukturellem Kasus bekommen Akkusativ.
% Die Unterteilung des Listenrests in First und Rest stellt sicher,
% daß es noch mindestens ein Element in der Valenzliste gibt.
% Für dieses werden die obigen Klauseln angewendet.
undelayed_assign_case_verb([(@np_str,
                             loc:cat:head:case:morph_case:acc)|Rest])  if assign_case_verb(Rest).
undelayed_assign_case_verb([@np_lex|Rest])                             if assign_case_verb(Rest).
undelayed_assign_case_verb([loc:cat:head: @not(noun)|Rest])            if assign_case_verb(Rest).





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
