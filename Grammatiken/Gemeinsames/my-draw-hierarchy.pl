% -*-trale-prolog-*-
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%   $RCSfile: le_macros.pl,v $
%%  $Revision: 1.12 $
%%      $Date: 2005/06/16 12:39:53 $
%%     Author: Stefan Mueller (Stefan.Mueller@cl.uni-bremen.de)
%%    Purpose: Eine kleine Spielzeuggrammatik fÃ¼r die Lehre
%%   Language: Trale
%      System: TRALE 2.7.5 (release ) under Sicstus 3.10.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% taken from graphviz.pl


% Diese Datei enthÃ¤lt Code aus dem Trale-System. Die Parameter
% sind so gesetzt, daß man eine Typhierarchie auf mehrere A4-Blätter
% ausgeben kann.

% Dazu muß man im Prolog-Modus diese Datei laden.
% ^C^B reicht im Emacs, wenn der Emacs-Prolog-Modus aktiviert ist.

draw_hierarchy_act(Type,Result,ShowApprops,Filename) :-	
	(Result == [] ->
	    format(user_output,'**Error: Type "~w" has no subtypes.~n',[Type])
	;
	    tmpnam(Filename),
	    format_to_chars('~w.dot',[Filename],DotFilenameS),
	    atom_codes(DotFilename,DotFilenameS),

	    tell(DotFilename),
	    format('digraph ~w {~n',[Type]),

            % vertical space between nodes in inches:
%	    format('ranksep="0.8 equally";~n',[]),             % viewing on the screen
            format('ranksep="4.6 equally";~n',[]),             % printing `bot'

%             format('ranksep="1.6 equally";~n',[]),             % printing `word' in Grammar 13

%            format('ranksep="1.6 equally";~n',[]), % printing `sign' in Grammar 16
            
            % horizontal space between nodes in inches:
	    format('nodesep="0.2 equally";~n',[]), 

	    % justification of labels (relevant if it has more lines)
	    format('labeljust="l";~n',[]),

            % set fontpath
%	    format('fontpath="/usr/share/fonts/default/TrueType/";~n',[]),

	    % font name and size to use
%	    format('node [fontname="helr____"];~n',[]),

	    % nodes are just text and there's no padding around them
	    format('node [height=0,width=0,shape=plaintext];~n',[]),


            %Ggf. will man das ganze auch noch landscapen, das geht mit

	    format('rotate=90;~n',[]),




            
	    % here we can compress it to a certain size
% Letter	    format('ratio="compress";~nsize="8.5,11";~n',[]),

% A4 Landscape 
%	    format('ratio="compress";~nsize="11,8.5";~n',[]),

% A3 Landscape
%	    format('ratio="compress";~nsize="22,17";~n',[]),


% Im Verhältnis 56.05, 43.31
% Der Drucker kann aber 15m lang drucken
%            format('ratio="compress";~nsize="80,43.31";~n',[]),
            
%            Um stattdessen einzustellen, wo er das Bild in Seiten bricht:

%	       format('page="8.2,11.6";~n',[]),
%	       format('margin="0.2";~n',[]),

            
	    % or one can just specify a certain size, without changing the ratio
%	    format('size="13,10";~n',[]),
            
            % or one can set size in inches at which to cut into pages, and margins
	    format('page="8.5,11"~numargin="0.1,0.1"~n',[]),

            % cut without margins
%      	    format('page="8.5,11"~n',[]), 

	    % no arrows at end of edges:
	    format('edge [arrowhead="none"];~n',[]), 

	    draw_hierarchy([Type-Result],_,ShowApprops),

	    format('~N}~n',[]),
	    told
        ).


% This predicate has to be defined by the user.
% for instance the following hides all types that
% have the prefix 'glb'
hide_in_type_hierarchy(Type) :-
         atom_codes(Type,[103,108,98|_]).