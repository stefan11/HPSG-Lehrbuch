% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: rules.pl,v $
%%  $Revision: 1.11 $
%%      $Date: 2007/09/14 20:28:02 $
%%     Author: Stefan Mueller (Stefan.Mueller@fu-berlin.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile rule/2.

% Diese Datei kann ignoriert werden, sie hilft nur dem Parser
% und wird aus technischen Gründen gebraucht.

h_arg rule (head_argument_phrase,
             dtrs:[HeadDtr,NonHeadDtr],
             loc:cat:head:initial:plus,
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.


arg_h rule (head_argument_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             loc:cat:head:initial:minus,
             head_dtr:HeadDtr,
             non_head_dtrs:[(NonHeadDtr,
                             @argument_sign   % speed + Regelberechnung
                            )]
         )
  ===>
cat> NonHeadDtr,
cat> HeadDtr.



h_adj rule (head_adjunct_phrase,
             dtrs:[HeadDtr,NonHeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[(NonHeadDtr,
                             loc:cat:head:pre_modifier:minus)])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.


adj_h rule (head_adjunct_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[(NonHeadDtr,
                             loc:cat:head:pre_modifier:plus)])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.


spr_h rule (head_specifier_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:(HeadDtr,
                       loc:cat:head:noun         % speed + Regelberechnung
                      ),
             non_head_dtrs:[(NonHeadDtr,
                             loc:cat:head:det,   % speed + Regelberechnung
                             trace:minus         % speed: steht eigentlich im Lexikon
                            )])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.


f_h rule (head_filler_phrase,
             dtrs:[NonHeadDtr,HeadDtr],
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.

% Das ist eine unär verzweigende Regel und keine Lexikonregel,
% da sie auch auf koordinierte Verben angewendet werden kann.
v1 rule (verb_initial_rule,
          dtrs:[NonHeadDtr],
          non_head_dtrs:[NonHeadDtr])
  ===>
sem_head>      NonHeadDtr.
