% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: signature,v $
%%  $Revision: 1.5 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bot sub [none_or_sign, head, list, case, pform, vform ].

none_or_sign sub [none, sign].

sign sub [phrase, word]
     intro [phon:list, head:head, spr:list, comps:list].

phrase sub [headed_phrase, non_headed_phrase]
       intro [non_head_dtrs:list, dtrs:list].

headed_phrase sub [head_non_specifier_phrase, head_non_complement_phrase]
              intro [head_dtr:sign].

head_non_specifier_phrase sub [head_complement_phrase, head_adjunct_phrase].
head_non_complement_phrase sub [head_specifier_phrase, head_adjunct_phrase].

head sub [intro_case_head, non_modifier, adj]
     intro [mod:none_or_sign ].

intro_case_head sub [attr_adj, det, noun, prep]
                intro [case:case].

attr_adj sub [].
det sub [].
noun sub [].
prep sub []
     intro [pform:pform].

non_modifier sub [det, noun, prep, verb]
             intro [mod:none].
verb sub []
     intro [vform:vform].

adj sub [attr_adj].

list sub [e_list,ne_list].
  e_list sub [].
  ne_list sub []
          intro [hd:bot,
                 tl:list].

case sub [nom, gen, dat, acc].

pform sub [an_pform].

an_pform sub [].

vform sub [fin].

fin sub [].

