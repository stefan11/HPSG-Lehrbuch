% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.8 $
%%      $Date: 2006/02/26 18:08:12 $
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
   (cat:head:Head,
    head_dtr:cat:head:Head).


%% Valenzprinzip

head_argument_phrase *>
   (cat:subcat:Subcat,
    head_dtr:cat:subcat:append(Subcat,[NonHeadDtr]),
    non_head_dtrs:[NonHeadDtr]).

head_non_argument_phrase *>
   (cat:subcat:Subcat,
    head_dtr:cat:subcat:Subcat).

%% Semantikprinzip

head_non_adjunct_phrase *>
   (cont:Cont,
    head_dtr:cont:Cont).

head_adjunct_phrase *>
   (cont:Cont,
    non_head_dtrs:[cont:Cont]).



%% Kopf-Adjunkt-Strukturen


head_adjunct_phrase *>
   (head_dtr:Head,
    non_head_dtrs:[cat:(head:mod:Head,
                        subcat:[])]).


%% Spezifikatorprinzip

(headed_phrase,
 non_head_dtrs:[cat:head:spec:sign]) *>
   (head_dtr:Head,
    non_head_dtrs:[cat:head:spec:Head]).

root :=
 (cat:subcat:[]).

interrog :=
 (@root).

decl :=
 (@root).













