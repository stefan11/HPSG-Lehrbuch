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

%% Das Valenzprinzip

head_complement_phrase *>
   (comps:Comps,
    head_dtr:comps:append(Comps,[NonHeadDtr]),
    non_head_dtr:NonHeadDtr).

head_specifier_phrase *>
   (spr:Spr,
    head_dtr:(spr:[NonHeadDtr|Spr],
              comps:[]),
    non_head_dtr:NonHeadDtr).

head_non_complement_phrase *>
   (comps:Comps,
    head_dtr:comps:Comps).

head_non_specifier_phrase *>
   (spr:Spr,
    head_dtr:spr:Spr).



head_adjunct_phrase *>
   (head_dtr:HD,
    non_head_dtr:(head:mod:HD,
                  spr:[],
                  comps:[])).

% Argumentrealisierungsprinzip
word *> (spr:Spr,
         comps:Comps,
         arg_st:append(Spr,Comps)).

% Wenn ein Wort mit der Wortart noun mindestens ein Element in der ARG-ST-Liste hat,
% muss die SPR-Liste ein Element ethalten.
(word,
 head:noun,
 arg_st:hd:sign) *> spr:[sign]. 

% Die SPR-Liste von (finiten) Verben ist leer.
(word,
 head:verb) *> spr:[]. 

% Die von Adjektiven auch.
(word,
 head:adj) *> spr:[]. 




root macro
 (spr:[],
  comps:[]).

interrog macro
 (@root).

decl macro
 (@root).
