% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: constraints.pl,v $
%%  $Revision: 1.3 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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


% Beschränkung, die alle RELS-Elemente sammelt.
fun collect_rels(+,-).
%collect_rels(Dtrs,Rels)

collect_rels(X,Y) if
  when( (X=(e_list;ne_list);
         Y=(e_list;ne_list)) 
       , undelayed_collect_rels(X,Y)
       ).



% Leere Liste, also keine Relationen
undelayed_collect_rels([],[]) if true.

% Rels1 sind die Relationen der ersten Tochter.
% Dtrs sind die restlichen Töchter.
% Für die Dtrs werden die Relationen in Rels2 zusammengesammelt.
% append verknüpft Rels1 und Rels2 zum Ergebnis Rels.
undelayed_collect_rels([rels:Rels1|Dtrs],Rels) if collect_rels(Dtrs,Rels2),
                                                  append(Rels1,Rels2,Rels).




% Es gibt nur zwei Fälle: eine oder zwei Töchter
%undelayed_collect_rels([rels:Rels],Rels) if true.
%undelayed_collect_rels([rels:Rels1,rels:Rels2],Rels) if append(Rels1,Rels2,Rels).



% Beschränkung, die alle HCONS-Elemente sammelt.
fun collect_hcons(+,-).
%collect_hcons(Dtrs,Hcons)

collect_hcons(X,Y) if
  when( (X=(e_list;ne_list);
         Y=(e_list;ne_list)) 
       , undelayed_collect_hcons(X,Y)
       ).


undelayed_collect_hcons([],[]) if true.
undelayed_collect_hcons([hcons:Hcons1|Dtrs],Hcons) if collect_hcons(Dtrs,Hcons2),
                                                               append(Hcons1,Hcons2,Hcons).




% Es gibt nur zwei Fälle: eine oder zwei Töchter
%undelayed_collect_hcons([hcons:Hcons],Hcons) if true.
%undelayed_collect_hcons([hcons:Hcons1,hcons:Hcons2],Hcons) if append(Hcons1,Hcons2,Hcons).



fun list_with_zero_or_one_element(-).
list_with_zero_or_one_element(X) if
  when( X=(e_list;ne_list)
      , undelayed_list_with_zero_or_one_element(X)
      ).
      
undelayed_list_with_zero_or_one_element([]) if true.
undelayed_list_with_zero_or_one_element([_]) if true.


/*
fun list_with_zero_or_one_element(-).
list_with_zero_or_one_element([]) if true.
list_with_zero_or_one_element([_]) if true.
*/


% Überprüfen, ob das zwei delays braucht. 01.06.2025
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
