STRAWBERRY = ../obj/stage2/strawberry.bin

FLAGS = -Wall -felf32
LDFLAGS = -nostdlib -static -m elf_x86_64 -z max-page-size=0x1000 -T link.ld

OBJDIR = ../obj/stage2/obj/
OBJ = $(OBJDIR)entry.o
OBJS = $(OBJDIR)entry.o

$(STRAWBERRY): $(OBJ)
	ld $(LDFLAGS) $(OBJS) -o $(STRAWBERRY)

$(OBJ):
	nasm $(FLAGS) entry.asm -o $(OBJDIR)entry.o

