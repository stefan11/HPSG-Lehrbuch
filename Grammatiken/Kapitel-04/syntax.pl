% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.3 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- multifile '*>'/2.



%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (head:Head,
    head_dtr:head:Head).

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
