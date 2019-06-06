.PHONY: setup balena clean

test: setup balena

setup:
	git submodule update --init; mkdir -p builds

balena:
	cd builds; rm -rf $@; mkdir $@; cd $@; cmake -DDEVICE=EFR32BG1B232F256GM48 ../..; make

clean:
	rm -rf builds
