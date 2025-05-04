% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: theory.pl,v $
%%  $Revision: 1.5 $
%%      $Date: 2005/03/27 13:24:08 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% für [incr TSDB()]
grammar_version('Lehrbuchgrammatik Kapitel 3').

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

% load phrase structure rules
:- [rules].

% load phrase structure macros
:- [syntax].

% load constraints on `phonology'
:- [phonology].


% load relational constraints for rules
:- [constraints].

% load a test sequence
:- [test_items].


% load a sequence that is executed after the grammar is loaded
:- ['../Gemeinsames/common.pl'].

examples(['  Der Affe schläft.',
          '  der Affe das Kind kennt',
          '  der Affe an das Kind denkt',
          '* Affe schläft.',
          '* Der Affe kennt.']).



