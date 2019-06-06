
balena_device = EFR32BG1B232F256GM48
dir = ./builds/balena

.PHONY: setup balena clean flash

all: setup balena

setup:
	git submodule update --init; mkdir -p builds

flash: | $(dir)
	cd builds/balena; make flash;

$(dir): 
	setup balena

balena:
	cd builds; rm -rf $@; mkdir $@; cd $@; cmake -DDEVICE=$(balena_device) ../..; make

clean:
	rm -rf builds
