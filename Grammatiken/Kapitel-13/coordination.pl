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

:- multifile '--->'/2.
:- multifile ':='/2.
:- multifile rule/2.

% Koordination von verbalen Projektionen

und ---> (simple_word,
          synsem:(loc:(cat:(head:(coord,
                                  spec:(loc:(cat:Cat,
                                             cont:(qstore:Q1,
                                                   nucleus:Nuc1)),
                                        nonloc:(rel:Rel,
                                                slash:Slash))),
                            subcat:[(loc:(cat:Cat,
                                          cont:(qstore:Q2,
                                                nucleus:Nuc2)),
                                     nonloc:(rel:Rel,
                                             slash:Slash),
                                     trace:minus)]),
                       cont:(qstore:append(Q1,Q2),
                             nucleus:(und,
                                      arg1:Nuc1,
                                      arg2:Nuc2))),
                  nonloc:(rel:Rel,
                          slash:Slash))).



coord_phrase :=
  (coord_phrase,
   non_head_dtrs:[(phon:ne_list,
                   synsem:trace:minus),
                  synsem:trace:minus]).

x_conj_y_coord_phrase :=
  (@coord_phrase,
   synsem:(loc:(cat:Cat,
                cont:Cont),
           nonloc:(rel:Rel,
                   slash:Slash)),
   non_head_dtrs:[(synsem:(Spec,
                           loc:cat:Cat,
                           nonloc:(rel:Rel,
                                   slash:Slash))),
                  (synsem:loc:(cat:(head:(coord,
                                          spec:Spec),
                                    subcat:[]),
                               cont:Cont))]).

x_conj_y rule (@x_conj_y_coord_phrase,
                  dtrs:Dtrs,
                  non_head_dtrs:(Dtrs,
                                 [Dtr1,Dtr2]))
  ===>
cat> Dtr1,
cat> Dtr2.
