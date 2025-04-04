% -*-  coding:utf-8; mode:trale-prolog   -*-


% feature hiding and ordering
hidden_feat(dtrs).          % hide the dtrs attribute (shown by tree)
hidden_feat(head_dtr).      % hide the dtrs attribute (shown by tree)
hidden_feat(non_head_dtrs). % hide the dtrs attribute (shown by tree)


>>> phon.        % phon shall be shown first
phon  <<< p_o_s.
p_o_s <<< spr.
spr   <<< comps.
comps <<< arg_st.

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
