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
# $Id: Makefile,v 1.17 2007-11-10 17:08:25 steve Exp $


#
#  Only used to build distribution tarballs.
#
DIST_PREFIX = ${TMP}
VERSION     = 1.0
BASE        = chronicle


#
#  Installation prefix, useful for the Debian package.
#
prefix=


nop:
	@echo "Valid targets are (alphabetically) :"
	@echo " "
	@echo " clean         = Remove bogus files and any local output."
	@echo " diff          = See the local changes."
	@echo " test          = Run our simple test cases."
	@echo " test-verbose  = Run our simple test cases, verbosely."
	@echo " update        = Update from the remote repository."
	@echo " "


#
#  Delete all temporary files, recursively.
#
clean:
	@find . -name '.*~' -exec rm \{\} \;
	@find . -name '.#*' -exec rm \{\} \;
	@find . -name '*~' -exec rm \{\} \;
	@find . -name '*.bak' -exec rm \{\} \;
	@find . -name '*.tmp' -exec rm \{\} \;
	@if [ -d output ]; then rm -rf output; mkdir output; fi
	@if [ -e build-stamp ]; then rm -f build-stamp; fi
	@if [ -e chronicle.1 ]; then rm -f chronicle.1 ; fi

#
#  Show what has been changed in the local copy vs. the remote repository.
#
diff:
	hg diff


#
#  Install to /usr/local/bin
#
install:
	cp ./etc/chroniclerc ${prefix}/etc/chroniclerc
	mkdir -p ${prefix}/usr/local/bin
	cp ./bin/chronicle ${prefix}/usr/local/bin
	mkdir -p ${prefix}/usr/share/chronicle/themes/xml
	cp -r ./themes/xml/*.* ${prefix}/usr/share/chronicle/themes/xml
	mkdir -p ${prefix}/usr/share/chronicle/themes/default
	cp -r ./themes/default/*.* ${prefix}/usr/share/chronicle/themes/default
	mkdir -p ${prefix}/usr/share/chronicle/themes/copyrighteous
	cp -r ./themes/copyrighteous/*.* ${prefix}/usr/share/chronicle/themes/copyrighteous
	mkdir -p ${prefix}/usr/share/chronicle/themes/blocky
	cp -r ./themes/blocky/*.* ${prefix}/usr/share/chronicle/themes/blocky


#
#  Make a new release tarball, and make a GPG signature.
#
release: clean
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)
	rm -f $(DIST_PREFIX)/$(BASE)-$(VERSION).tar.gz
	cp -R . $(DIST_PREFIX)/$(BASE)-$(VERSION)
	perl -pi.bak -e "s/UNRELEASED/$(VERSION)/g" $(DIST_PREFIX)/$(BASE)-$(VERSION)/bin/chronicle
	find  $(DIST_PREFIX)/$(BASE)-$(VERSION) -name ".hg*" -print | xargs rm -rf
	find  $(DIST_PREFIX)/$(BASE)-$(VERSION)/blog -name "*.txt" -print | xargs rm -rf
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)/debian
	cd $(DIST_PREFIX) && tar -cvf $(DIST_PREFIX)/$(BASE)-$(VERSION).tar $(BASE)-$(VERSION)/
	gzip $(DIST_PREFIX)/$(BASE)-$(VERSION).tar
	mv $(DIST_PREFIX)/$(BASE)-$(VERSION).tar.gz .
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)
	gpg --armour --detach-sign $(BASE)-$(VERSION).tar.gz


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
#  NOTE: Removes empty local directories.
#
update: 
	hg pull --update


steve:
	./bin/chronicle --theme-dir=./themes --theme=default --url-prefix=http://www.steve.org.uk/Software/chronicle/demo/ --pre-build="/bin/rm -rf ./output" --post-build="rsync -v -r output/* steve@www.steve.org.uk:/home/www/www.steve.org.uk/htdocs/Software/chronicle/demo/"
	./bin/chronicle  --theme-dir=./themes --theme=copyrighteous --url-prefix=http://www.steve.org.uk/Software/chronicle/demo2/ --pre-build="/bin/rm -rf ./output"  --post-build="rsync -v -r output/* steve@www.steve.org.uk:/home/www/www.steve.org.uk/htdocs/Software/chronicle/demo2/"
	./bin/chronicle --theme-dir=./themes --theme=blocky --url-prefix=http://www.steve.org.uk/Software/chronicle/demo3/ --pre-build="/bin/rm -rf ./output"  --post-build="rsync -v -r output/* steve@www.steve.org.uk:/home/www/www.steve.org.uk/htdocs/Software/chronicle/demo3/"
