% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.4 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile '*>'/2.


%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (cat:head:Head,
    head_dtr:cat:head:Head).


%% Valenzabbindung

head_argument_phrase *>
   (cat:subcat:Subcat,
    head_dtr:cat:subcat:append(Subcat,[NonHeadDtr]),
    non_head_dtrs:[NonHeadDtr]).


%% Semantikprinzip (vorläufig)

head_non_adjunct_phrase *>
   (cont:Cont,
    head_dtr:cont:Cont).




root macro
 (cat:subcat:[]).

interrog macro
 (@root).

decl macro
 (@root).
