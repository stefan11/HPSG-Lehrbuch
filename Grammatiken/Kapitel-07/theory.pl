% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: theory.pl,v $
%%  $Revision: 1.10 $
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


% Generator
%:- ale_flag(pscompiling,_,parse_and_gen).

% für [incr TSDB()]
grammar_version('Lehrbuchgrammatik Kapitel 7').

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

% load phrase structure rules
:- [rules].

% load phrase structure macros
:- [syntax].


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
sem1(cont:Cont,Cont) if true.

gen_pathes([[cat],[cont]]).


examples(['  das interessante Buch',
          '  der mutmaßliche Mörder',
          '  seine Frau',
          '  die Wurst in der Speisekammer',
          '* die Wurst in']).


