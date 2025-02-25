% -*-  coding:utf-8; mode:trale-prolog   -*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: lexicon.pl,v $
%%  $Revision: 1.9 $
%%      $Date: 2006/02/26 18:08:12 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik für die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.12.0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

das ---> (word,
  cat:(cat,
       head:(det,
             case:nom),
       subcat:[] ),
  cont:def).

das ---> (word,
  cat:(head:(det,
             case:acc),
       subcat:[] ),
  cont:def).

der ---> (word,
  cat:(head:(det,
             case:nom),
       subcat:[] ),
  cont:def).

% wir gedenken der Frau
der ---> (word,
  cat:(head:(det,
             case:gen),
       subcat:[] ),
  cont:def).

% wir helfen der Frau
der ---> (word,
  cat:(head:(det,
             case:dat),
       subcat:[] ),
  cont:def).


% dem Mann
dem ---> (word,
  cat:(head:(det,
             case:dat),
       subcat:[] ),
  cont:def).

% den Mann
den ---> (word,
  cat:(head:(det,
             case:acc),
       subcat:[] ),
  cont:def).


des ---> (word,
  cat:(head:(det,
             case:gen),
       subcat:[] ),
  cont:def).

die ---> (word,
  cat:(head:(det,
             case:nom),
       subcat:[] ),
  cont:def).

die ---> (word,
  cat:(head:(det,
             case:acc),
       subcat:[] ),
  cont:def).


mann ---> (word,
  cat:(head:(noun,
             case:nom),
       subcat:[cat:(head:(det,
                          case:nom),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:mas),
        restr:[(mann,
                arg1:Ind)])).

mann ---> (word,
  cat:(head:(noun,
             case:dat),
       subcat:[cat:(head:(det,
                          case:dat),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:mas),
        restr:[(mann,
                arg1:Ind)])).

mann ---> (word,
  cat:(head:(noun,
             case:acc),
       subcat:[cat:(head:(det,
                          case:acc),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:mas),
        restr:[(mann,
                arg1:Ind)])).

mannes ---> (word,
  cat:(head:(noun,
             case:gen),
       subcat:[cat:(head:(det,
                          case:gen),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:mas),
        restr:[(mann,
                arg1:Ind)])).


frau ---> (word,
  cat:(head:(noun,
             case:gen),
       subcat:[cat:(head:(det,
                          case:gen),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:fem),
        restr:[(frau,
                arg1:Ind)])).

frau ---> (word,
  cat:(head:(noun,
             case:dat),
       subcat:[cat:(head:(det,
                          case:dat),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:fem),
        restr:[(frau,
                arg1:Ind)])).

frau ---> (word,
  cat:(head:(noun,
             case:acc),
       subcat:[cat:(head:(det,
                          case:acc),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:fem),
        restr:[(frau,
                arg1:Ind)])).


buch ---> (word,
  cat:(head:(noun,
             case:nom),
       subcat:[cat:(head:(det,
                          case:nom),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:neu),
        restr:[(buch,
                arg1:Ind)])).

buch ---> (word,
  cat:(head:(noun,
             case:dat),
       subcat:[cat:(head:(det,
                          case:dat),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:neu),
        restr:[(buch,
                arg1:Ind)])).

buch ---> (word,
  cat:(head:(noun,
             case:acc),
       subcat:[cat:(head:(det,
                          case:acc),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:neu),
        restr:[(buch,
                arg1:Ind)])).

buches ---> (word,
  cat:(head:(noun,
             case:gen),
       subcat:[cat:(head:(det,
                          case:gen),
                    subcat:[]) ] ),
  cont:(ind:(Ind,
             per:third,
             num:sg,
             gen:neu),
        restr:[(buch,
                arg1:Ind)])).


er ---> (word,
  cat:(head:(noun,
             case:nom),
       subcat:[]),
  cont:(ind:(per:third,
             num:sg,
             gen:mas),
        restr:[])).

es ---> (word,
  cat:(head:(noun,
             case:acc),
       subcat:[]),
  cont:(ind:(per:third,
             num:sg,
             gen:neu),
        restr:[])).

ihm ---> (word,
  cat:(head:(noun,
             case:dat),
       subcat:[]),
  cont:(ind:(per:third,
             num:sg,
             gen:mas),
        restr:[])).

schläft ---> (word,
  cat:(head:(verb,
             vform:fin),
       subcat:[(cat:(head:(noun,
                           case:nom),
                     subcat:[]),
                cont:ind:Ind) ] ),
  cont:(schlafen,
        arg1:Ind)).

graut ---> (word,
  cat:(head:(verb,
             vform:fin),
       subcat:[(cat:(head:(noun,
                           case:dat),
                     subcat:[]),
                cont:ind:Ind) ] ),
  cont:(grauen,
        arg2:Ind)).

kennt ---> (word,
  cat:(head:(verb,
             vform:fin),
       subcat:[ (cat:(head:(noun,
                            case:nom),
                      subcat:[]),
                    cont:ind:Ind1),
                (cat:(head:(noun,
                            case:acc),
                      subcat:[]),
                    cont:ind:Ind2) ] ),
              cont:(kennen,
                    arg1:Ind1,
                    arg2:Ind2)).

gab ---> (word,
  cat:(head:(verb,
             vform:fin),
       subcat:[ (cat:(head:(noun,
                            case:nom),
                      subcat:[]),
                    cont:ind:Ind1),
                (cat:(head:(noun,
                            case:acc),
                      subcat:[]),
                    cont:ind:Ind2),
                (cat:(head:(noun,
                            case:dat),
                      subcat:[]),
                    cont:ind:Ind3) ] ),
            cont:(geben,
                  arg1:Ind1,
                  arg2:Ind2,
                  arg3:Ind3)).


gibt ---> (word,
  cat:(head:(verb,
             vform:fin),
       subcat:[ (cat:(head:(noun,
                            case:nom),
                      subcat:[]),
                    cont:ind:Ind1),
                (cat:(head:(noun,
                            case:acc),
                      subcat:[]),
                    cont:ind:Ind2),
                (cat:(head:(noun,
                            case:dat),
                      subcat:[]),
                    cont:ind:Ind3) ] ),
             cont:(geben,
                   arg1:Ind1,
                   arg2:Ind2,
                   arg3:Ind3)).

denkt ---> (word,
  cat:(head:(verb,
             vform:fin),
       subcat:[ (cat:(head:(noun,
                            case:nom),
                      subcat:[]),
                 cont:ind:Ind1),
                (cat:(head:(prep,
                            pform:an_pform,
                            case:acc),
                      subcat:[]),
                 cont:ind:Ind2) ] ),
              cont:(denken_an,
                    arg1:Ind1,
                    arg2:Ind2)).


an ---> (word,
  cat:(head:(prep,
             pform:an_pform,
             case:Cas),
       subcat:[(cat:(head:(noun,
                           case:Cas),
                     subcat:[]),
                cont:Cont) ] ),
  cont:Cont).



