STRAWBERRY = strawberry.bin
STRAWBERRY_BIOS = obj/stage1/bios/strawberry-bios.bin
STRAWBERRY_UEFI = obj/stage1/uefi/strawberry-uefi.bin
STRAWBERRY_STAGE2 = obj/stage2/strawberry.bin

.PHONY: clean iso

hdd: $(STRAWBERRY_STAGE2)
	cd stage2 && make && cd ..
	cd bios && make hdd && cd ..
cd: $(STRAWBERRY_STAGE2)
	cd stage2 && make && cd ..
	cd bios && make cd && cd ..
pxe: $(STRAWBERRY_STAGE2)
	cd stage2 && make && cd ..
	cd bios && make pxe && cd ..

iso:
	cp $(STRAWBERRY_BIOS) iso_root/strawberry-bios.bin
	xorriso -as mkisofs -b strawberry-bios.bin \
        	-no-emul-boot -boot-load-size 4 -boot-info-table \
        	iso_root -o image.iso;
clean:
	cd bios && make clean && cd ..
	cd stage2 && make clean && cd ..
install:
	mkdir obj
	mkdir obj/stage1
	mkdir obj/stage1/bios
	mkdir obj/stage1/uefi
	mkdir obj/stage2
	mkdir obj/stage2/obj
