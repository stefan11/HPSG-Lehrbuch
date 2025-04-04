% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexicon.pl,v $
%%  $Revision: 1.7 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

das ---> (word,
  head:(det,
        case:nom),
  arg_st:[]).

das ---> (word,
  head:(det,
        case:acc),
  arg_st:[] ).

der ---> (word,
  head:(det,
        case:nom),
  arg_st:[] ).

% wir gedenken der Frau
der ---> (word,
  head:(det,
        case:gen),
  arg_st:[] ).

% wir helfen der Frau
der ---> (word,
  head:(det,
        case:dat),
  arg_st:[] ).


% dem Mann
dem ---> (word,
  head:(det,
        case:dat),
  arg_st:[] ).

% den Mann
den ---> (word,
  head:(det,
        case:acc),
  arg_st:[] ).


des ---> (word,
  head:(det,
        case:gen),
  arg_st:[] ).

die ---> (word,
  head:(det,
        case:nom),
  arg_st:[] ).

die ---> (word,
  head:(det,
        case:acc),
  arg_st:[] ).

kleine ---> (word,
  head:(adj,
        case:nom,
        mod:(head:noun,
             spr:[_],
             comps:[])),
  arg_st:[]).

in ---> (word,
  head:(prep,
        mod:(head:noun,
             spr:[_],
             comps:[])),
  spr:[],
  arg_st:[(head:(noun,
                 case:dat),
           spr:[],
           comps:[])]).

affe ---> (word,
  head:(noun,
        case:nom),
  arg_st:[(head:(det,
                 case:nom),
           spr:[],
           comps:[])]).

affen ---> (word,
  head:(noun,
        case:dat),
  arg_st:[(head:(det,
                 case:dat),
           spr:[],
           comps:[])]).

affe ---> (word,
  head:(noun,
        case:acc),
  arg_st:[(head:(det,
                 case:acc),
           spr:[],
           comps:[])]).

affens ---> (word,
  head:(noun,
        case:gen),
  arg_st:[(head:(det,
                 case:gen),
           spr:[],
           comps:[])]).

mann ---> (word,
  head:(noun,
        case:nom),
  arg_st:[(head:(det,
                 case:nom),
           spr:[],
           comps:[])]).

mann ---> (word,
  head:(noun,
        case:dat),
  arg_st:[(head:(det,
                 case:dat),
           spr:[],
           comps:[])]).

mann ---> (word,
  head:(noun,
        case:acc),
  arg_st:[(head:(det,
                 case:acc),
           spr:[],
           comps:[])]).

mannes ---> (word,
  head:(noun,
        case:gen),
  arg_st:[(head:(det,
                 case:gen),
           spr:[],
           comps:[])]).

kind ---> (word,
  head:(noun,
        case:nom),
  arg_st:[(head:(det,
                 case:nom),
           spr:[],
           comps:[])]).

kindes ---> (word,
  head:(noun,
        case:gen),
  arg_st:[(head:(det,
                 case:gen),
          spr:[],
          comps:[])]).

kind ---> (word,
  head:(noun,
        case:dat),
  arg_st:[(head:(det,
                 case:dat),
           spr:[],
           comps:[])]).

kind ---> (word,
  head:(noun,
        case:acc),
  arg_st:[(head:(det,
                 case:acc),
          spr:[],
          comps:[])]).

buch ---> (word,
  head:(noun,
        case:nom),
  arg_st:[(head:(det,
                 case:nom),
           spr:[],
           comps:[])]).

buch ---> (word,
  head:(noun,
        case:dat),
  arg_st:[(head:(det,
                 case:dat),
          spr:[],
          comps:[])]).

buch ---> (word,
  head:(noun,
        case:acc),
  arg_st:[(head:(det,
                 case:acc),
          spr:[],
          comps:[])]).

buches ---> (word,
  head:(noun,
        case:gen),
  arg_st:[(head:(det,
                 case:gen),
          spr:[],
          comps:[])]).

tochter ---> (word,
  head:(noun,
        case:nom),
  arg_st:[(head:(det,
                 case:nom),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:gen),
           spr:[],
           comps:[]) ] ).

tochter ---> (word,
  head:(noun,
        case:gen),
  arg_st:[(head:(det,
              case:gen),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:gen),
           spr:[],
           comps:[]) ] ).

tochter ---> (word,
  head:(noun,
        case:dat),
  arg_st:[(head:(det,
              case:dat),
        spr:[],
        comps:[]),
       (head:(noun,
              case:gen),
        spr:[],
        comps:[]) ] ).

tochter ---> (word,
  head:(noun,
        case:acc),
  arg_st:[(head:(det,
              case:acc),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:gen),
           spr:[],
           comps:[]) ] ).

tofu ---> (word,
  head:(noun,
        case:nom),
  arg_st:[(head:(det,
                 case:nom),
           spr:[],
           comps:[])]).


speisekammer ---> (word,
  head:(noun,
        case:dat),
  arg_st:[(head:(det,
              case:dat),
           spr:[],
           comps:[])]).


er ---> (word,
  head:(noun,
        case:nom),
  arg_st:[]).

ihm ---> (word,
  head:(noun,
        case:dat),
  arg_st:[]).

schläft ---> (word,
  head:(verb,
        vform:fin),
  arg_st:[(head:(noun,
                case:nom),
           spr:[],
           comps:[]) ] ).

stinkt ---> (word,
  head:(verb,
        vform:fin),
  arg_st:[(head:(noun,
                 case:nom),
           spr:[],
           comps:[]) ] ).

graut ---> (word,
  head:(verb,
        vform:fin),
  arg_st:[(head:(noun,
                 case:dat),
          spr:[],
          comps:[]) ] ).

jagt ---> (word,
  head:(verb,
        vform:fin),
  arg_st:[ (head:(noun,
                 case:nom),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:acc),
           spr:[],
           comps:[]) ] ).

kennt ---> (word,
  head:(verb,
        vform:fin),
  arg_st:[ (head:(noun,
                 case:nom),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:acc),
           spr:[],
           comps:[]) ] ).

gab ---> (word,
  head:(verb,
        vform:fin),
  arg_st:[ (head:(noun,
                 case:nom),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:acc),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:dat),
           spr:[],
           comps:[]) ] ).


gibt ---> (word,
  head:(verb,
        vform:fin),
  arg_st:[ (head:(noun,
                 case:nom),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:acc),
           spr:[],
           comps:[]),
          (head:(noun,
                 case:dat),
           spr:[],
           comps:[]) ] ).


denkt ---> (word,
  head:(verb,
        vform:fin),
  arg_st:[ (head:(noun,
                 case:nom),
           spr:[],
           comps:[]),
          (head:(prep,
                 pform:an_pform,
                 case:acc),
           spr:[],
           comps:[]) ] ).


an ---> (word,
  head:(prep,
        pform:an_pform,
        case:Cas),
  spr:[],
  comps:[(head:(noun,
                case:Cas),
          spr:[],
          comps:[]) ] ).



