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
  spr:[],
  comps:[] ).

das ---> (word,
  head:(det,
        case:acc),
  spr:[],
  comps:[] ).

der ---> (word,
  head:(det,
        case:nom),
  spr:[],
  comps:[] ).

% wir gedenken der Frau
der ---> (word,
  head:(det,
        case:gen),
  spr:[],
  comps:[] ).

% wir helfen der Frau
der ---> (word,
  head:(det,
        case:dat),
  spr:[],
  comps:[] ).


% dem Mann
dem ---> (word,
  head:(det,
        case:dat),
  spr:[],
  comps:[] ).

% den Mann
den ---> (word,
  head:(det,
        case:acc),
  spr:[],
  comps:[] ).


des ---> (word,
  head:(det,
        case:gen),
  spr:[],
  comps:[] ).

die ---> (word,
  head:(det,
        case:nom),
  spr:[],
  comps:[] ).

die ---> (word,
  head:(det,
        case:acc),
  spr:[],
  comps:[] ).

kleine ---> (word,
  head:(adj,
        case:nom,
        mod:(head:noun,
             spr:[_],
             comps:[])),
  spr:[],
  comps:[]).


affe ---> (word,
  head:(noun,
        case:nom),
  spr:[(head:(det,
              case:nom),
        spr:[],
        comps:[])],
  comps:[ ] ).

affen ---> (word,
  head:(noun,
        case:dat),
  spr:[(head:(det,
                 case:dat),
           comps:[])],
  comps:[ ] ).

affe ---> (word,
  head:(noun,
        case:acc),
  spr:[(head:(det,
                 case:acc),
          spr:[],
          comps:[])],
  comps:[ ] ).

affens ---> (word,
  head:(noun,
        case:gen),
  spr:[(head:(det,
                 case:gen),
          spr:[],
          comps:[])],
  comps:[ ] ).

mann ---> (word,
  head:(noun,
        case:nom),
  spr:[(head:(det,
              case:nom),
        spr:[],
        comps:[])],
  comps:[ ] ).

mann ---> (word,
  head:(noun,
        case:dat),
  spr:[(head:(det,
                 case:dat),
           comps:[])],
  comps:[ ] ).

mann ---> (word,
  head:(noun,
        case:acc),
  spr:[(head:(det,
                 case:acc),
          spr:[],
          comps:[])],
  comps:[ ] ).

mannes ---> (word,
  head:(noun,
        case:gen),
  spr:[(head:(det,
                 case:gen),
          spr:[],
          comps:[])],
  comps:[ ] ).


kind ---> (word,
  head:(noun,
        case:nom),
  spr:[(head:(det,
                 case:nom),
           comps:[])],
  comps:[ ] ).

kindes ---> (word,
  head:(noun,
        case:gen),
  spr:[(head:(det,
                 case:gen),
          spr:[],
          comps:[])],
  comps:[ ] ).

kind ---> (word,
  head:(noun,
        case:dat),
  spr:[(head:(det,
                case:dat),
          spr:[],
          comps:[])],
  comps:[ ] ).

kind ---> (word,
  head:(noun,
        case:acc),
  spr:[(head:(det,
                 case:acc),
          spr:[],
          comps:[])],
  comps:[ ] ).

buch ---> (word,
  head:(noun,
        case:nom),
  spr:[(head:(det,
                 case:nom),
          spr:[],
          comps:[])],
  comps:[ ] ).

buch ---> (word,
  head:(noun,
        case:dat),
  spr:[(head:(det,
                 case:dat),
          spr:[],
          comps:[])],
  comps:[ ] ).

buch ---> (word,
  head:(noun,
        case:acc),
  spr:[(head:(det,
                 case:acc),
          spr:[],
          comps:[])],
  comps:[ ] ).

buches ---> (word,
  head:(noun,
        case:gen),
  spr:[(head:(det,
                 case:gen),
          spr:[],
          comps:[])],
  comps:[ ] ).

tochter ---> (word,
  head:(noun,
        case:nom),
  spr:[(head:(det,
              case:nom),
        spr:[],
        comps:[])],
  comps:[(head:(noun,
                case:gen),
          spr:[],
          comps:[]) ] ).

tochter ---> (word,
  head:(noun,
        case:gen),
  spr:[(head:(det,
              case:gen),
        spr:[],
        comps:[])],
  comps:[(head:(noun,
                case:gen),
          spr:[],
          comps:[]) ] ).

tochter ---> (word,
  head:(noun,
        case:dat),
  spr:[(head:(det,
              case:dat),
        spr:[],
        comps:[])],
  comps:[(head:(noun,
                case:gen),
          spr:[],
          comps:[]) ] ).

tochter ---> (word,
  head:(noun,
        case:acc),
  spr:[(head:(det,
              case:acc),
        spr:[],
        comps:[])],
  comps:[(head:(noun,
                case:gen),
          spr:[],
          comps:[]) ] ).


er ---> (word,
  head:(noun,
        case:nom),
  spr:[],
  comps:[]).

ihm ---> (word,
  head:(noun,
        case:dat),
  spr:[],
  comps:[]).

schläft ---> (word,
  head:(verb,
        vform:fin),
  spr:[],
  comps:[(head:(noun,
                case:nom),
          spr:[],
          comps:[]) ] ).

graut ---> (word,
  head:(verb,
        vform:fin),
  spr:[],
  comps:[(head:(noun,
                 case:dat),
          spr:[],
          comps:[]) ] ).

jagt ---> (word,
  head:(verb,
        vform:fin),
  spr:[],
  comps:[ (head:(noun,
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
  spr:[],
  comps:[ (head:(noun,
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
  spr:[],
  comps:[ (head:(noun,
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
  spr:[],
  comps:[ (head:(noun,
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
  spr:[],
  comps:[ (head:(noun,
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



