% feature hiding and ordering
hidden_feat(dtrs).      % hide the dtrs attribute (shown by tree)

% Die sind in den Bäumen enthalten, deshalb werden sie hier ausgeblendet.
hidden_feat(non_head_dtrs).
hidden_feat(head_dtr).


% Binäres Merkmal, das aus Effizenzgründen verwendet wird.
% Sieht nicht gut aus in Demos ... =;-)
hidden_feat(trace).
hidden_feat(phrase).    % V1 ist eine unäre Projektion, keine Lexikonregel
                        % Koordinationen von Wörtern dürfen Töchter sein, echte Phrasen nicht.
                        % Da das Merkmal im Buch nicht eingeführt wurde, wird es nciht angezeigt.


>>> phon.        % phon shall be shown first
phon <<< synsem.
synsem <<< qstore.
qstore <<< head_dtr.

head <<< subcat.

loc <<< nonloc.
nonloc <<< lex.
%<<<(lex, max_).

% use ghostview for drawing signatures
% für Linux
% graphviz_option(ps,gv).
% für Mac
graphviz_option(svg,'batik-squiggle').

% Load phonology and tree output

:- [phonology].

:- trale_milca_version('2.7.12') -> true; ['../Gemeinsames/new-trale.pl'].

:- chart_display.

:- nochart_debug.  % this helps if somebody interrupted during chart debugging and the
                   % flag is still set to 'on'.

:- german.

:- notcl_warnings.  % on = output of warnings in a TCL window, off = output to console

%:- hrp.  % use grisu for rules

%:- nofs. % do not print feature structures after parsing
