

% So if there is a general type A that introduces two features and the values of these features
% are different on all of its subtypes, then inequations are added to A.

% According to Gerald working with this on, type inference is NP complete.
% Makes the system slower at compile time and run time.

% Strangely enough this affects sentences with coordination. With subtype covering on
% Persian "Ali telefon kard va fout kard." does not parse, with off it does.

% The same for Danish: Bjarne spørger hvem der kommer og synger.


:- ale_flag(subtypecover,_,off).


% Gerald Penn, 03.06.2012
%
% ALE never had support for "unfilling", at least in one reading of that term,
% until now.
%   But now it does.  We're not going to call it unfilling ,however, because
% that term has been so molested that it's going to confuse everyone.  We'll
% call it "sparse output."
%   To turn this on, use ale_flag(sparseoutput,_,on).

:- ale_flag(sparseoutput,_,on).


% newly defined in chart-display code
% chart_display :-
%         ale_flag(chart_display,_,on).

% nochart_display :-
%         ale_flag(chart_display,_,off).


% This tries to eliminate as many inconsistent rules which otherwise would result from EFD closure computation.
:-ale_flag(ruleindexscope,_,localresolve).

% Do not ask any questions!
:-ale_flag(another,_,0).

% this shows a warning if a unification in macro expansion did not succeed
% may be useful for debugging
:- ale_flag(adderrs,_,on).


% this shows the input of lexical rules as daughters
:- ale_flag(lrtrees,_,on).