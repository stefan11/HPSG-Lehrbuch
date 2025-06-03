% -*- coding:utf-8; trale-prolog -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: oberfeldumstellung.pl,v $
%%  $Revision: 1.5 $
%%      $Date: 2006/02/26 18:08:11 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile rule/2.
:- multifile '--->'/2.

% Diese Regel wird für Oberfeldumstellung benötigt, die im Buch
% nicht besprochen wird. Siehe Müller, 1999.

% Testen mit:   dass er das Buch wird lesen müssen
%               dass er das Buch wird haben lesen müssen


h_cl rule (head_cluster_phrase,
           non_head_dtrs:hd:synsem:loc:cat:head:flip:plus,
           dtrs:[HeadDtr,NonHeadDtr])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.


% dass er das Lied hat singen dürfen
dürfen ---> @modal_flip_verb(dürfen_rel).
können ---> @modal_flip_verb(können_rel).
müssen ---> @modal_flip_verb(müssen_rel).
sollen ---> @modal_flip_verb(sollen_rel).
wollen ---> @modal_flip_verb(wollen_rel).
