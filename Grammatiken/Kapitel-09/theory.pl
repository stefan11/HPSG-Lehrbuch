% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: theory.pl,v $
%%  $Revision: 1.11 $
%%      $Date: 2007/03/05 11:26:29 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile if/2.

:- (environ('TRALE_UNICODE', true);
    format(user_error,"~n~n**ERROR: Please start trale with the option `-u' to enable unicode support, which is needed for this grammar.~n~n~n",[]),
    abort).

% generate code for generation
%:- ale_flag(pscompiling,_,parse_and_gen).


% für [incr TSDB()]
grammar_version('Lehrbuchgrammatik Kapitel 9').

:- [setup].

root_symbol(@root).
decl_symbol(@root).
que_symbol(@interrog).

% load tokenization rules for parsing ordinary strings and atoms
:- ['../Gemeinsames/tokenization'].


% specify signature file
signature(signature).

% load lexicon
:- [lexicon].


% load lexical macros
:- [le_macros].


% load lexical rules
% Verbbewegungsregel wird ab 2013 durch eine Grammatikregel gemacht
%:- [lexrules].

% load phrase structure rules
:- [rules].

% load phrase structure macros
:- [syntax].

% load lexical items and grammar rules for coordination
:- [coordination].

% load some constraints that are not linguistically necessary,
% but good for performance/termination
:- [speed].


% load relational constraints for rules
:- [constraints].

% load a test sequence
:- [test_items].


% load a sequence that is executed after the grammar is loaded
:- ['../Gemeinsames/common.pl'].


% für Generierung
semantics sem1.
sem1(loc:cont:Cont,Cont) if true.

gen_pathes([[loc,cat],[loc,cont]]).

%:- chain_length(4).

examples(['daß der Mann der Frau das Buch gibt',
          'daß der Mann das Buch der Frau gibt',
          'Schläft er?',
          'Lacht der Mann oft?',
          '* Mann der',
          '* der Speisekammer in',
          '* der Mann kluge',
          '* die in der Speisekammer Wurst',
          '* daß er das Buch gibt ihm']).


