% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: common.pl,v $
%%  $Revision: 1.13 $
%%      $Date: 2007/03/05 11:26:28 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

compile_grammar_hook :-
         inform_user_about_top_level,
         print_examples.
         

% Interferes with TSDB stuff

%          % If we are at the Prolog top level, ...
%          ( trale_mode(prolog) ->
%              go

%          ;   true
%          ).



t :- testt(all).


% Wie in ale.pl, aber mit Statistik-Ausgaben.

%:- abolish(compile_gram/1).

% compile_gram(File) :-
%   abolish_preds,
%   reconsult(File),
%   statistics(walltime,_),       % rücksetzen des Timers
%   compile_gram,
%   statistics(walltime,[_,T]),
%   msec2time(T,Time),
%   number_of(lex(_,_),NumberOfWords),
%   format(user_error,"~nGrammatik geladen: ~w~n~w Lexikoneinheiten~n~n",[Time,NumberOfWords]),
%   %r, % diese Zeile auskommentieren, falls die Stämme zum Debuggen im Lexikon bleiben sollen
%   number_of(lex(_,_),NumberOfRemainingWords),
%   format(user_error,"~w verbleibende Lexikoneinheiten~n~n",[NumberOfRemainingWords]).



% :- [trale_home('tsdb/retract_lex_desc')].


% % Dieses Prädikat entfernt die Stämme aus dem Lexikon.
% % In der syntaktischen Analyse braucht man die Stämme nicht,
% % die Grammatikregeln sind ohnehin so formuliert, daß Stämme
% % nicht als Töchter vorkommen können. Stämme für Nomina (Frau, Mann, Haus)
% % und Adjektive (klug, interessant) würden aber beim Parsen in die Parse-Tabelle
% % eingetragen und bei jedem Parse-Schritt wieder überprüft. Diese Arbeit kann
% % man sich sparen, wenn man die Stämme nach der Lexikonberechnung löscht.
% r :-    format(user_error,"Lösche Stammeinträge ...~n",[]),
%         open_null_stream(DevNull),
%         prolog_flag(user_error,UserError,DevNull),
%         retract_lex_desc(stem),
%         prolog_flag(user_error,_,UserError).




% :- abolish(morph/3).

% % Das ist eine Kopie des Codes aus ale.pl
% % + einer Zeile zur Ausgabe des aktuell erzeugten Wortes.
% % Das ist zum Debuggen und wegen der langen Lexikonkompilierungszeit sinnvoll.

% morph(Morphs,WordIn,WordOut):-  % need to instantiate Word even if
%   name(WordIn,CodesIn),         %  X becomes X - do we want this?
%   make_char_list(CodesIn,CharsIn), 
%   morph_chars(Morphs,CharsIn,CharsOut),
%   make_char_list(CodesOut,CharsOut),
%   name(WordOut,CodesOut),
%   format(user_error,"~w~n",[WordOut]),
% %  write(user_error,'.'),flush_output(user_error),
%   true.



