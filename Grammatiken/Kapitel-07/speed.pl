% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: speed.pl,v $
%%  $Revision: 1.5 $
%%      $Date: 2005/03/25 10:00:53 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Linguistisch nicht signifikante Hacks
%%             zur Effizienzsteigerung/Terminierung
%%             beim Bottom-Up-Parsen
%%             bzw. bei der Semantic-Head-Driven-Generation
%%   Language: Trale
%%     System: TRALE 2.3.7 under Sicstus 3.9.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- multifile ':='/2.
:- discontiguous ':='/2.
:- multifile '*>'/2.
:- discontiguous '*>'/2.
:- multifile if/2.
:- discontiguous if/2.
:- multifile fun/1.
:- discontiguous fun/1.

:- multifile macro/2.
:- discontiguous macro/2.


% Beschränkung für Elemente in Subcat-Listen
% Die Beschränkung ist eigentlich
% nicht nötig, da das vom Quantor gemacht wird, aber beim Generieren ist
% der Quantor noch nicht verfügbar und so können beliebig viele Adjunkte eingeführt
% werden, weshalb das Generieren nicht terminieren würde.

%(subcat:hd:(cat:head:noun,
%                   cont:qstore:ne_list)) *> (subcat:hd:(cont:(nucleus:Cont,
%                                                                     qstore:hd:restind:Cont))).

%(cat:(head:noun,
%      subcat:[]),
% cont:qstore:ne_list) *> (cont:(nucleus:Cont,
%                                 qstore:hd:restind:Cont)).


% Schlägt wegen `seine Frau' fehl.
% non_head_dtrs:hd:(cat:head:noun,
%                   cont:qstore:ne_list) *> non_head_dtrs:hd:cont:(nucleus:Cont,
%                                                                  qstore:hd:restind:Cont).


% geht nicht wegen "der mutmaßliche Mörder"
% (cat:head:noun,
%  cont:qstore:ne_list)          *> cont:(nucleus:restr:sublist(Restr),
%                                         qstore:hd:restind:restr:Restr).



% das interessante buch seine kluge frau kennt = 1:41 Min
% non_head_dtrs:hd:(cat:head:noun,
%                   cont:qstore:ne_list) *> non_head_dtrs:hd:cont:(% der normale Fall
%                                                                  nucleus:Cont,
%                                                                  qstore:hd:restind:Cont
%                                                                 ;% Possessivpronomina fügen eine `besitzen'-Relation
%                                                                  % in die Menge der Restriktionen ein.
%                                                                  nucleus:restr:Restr,
%                                                                  qstore:hd:restind:restr:tl:Restr
%                                                                  ).


% ist nicht restriktiv genug, da alle Nomina im Lexikon erst mal zur Generierung
% der NP gewählt werden.
% das interessante buch seine kluge frau kennt = 1:00 Min

% Eventuell wird die obige Restriktion bei größeren Lexika besser.

(head_adjunct_phrase,
   cat:head:noun)          *> cont:(nucleus:restr:sublist(Restr),
                                    qstore:hd:restind:restr:Restr).
