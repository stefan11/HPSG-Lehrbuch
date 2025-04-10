% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: constraints.pl,v $
%%  $Revision: 1.5 $
%%      $Date: 2006/02/26 18:08:11 $
%%     Author: Stefan Mueller (Stefan.Mueller@fu-berlin.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


:- multifile '*>'/2.
:- multifile if/2.


% Hier werden einfach die PHON-Werte von Lexikoneinträgen festgelegt und bei Phrasen von den
% Töchtern aufgesammelt.


phonology
forall Word ---> FS do
 FS = phon:[(a_ Word)].

phrase_or_lexical_rule *>
          (phon:P,
           dtrs:Dtrs) goal collect_phonologies(Dtrs,P).



collect_phonologies(Dtrs,PhonL) if 
   when( (Dtrs=(e_list;ne_list);
          PhonL=(e_list;ne_list)) 
       , undelayed_collect_phonologies(Dtrs,PhonL)
       ).

undelayed_collect_phonologies([],[]) if true.
undelayed_collect_phonologies([phon:Phon|T1],PhonL) if collect_phonologies(T1,PhonRestL),append(Phon,PhonRestL,PhonL).
