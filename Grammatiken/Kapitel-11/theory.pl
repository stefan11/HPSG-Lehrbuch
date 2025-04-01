% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: theory.pl,v $
%%  $Revision: 1.7 $
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
grammar_version('Lehrbuchgrammatik Kapitel 12').

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


examples(['  Der Mann, der lacht, liebt die Frau.',
          '  die Speisekammer, in der er lacht',
          '* der Mann, lacht der, liebt die Frau.',
          '* die Speisekammer, er in der lacht']).





% nur für die Entwicklung von Trale.
make :- ensure_loaded([trale_home(grammar_interface),
                       trale_home('tsdb/itsdb'),
                       trale_home('chart_display/chart_display'),
                       trale_home('chart_display/sic'),
                       trale_home('chart_display/ale_redefinitions'),
                       trale_home('chart_display/print_mrs'),
                  trale_home('tsdb/retract_lex_desc')    % retraction of stems
                  ,trale_home('tsdb/itsdb-err')              % capi-registration write-filed ...
                 ,trale_home('tsdb/trale-itsdb')
                      ,trale_home('debug_unify'),
                       trale_home('toplevel')
                 ]),
         chart_display,
         nofs,
         german,
         notcl_warnings,
         hrp.
