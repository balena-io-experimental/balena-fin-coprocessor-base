.PHONY: all setup balena devkit

CORES=1

all: setup balena devkit

setup: check-and-reinit-submodule check-output set-cores
	mkdir -p builds

set-cores:
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
	CORES=$(nproc)
endif
ifeq ($(UNAME_S),Darwin)
	CORES=$(sysctl -n hw.ncpu)
endif

check-and-reinit-submodule:
	@if git submodule status | egrep -q '^[-]|^[+]' ; then \
			echo "INFO: Need to reinitialize git submodules"; \
			git submodule update --init; \
	fi

check-output:
ifndef OUTDIR
export OUTDIR=builds
endif

#BalenaFin
balena: setup
	rm -rf $(OUTDIR)/$@; mkdir $(OUTDIR)/$@; cmake -DDEVICE=EFR32BG1B232F256GM48 -DSERIAL=FIN -S. -B$(OUTDIR)/$@; cd $(OUTDIR)/$@; make -j $(CORES)
	
#Silabs-BRD4300A
devkit: setup
	rm -rf $(OUTDIR)/$@; mkdir $(OUTDIR)/$@; cmake -DDEVICE=EFR32BG1B232F256GM48 -DSERIAL=DEV -S. -B$(OUTDIR)/$@; cd $(OUTDIR)/$@; make -j $(CORES)

clean:
	rm -rf $(OUTDIR)