STYLE-PATH= ${HOME}/Library/texmf/tex/latex/
LANGSCI-PATH=~/Documents/Dienstlich/Projekte/LangSci/Git-HUB/latex/


# texlive 2025
# mit vorberechneten Bäumen aus memoize: time lualatex main.tex
# MacBook Pro 16" 2023 M2 Max 39.759u 27.837s 1:07.63 99.9%	0+0k 0+0io 24pf+0w
#                             40.512u 28.475s 1:09.01 99.9%	0+0k 0+0io 24pf+0w
# mit nomemoize 
# 52.828u 31.830s 1:24.69 99.9%	0+0k 0+0io 1pf+0w
#
#
# mit vorberechneten Bäumen aus memoize: time xelatex main.tex
# MacBook Pro 16" 2023 M2 Max 42.020u 38.833s 1:20.04 101.0%	0+0k 0+0io 1070pf+0w
#                             40.062u 38.184s 1:17.28 101.2%	0+0k 0+0io 561pf+0w
# mit nomemoize
# 52.968u 41.995s 1:34.02 100.9%	0+0k 0+0io 373pf+0w

all: completed-hpsg.pdf


SOURCE=/Users/stefan/Documents/Dienstlich/Bibliographien/biblio.bib $(wildcard *.tex chapters/*.tex)

.SUFFIXES: .tex


# for Stefan. Uses memoize.
completed-hpsg.pdf: completed-hpsg.tex $(SOURCE)
	lualatex  -no-pdf completed-hpsg |grep -v math
	biber completed-hpsg
	lualatex  -no-pdf completed-hpsg |grep -v math
	biber completed-hpsg
	lualatex completed-hpsg  -no-pdf |egrep -v 'math|PDFDocEncod' |egrep 'Warning|label|aux'
	correct-toappear
	correct-index
	sed -i.backup s/.*\\emph.*// completed-hpsg.adx #remove titles which biblatex puts into the name index
# sed -i.backup 's/hyperindexformat{\\\(infn {[0-9]*\)}/\1/' completed-hpsg.sdx # ordering of references to footnotes
# sed -i.backup 's/hyperindexformat{\\\(infn {[0-9]*\)}/\1/' completed-hpsg.adx
# sed -i.backup 's/hyperindexformat{\\\(infn {[0-9]*\)}/\1/' completed-hpsg.ldx
	sed -i.backup 's/\\MakeCapital //g' completed-hpsg.adx
	python3 fixindex.py a completed-hpsg
	mv completed-hpsgmod.adx completed-hpsg.adx
	sed -i.backup 's/\\MakeCapital //g' completed-hpsg.adx
	footnotes-index.pl completed-hpsg.ldx
	footnotes-index.pl completed-hpsg.sdx
	footnotes-index.pl completed-hpsg.adx 
	makeindex -o completed-hpsg.and completed-hpsg.adx
	makeindex -gs index.format -o completed-hpsg.lnd completed-hpsg.ldx
	makeindex -gs index.format -o completed-hpsg.snd completed-hpsg.sdx 
	lualatex  completed-hpsg | egrep -v 'math|PDFDocEncod|\\mark' |egrep 'Warning|label'



#	sed -i.backup 's/hyperindexformat{\\\(infn {[0-9]*\)}/\1/' *.adx
#	sed -i.backup 's/hyperindexformat{\\\(infn {[0-9]*\)}/\1/' *.ldx
#	sed -i.backup 's/\\protect \\active@dq \\dq@prtct {=}/"=/g' *.adx
#	sed -i.backup 's/{\\O }/Oe/' *.adx
#	python3 fixindex.py

# for Sebastian and overleaf. Does not use memoize
main.pdf: main.tex $(SOURCE)
	lualatex  -no-pdf main 
	biber main
	lualatex  -no-pdf main 
	biber main
	lualatex main  -no-pdf |egrep -v 'math|PDFDocEncod' |egrep 'Warning|label|aux'
	correct-toappear
	correct-index
	sed -i.backup s/.*\\emph.*// main.adx #remove titles which biblatex puts into the name index
# sed -i.backup 's/hyperindexformat{\\\(infn {[0-9]*\)}/\1/' main.sdx # ordering of references to footnotes
# sed -i.backup 's/hyperindexformat{\\\(infn {[0-9]*\)}/\1/' main.adx
# sed -i.backup 's/hyperindexformat{\\\(infn {[0-9]*\)}/\1/' main.ldx
	sed -i.backup 's/\\MakeCapital //g' main.adx
	python3 fixindex.py a main
	mv mainmod.adx main.adx
	sed -i.backup 's/\\MakeCapital //g' main.adx
	footnotes-index.pl main.ldx
	footnotes-index.pl main.sdx
	footnotes-index.pl main.adx 
	makeindex -o main.and main.adx
	makeindex -gs index.format -o main.lnd main.ldx
	makeindex -gs index.format -o main.snd main.sdx 
	lualatex  main | egrep -v 'math|PDFDocEncod|\\mark' |egrep 'Warning|label'



# just for quick comile and checking
index: completed-hpsg.tex $(SOURCE)
	lualatex completed-hpsg  -no-pdf 
	footnotes-index.pl completed-hpsg.ldx
	footnotes-index.pl completed-hpsg.sdx
	footnotes-index.pl completed-hpsg.adx 
	makeindex -o completed-hpsg.and completed-hpsg.adx
	makeindex -gs index.format -o completed-hpsg.lnd completed-hpsg.ldx
	makeindex -gs index.format -o completed-hpsg.snd completed-hpsg.sdx 
	lualatex  completed-hpsg | egrep -v 'math|PDFDocEncod|\\mark' |egrep 'Warning|label'


# http://stackoverflow.com/questions/10934456/imagemagick-pdf-to-jpgs-sometimes-results-in-black-background
cover: completed-hpsg.pdf
	magick $<\[0\] -resize 486x -background white -alpha remove -bordercolor black -border 2  cover.png
	cp cover.png hpsg-lehrbuch.png
	magick $<\[0\] -resize 140x -background white -alpha remove -bordercolor black -border 1  hpsg-lehrbuch-142x200.png

# Ergebnis ist dann 490xirgendwas




# fuer Sprachenindex
#	makeindex -gs index.format -o $*.lnd $*.ldx


lsp-styles:
	rsync -a $(LSP-STYLES) LSP/




public: completed-hpsg.pdf
	cp $? /Users/stefan/public_html/Pub/


commit:
	svn commit -m "published version to the web"

forest-commit:
	git add completed-hpsg.for.dir/*.pdf
	git commit -m "forest trees" completed-hpsg.for.dir/*.pdf completed-hpsg.for
	git push -u origin


/Users/stefan/public_html/Pub/completed-hpsg.pdf: completed-hpsg.pdf
	cp -p $?                      /Users/stefan/public_html/Pub/completed-hpsg.pdf


o-public: o-public-lehrbuch 
#commit 
#o-public-bib

o-public-lehrbuch: /Users/stefan/public_html/Pub/completed-hpsg.pdf 
	scp -p $? hpsg.hu-berlin.de:/home/stefan/public_html/Pub/hpsg-lehrbuch.pdf



PUB_FILE=stmue.bib

o-public-bib: $(PUB_FILE)
	scp -p $? home.hpsg.fu-berlin.de:/home/stefan/public_html/Pub/



#-f '(author){%n(author)}{%n(editor)}:{%2d(year)#%s(year)#no-year}'

#$(IN_FILE).dvi
$(PUB_FILE): ../hpsg/make_bib_header ../hpsg/make_bib_html_number  ../hpsg/.bibtool77-no-comments grammatical-theory.aux ../hpsg/la.aux ../HPSG-Lehrbuch/hpsg-lehrbuch.aux ../complex/complex-csli.aux 
	sort -u grammatical-theory.aux ../hpsg/la.aux ../HPSG-Lehrbuch/hpsg-lehrbuch.aux ../complex/complex-csli.aux  >tmp.aux
	bibtool -r ../hpsg/.bibtool77-no-comments  -x tmp.aux -o $(PUB_FILE).tmp
	sed -e 's/-u//g'  $(PUB_FILE).tmp  >$(PUB_FILE).tmp.neu
	../hpsg/make_bib_header
	cat bib_header.txt $(PUB_FILE).tmp.neu > $(PUB_FILE)
	rm $(PUB_FILE).tmp $(PUB_FILE).tmp.neu



# lualatex has to be run two times + biber to get "also printed as ..." right.
completed-hpsg.bib: ../../Bibliographien/biblio.bib $(SOURCE) langsci.dbx bib-creation.tex
	lualatex -no-pdf -interaction=nonstopmode  bib-creation 
	biber bib-creation
	lualatex -no-pdf -interaction=nonstopmode  bib-creation
	biber --output_format=bibtex --output-resolve-xdata --output-legacy-date bib-creation.bcf -O completed-hpsg_tmp.bib
	biber --tool --configfile=biber-tool.conf --output-field-replace=location:address,journaltitle:journal --output-legacy-date completed-hpsg_tmp.bib -O completed-hpsg.bib


todo-bib.unique.txt: completed-hpsg.bcf
	biber -V completed-hpsg | grep -i warn | sort -uf > todo-bib.unique.txt


memos:
	lualatex completed-hpsg
	python3 memomanager.py split completed-hpsg.mmz

languagecandidates:
	ggrep -ohP "(?<=[a-z]|[0-9])(\))?(,)? (\()?[A-Z]['a-zA-Z-]+" chapters/*tex| grep -o  [A-Z].* |sort -u >languagelist.txt

memo-install:
	cp -pr ~/Documents/Dienstlich/Projekte/memoize/memoize* .
	cp -pr ~/Documents/Dienstlich/Projekte/memoize/nomemoize* .
	cp -pr ~/Documents/Dienstlich/Projekte/memoize/xparse-arglist.sty .
	cp -pr ~/Documents/Dienstlich/Projekte/memoize/memomanager.py .


avm-install:
	cp -fp ~/Documents/Dienstlich/Projekte/LangSci/Git-HUB/langsci-avm/langsci-avm.sty .


install:
	cp -p ${STYLE-PATH}makros.2020.sty styles/
	cp -p ${STYLE-PATH}abbrev.sty    styles/
	cp -p ${STYLE-PATH}mycommands.sty    styles/
	cp -p ${STYLE-PATH}fixcitep.sty  styles/
	cp -p ${STYLE-PATH}de-date.sty   styles/
	cp -p ${STYLE-PATH}oneline.sty   styles/
	cp -p ${STYLE-PATH}my-theorems.sty   styles/
	cp -p ${STYLE-PATH}Ling/article-ex.sty           styles/
	cp -p ${STYLE-PATH}Ling/merkmalstruktur.sty      styles/
	cp -p ${STYLE-PATH}my-xspace.sty            styles/
	cp -p ${STYLE-PATH}Ling/my-ccg-ohne-colortbl.sty styles/
	cp -p ${STYLE-PATH}Ling/tikz-mrs.sty 		styles/
#	cp -p ${STYLE-PATH}Ling/forest.sty               .
#	cp -p ${STYLE-PATH}Ling/forest-lib-edges.sty     .
#	cp -p ${STYLE-PATH}Ling/forest-lib-linguistics.sty .
	cp -p ${STYLE-PATH}de-hyp-utf8.sty 	         styles/
	cp -p ${STYLE-PATH}Ling/cgloss.sty               styles/
	cp -p ${STYLE-PATH}Ling/jambox.sty               styles/
	cp -p ${LANGSCI-PATH}langsci-forest-setup.sty    .






source: 
	tar chzvf ~/Downloads/completed-hpsg.tgz *.tex styles/*.sty LSP/


clean:
	rm -f *.bak *~ *.log *.blg *.bbl *.aux *.toc *.cut *.out *.tpm *.adx *.idx *.ilg *.ind *.and *.glg *.glo *.gls *.657pk *.adx.hyp *.bbl.old *.backup *.mw *.bcf *.lnd *.ldx *.rdx *.sdx *.wdx *.xdv *.run.xml *.aux.copy *.auxlock chapters/*.aux

check-clean:
	rm -f *.bak *~ *.log *.blg complex-draft.dvi


cleanmemo:
	rm -f *.mmz chapters/*.mmz hpsg.memo.dir/*

realclean: clean
	mv langsci_logo_nocolor.pdf langsci_logo_nocolor.safe
	mv ccby.pdf ccby.safe
	mv storagelogo.pdf storagelogo.safe
	rm -f *.dvi *.ps *.pdf chapters/*.pdf
	mv langsci_logo_nocolor.safe langsci_logo_nocolor.pdf
	mv ccby.safe ccby.pdf
	mv storagelogo.safe storagelogo.pdf


brutal-clean: realclean cleanmemo


