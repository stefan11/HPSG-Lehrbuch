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

% Diese Datei wird nicht mehr geladen, da die Verbbewegung in der Syntax gemacht wird.

verb_initial_lr *>
( %complementizer_like_word
  loc:cat:(head:(verb,
                 vform:fin),
           subcat:[loc:cat:head:dsl:Loc]),
  dtrs:[(word,
         loc:(Loc,
              cat:head:(verb,
                        vform:fin,
                        initial:minus)))]).


verb_initial_lr lex_rule
  Dtr
**>
( verb_initial_lr,
  dtrs:[Dtr])
morphs
  X becomes X.
