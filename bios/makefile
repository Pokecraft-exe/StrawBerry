OBJDIR = ../obj/stage1/bios
STRAWBERRY = $(OBJDIR)/strawberry-bios.bin
STRAWBERRY_STAGE2 = ../obj/stage2/strawberry.bin
FLAGS = -Wall -fbin

.PHONY: hdd cd pxe clean

clean:
	rm $(STRAWBERRY)
hdd: $(STRAWBERRY_STAGE2)
	cd hdd && nasm $(FLAGS) -o ../$(STRAWBERRY) ./boot.asm
	cd ..
cd: $(STRAWBERRY_STAGE2)
	cd cd && nasm $(FLAGS) -o ../$(STRAWBERRY) ./boot.asm
	cd ..
pxe: $(STRAWBERRY_STAGE2)
	cd pxe && nasm $(FLAGS) -o ../$(STRAWBERRY) ./boot.asm
	cd ..