% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: speed.pl,v $
%%  $Revision: 1.12 $
%%      $Date: 2007/06/23 14:36:58 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Linguistisch nicht signifikante Hacks
%%             zur Effizienzsteigerung beim Bottom-Up-Parsen
%%   Language: Trale
%      System: TRALE 2.7.5 under Sicstus 3.12.0
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
   (synsem:v2:plus,
    non_head_dtrs:[phon:ne_list]).  % keine Spuren (TRACE-) bzw. leere Elemente (Determinator).
                                    % Evtl. bei Vorfeldellipse ändern.





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

                 mod:none,      % keine Adjunkte: Adjektive ^ Adverbien
                 spec:none % keine Determinierer
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
 synsem:loc:cat:head:initial:minus) *>
  (non_head_dtrs:[synsem:loc:cat:head:dsl:none]).

*/

/*
% inkohärente Konstruktion mit zu-Infinitiv
% Einbettung finiter Verben (Sätze) ist natürlich auch möglich,
% kommt aber in diesem Fragment nicht vor.

(head_argument_phrase,
 non_head_dtrs:[synsem:loc:cat:head:verb]) *> (non_head_dtrs:[synsem:loc:cat:head:vform:(fin;inf)]).

% Ansonsten könnte z.B. [ _ sieht] als Argument der Verbspur auftreten.
(head_argument_phrase,
 synsem:loc:cat:head:initial:minus,
 non_head_dtrs:[synsem:loc:cat:head:(verb,
                                     vform:fin)]) *> (non_head_dtrs:[synsem:loc:cat:head:initial:plus]).
*/

% Folgendes schließt finite Verben als Argumente (der Verbspur) ganz aus, da
% sie in diesem Fragment nicht vorkommen.
(head_argument_phrase,
 synsem:loc:cat:head:initial:minus,
 non_head_dtrs:[synsem:loc:cat:head:verb]) *> (non_head_dtrs:[synsem:loc:cat:head:vform:inf]).






% ebenfalls linguistisch nicht notwendig, verringert
% aber die Menge der von TRALE berechneten Regeln.

% ohne diese Bedingung könnte die Verbspur beliebig oft
% als Adjunkt auftreten.

head_adjunct_phrase *>
  (non_head_dtrs:[synsem:loc:cat:head:dsl:none]).

% allgemeiner
%head_non_argument_phrase *>
%  (non_head_dtrs:[synsem:loc:cat:head:dsl:none]).






% Die folgende Beschränkung erlaubt Extraktion nur,
% wenn der Kopf ein Verb in Letztstellung ist.
% Damit wird gleichzeitig die Modifikation des "bewegten" Verbs
% durch eine Spur ausgeschlossen.

% Extraktion aus NPen ist ebenfalls ausgeschlossen, was empirisch nicht korrekt ist.

(head_adjunct_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *> (synsem:loc:cat:head:(verb,
                                                                   initial:minus)).



% Das steht auch im Lexikon bei den Verbmodifikatoren, aber man braucht es hier,
% um sinnlose Spuren auszuschließen.

% [ daß er schläft _ ]

% Außerdem wird das leere Verb bei Initialstellung als Kopf ausgeschlossen.
% Das ist wichtig für die Regelberechnung.

(head_adjunct_phrase,
 head_dtr:synsem:loc:cat:head:verb) *> (non_head_dtrs:[synsem:loc:cat:head:pre_modifier:plus]).


% Adjunkte werden immer als direkte Töchter des Verbs eingeführt,
% da sonst unechte Mehrdeutigkeiten entstünden.
(head_adjunct_phrase,
 non_head_dtrs:[synsem:trace:extraction]) *> (head_dtr:synsem:lex:plus).



% Achtung: Oft gibt er nicht dem Mann das Buch.

% er lacht oft.
% ist sonst mehrdeutig.

% * [ oft [ _ _ ]]
%   [ _   [ oft _ ]]

(head_adjunct_phrase,
 head_dtr:head_argument_phrase) *> (head_dtr:non_head_dtrs:[synsem:trace:minus]).



% Relativsätze

% Information über Relativpronomina kann nur aus der vorangestellten Relativphrase kommen.
% Die Relativphrase kann aber nur aus dem Relativpronomen selbst oder aus einer PP bestehen.

head_adjunct_phrase *>
  (non_head_dtrs:[synsem:nonloc:rel:[]]).

% Das stimmt nicht für zu-Infinitive wie in
% das Buch, das zu lesen ich ihm empfohlen habe
% Deshalb wird diese Beschränkung später revidiert.
(headed_phrase,
 synsem:loc:cat:head:verb) *> (synsem:nonloc:rel:[]).


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

head_cluster_phrase *> (synsem:loc:cat:subcat:(list_of_argument_synsems,
                                               list_of_non_complex_forming_synsems)). % Extraktionsspur + Verbspur -> danach weitere Cluster


% er ihm müssen mit verbleibendem Verb-Komplement auf der Valenzliste
(head_argument_phrase,
 synsem:loc:cat:head:initial:minus) *> (synsem:loc:cat:subcat:list_of_non_complex_forming_synsems).

% Ansonsten würde `er lachen' als Verbalkomplexbestandteil mit einer
% Verbspur kombinierbar sein.
(head_cluster_phrase,
 synsem:loc:cat:head:initial:minus) *> (non_head_dtrs:[synsem:lex:plus]).



/*
% Für die Anzeige der Regeln
head_argument_phrase *> (head_dtr:HD,
                            non_head_dtrs:[NHD],
                            ( head_dtr:synsem:loc:cat:head:initial:plus,
                              dtrs:[HD,NHD]
                            ; head_dtr:synsem:loc:cat:head:initial:minus,
                              dtrs:[NHD,HD]
                            )).

*/


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
 non_head_dtrs:[synsem:loc:cat:head:flip:plus]) *> (non_head_dtrs:[phon:hd: (a_ haben)]).


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
)         *> (non_head_dtrs:[synsem:loc:cat:head:vform:non_fin]).


% Das oben funktioniert nicht ohne folgende Implikation, da der DSL-Wert finiter
% Verben nicht im Lexikon festgelegt wird, sondern erst über Implikationen in der
% Syntax. Siehe syntax.pl zum Fall mit Spur als Kopftochter.

(headed_phrase,
 non_head_dtrs:hd:(%word,           % should be sufficient, seems to be a TRALE bug.
                   (simple_word;
                       complex_word),
                   phon:ne_list)) *> (non_head_dtrs:hd:synsem:loc:cat:head:dsl:none).


head_initial := (head_dtr:HD,
                    non_head_dtrs:[NHD],
                    dtrs:[HD,NHD]).

head_final := (head_dtr:HD,
                  non_head_dtrs:[NHD],
                  dtrs:[NHD,HD]).


