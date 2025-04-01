% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: theory.pl,v $
%%  $Revision: 1.8 $
%%      $Date: 2007/03/05 11:26:28 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- (environ('TRALE_UNICODE', true);
    format(user_error,"~n~n**ERROR: Please start trale with the option `-u' to enable unicode support, which is needed for this grammar.~n~n~n",[]),
    abort).

% für [incr TSDB()]
grammar_version('Lehrbuchgrammatik Kapitel 14').

:- [setup].

root_symbol(@root).
decl_symbol(@decl).
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
%:- [lexrules].

% load phrase structure rules
:- [rules].

% load phrase structure macros
:- [syntax].

% load lexical items and grammar rules for coordination
:- [coordination].

% load some constraints that are not linguistically necessary,
% but good for performance
:- [speed].

% load relational constraints for rules
:- [constraints].

% load a test sequence
:- [test_items].

% load a sequence that is executed after the grammar is loaded
:- ['../Gemeinsames/common.pl'].

%phenomenon('Kapitel 13: Kongruenz').

examples(['  Die Frau liebt den Mann.',
          '  Die Frau liebt der Mann.',
          '  Die Frau liebt das Kind.',
          '* Den Mann liebt den Mann.']).


