

% code taken from ale.pl and made a little bit more verbose.
%
% St. Mü. 23.05.2005

:- abolish(chained/6).




% ------------------------------------------------------------------------------
% chained(+PivotTag:<tag>, +PivotSVs:<svs>, +RootTag:<tag>,
%         +RootSVs:<svs>, +IqsIn:<ineq>s, -IqsOut:<ineq>s)
% ------------------------------------------------------------------------------
% checks whether PivotTag-PivotSVs and RootTag-RootSVs can be connected through
% a chain of grammar rules
% ------------------------------------------------------------------------------
chained(_,_,PivotTag,PivotSVs,RootTag,RootSVs) if_b    % keep this clause
  [ud(PivotTag,PivotSVs,RootTag,RootSVs)].    % first after multi-hashing
chained(N,Max,PivotTag,PivotSVs,RootTag,RootSVs) if_b [N<Max|PGoals] :-
  current_predicate(rule,(_ rule _)),
  empty_assoc(VarsIn),
  empty_assoc(NVs),
  (_Rule rule Mother ===> Body),
  split_dtrs(Body,HeadIn,_,_,_,_),
  compile_desc(HeadIn,PivotTag,PivotSVs,PGoals,PGoalsPivot,true,VarsIn,
               VarsMid,FSPal,[],FSsMid,NVs),
  compile_desc(Mother,NewPTag,bot,PGoalsPivot,
               [SN is N + 1,
                chained(SN,Max,NewPTag,bot,RootTag,RootSVs)],
               true,VarsMid,_,FSPal,FSsMid,FSsOut,NVs),
  FSsOut = [].