% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexrules.pl,v $
%%  $Revision: 1.14 $
%%      $Date: 2007/03/05 11:26:28 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile '*>'/2.
:- discontiguous '*>'/2.




% Die semantisch richtige Version, die einen Interrogativoperator
% für V1-Sätze und einen Assertationsoperator für V2-Sätze einführt.

verb_initial_lr *>
( %word
  loc:cat:(head:(verb,
                 vform:fin),
           subcat:[loc:cat:head:dsl:Loc]),
  nonloc:Nonloc,
  trace:Trace,
  dtrs:[( word,
          loc:(Loc,
               cat:head:(verb,
                         vform:fin,
                         initial:minus)),
          nonloc:Nonloc,
          trace:Trace)]).


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
 loc:cat:subcat:[nonloc:slash:[]])      *> loc:cont:nucleus:imperative_or_interrogative.

% Hier spielt das Element in SLASH eine entscheidende Rolle.
% Ist es eine Interrogativphrase, muß ein entsprechender Operator angenommen
% werden. Da die vorliegende Grammatik keine Interrogativpronomina enthält,
% wird die Fallunterscheidung nicht gemacht.
(verb_initial_lr,
 loc:cat:subcat:[nonloc:slash:ne_list]) *> loc:cont:nucleus:assertion_or_imperative.

verb_initial_lr lex_rule
  Dtr
**>
( verb_initial_lr,
  dtrs:[Dtr])
morphs
  X becomes X.





