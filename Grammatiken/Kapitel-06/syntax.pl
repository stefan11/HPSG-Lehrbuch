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

:- multifile ':='/2.
:- discontiguous ':='/2.

%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (cat:head:Head,
    head_dtr:cat:head:Head).

%% Das Valenzprinzip

head_complement_phrase *>
   (cat:comps:Comps,
    head_dtr:cat:comps:append(Comps,[NonHeadDtr]),
    non_head_dtrs:[NonHeadDtr]).

head_specifier_phrase *>
   (cat:spr:Spr,
    head_dtr:cat:(spr:[NonHeadDtr|Spr],
                  comps:[]),
    non_head_dtrs:[NonHeadDtr]).

head_non_complement_phrase *>
   (cat:comps:Comps,
    head_dtr:cat:comps:Comps).

head_non_specifier_phrase *>
   (cat:spr:Spr,
    head_dtr:cat:spr:Spr).


head_adjunct_phrase *>
   (head_dtr:HD,
    non_head_dtrs:[cat:(head:mod:HD,
                        spr:[],
                        comps:[])]).
       

% for headed structures the head daughter is appended to the non-head daughters to give a list of all daughters.
% This daughters list can be used to collect RELS, HCONS and so on.
% See rules.pl. The dtrs are ordered according to surface order in rules.pl.

%headed_phrase *>
%   head_dtr:HD,
%   non_head_dtrs:NHDtrs,
%   dtrs:[HD|NHDtrs].


% Argumentrealisierungsprinzip
word *> cat:(spr:Spr,
             comps:Comps,
             arg_st:append(Spr,Comps)).



% Semantik

phrase *>
  (cont:rels:append(Rels1,Rels2),
   dtrs:[cont:rels:Rels1,cont:rels:Rels2]).

phrase *>
  (cont:hcons:append(HCons1,HCons2),
   dtrs:[cont:hcons:HCons1,cont:hcons:HCons2]).

/* GTop wird nciht wirklich gebraucht. 
headed_phrase *>
   (cont:(ind:Ind,
          gtop:GTop),
    head_dtr:cont:(ind:Ind,
                   gtop:GTop),
    non_head_dtrs:[cont:gtop:GTop]).
*/

headed_phrase *>
   (cont:ind:Ind,
    head_dtr:cont:ind:Ind).

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
 non_head_dtrs:[cat:head:scopal:minus]) *>
 (head_dtr:cont:ltop:LTop,
  non_head_dtrs:[cont:ltop:LTop]).

(headed_phrase,
 non_head_dtrs:[cat:head:spec:sign]) *>
 (head_dtr:Spec,
  non_head_dtrs:[cat:head:spec:Spec]).

% root :=
%  (spr:[],
%   comps:[],
%   cont:(gtop:GTop,
%         ltop:GTop)).

root :=
 (cat:(spr:[],
       comps:[])).


interrog :=
 (@root).

decl :=
 (@root).

