SRCDIR := ./
OBJDIR := ../obj/stage2

STRAWBERRY := $(OBJDIR)/strawberry.bin

LDFLAGS = -nostdlib -static -m elf_x86_64 -z max-page-size=0x1000 -T link.ld
FLAGS = -Wall -felf32

rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d)) 

SRC += $(call rwildcard,$(SRCDIR), *.asm)
OBJ += $(patsubst $(SRCDIR)/%.asm, $(OBJDIR)/obj/%.o, $(SRC))

.PHONY: clean

all: $(STRAWBERRY)

$(STRAWBERRY): $(OBJ)
	$(LD) $(OBJ) $(LDFLAGS) -o $@

$(OBJDIR)/obj/%.o: $(SRCDIR)/%.asm
	nasm $(FLAGS) $< -o $@

clean:
	-rm $(STRAWBERRY)
	-rm $(OBJDIR)/obj/*.o