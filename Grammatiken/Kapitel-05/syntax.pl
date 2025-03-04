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
       

% for headed structures the head daughter is appended to the non-head daughters to give a list of all daughters.
% This daughters list can be used to collect RELS, HCONS and so on.
%headed_phrase *>
%   head_dtr:HD,
%   non_head_dtrs:NHDtrs,
%   dtrs:[HD|NHDtrs].

phrase *>
  (cont:rels:append(Rels1,Rels2),
   dtrs:[cont:rels:Rels1,cont:rels:Rels2]).

phrase *>
  (cont:hcons:append(HCons1,HCons2),
   dtrs:[cont:hcons:HCons1,cont:hcons:HCons2]).

headed_phrase *>
   (cont:(ind:Ind,
          gtop:GTop),
    head_dtr:cont:(ind:Ind,
                   gtop:GTop),
    non_head_dtrs:[cont:gtop:GTop]).

head_complement_phrase *>
   (cont:ltop:LTop,
    head_dtr:cont:ltop:LTop).

head_specifier_phrase *>
   (cont:ltop:LTop,
    head_dtr:cont:ltop:LTop).

head_adjunct_phrase *>
   (cont:ltop:LTop,
    non_head_dtrs:[cont:ltop:LTop]).

% Wegen „ein scheinbar schwieriges Beispiel“ kann sich „schwieriges“ nicht im Lexikon den LTop-Wert
% von „Beispiel“ nehmen, denn der LTop-Wert von „Beispiel“ muss mit dem von „scheinbar schwieriges“ gleichgesetzt werden.
(head_adjunct_phrase,
 non_head_dtrs:[head:scopal:minus]) *>
 (head_dtr:cont:ltop:LTop,
  non_head_dtrs:[cont:ltop:LTop]).

(headed_phrase,
 non_head_dtrs:[head:spec:sign]) *>
 (head_dtr:Spec,
  non_head_dtrs:[head:spec:Spec]).


% root macro
%  (spr:[],
%   comps:[],
%   cont:(gtop:GTop,
%         ltop:GTop)).

root macro
 (spr:[],
  comps:[]).


interrog macro
 (@root).

decl macro
 (@root).

