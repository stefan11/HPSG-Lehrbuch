% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.2 $
%%      $Date: 2005/03/10 10:58:31 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile '*>'/2.

head_argument_phrase *>
   (subcat:Subcat,
    head_dtr:subcat:append(Subcat,[NonHeadDtr]),
    non_head_dtrs:[NonHeadDtr]).











root macro
 (subcat:[]).

interrog macro
 (@root).

decl macro
 (@root).
