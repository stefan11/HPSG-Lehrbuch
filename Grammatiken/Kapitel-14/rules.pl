% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: rules.pl,v $
%%  $Revision: 1.8 $
%%      $Date: 2006/02/26 18:08:11 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile rule/2.



% Diese Datei kann ignoriert werden, sie hilft nur dem Parser
% und wird aus technischen Gründen gebraucht.

h_arg rule (head_argument_phrase,
             synsem:loc:cat:head:initial:plus,
             head_dtr:HeadDtr,
             non_head_dtrs:[(NonHeadDtr,
                             % VM-Trace kann nie allein hier stehen, immer ein Argument, oder eingebettetes Verb
                             % wird für mehrfache Vorfeldbesetzung gebraucht, sonst Nichterminierung
                             synsem:trace:extraction_or_minus) 
                           ])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.


arg_h rule (head_argument_phrase,
             synsem:loc:cat:head:initial:minus,
             head_dtr:HeadDtr,
             non_head_dtrs:[(NonHeadDtr,
                             synsem: @argument_synsem   % speed + Regelberechnung
                            )]
         )
  ===>
cat> NonHeadDtr,
cat> HeadDtr.



h_adj rule (head_adjunct_phrase,
             head_dtr:HeadDtr,
             non_head_dtrs:[(NonHeadDtr,
                             synsem:loc:cat:head:pre_modifier:minus)])
  ===>
cat> HeadDtr,
cat> NonHeadDtr.


adj_h rule (head_adjunct_phrase,
             head_dtr:HeadDtr,
             non_head_dtrs:[(NonHeadDtr,
                             synsem:loc:cat:head:pre_modifier:plus)])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.


spr_h rule (head_specifier_phrase,
             head_dtr:(HeadDtr,
                       synsem:loc:cat:head:noun        % speed + Regelberechnung
                      ),
             non_head_dtrs:[(NonHeadDtr,
                             synsem:(loc:cat:head:det,   % speed + Regelberechnung
                                     trace:minus         % speed: steht eigentlich im Lexikon
                                    ))])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.


f_h rule (head_filler_phrase,
            @head_final,                                  % nur für Regelausgabe
             head_dtr:HeadDtr,
             non_head_dtrs:[NonHeadDtr])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.

rc rule (rc,
       non_head_dtrs:[Filler,Clause])
  ===>
cat> Filler,
cat> Clause.



cl_h rule (head_cluster_phrase,
            @head_final,                                  % nur für Regelausgabe
            % In Head-Cluster-Strukturen wird nicht auf den INITIAL-Wert bezug genommen,
            % da auch Nomina wie `Herumgerenne' durch diese Strukturen lizenziert werden.
            % Für die Linearisierung ist nur der FLIP-Wert relevant.
            
            %            synsem:loc:cat:head:initial:minus,
            head_dtr:(HeadDtr,
                      synsem:trace:minus_or_vm),
            non_head_dtrs:[(NonHeadDtr,
                            synsem:loc:cat:head:flip:minus   % zur Oberfeldumstellung siehe Müller99a:14.2
                           )])
  ===>
cat> NonHeadDtr,
cat> HeadDtr.



