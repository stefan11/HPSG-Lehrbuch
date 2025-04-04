% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: rules.pl,v $
%%  $Revision: 1.1 $
%%      $Date: 2005/04/23 13:26:20 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Diese Datei kann ignoriert werden, sie hilft nur dem Parser
% und wird aus technischen Gründen gebraucht.

h_comp rule (head_complement_phrase,
             dtrs:[HeadDtr,NonHeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.

comp_h rule (head_complement_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.


spr_h rule (head_specifier_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.

adj_h rule (head_adjunct_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.

adj_h rule (head_adjunct_phrase,
             dtrs:[HeadDtr,NonHeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.
