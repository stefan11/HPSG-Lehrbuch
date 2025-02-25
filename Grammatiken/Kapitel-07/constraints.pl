% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: constraints.pl,v $
%%  $Revision: 1.6 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- multifile if/2.
:- discontiguous if/2.

:- multifile fun/1.
:- discontiguous fun/1.


% *****************************
%   list manipulation utilities
% *****************************



% append(+,+,-)
% This append assumes that the first or the third argument
% are known to be non_empty or empty lists. 
%

fun append(+,+,-).
append(X,Y,Z) if 
   when( (X=(e_list;ne_list);
          Z=(e_list;ne_list)) 
       , undelayed_append(X,Y,Z)
       ).

undelayed_append([],L,L) if true.
undelayed_append([H|T1],L,[H|T2]) if append(T1,L,T2).




% Beschränkung, die alle QStore-Elemente sammelt.
fun collectQStores(+,-).
%collectQStores(Subcat,Stores)

collectQStores(X,Y) if
  when( (X=(e_list;ne_list);
         Y=(e_list;ne_list)) 
       , undelayed_collectQStores(X,Y)
       ).

undelayed_collectQStores([],[]) if true.
undelayed_collectQStores([cont:qstore:QStore1],QStore1) if true.
undelayed_collectQStores([cont:qstore:QStore1,cont:qstore:QStore2],append(QStore1,QStore2)) if true.
undelayed_collectQStores([cont:qstore:QStore1,cont:qstore:QStore2,cont:qstore:QStore3],
                         append(QStore1,append(QStore2,QStore3))) if true.






fun sublist(-,+).
sublist(X,Y) if 
  when( (X=(e_list;ne_list),
         Y=(e_list;ne_list)) 
       , undelayed_sublist(X,Y)
       ).

undelayed_sublist([],_) if true.
undelayed_sublist([El|Rest1],[El|Rest2]) if
  sublist(Rest1,Rest2).
undelayed_sublist(List,[_El|Rest2]) if
  sublist(List,Rest2).