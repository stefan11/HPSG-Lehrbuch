% -*-  coding:utf-8; mode:trale-prolog   -*-

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: theory.pl,v $
%%  $Revision: 1.12 $
%%      $Date: 2007/03/05 11:26:29 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- (environ('TRALE_UNICODE', true);
    format(user_error,"~n~n**ERROR: Please start trale with the option `-u' to enable unicode support, which is needed for this grammar.~n~n~n",[]),
    abort).

% für [incr TSDB()]
grammar_version('Lehrbuchgrammatik Kapitel 4').


% Load phonology and tree output
:- [phonology].

:- [setup].

root_symbol(@root).
decl_symbol(@decl).
que_symbol(@interrog).
imp_symbol(@imp).

% specify signature file
signature(signature).

% macros for the lexicon
:- [le_macros].

% load lexicon
:- [lexicon].

% load phrase structure rules
:- [rules].

% load phrase structure macros
:- [syntax].


% load lexical items and grammar rules for coordination
:- [coordination].

% Nur zum Spielen noch da.
:- ['old-constraints-head-movement'].


% load some constraints that are not linguistically necessary,
% but good for performance/termination
:- [speed].


% load relational constraints for rules
:- [constraints].

% load a test sequence
:- [test_items].


% load a sequence that is executed after the grammar is loaded
:- ['../Gemeinsames/common.pl'].


examples(['  Der Affe, der schläft, kennt das Kind.',
          '  Ein Affe, dessen Kind schläft, lacht.',
          '  Der Affe, von dessen Kind er ein Bild kennt, lacht.',
          '* der, der schläft, Affe',
          '* Der Affe, schläft der, kennt das Kind.']).



