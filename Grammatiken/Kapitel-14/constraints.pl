% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: constraints.pl,v $
%%  $Revision: 1.5 $
%%      $Date: 2006/02/26 18:08:11 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



:- multifile if/2.
:- discontiguous if/2.

:- multifile fun/1.
:- discontiguous fun/1.

:- multifile macro/2.


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


fun del(+,+,-).
del(X,Y,Z) if 
   when( (Y=(e_list;ne_list);
          Z=(e_list;ne_list)) 
       , undelayed_del(X,Y,Z)
       ).

undelayed_del(El,[El|L],L) if true.
undelayed_del(El,[H|T1],[H|T2]) if del(El,T1,T2).



% Beschränkung, die alle QStore-Elemente sammelt.
fun collectQStores(+,-).
%collectQStores(Subcat,Stores)

collectQStores(X,Y) if
  when( (X=(e_list;ne_list);
         Y=(e_list;ne_list)) 
       , undelayed_collectQStores(X,Y)
       ).

% undelayed_collectQStores([],[]) if true.
% undelayed_collectQStores([loc:cont:qstore:QStore1],QStore1) if true.
% undelayed_collectQStores([loc:cont:qstore:QStore1,loc:cont:qstore:QStore2],append(QStore1,QStore2)) if true.
% undelayed_collectQStores([loc:cont:qstore:QStore1,loc:cont:qstore:QStore2,loc:cont:qstore:QStore3],
%                          append(QStore1,append(QStore2,QStore3))) if true.



undelayed_collectQStores([],[]) if true.
undelayed_collectQStores([loc:cont:qstore:QStore|T1],Result) if
   collectQStores(T1,T2),
   append(QStore,T2,Result).



/*

This version is not correct since it fires for [X|_] and returns X.

fun last(+,-).
last(X,L) if
  when( X=(e_list;ne_list)
      , undelayed_last(X,L)
      ).

undelayed_last([L],L) if true.
undelayed_last(tl:T1,L) if last(T1,L).

*/


fun last(+,-).
last(X,L) if
  when( X=(e_list;ne_list)
      , last2(X,L)
      ).

last2([H|T],L) if
  when( T=(e_list;ne_list)
      , undelayed_last([H|T],L)
      ).

undelayed_last([L],L)   if true.
undelayed_last(tl:T1,L) if last(T1,L).



fun collect_qs(+,-).
collect_qs(X,Y) if 
   when( X=(e_list;ne_list) 
       , undelayed_collect_qs(X,Y)
       ).
undelayed_collect_qs([],[]) if true.
undelayed_collect_qs([(qstore:Sem)|Dtrs],SemRes) if collect_qs(Dtrs,Sems),
                                                    append(Sem,Sems,SemRes).


fun list_with_zero_or_one_element(-).
list_with_zero_or_one_element(X) if
  when( X=(e_list;ne_list)
      , undelayed_list_with_zero_or_one_element(X)
      ).
      
undelayed_list_with_zero_or_one_element([]) if true.
undelayed_list_with_zero_or_one_element([_]) if true.




% Hey, Negation!

%% Type negation - delay until type T and then die.
not(Type) macro not_type(a_ Type).
fun not_type(+,-).
( not_type((a_ Type),FS) if
      when(FS=Type,
           prolog(fail)) ) :-
        type(Type).

