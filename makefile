#STRAWBERRY = strawberry.bin
STRAWBERRY_BIOS = obj/stage1/bios/strawberry-bios.bin
#STRAWBERRY_UEFI = obj/stage1/uefi/strawberry-uefi.bin
STRAWBERRY_STAGE2 = obj/stage2/strawberry.bin

.PHONY: clean help
help:
	@echo hdd: build for hard drive booting
	@echo cd : build for cd booting
	@echo pxe: build for pxe booting
	@echo clean: remove all binaries
	@echo install: make the envirenment for building StrawBerry
clean:
	cd bios && nmake clean && cd ..
	rm $(STRAWBERRY_STAGE2)
	rm obj/stage2/obj/*.o
hdd:
	cd stage2 && nmake && cd ..
	cd bios && nmake hdd && cd ..
cd:
	cd stage2 && nmake && cd ..
	cd bios && nmake cd && cd ..
pxe:
	cd stage2 && nmake && cd ..
	cd bios && nmake pxe && cd ..
install:
	mkdir obj
	mkdir obj/stage1
	mkdir obj/stage1/bios
	mkdir obj/stage1/uefi
	mkdir obj/stage2
	mkdir obj/stage2/obj
