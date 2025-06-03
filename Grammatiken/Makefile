
alle-grammatiken.tgz: clean
	tar -X tar-exclude -czvf alle-grammatiken.tgz Gemeinsames Kapitel-*

kapitel03.tgz: clean
	tar -X tar-exclude -czvf kapitel03.tgz Gemeinsames Kapitel-03 Kapitel-03-ArgSt

kapitel04.tgz: clean
	tar -X tar-exclude -czvf kapitel04.tgz Gemeinsames Kapitel-04 Kapitel-04-ArgSt

kapitel05.tgz: clean
	tar -X tar-exclude -czvf kapitel05.tgz Gemeinsames Kapitel-05

kapitel06.tgz: clean
	tar -X tar-exclude -czvf kapitel06.tgz Gemeinsames Kapitel-06*

kapitel08.tgz: clean
	tar -X tar-exclude -czvf kapitel08.tgz Gemeinsames Kapitel-08*

kapitel09.tgz: clean
	tar -X tar-exclude -czvf kapitel09.tgz Gemeinsames Kapitel-09*

kapitel10.tgz: clean
	tar -X tar-exclude -czvf kapitel10.tgz Gemeinsames Kapitel-10*

kapitel11.tgz: clean
	tar -X tar-exclude -czvf kapitel11.tgz Gemeinsames Kapitel-11*

kapitel12.tgz: clean
	tar -X tar-exclude -czvf kapitel12.tgz Gemeinsames Kapitel-12*

kapitel13.tgz: clean
	tar -X tar-exclude -czvf kapitel13.tgz Gemeinsames Kapitel-13*

kapitel14.tgz: clean
	tar -X tar-exclude -czvf kapitel14.tgz Gemeinsames Kapitel-14*

kapitel15.tgz: clean
	tar -X tar-exclude -czvf kapitel15.tgz Gemeinsames Kapitel-15*

kapitel16.tgz: clean
	tar -X tar-exclude -czvf kapitel16.tgz Gemeinsames Kapitel-16*

kapitel17.tgz: clean
	tar -X tar-exclude -czvf kapitel17.tgz Gemeinsames Kapitel-17*

kapitel18.tgz: clean
	tar -X tar-exclude -czvf kapitel18.tgz Gemeinsames Kapitel-18*

kapitel19.tgz: clean
	tar -X tar-exclude -czvf kapitel19.tgz Gemeinsames Kapitel-19*

#kapitel12.tgz kapitel13.tgz kapitel14.tgz kapitel15.tgz kapitel16.tgz kapitel17.tgz kapitel18.tgz kapitel19.tgz

public: alle-grammatiken.tgz kapitel03.tgz kapitel04.tgz kapitel05.tgz kapitel06.tgz kapitel08.tgz kapitel09.tgz kapitel10.tgz kapitel11.tgz kapitel12.tgz kapitel13.tgz
	cp -p $? /Users/stefan/public_html/Pub/Einfuehrung/

o-public: alle-grammatiken.tgz kapitel03.tgz kapitel04.tgz kapitel05.tgz kapitel06.tgz kapitel08.tgz kapitel09.tgz kapitel10.tgz kapitel11.tgz kapitel12.tgz kapitel13.tgz
	scp -p $? hpsg.hu-berlin.de:/home/stefan/public_html/Pub/Einfuehrung/

old-o-public: knoppix o-copy

o-copy: alle-grammatiken.tgz kapitel3.tgz kapitel4.tgz  kapitel5.tgz kapitel6.tgz kapitel7.tgz kapitel9.tgz kapitel10.tgz kapitel11.tgz kapitel12.tgz kapitel13.tgz kapitel14.tgz kapitel15.tgz kapitel16.tgz kapitel17.tgz kapitel18.tgz kapitel19.tgz
	scp -p $? www.cl.uni-bremen.de:/home/stefan/public_html/Pub/Einfuehrung/

knoppix: clean
	\rm -rf ../../../Grammatik-CD/Grammatiken/HPSG-Textbook/Kapitel* ../../../Grammatik-CD/Grammatiken/HPSG-Textbook/Gemeinsames
	rsync -a --exclude '*~' --exclude '*CVS*' --exclude 'tmp' --exclude 'Current' --exclude '*.tgz' --exclude 'Makefile' --exclude 'notes' --exclude 'tar-exclude' --exclude 'trale-test-export' . ../../../Grammatik-CD/Grammatiken/HPSG-Textbook/


mehr-vf: kapitel15.tgz
	scp kapitel15.tgz stat2:/srv/www/htdocs/Fragments/mehr-vf.tgz

backup: 
	tar cjvf /home/stefan/Backup/einfuehrungen-grammars.`date +"%Y.%m.%d"`.tbz .

clean:
	find . -name \*~ -exec \rm {} \;
	find . -name .trale_\* -exec \rm {} \;
	find . -name \.alec_throw -exec \rm {} \;

realclean: clean
	rm kapitel*.tgz

cvs:
	cvs 
