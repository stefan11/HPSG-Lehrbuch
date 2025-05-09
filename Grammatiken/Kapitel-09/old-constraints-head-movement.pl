% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexrules.pl,v $
%%  $Revision: 1.4 $
%%      $Date: 2005/03/03 15:11:24 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile '*>'/2.
:- discontiguous '*>'/2.


% * Er schläft schläft.
%
(headed_phrase,
 head_dtr:(word,
           phon:ne_list)) *> head_dtr:loc:cat:head:dsl:none.

% Leider gibt es noch ein weiteres Problem in Sätzen mit Koordination, denn in
% Der Affe nimmt den Stock und lacht.
% gibt es eine Lesart, in der "den Stock _" mit "und lacht" koordiniert wird.
% Das passiert, weil in "und lacht" die Konjunktion der Kopf ist.
%
% Das Problem ist, dass bei "Kennt und liebt das Kind das Buch?" genau die beiden Verbletztverben
% koordiniert werden und die V1-Regel auf das Ergebnis angewendet wird.

% Die folgende Implikation würde das ausschließen:
/*
(headed_phrase,
 dtrs:[loc:cat:head:coord,
       (word,
        phon:ne_list)]) *> dtrs:tl:hd:loc:cat:head:dsl:none.
*/

% Man braucht also leider die folgende sehr komplexe Implikation. St. Mü. 03.05.2025

% [ Zeug [ Coord Verb ]] Wenn Zeug phrasal ist (Verbspur + irgendwas), dann ist es keine
% V1-Koordination und wir können verlangen, dass die DSL-Information des rechten Konjunkts none ist.

(coord_phrase,
 loc:cat:head:dsl:local,
 dtrs:[phrase:plus, dtrs:[loc:cat:head:coord,
                          (word,
                           phon:ne_list)]]) *> dtrs:tl:hd:dtrs:tl:hd:loc:cat:head:dsl:none.

% [Verb [Coord Zeug ]]
% Der Affe nimmt lacht und den Stock.
(coord_phrase,
 loc:cat:head:dsl:local,
 dtrs:[(word,
        phon:ne_list), dtrs:[loc:cat:head:coord,
                             phrase:plus]]) *> dtrs:hd:loc:cat:head:dsl:none.

% Leider geht immer noch:
% Der Affe schläft schläft und lacht.

% Eigentlich will man: Wenn irgendwas mit Verben mit DSL koordiniert wurde, kann es nur noch in die V1-Regel.
% Auch key würde nicht helfen, weil man immer noch:
%
% Der Affe [schläft und lacht] [schläft und lacht].
%
% machen könnte.
