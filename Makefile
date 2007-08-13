#
#  Utility makefile for people working with chronicle
#
#  The targets are intended to be useful for people who are using
# the CVS repository - but it also contains other useful targets.
#
# Steve
# --
# http://www.steve.org.uk/
#
# $Id: Makefile,v 1.3 2007-08-13 23:22:03 steve Exp $


#
#  Only used to build distribution tarballs.
#
DIST_PREFIX = ${TMP}
VERSION     = 0.1
BASE        = chronicle


#
#  Installation prefix, useful for the Debian package.
#
prefix=


nop:
	@echo "Valid targets are (alphabetically) :"
	@echo " "
	@echo " clean         = Remove bogus files and any local output."
	@echo " diff          = Run a 'cvs diff'."
	@echo " test          = Run our simple test cases."
	@echo " test-verbose  = Run our simple test cases, verbosely."
	@echo " update        = Update from the CVS repository."
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
#
#  Show what has been changed in the local copy vs. the CVS repository.
#
diff:
	cvs diff --unified 2>/dev/null


#
#  Install to /usr/local/bin
#
install:
	cp ./etc/chroniclerc ${prefix}/etc/chroniclerc
	mkdir -p ${prefix}/usr/local/bin
	cp ./bin/chronicle ${prefix}/usr/local/bin
	mkdir -p ${prefix}/usr/share/chronicle/themes/default
	cp -r ./themes/default/*.* ${prefix}/usr/share/chronicle/themes/default


#
#  Make a new release tarball, and make a GPG signature.
#
release: clean
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)
	rm -f $(DIST_PREFIX)/$(BASE)-$(VERSION).tar.gz
	cp -R . $(DIST_PREFIX)/$(BASE)-$(VERSION)
	find  $(DIST_PREFIX)/$(BASE)-$(VERSION) -name "CVS" -print | xargs rm -rf
	rm -rf $(DIST_PREFIX)/$(BASE)-$(VERSION)/debian
	cd $(DIST_PREFIX) && tar --exclude=.cvsignore -cvf $(DIST_PREFIX)/$(BASE)-$(VERSION).tar $(BASE)-$(VERSION)/
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
#  Update the local copy from the CVS repository.
#
#  NOTE: Removes empty local directories.
#
update: 
	cvs -z3 update -A -P -d 2>/dev/null
