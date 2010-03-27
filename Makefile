#
#  Utility makefile for people working with chronicle
#
#  The targets are intended to be useful for people who are using
# the remote repository - but it also contains other useful targets.
#
# Steve
# --
# http://www.steve.org.uk/
#

#
#  Only used to build distribution tarballs.
#
DIST_PREFIX = ${TMP}
VERSION     = 4.3
BASE        = chronicle


#
#  Installation prefix, useful for the Debian package.
#
prefix=


nop:
	@echo "Valid targets are (alphabetically) :"
	@echo " "
	@echo " clean         = Remove bogus files and any local output."
	@echo " demos[*]      = Generate and upload demo blogs."
	@echo " diff          = See the local changes."
	@echo " install       = Install upon the local system."
	@echo " release [*]   = Generate a release tarball."
	@echo " test          = Run our simple test cases."
	@echo " test-verbose  = Run our simple test cases, verbosely."
	@echo " tidy [*]      = Tidy the code via perltidy."
	@echo " update        = Update from the remote repository."
	@echo " "
	@echo "[*] - These targets are Steve-specific.  Probably."
	@echo " "


#
#  Delete all temporary files, recursively.
#
clean:
	@find . -name '.*~' -exec rm \{\} \;
	@find . -name '.#*' -exec rm \{\} \;
	@find . -name '*~' -exec rm \{\} \;
	@find . -name '*.1' -exec rm \{\} \;
	@find . -name '*.bak' -exec rm \{\} \;
	@find . -name '*.tmp' -exec rm \{\} \;
	@if [ -e .version ]; then rm -f .version; fi
	@if [ -d comments ]; then rm -rf comments; fi
	@if [ -d output   ]; then rm -rf output; fi
	@if [ -e build-stamp ]; then rm -f build-stamp; fi
	@if [ -e debian/chronicle.debhelper.log ]; then rm debian/chronicle.debhelper.log; fi
	@if [ -e debian/chronicle/ ]; then rm -rf debian/chronicle/ ; fi


#
#  Run perlcritic on our scripts
#
critic:
	perlcritic bin/*


#
#  Show what has been changed in the local copy vs. the remote repository.
#
diff:
	hg diff


#
#  Install to /usr/bin
#
#  Install the themes without hardwiring a list of them.
#
install:
	mkdir -p ${prefix}/etc
	cp ./etc/chroniclerc ${prefix}/etc/chroniclerc
	mkdir -p ${prefix}/usr/bin
	cp ./bin/chronicle ${prefix}/usr/bin
	cp ./bin/chronicle-spooler ${prefix}/usr/bin
	cp ./bin/chronicle-entry-filter ${prefix}/usr/bin
	cp ./bin/chronicle-rss-importer ${prefix}/usr/bin
	mkdir -p ${prefix}/usr/share/chronicle/themes/xml
	cp -r ./themes/xml/*.* ${prefix}/usr/share/chronicle/themes/xml
	for i in themes/*/; do \
		mkdir -p ${prefix}/usr/share/chronicle/themes/$$(basename $$i) ;\
		cp -r ./themes/$$(basename $$i)/*.* ${prefix}/usr/share/chronicle/themes/$$(basename $$i)/ ;\
	done


#
#  Make a new release tarball, and make a GPG signature.
#
release: tidy clean
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)
	rm -f $(DIST_PREFIX)/$(BASE)-$(VERSION).tar.gz
	cp -R . $(DIST_PREFIX)/$(BASE)-$(VERSION)
	perl -pi.bak -e "s/UNRELEASED/$(VERSION)/g" $(DIST_PREFIX)/$(BASE)-$(VERSION)/bin/chronicle
	perl -pi.bak -e "s/UNRELEASED/$(VERSION)/g" $(DIST_PREFIX)/$(BASE)-$(VERSION)/bin/chronicle-entry-filter
	perl -pi.bak -e "s/UNRELEASED/$(VERSION)/g" $(DIST_PREFIX)/$(BASE)-$(VERSION)/bin/chronicle-spooler
	rm  $(DIST_PREFIX)/$(BASE)-$(VERSION)/bin/*.bak
	find  $(DIST_PREFIX)/$(BASE)-$(VERSION) -name ".hg*" -print | xargs rm -rf
	find  $(DIST_PREFIX)/$(BASE)-$(VERSION) -name ".release" -print | xargs rm -rf
	find  $(DIST_PREFIX)/$(BASE)-$(VERSION)/blog -name "*.txt" -print | xargs rm -rf
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)/debian
	cd $(DIST_PREFIX) && tar -cvf $(DIST_PREFIX)/$(BASE)-$(VERSION).tar $(BASE)-$(VERSION)/
	gzip $(DIST_PREFIX)/$(BASE)-$(VERSION).tar
	mv $(DIST_PREFIX)/$(BASE)-$(VERSION).tar.gz .
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)
	gpg --armour --detach-sign $(BASE)-$(VERSION).tar.gz
	echo $(VERSION) > .version



#
#  Tidy the code
#
tidy:
	if [ -x ~/bin/perltidy ]; then \
           ~/bin/perltidy ./bin/chronicle-entry-filter ./bin/chronicle-spam-test ./bin/chronicle-spooler ./bin/chronicle-rss-importer ./bin/chronicle ./cgi-bin/comments.cgi \
	; fi


#
#  Run the test suite.
#
test:
	prove --shuffle tests/


#
#  Run the test suite verbosely.
#
test-verbose:
	prove --shuffle --verbose tests/



#
#  Update the local copy from the remote repository.
#
update:
	hg pull --update


#
#  Generate the demo blogs.
#
demos:
	./bin/chronicle --theme-dir=./themes --theme=default --url-prefix=http://www.steve.org.uk/Software/chronicle/demo/ --pre-build="/bin/rm -rf ./output" --post-build="rsync -q -r output/* steve@www.steve.org.uk:/home/www/www.steve.org.uk/htdocs/Software/chronicle/demo/" --no-comments --no-cache --blog-title="Sample Blog" --blog-subtitle="Created by Chronicle" --date-archive-path
	./bin/chronicle  --theme-dir=./themes --theme=copyrighteous --url-prefix=http://www.steve.org.uk/Software/chronicle/demo2/ --pre-build="/bin/rm -rf ./output"  --post-build="rsync -q -r output/* steve@www.steve.org.uk:/home/www/www.steve.org.uk/htdocs/Software/chronicle/demo2/" --no-comments --no-cache --blog-title="Sample Blog" --blog-subtitle="Created by Chronicle"
	./bin/chronicle --date-archive-path --theme-dir=./themes --theme=blocky --url-prefix=http://www.steve.org.uk/Software/chronicle/demo3/ --pre-build="/bin/rm -rf ./output"  --post-build="rsync -q -r output/* steve@www.steve.org.uk:/home/www/www.steve.org.uk/htdocs/Software/chronicle/demo3/" --no-comments --no-cache --blog-title="Sample Blog" --blog-subtitle="Created by Chronicle"
	./bin/chronicle --theme-dir=./themes --theme=leftbar --url-prefix=http://www.steve.org.uk/Software/chronicle/demo4/ --pre-build="/bin/rm -rf ./output"  --post-build="rsync -q -r output/* steve@www.steve.org.uk:/home/www/www.steve.org.uk/htdocs/Software/chronicle/demo4/" --no-comments --no-cache --blog-title="Sample Blog" --blog-subtitle="Created by Chronicle"
	./bin/chronicle --theme-dir=./themes --theme=simple --url-prefix=http://www.steve.org.uk/Software/chronicle/demo5/ --pre-build="/bin/rm -rf ./output"  --post-build="rsync -q -r output/* steve@www.steve.org.uk:/home/www/www.steve.org.uk/htdocs/Software/chronicle/demo5/" --no-comments --no-cache --blog-title="Sample Blog" --blog-subtitle="Created by Chronicle"
