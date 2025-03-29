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
           subcat:[])).

% Das könnte man auch wie folgt als Implikation definieren:
%
/*

% ohne diese Bedingung könnten Projektionen der Verbspur
% mit einer weiteren Verbspur kombiniert werden:
% [ [ er _ ] _ ]
(head_argument_phrase,
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
(head_argument_phrase,
 loc:cat:head:initial:minus) *> non_head_dtrs:[loc:cat:head: @not(verb)].



% ebenfalls linguistisch nicht notwendig, verringert
% aber die Menge der von TRALE berechneten Regeln.

% ohne diese Bedingung könnte die Verbspur beliebig oft
% als Adjunkt auftreten.

head_adjunct_phrase *>
  (non_head_dtrs:[loc:cat:head:dsl:none]).


% Hierdurch wird das leere Verb bei Initialstellung als Kopf ausgeschlossen.
% Das ist wichtig für die Regelberechnung.

% Siehe auch Kapitel-10/speed.pl

(head_adjunct_phrase,
 head_dtr:loc:cat:head:verb) *> (non_head_dtrs:[loc:cat:head:pre_modifier:plus]).
















%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%
%%%%%%%% Generierung


% Beschränkung für Elemente in Subcat-Listen
% Die Beschränkung ist eigentlich
% nicht nötig, da das vom Quantor gemacht wird, aber beim Generieren ist
% der Quantor noch nicht verfügbar und so können beliebig viele Adjunkte eingeführt
% werden, weshalb das Generieren nicht terminieren würde.

%(subcat:hd:(cat:head:noun,
%                   cont:qstore:ne_list)) *> (subcat:hd:(cont:(nucleus:Cont,
%                                                                     qstore:hd:restind:Cont))).

%(cat:(head:noun,
%      subcat:[]),
% cont:qstore:ne_list) *> (cont:(nucleus:Cont,
%                                 qstore:hd:restind:Cont)).


% Schlägt wegen `seine Frau' fehl.
% non_head_dtrs:hd:(cat:head:noun,
%                   cont:qstore:ne_list) *> non_head_dtrs:hd:cont:(nucleus:Cont,
%                                                                  qstore:hd:restind:Cont).


% geht nicht wegen "der mutmaßliche Mörder"
% (cat:head:noun,
%  cont:qstore:ne_list)          *> cont:(nucleus:restr:sublist(Restr),
%                                         qstore:hd:restind:restr:Restr).



% das interessante buch seine kluge frau kennt = 1:41 Min
non_head_dtrs:hd:loc:(cat:head:noun,
                      cont:qstore:ne_list) *> non_head_dtrs:hd:loc:cont:( % der normale Fall
                                                                          nucleus:Cont,
                                                                          qstore:hd:restind:Cont
                                                                        ; % Possessivpronomina fügen eine `besitzen'-Relation
                                                                          % in die Menge der Restriktionen ein.
                                                                          nucleus:restr:Restr,
                                                                          qstore:hd:restind:restr:tl:Restr
                                                                        ).


% ist nicht restriktiv genug, da alle Nomina im Lexikon erst mal zur Generierung
% der NP gewählt werden.
% das interessante buch seine kluge frau kennt = 1:00 Min

% Eventuell wird die obige Restriktion bei größeren Lexika besser.

% (head_adjunct_phrase,
%    loc:cat:head:noun)          *> loc:cont:(nucleus:restr:sublist(Restr),
%                                             qstore:hd:restind:restr:Restr).





% schließt beim Generieren von Pronomina Hypothesen für Nomina aus.
% er oft lacht 1.910 -> 0.280 sec
cat:head:det *> cont:qstore:ne_list.

/*

non_quantifying_pred :=
  (loc:(cat:subcat:Subcat,
        cont:qstore:collectQStores(Subcat))).

verb_trace_generator_hack :=
  (@non_quantifying_pred,  % nur für das Terminieren der Generierung nötig
                           % setzt QStore zu SUBCAT in Beziehung.

   % Diese Spezifikation macht die Spur mit dem semantischen Beitrag
   % in Verberststellung inkompatibel. Damit kann sie bei der semantic-head-driven
   % Generierung nicht verwendet werden und nur Verberstverben werden generiert.
   % Diese sind spezifisch genug, so daß die Generierung terminiert.
   loc:cont:relation).


*/