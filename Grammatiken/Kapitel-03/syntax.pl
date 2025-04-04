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

head_complement_phrase *>
   (p_o_s:POS,
    mod:Mod,
    spr:Spr,
    comps:Comps,
    head_dtr:(p_o_s:POS,
              mod:Mod,
              spr:Spr,
              comps:append(Comps,[NonHeadDtr])),
    non_head_dtrs:[NonHeadDtr]).

head_specifier_phrase *>
   (p_o_s:POS,
    mod:Mod,
    spr:Spr,
    comps:Comps,
    head_dtr:(p_o_s:POS,
              mod:Mod,
              spr:[NonHeadDtr|Spr],
              comps:(Comps,[])),
    non_head_dtrs:[NonHeadDtr]).

head_adjunct_phrase *>
   (mod:
    spr:Spr,
    comps:Comps,
    head_dtr:(HD,
              spr:Spr,
              comps:Comps),
    non_head_dtrs:[(mod:HD,
                    spr:[],
                    comps:[])]).



root :=
 (spr:[],
  comps:[]).

interrog :=
 (@root).

decl :=
 (@root).
