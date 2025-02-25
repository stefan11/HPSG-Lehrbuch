% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: syntax.pl,v $
%%  $Revision: 1.7 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile     '*>'/2.
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


phrase *>
   (qstore:collect_qs(Dtrs),
    dtrs:Dtrs).



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


root macro
 (cat:subcat:[]).

interrog macro
 (@root).

decl macro
 (@root).




%% Das folgende sollte in der Signatur sein, geht aber wegen
%% der Homomorphismus-Bedingung nicht. Diese erzeugt nur eine
%% Warnung beim Laden, und das Parsen funktioniert auch, aber
%% der Generator stürzt ab.

det       *> mod:none.
noun      *> mod:none.
comp_prep *> mod:none.
verb      *> mod:none.














