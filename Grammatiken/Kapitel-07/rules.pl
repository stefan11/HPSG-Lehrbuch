% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: rules.pl,v $
%%  $Revision: 1.4 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Diese Datei kann ignoriert werden, sie hilft nur dem Parser
% und wird aus technischen Gründen gebraucht.

h_arg rule (head_argument_phrase,
             dtrs:[HeadDtr,NonHeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
sem_head> HeadDtr,
cat>      NonHeadDtr.

arg_h rule (head_argument_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat>      NonHeadDtr,
sem_head> HeadDtr.



h_adj rule (head_adjunct_phrase,
             dtrs:[HeadDtr,NonHeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat>      HeadDtr,
sem_head> NonHeadDtr.

adj_h rule (head_adjunct_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
sem_head> NonHeadDtr,
cat> HeadDtr.

