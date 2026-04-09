% -*- trale-prolog -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: mehrfache-vorfeldbesetzung.pl,v $
%%  $Revision: 1.9 $
%%      $Date: 2006/02/26 18:08:11 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%
%%             Diese Datei enthält eine Lexikonregel, die
%%             für die Analyse der scheinbar mehrfachen
%%             Vorfeldbesetzung verwendet wird.
%%             Siehe Müller, 2005
%%
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile lex_rule/2.
:- multifile '*>'/2.

:- multifile 'fun'/1.
:- multifile 'if'/2.

% Testen mit:   Der Frau das Buch gibt er nicht.
%               Der Frau den Aufsatz will er geben.
%             * Der Frau der Aufsatz gibt er.
%             * Der Frau der Aufsatz will er geben.


fun list_of_non_dsl_synsems(-).
list_of_non_dsl_synsems(L) if
   when( (L=(e_list;ne_list)),
         undelayed_list_of_non_dsl_synsems(L) ).

undelayed_list_of_non_dsl_synsems([]) if true.
undelayed_list_of_non_dsl_synsems([loc:cat:head:dsl:none|T]) if
   list_of_non_dsl_synsems(T).



mvf_rule *>
( %verb_movement_lr,
  synsem:(loc:(cat:(head:(initial:Initial,
                          vform:VForm),
                    comps:hd:(loc:cont:Cont,
                              trace:extraction % nur um unechte Mehrdeutigkeiten zu vermeiden
                             )),
               cont:Cont)),
  v2:minus,
  dtrs:[synsem:loc:cat:(head:(initial:Initial,
                              initial:minus, % would exclude particle verbs: [Völlig zur Kaffeesatzleserei -] artet es aus
                              vform:VForm),
                        comps:(list_of_non_dsl_synsems,             % ansonsten könnte Regel auf sich selbst angewendet werden
                               list_of_non_complex_forming_synsems) % ansonsten würden PVP-Strukturen mit NP und Verb im VF ambig
                       )]).


mult_fronting_verb_movement_lr lex_rule
  Dtr
**>
( mvf_rule,
  dtrs:[Dtr])
morphs
  X becomes X. % when ((write('mult:'),write(Phon),nl)).

/*
test_lr lex_rule
  (Dtr,
   synsem:(Synsem,
           loc:cat:(head:noun,
                    spr:[],
                    comps:[])),
   rels:Rels,
   hcons:HCons)
**>
( complex_word,
  synsem:Synsem,
  rels:Rels,
  hcons:HCons,
  dtr:Dtr)
morphs
  X becomes X. % when ((write('mult:'),write(Phon),nl)).
*/
