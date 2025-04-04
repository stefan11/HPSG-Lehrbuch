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
(head_argument_phrase,
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


% Hierdurch wird das leere Verb bei Initialstellung als Kopf ausgeschlossen.
% Das ist wichtig für die Regelberechnung.

% Siehe auch Kapitel-10/speed.pl

(head_adjunct_phrase,
 head_dtr:loc:cat:head:verb) *> non_head_dtr:loc:cat:head:pre_modifier:plus.


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
