% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.14 $
%%      $Date: 2007/09/14 20:28:02 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile '*>'/2.
:- discontiguous '*>'/2.

%% Das Kopfmerkmalsprinzip

headed_phrase *>
   (loc:cat:head:Head,
    head_dtr:loc:cat:head:Head).


%% Valenzprinzip

head_argument_phrase *>
   (loc:cat:subcat:append(Subcat1,Subcat2),                       % = Subcat1 + Subcat2
    head_dtr:loc:cat:subcat:append(Subcat1,[NonHeadDtr|Subcat2]), % = Subcat1 + [NonHeadDtr] + Subcat2
    non_head_dtrs:[NonHeadDtr]).

head_non_argument_phrase *>
   (loc:cat:subcat:Subcat,
    head_dtr:loc:cat:subcat:Subcat).


%% Semantikprinzip

head_non_adjunct_phrase *>
   (loc:cont:Cont,
    head_dtr:loc:cont:Cont).

head_adjunct_phrase *>
   (loc:cont:Cont,
    non_head_dtrs:[loc:cont:Cont]).


%% Kopf-Adjunkt-Strukturen


head_adjunct_phrase *>
   (head_dtr:Head,
    non_head_dtrs:[loc:cat:(head:mod:Head,
                            spr:[],
                            subcat:[])]).


%% Spezifikatorprinzip

(headed_phrase,
 non_head_dtrs:[loc:cat:head:spec:sign]) *>
   (head_dtr:Head,
    non_head_dtrs:[loc:cat:head:spec:Head]).


head_specifier_phrase *> 
   (loc:cat:spr:[],
    head_dtr:loc:cat:(spr:[Spr],
                      subcat:[]),
    non_head_dtrs:[Spr]).

head_non_specifier_phrase *> 
   (loc:cat:spr:Spr,
    head_dtr:loc:cat:spr:Spr).


% die Verbbewegungsanalyse

% Das ist eine unär verzweigende Regel und keine Lexikonregel,
% da sie auch auf koordinierte Verben angewendet werden kann.
% Siehe auch coordination.pl.
verb_initial_rule *>
( %complementizer_like_sign
  loc:cat:(head:(verb,
                 vform:fin),
           subcat:[loc:cat:head:dsl:Loc]),
  non_head_dtrs:[(loc:(Loc,
                       cat:head:(verb,
                                 vform:fin,
                                 initial:minus)),
                  trace:minus,
                  % nur koordinierte Wörter dürfen zu V1-Verben umkategorisiert werden.
                  phrase:minus)]).


% * Er schläft schläft.
%
(headed_phrase,
 head_dtr:(word,
           phon:ne_list)) *> head_dtr:loc:cat:head:dsl:none.


headed_phrase *> phrase:plus.

% Da coord_phrase nicht Untertyp von headed_phrase ist,
% ist der PHRASE-Wert unterspezifiziert.

% [Ihn kennt und schläft] er.
% Ist dennoch ausgeschlossen, da die obige Implikation
% dafür sorgt, daß der DSL-Wert von `ihn kennt' none ist.
% Damit hat die Konjunktion auch den DSL-Wert none und kann
% dann nicht mehr Tochter der V1-Regel sein.


root :=
 (loc:cat:(head:dsl:none,
           spr:[],
           subcat:[])).

initial_fin_verb :=
 (@root,
  loc:cat:head:(verb,
                initial:plus,
                vform:fin)).


interrog :=
 @initial_fin_verb.

decl :=
 @initial_fin_verb.
