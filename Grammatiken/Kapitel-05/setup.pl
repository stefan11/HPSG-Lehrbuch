% -*-trale-prolog-*-

% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)


>>> phon.        % phon shall be shown first
>>> lbl.

head   <<< spr.
spr    <<< comps.
comps  <<< arg_st.
comps  <<< head_dtr.
head_dtr <<< non_head_dtrs.
non_head_dtrs <<< dtrs.

%gtop <<< ltop.
ltop <<< ind.
ind  <<< rels.
rels <<< hcons.

arg0 <<< rstr.
rstr <<< body.

% use ghostview for drawing signatures
% für Linux
% graphviz_option(ps,gv).
% für Mac
graphviz_option(svg,'batik-squiggle').

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


ind_path([cont,ind]).
gtop_path([cont,gtop]).
cont_path([cont]).
liszt_path([cont,rels]).
hcons_path([cont,hcons]).

outscoped_feat(larg).
sc_arg_feat(harg).
scopable_description([@decl,@interrog,@ass_or_imp]).

quantifiers([udef_q,def_q,some_q,demonstrative_q,proper_q]).
