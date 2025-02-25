% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexicon.pl,v $
%%  $Revision: 1.7 $
%%      $Date: 2005/03/03 15:11:24 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


das ---> (word,
  p_o_s:det,
  spr:[],
  comps:[] ).


der ---> (word,
  p_o_s:det,
  spr:[],
  comps:[] ).


% dem Mann
dem ---> (word,
  p_o_s:det,
  spr:[],
  comps:[] ).

% den Mann
den ---> (word,
  p_o_s:det,
  spr:[],
  comps:[] ).


des ---> (word,
  p_o_s:det,
  spr:[],
  comps:[] ).

die ---> (word,
  p_o_s:det,
  spr:[],
  comps:[] ).



mann ---> (word,
  p_o_s:noun,
  spr:[(p_o_s:det,
          spr:[],
          comps:[])],
  comps:[] ).


mannes ---> (word,
  p_o_s:noun,
  spr:[(p_o_s:det,
        spr:[],
        comps:[])],
  comps:[ ] ).

frau ---> (word,
  p_o_s:noun,
  spr:[(p_o_s:det,
        spr:[],
        comps:[])],
  comps:[ ] ).

tochter ---> (word,
  p_o_s:noun,
  spr:[(p_o_s:det,
        spr:[],
        comps:[])],
  comps:[(p_o_s:noun,
          spr:[],
          comps:[]) ] ).



buch ---> (word,
  p_o_s:noun,
  spr:[(p_o_s:det,
        spr:[],
        comps:[])],
  comps:[ ] ).

buches ---> (word,
  p_o_s:noun,
  spr:[(p_o_s:det,
        spr:[],
        comps:[])],
  comps:[ ] ).


er ---> (word,
  p_o_s:noun,
  spr:[],
  comps:[]).

ihm ---> (word,
  p_o_s:noun,
  spr:[],
  comps:[]).

aicke ---> (word,
  p_o_s:noun,
  spr:[],
  comps:[]).

conny ---> (word,
  p_o_s:noun,
  spr:[],
  comps:[]).


schläft ---> (word,
  p_o_s:verb,
  spr:[],
  comps:[(p_o_s:noun,
          spr:[],
          comps:[]) ] ).

graut ---> (word,
  p_o_s:verb,
  spr:[],
  comps:[(p_o_s:noun,
          spr:[],
          comps:[]) ] ).

jagt ---> (word,
  p_o_s:verb,
  spr:[],
  comps:[ (p_o_s:noun,
           spr:[],
           comps:[]),
           (p_o_s:noun,
            spr:[],
            comps:[]) ] ).

kennt ---> (word,
  p_o_s:verb,
  spr:[],
  comps:[ (p_o_s:noun,
           spr:[],
           comps:[]),
           (p_o_s:noun,
            spr:[],
            comps:[]) ] ).

gab ---> (word,
  p_o_s:verb,
  spr:[],
  comps:[ (p_o_s:noun,
           spr:[],
           comps:[]),
           (p_o_s:noun,
            spr:[],
            comps:[]),
           (p_o_s:noun,
            spr:[],
            comps:[]) ] ).


gibt ---> (word,
  p_o_s:verb,
  spr:[],
  comps:[ (p_o_s:noun,
           spr:[],
           comps:[]),
           (p_o_s:noun,
            spr:[],
            comps:[]),
           (p_o_s:noun,
            spr:[],
            comps:[]) ] ).


denkt ---> (word,
  p_o_s:verb,
  spr:[],
  comps:[ (p_o_s:noun,
           spr:[],
           comps:[]),
           (p_o_s:prep,
            spr:[],
            comps:[]) ] ).


an ---> (word,
  p_o_s:prep,
  spr:[],
  comps:[(p_o_s:noun,
          spr:[],
          comps:[]) ] ).



