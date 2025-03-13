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

head_complement_phrase *>
   (comps:Subcat,
    head_dtr:comps:append(Subcat,[NonHeadDtr]),
    non_head_dtrs:[NonHeadDtr]).


head_specifier_phrase *>
   (spr:Spr,
    head_dtr:(spr:[NonHeadDtr|Spr],
              comps:[]),
    non_head_dtrs:[NonHeadDtr]).

head_non_complement_phrase *>
   (comps:Comps,
    head_dtr:comps:Comps).

head_non_specifier_phrase *>
   (spr:Spr,
    head_dtr:spr:Spr).

head_adjunct_phrase *>
   (head_dtr:HD,
    non_head_dtrs:[head:mod:HD]).



root macro
 (spr:[],
  comps:[]).

interrog macro
 (@root).

decl macro
 (@root).
