% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: oberfeldumstellung.pl,v $
%%  $Revision: 1.5 $
%%      $Date: 2006/02/26 18:08:11 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile rule/2.
:- multifile '--->'/2.

% Diese Regel wird für Oberfeldumstellung benötigt, die im Buch
% nicht besprochen wird. Siehe Müller, 1999.

% Testen mit:   daß er das Buch wird lesen müssen
%               daß er das Buch wird haben lesen müssen


h_cl ## (head_cluster_phrase,
            @head_initial,                                  % nur für Regelausgabe
            synsem:loc:cat:head:initial:minus,
            head_dtr:(HeadDtr,
                      synsem:trace:minus_or_vm),
            non_head_dtrs:[(NonHeadDtr,
                            synsem:loc:cat:head:flip:plus)])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.



dürfen ~~> @modal_flip_verb(dürfen).
können ~~> @modal_flip_verb(können).
müssen ~~> @modal_flip_verb(müssen).
sollen ~~> @modal_flip_verb(sollen).
wollen ~~> @modal_flip_verb(wollen).
