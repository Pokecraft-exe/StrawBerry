OUTPUT_FORMAT(elf32-i386)
OUTPUT_ARCH(i386)
ENTRY(_start)

PHDRS
{
    text   PT_LOAD    FLAGS((1 << 0) | (1 << 2)) ;
    data   PT_LOAD    FLAGS((1 << 1) | (1 << 2)) ;
}

SECTIONS
{
    . = 0xf000;

    .text : {
        *(.text .text.*)
        *(COMMON)
    } :text

    .data : {
        *(.data .data.*)
        *(COMMON)
    } :data

    .bss : {
        *(.bss .bss.*)
        *(COMMON)
    } :data

    /DISCARD/ : {
        *(.eh_frame)
        *(.note .note.*)
    }
}