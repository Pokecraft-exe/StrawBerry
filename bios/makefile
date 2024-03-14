OBJDIR := ../obj/stage1/bios

STRAWBERRY := $(OBJDIR)/strawberry-bios.bin
STRAWBERRY_STAGE2 = ../obj/stage2/strawberry.bin

FLAGS = -Wall -fbin

.PHONY: hdd cd pxe clean

hdd:
	cd hdd && nasm $(FLAGS) -o ../$(STRAWBERRY) ./boot.asm
	cd ..
cd:
	cd cd && nasm $(FLAGS) -o ../$(STRAWBERRY) ./boot.asm
	cd ..
pxe:
	cd pxe && nasm $(FLAGS) -o ../$(STRAWBERRY) ./boot.asm
	cd ..
clean:
	-rm $(STRAWBERRY)