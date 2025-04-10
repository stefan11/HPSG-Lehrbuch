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

% load tokenization rules for parsing ordinary strings and atoms
:- ['../Gemeinsames/tokenization'].

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

% load some constraints that are not linguistically necessary,
% but good for performance/termination
:- [speed].


% load relational constraints for rules
:- [constraints].

% load a test sequence
:- [test_items].


% load a sequence that is executed after the grammar is loaded
:- ['../Gemeinsames/common.pl'].


examples(['* der Tofu der Speisekammer in',
          '  dass das Kind dem Affen den Stock gibt',
          '  dass das Kind den Stock dem Affen gibt',
          '  Schläft er?',
          '  Lacht das Kind oft?',
          '  Lacht das Kind oft nicht?',
          '  Lacht das Kind nicht oft?',
          '  Kennt ein Kind den Roman?',
          '  Kennt den Roman ein Kind?',
          '* Aicke schläft schläft.',
          '* Den Roman kennt und schläft er',
          '  Kennt und liebt das Kind den Roman?',
          '  Kennt und liebt den Roman das Kind?',
          '  dass das Kind dem Affen den Stock morgen gibt',
          '  dass das Kind dem Affen morgen den Stock gibt',
          '  dass das Kind morgen dem Affen den Stock gibt',
          '  dass morgen das Kind dem Affen den Stock gibt',
          '  Mann der',
          '  der Speisekammer in',
          '  das Kind kluge',
          '* die in der Speisekammer Wurst',
          '* dass Aicke den Stock gibt ihm',
          '* dass das Kind den Roman']).



