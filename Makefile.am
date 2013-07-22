OPENSTACK_MANUALS_CONVERT_CACHE_DIR	?= $(HOME)/openstack-manuals-convert-cache

EXTRA_DIST = \
  bin \
  xml \
  xsl \
  cfg \
  etc \
  doc \
  openstack-manuals-convert.spec
DISTCLEANFILES = $(PACKAGE)-$(VERSION).tar.gz

rpms: dist
	rpmbuild $(RPM_FLAGS) -ta $(distdir).tar.gz

srpms: dist
	rpmbuild $(RPM_FLAGS) -ts $(distdir).tar.gz

publish: rpms
	mkdir -p $(OPENSTACK_MANUALS_CONVERT_CACHE_DIR)
	rsync -aq $(shell rpm --eval '%{_rpmdir}')/ $(OPENSTACK_MANUALS_CONVERT_CACHE_DIR)/skynet/
	rsync -aq $(shell rpm --eval '%{_srcrpmdir}')/ $(OPENSTACK_MANUALS_CONVERT_CACHE_DIR)/skynet/src
	createrepo $(OPENSTACK_MANUALS_CONVERT_CACHE_DIR)/skynet

.PHONY: rpms publish srpms

