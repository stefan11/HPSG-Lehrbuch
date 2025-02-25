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
  subcat:[] ).


der ---> (word,
  p_o_s:det,
  subcat:[] ).


% dem Mann
dem ---> (word,
  p_o_s:det,
  subcat:[] ).

% den Mann
den ---> (word,
  p_o_s:det,
  subcat:[] ).


des ---> (word,
  p_o_s:det,
  subcat:[] ).

die ---> (word,
  p_o_s:det,
  subcat:[] ).



mann ---> (word,
  p_o_s:noun,
  subcat:[(p_o_s:det,
           subcat:[]) ] ).


mannes ---> (word,
  p_o_s:noun,
  subcat:[(p_o_s:det,
           subcat:[]) ] ).

frau ---> (word,
  p_o_s:noun,
  subcat:[(p_o_s:det,
           subcat:[]) ] ).


buch ---> (word,
  p_o_s:noun,
  subcat:[(p_o_s:det,
           subcat:[]) ] ).

buches ---> (word,
  p_o_s:noun,
  subcat:[(p_o_s:det,
           subcat:[]) ] ).


er ---> (word,
  p_o_s:noun,
  subcat:[]).

ihm ---> (word,
  p_o_s:noun,
  subcat:[]).

schläft ---> (word,
  p_o_s:verb,
  subcat:[(p_o_s:noun,
           subcat:[]) ] ).

graut ---> (word,
  p_o_s:verb,
  subcat:[(p_o_s:noun,
           subcat:[]) ] ).

jagt ---> (word,
  p_o_s:verb,
  subcat:[ (p_o_s:noun,
            subcat:[]),
           (p_o_s:noun,
            subcat:[]) ] ).

kennt ---> (word,
  p_o_s:verb,
  subcat:[ (p_o_s:noun,
            subcat:[]),
           (p_o_s:noun,
            subcat:[]) ] ).

gab ---> (word,
  p_o_s:verb,
  subcat:[ (p_o_s:noun,
               subcat:[]),
           (p_o_s:noun,
               subcat:[]),
           (p_o_s:noun,
               subcat:[]) ] ).


gibt ---> (word,
  p_o_s:verb,
  subcat:[ (p_o_s:noun,
               subcat:[]),
           (p_o_s:noun,
               subcat:[]),
           (p_o_s:noun,
               subcat:[]) ] ).


denkt ---> (word,
  p_o_s:verb,
  subcat:[ (p_o_s:noun,
               subcat:[]),
           (p_o_s:prep,
               subcat:[]) ] ).


an ---> (word,
  p_o_s:prep,
  subcat:[(p_o_s:noun,
           subcat:[]) ] ).



