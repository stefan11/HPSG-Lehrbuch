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
  subcat:[] ).

das ---> (word,
  head:(det,
        case:acc),
  subcat:[] ).

der ---> (word,
  head:(det,
        case:nom),
  subcat:[] ).

% wir gedenken der Frau
der ---> (word,
  head:(det,
        case:gen),
  subcat:[] ).

% wir helfen der Frau
der ---> (word,
  head:(det,
        case:dat),
  subcat:[] ).


% dem Mann
dem ---> (word,
  head:(det,
        case:dat),
  subcat:[] ).

% den Mann
den ---> (word,
  head:(det,
        case:acc),
  subcat:[] ).


des ---> (word,
  head:(det,
        case:gen),
  subcat:[] ).

die ---> (word,
  head:(det,
        case:nom),
  subcat:[] ).

die ---> (word,
  head:(det,
        case:acc),
  subcat:[] ).


mann ---> (word,
  head:(noun,
        case:nom),
  subcat:[(head:(det,
                 case:nom),
           subcat:[]) ] ).

mann ---> (word,
  head:(noun,
        case:dat),
  subcat:[(head:(det,
                 case:dat),
           subcat:[]) ] ).

mann ---> (word,
  head:(noun,
        case:acc),
  subcat:[(head:(det,
                 case:acc),
           subcat:[]) ] ).

mannes ---> (word,
  head:(noun,
        case:gen),
  subcat:[(head:(det,
                 case:gen),
           subcat:[]) ] ).

frau ---> (word,
  head:(noun,
        case:nom),
  subcat:[(head:(det,
                 case:nom),
           subcat:[]) ] ).

frau ---> (word,
  head:(noun,
        case:gen),
  subcat:[(head:(det,
                 case:gen),
           subcat:[]) ] ).

frau ---> (word,
  head:(noun,
        case:dat),
  subcat:[(head:(det,
                 case:dat),
           subcat:[]) ] ).

frau ---> (word,
  head:(noun,
        case:acc),
  subcat:[(head:(det,
                 case:acc),
           subcat:[]) ] ).

buch ---> (word,
  head:(noun,
        case:nom),
  subcat:[(head:(det,
                 case:nom),
           subcat:[]) ] ).

buch ---> (word,
  head:(noun,
        case:dat),
  subcat:[(head:(det,
                 case:dat),
           subcat:[]) ] ).

buch ---> (word,
  head:(noun,
        case:acc),
  subcat:[(head:(det,
                 case:acc),
           subcat:[]) ] ).

buches ---> (word,
  head:(noun,
        case:gen),
  subcat:[(head:(det,
                 case:gen),
           subcat:[]) ] ).


er ---> (word,
  head:(noun,
        case:nom),
  subcat:[]).

ihm ---> (word,
  head:(noun,
        case:dat),
  subcat:[]).

schläft ---> (word,
  head:(verb,
             vform:fin),
  subcat:[(head:(noun,
                 case:nom),
           subcat:[]) ] ).

graut ---> (word,
  head:(verb,
             vform:fin),
  subcat:[(head:(noun,
                 case:dat),
           subcat:[]) ] ).

jagt ---> (word,
  head:(verb,
        vform:fin),
  subcat:[ (head:(noun,
                  case:nom),
               subcat:[]),
           (head:(noun,
                  case:acc),
               subcat:[]) ] ).

kennt ---> (word,
  head:(verb,
        vform:fin),
  subcat:[ (head:(noun,
                  case:nom),
            subcat:[]),
           (head:(noun,
                  case:acc),
               subcat:[]) ] ).

gab ---> (word,
  head:(verb,
        vform:fin),
  subcat:[ (head:(noun,
                  case:nom),
               subcat:[]),
           (head:(noun,
                  case:acc),
               subcat:[]),
           (head:(noun,
                  case:dat),
               subcat:[]) ] ).


gibt ---> (word,
  head:(verb,
        vform:fin),
  subcat:[ (head:(noun,
                  case:nom),
               subcat:[]),
           (head:(noun,
                  case:acc),
               subcat:[]),
           (head:(noun,
                  case:dat),
               subcat:[]) ] ).


denkt ---> (word,
  head:(verb,
        vform:fin),
  subcat:[ (head:(noun,
                  case:nom),
               subcat:[]),
           (head:(prep,
                  pform:an_pform,
                  case:acc),
               subcat:[]) ] ).


an ---> (word,
  head:(prep,
        pform:an_pform,
        case:Cas),
  subcat:[(head:(noun,
                 case:Cas),
           subcat:[]) ] ).



