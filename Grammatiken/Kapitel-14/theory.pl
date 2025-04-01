% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: theory.pl,v $
%%  $Revision: 1.14 $
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
grammar_version('Lehrbuchgrammatik Kapitel 15').


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
:- [lexrules].

% load lexical rule for multiple frontings
:- ['mehrfache-vorfeldbesetzung'].

% load phrase structure rules
:- [rules].

% load phrase structure rules for Oberfeldumstellung
%:- [oberfeldumstellung].

% load phrase structure macros
:- [syntax].

% load some constraints that are not linguistically necessary,
% but good for performance
:- [speed].

% load relational constraints for rules
:- [constraints].

% load a test sequence
:- [test_items].

% load a sequence that is executed after the grammar is loaded
:- ['../Gemeinsames/common.pl'].


examples(['  daß er lachen muß',
          '  Lachen muß er.',
          '  Dem Kind erzählen muß er die Geschichte.',
          '  Eine Geschichte erzählen muß er dem Kind.']).


% Beispiele für Vorträge
demo :-
        parse_print_all([kennt,er,ihn],@interrog),
        parse_print_all([den,mann,kennt,er],@decl),
        parse_print_all([daß,er,ihn,lesen,wird],@root),
        parse_print_all([daß,ihn,der,mann,lesen,wird],@root),
        parse_print_all([das,buch,lesen,wird,er,nicht],@decl),
        parse_print_all([lesen,wird,er,nicht,das,buch],@decl),
        parse_print_all([der,frau,das,buch,gibt,er,nicht],@decl),
        parse_print_all([der,frau,den,aufsatz,will,er,geben],@decl).

            