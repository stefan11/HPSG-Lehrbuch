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
    non_head_dtr:phon:ne_list).  % keine Spuren (TRACE-) bzw. leere Elemente (Determinator).
                                 % Evtl. bei Vorfeldellipse ändern.

%head_filler_phrase *> loc:cat:head:dsl:none.
   
% scheint nicht zu funktionieren
%head_filler_phrase *>
%   head_dtr:phon:ne_list.  % keine Spuren (TRACE-) bzw. leere Elemente (Determinator).

% head_filler_phrase *> dtrs:[phon:ne_list,phon:ne_list].

% Phrasen sind natürlich nie Spuren.
phrase *> trace:minus.


(head_adjunct_phrase,
 non_head_dtr:trace:extraction) *> head_dtr:lex:plus. % to avoid spurious ambiguities



% Bedingung, die in rules.pl für kopffinale Regel verwendet wird.
argument_sign :=
 (loc:cat:(head:(% Linguistisch ist es nicht notwendig, aber TRALE rechnet
                 % die leeren Elemente aus und hängt sich dabei auf, wenn
                 % man nicht Spuren per Hand ausschließt.
                 dsl:none,
                 
                 mod:none,      % keine Adjunkte: Adjektive ^ Adverbien
                 spec:none      % keine Determinierer
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
  (non_head_dtr:loc:cat:head:dsl:none).

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
 loc:cat:head:initial:minus) *> non_head_dtr:loc:cat:head: @not(verb).



% ebenfalls linguistisch nicht notwendig, verringert
% aber die Menge der von TRALE berechneten Regeln.

% ohne diese Bedingung könnte die Verbspur beliebig oft
% als Adjunkt auftreten.

head_adjunct_phrase *>
  non_head_dtr:loc:cat:head:dsl:none.

% allgemeiner
%head_non_complement_phrase *>
%  (non_head_dtr:loc:cat:head:dsl:none).






% Die folgende Beschränkung erlaubt Extraktion nur,
% wenn der Kopf ein Verb in Letztstellung ist.
% Damit wird gleichzeitig die Modifikation des "bewegten" Verbs
% durch eine Spur ausgeschlossen.

% Extraktion aus NPen ist ebenfalls ausgeschlossen, was empirisch nicht korrekt ist.

(head_adjunct_phrase,
 non_head_dtr:trace:extraction) *> loc:cat:head:(verb,
                                                 initial:minus).

% Wahrscheinlich kann Verbspur mit Extraktionsspur kombiniert werden, diese wird dann mit
% extrahiertem Adverb kombiniert. Das sollte nicht gehen, weil es eine Restriktion in der Anzahl der
% Elemente auf 1 für SLASH gibt. Diese wird aber nur angewendet, wenn sie in der richtigen
% Reihenfolge wie in syntax.pl angegeben verwendet wird.
%
%(head_adjunct_phrase,
% non_head_dtr:trace:extraction) *> nonloc:slash:[].



% Das steht auch im Lexikon bei den Verbmodifikatoren, aber man braucht es hier,
% um sinnlose Spuren auszuschließen.

% [ daß er schläft _ ]

% Außerdem wird das leere Verb bei Initialstellung als Kopf ausgeschlossen.
% Das ist wichtig für die Regelberechnung.

(head_adjunct_phrase,
 head_dtr:loc:cat:head:verb) *> non_head_dtr:loc:cat:head:pre_modifier:plus.

% Adjunkte werden immer als direkte Töchter des Verbs eingeführt,
% da sonst unechte Mehrdeutigkeiten entstünden.
(head_adjunct_phrase,
 non_head_dtr:trace:extraction) *> head_dtr:lex:plus.

% Das wird später im Zusammenhang mit dem Verbalkomplex benötigt.
% Jetzt ist es aus Effizienzgründen schon in der Grammatik.
% Siehe speed.pl.
head_non_adjunct_phrase *> lex:minus.

% Achtung: Oft gibt er nicht dem Mann das Buch.

% er lacht oft.
% ist sonst mehrdeutig.

% * [ oft [ _ _ ]]
%   [ _   [ oft _ ]]

(head_adjunct_phrase,
 head_dtr:head_complement_phrase) *> head_dtr:non_head_dtr:trace:minus.




% Entweder in rules.pl spr_h nur für nomina und Determinatoren spezifizieren, oder hier sagen, dass
% Verbspuren keinen Specifier haben. Das kommt sonst erst, wenn das Verb in Initialstellung mit dem
% Rest kombiniert wird. Das bedeutet, dass beliebig viele Elemente mit der Verbspur als Spezifikator
% kombiniert werden könnten.
(phon:[],
 loc:cat:head:verb) *> loc:cat:spr:[].


head_specifier_phrase *>
             dtrs:[(loc:cat:head:det,   % speed + Regelberechnung
                    trace:minus         % speed: steht eigentlich im Lexikon
                    ),loc:cat:head:noun].        % speed + Regelberechnung


% Relativsätze

% Information über Relativpronomina kann nur aus der vorangestellten Relativphrase kommen.
% Die Relativphrase kann aber nur aus dem Relativpronomen selbst oder aus einer PP bestehen.

head_adjunct_phrase *>
  non_head_dtr:nonloc:rel:[].

% Das stimmt nicht für zu-Infinitive wie in
% das Buch, das zu lesen ich ihm empfohlen habe
% Deshalb wird diese Beschränkung später revidiert.
(headed_phrase,
 loc:cat:head:verb) *> nonloc:rel:[].

