% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexrules.pl,v $
%%  $Revision: 1.13 $
%%      $Date: 2007/03/05 11:26:29 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile lex_rule/2.


:- multifile '*>'/2.
:- discontiguous '*>'/2.



verb_movement_lr *>
( %complex_word
  %optionally_coherent_word
  synsem:(loc:cat:(head:verb,
                   subcat:hd:loc:cat:head:dsl:Loc),
          nonloc:Nonloc,
          trace:Trace,
          lex:Lex),
  dtrs:[( word,
          synsem:(loc:(Loc,
                       cat:head:(verb,
                                 initial:minus)),
                  nonloc:Nonloc,
                  trace:Trace,
                  lex:Lex))]).


verb_initial_lr *>
( %verb_movement_lr
  %complementizer_like_word
  synsem:loc:cat:head:vform:fin,
  dtrs:[ synsem:loc:cat:head:vform:fin ]).


% Sätze mit Verb in Erststellung können Imperativsätze oder auch Interrogativsätze sein.
% Die beiden folgenden Sätze unterscheiden sich nur hinsichtlich ihrer Flexion:
%
%     Gib   Du mir das Buch!
%     Gibst Du mir das Buch?
%
% Die genaue Auflösung der Relation erfolgt erst in der Grammatik für Kapitel 16,
% da dort erst eine Morphologiekomponente eingeführt wird.

% Konditionalsätze werden ignoriert.


(verb_initial_lr,
 synsem:loc:cat:subcat:[nonloc:slash:[]])      *> synsem:loc:cont:nucleus:imperative_or_interrogative.

% Hier spielt das Element in SLASH eine entscheidende Rolle.
% Ist es eine Interrogativphrase, muß ein entsprechender Operator angenommen
% werden. Da die vorliegende Grammatik keine Interrogativpronomina enthält,
% wird die Fallunterscheidung nicht gemacht.
(verb_initial_lr,
 synsem:loc:cat:subcat:[nonloc:slash:ne_list]) *> synsem:loc:cont:nucleus:assertion_or_imperative.



verb_initial_lr lex_rule
  Dtr
**>
( verb_initial_lr,
  dtrs:[Dtr])
morphs
  X becomes X.

