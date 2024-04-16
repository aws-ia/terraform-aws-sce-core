SUBDIRS := $(wildcard examples/*/.)
SUBDIRSCLEAN=$(addsuffix clean,$(SUBDIRS))

BASE = $(shell /bin/pwd)

.PHONY: $(TOPTARGETS) $(SUBDIRS)

clean: $(SUBDIRSCLEAN)

clean_curdir:
	rm -f .terraform.lock.hcl
	rm -rf .terraform
	rm -f ./test/go.mod
	rm -f ./test/go.sum
	rm -f tf.json
	rm -f tf.plan
	rm -f *.tfvars
	rm -rf ./build-artifacts

%clean: %
    $(MAKE) -C $< -f $(PWD)/Makefile clean_curdir