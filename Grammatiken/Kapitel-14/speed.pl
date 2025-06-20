% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: speed.pl,v $
%%  $Revision: 1.11 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Linguistisch nicht signifikante Hacks
%%             zur Effizienzsteigerung/Terminierung
%%             beim Bottom-Up-Parsen
%%             bzw. bei der Semantic-Head-Driven-Generation
%%   Language: Trale
%%     System: TRALE 2.3.7 under Sicstus 3.9.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile '*>'/2.
:- discontiguous '*>'/2.
:- multifile if/2.
:- discontiguous if/2.
:- multifile fun/1.
:- discontiguous fun/1.

:- multifile macro/2.
:- discontiguous macro/2.

% Die folgenden Regeln schließen die Erzeugung von Phrasenstrukturregeln aus,
% die in der Grammatik nicht gebraucht werden.

head_filler_phrase *>
   (v2:plus,
    non_head_dtrs:[phon:ne_list]).  % keine Spuren (TRACE-) bzw. leere Elemente (Determinator).
                                    % Evtl. bei Vorfeldellipse ändern.

%head_filler_phrase *> loc:cat:head:dsl:none.
   
% scheint nicht zu funktionieren
%head_filler_phrase *>
%   head_dtr:phon:ne_list.  % keine Spuren (TRACE-) bzw. leere Elemente (Determinator).

% head_filler_phrase *> dtrs:[phon:ne_list,phon:ne_list].

% Phrasen sind natürlich nie Spuren.
phrase *> synsem:trace:minus.


(head_adjunct_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *> head_dtr:synsem:lex:plus. % to avoid spurious ambiguities



% Bedingung, die in rules.pl für kopffinale Regel verwendet wird.
argument_synsem :=
 (loc:cat:(head:(% Linguistisch ist es nicht notwendig, aber TRALE rechnet
                 % die leeren Elemente aus und hängt sich dabei auf, wenn
                 % man nicht Spuren per Hand ausschließt.
                        dsl:none,
                 
                        mod:none, % keine Adjunkte: Adjektive ^ Adverbien
                        spec:none % keine Determinierer
                       ),
                  spr:[],
                  comps:[])).

% Das könnte man auch wie folgt als Implikation definieren:
%
/*

% ohne diese Bedingung könnten Projektionen der Verbspur
% mit einer weiteren Verbspur kombiniert werden:
% [ [ er _ ] _ ]
(head_complement_phrase,
 loc:cat:head:initial:minus) *>
  (non_head_dtrs:[loc:cat:head:dsl:none]).

*/

% Hey, Negation!

%% Type negation - delay until type T and then die.
not(Type) macro not_type(a_ Type).
fun not_type(+,-).
( not_type((a_ Type),FS) if
      when(FS=Type,
           prolog(fail)) ) :-
        type(Type).



% Folgendes schließt finite Verben als Argumente (der Verbspur) aus, da
% sie in diesem Fragment nicht vorkommen.
(head_complement_phrase,
 synsem:loc:cat:head:initial:minus) *> non_head_dtrs:[synsem:loc:cat:head: @not(verb)].



% ebenfalls linguistisch nicht notwendig, verringert
% aber die Menge der von TRALE berechneten Regeln.

% ohne diese Bedingung könnte die Verbspur beliebig oft
% als Adjunkt auftreten.

head_adjunct_phrase *>
  non_head_dtrs:[synsem:loc:cat:head:dsl:none].

% allgemeiner
%head_non_complement_phrase *>
%  (non_head_dtrs:[loc:cat:head:dsl:none]).






% Die folgende Beschränkung erlaubt Extraktion nur,
% wenn der Kopf ein Verb in Letztstellung ist.
% Damit wird gleichzeitig die Modifikation des "bewegten" Verbs
% durch eine Spur ausgeschlossen.

% Extraktion aus NPen ist ebenfalls ausgeschlossen, was empirisch nicht korrekt ist.

(head_adjunct_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *> synsem:loc:cat:head:(verb,
                                                                  initial:minus).

% Wahrscheinlich kann Verbspur mit Extraktionsspur kombiniert werden, diese wird dann mit
% extrahiertem Adverb kombiniert. Das sollte nicht gehen, weil es eine Restriktion in der Anzahl der
% Elemente auf 1 für SLASH gibt. Diese wird aber nur angewendet, wenn sie in der richtigen
% Reihenfolge wie in syntax.pl angegeben verwendet wird.
%
%(head_adjunct_phrase,
% non_head_dtrs:[trace:extraction]) *> nonloc:slash:[].



% Das steht auch im Lexikon bei den Verbmodifikatoren, aber man braucht es hier,
% um sinnlose Spuren auszuschließen.

% [ daß er schläft _ ]

% Außerdem wird das leere Verb bei Initialstellung als Kopf ausgeschlossen.
% Das ist wichtig für die Regelberechnung.

(head_adjunct_phrase,
 head_dtr:synsem:loc:cat:head:verb) *> non_head_dtrs:[synsem:loc:cat:head:pre_modifier:plus].

% Adjunkte werden immer als direkte Töchter des Verbs eingeführt,
% da sonst unechte Mehrdeutigkeiten entstünden.
(head_adjunct_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *> head_dtr:synsem:lex:plus.


% Achtung: Oft gibt er nicht dem Mann das Buch.

% er lacht oft.
% ist sonst mehrdeutig.

% * [ oft [ _ _ ]]
%   [ _   [ oft _ ]]

(head_adjunct_phrase,
 head_dtr:head_complement_phrase) *> head_dtr:non_head_dtrs:[synsem:trace:minus].




% Entweder in rules.pl spr_h nur für nomina und Determinatoren spezifizieren, oder hier sagen, dass
% Verbspuren keinen Specifier haben. Das kommt sonst erst, wenn das Verb in Initialstellung mit dem
% Rest kombiniert wird. Das bedeutet, dass beliebig viele Elemente mit der Verbspur als Spezifikator
% kombiniert werden könnten.
(phon:[],
 synsem:loc:cat:head:verb) *> synsem:loc:cat:spr:[].


head_specifier_phrase *>
             dtrs:[synsem:(loc:cat:head:det,   % speed + Regelberechnung
                           trace:minus),       % speed: steht eigentlich im Lexikon
                   synsem:loc:cat:head:noun].  % speed + Regelberechnung


% Relativsätze

% Information über Relativpronomina kann nur aus der vorangestellten Relativphrase kommen.
% Die Relativphrase kann aber nur aus dem Relativpronomen selbst oder aus einer PP bestehen.

head_adjunct_phrase *>
  non_head_dtrs:[synsem:nonloc:rel:[]].

% Das stimmt nicht für zu-Infinitive wie in
% das Buch, das zu lesen ich ihm empfohlen habe
% Deshalb wird diese Beschränkung später revidiert.
(headed_phrase,
 synsem:loc:cat:head:verb) *> synsem:nonloc:rel:[].


% Für Sätze wie "Lachen muß er." braucht man am Satzende
% eine Kombination der Verbspur mit einer Extraktionsspur.
% Die Sucat-Liste der entstehenden Projektion ist unbestimmt,
% so daß dieser Komplex dann mit allem Material, das es
% im Satz gibt, kombiniert werden kann.
% Erst wenn der Füller gefunden wird, stellt sich heraus,
% daß diese Kombinationen sinnlos waren.
% Wir sind schlauer und sagen schon jetzt Bescheid:


fun list_of_argument_synsems(-).
list_of_argument_synsems(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_argument_synsems(L) ).

undelayed_list_of_argument_synsems([]) if true.
undelayed_list_of_argument_synsems([(@argument_synsem)|T]) if
   list_of_argument_synsems(T).

head_cluster_phrase *> (synsem:loc:cat:comps:(list_of_argument_synsems,
                                              list_of_non_complex_forming_synsems)). % Extraktionsspur + Verbspur -> danach weitere Cluster

% er ihm müssen mit verbleibendem Verb-Komplement auf der Valenzliste
(head_complement_phrase,
 synsem:loc:cat:head:initial:minus) *> synsem:loc:cat:comps:list_of_non_complex_forming_synsems.



% Ansonsten würde `er lachen' als Verbalkomplexbestandteil mit einer
% Verbspur kombinierbar sein.
(head_cluster_phrase,
 synsem:loc:cat:head:initial:minus) *> non_head_dtrs:[synsem:lex:plus].



% Der folgende Satz ist der einzige Satztyp, für den man eine geflippte Verbspur braucht.
% Das Lied wird er [ _ [haben singen wollen]].
%
% * Das Lied wird er [ _ singen wollen].
%   Das Lied wird er [ singen wollen _].

% Verhindert unechte Mehrdeutigkeiten und:

% er wird lachen dürfen wollen.
% ==> 18 min 37.340 sec CPU time.        2 solutions; 1033 passive edges; residues: 0,0
%
% ==>  8 min 45.000 sec CPU time.        1 solutions; 583 passive edges; residues: 0


(head_cluster_phrase,
 synsem:loc:cat:head:dsl:local,
 non_head_dtrs:[synsem:loc:cat:head:flip:plus]) *> non_head_dtrs:[phon:hd: (a_ haben)].


% Terminierung: Der Regelberechnung.
% Die Nicht-Kopftochter in Kopf-Cluster-Strukturen kann nur einen
% gefüllten DSL-Wert haben, wenn die Verbspur auch extrahiert wird.
(head_cluster_phrase,
 non_head_dtrs:[ synsem:loc:cat:head:dsl:local]) *> non_head_dtrs:[synsem:trace:extraction].


% Das schließt das finite Verb als cluster daughter aus.
% Diese Implikation schließt auch Partikel und Adjektive aus, ist also zu stark.
% Die Einschränkung auf gefüllte PHON läßt Verbspuren für die mehrfache Vorfeldbesetzung zu.
(head_cluster_phrase
% ,phon:ne_list  % funktioniert nicht. TRALE-Bug??
, non_head_dtrs:[synsem:loc:cat:head:dsl:none] 
)         *> non_head_dtrs:[synsem:loc:cat:head:vform:non_fin].
