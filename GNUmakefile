STRAWBERRY = strawberry.bin
STRAWBERRY_BIOS = obj/stage1/bios/strawberry-bios.bin
STRAWBERRY_UEFI = obj/stage1/uefi/strawberry-uefi.bin
STRAWBERRY_STAGE2 = obj/stage2/strawberry.bin

.PHONY: clean iso help
help:
	$(info hdd: build for hard drive booting)
	$(info cd : build for cd booting)
	$(info pxe: build for pxe booting)
	$(info clean: remove all binaries)
	$(info install: make the envirenment for building StrawBerry)
hdd: $(STRAWBERRY_STAGE2)
	cd stage2 && make && cd ..
	cd bios && make hdd && cd ..
cd: $(STRAWBERRY_STAGE2)
	cd stage2 && make && cd ..
	cd bios && make cd && cd ..
pxe: $(STRAWBERRY_STAGE2)
	cd stage2 && make && cd ..
	cd bios && make pxe && cd ..
clean:
	-cd bios && make clean && cd ..
	-cd stage2 && make clean && cd ..
install:
	mkdir obj
	mkdir obj/stage1
	mkdir obj/stage1/bios
	mkdir obj/stage1/uefi
	mkdir obj/stage2
	mkdir obj/stage2/obj
