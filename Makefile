SUBDIRS := $(wildcard examples/*/.)
SUBDIRSCLEAN=$(addsuffix clean,$(SUBDIRS))

BASE = $(shell /bin/pwd)

.PHONY: $(TOPTARGETS) $(SUBDIRS)

clean:
	rm -f .terraform.lock.hcl
	rm -rf .terraform
	rm -f ./test/go.mod
	rm -f ./test/go.sum
	rm -f tf.json
	rm -f tf.plan
	rm -f *.tfvars
	rm -rf ./build-artifacts
	rm -rf ./tests/setup/parameter_parser/.terraform
	rm -rf ./tests/setup/parameter_parser/.terraform.lock.hcl
	rm -rf ./tests/setup/parameter_parser/build-artifacts