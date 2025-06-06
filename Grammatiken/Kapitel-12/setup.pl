% -*-trale-prolog-*-

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)


% Binäres Merkmal, das aus Effizenzgründen verwendet wird.
% Sieht nicht gut aus in Demos ... =;-)
hidden_feat(trace).
hidden_feat(phrase).    % V1 ist eine unäre Projektion, keine Lexikonregel
                        % Koordinationen von Wörtern dürfen Töchter sein, echte Phrasen nicht.
                        % Da das Merkmal im Buch nicht eingeführt wurde, wird es nciht angezeigt.

hidden_feat(max_).


>>> phon.        % phon shall be shown first
>>> lbl.

head   <<< spr.
spr    <<< comps.
comps  <<< arg_st.

%gtop <<< ltop.
ltop <<< ind.

arg0 <<< rstr.
rstr <<< body.

loc <<< nonloc.

synsem <<< rels.
rels   <<< hcons.
hcons  <<< dtrs.

arg0   <<< lindex.
lindex <<< rindex.
rindex <<< lhandle.
lhandle <<< rhandle.

% load tokenization rules for parsing ordinary strings and atoms
:- ['../Gemeinsames/tokenization'].


% use ghostview for drawing signatures
% für Linux
%graphviz_option(ps,gv).


% für Mac
%graphviz_option(svg,'batik-squiggle').

% Install gapplin, so that it is the default app.
%graphviz_option(svg,'sleep 0.1; open').

% just use built-in preview for SVG
% graphviz_option(svg,'qlmanage -p').

% install SVGViewer from Appstore and use
graphviz_option(svg,'sleep 0.1; open').


:- trale_milca_version('2.7.12') -> true; ['../Gemeinsames/new-trale.pl'].


:- chart_display.

:- nochart_debug.  % this helps if somebody interrupted during chart debugging and the
                   % flag is still set to 'on'.

:- german.

:- notcl_warnings.  % on = output of warnings in a TCL window, off = output to console


%:- nofs. % do not print feature structures after parsing

% display MRSes after each parse in the interactive mode.
:- mrs.

% send MRSes to utool for display
:- display_mrs.

% send MRSes to utool for scoping
:- scope_mrs.


ind_path([synsem,loc,cont,ind]).
% Just use h1 and add a qeq to the local top. This does not have any effect in Utool.
% gtop_path(implicit).

% Just print h1 and do not do anything else.
gtop_path(none).

ltop_path([synsem,loc,cont,ltop]).

cont_path([synsem,loc,cont]).
liszt_path([rels]).
hcons_path([hcons]).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).

