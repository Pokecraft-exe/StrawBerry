@echo off
cd hdd
nasm boot.asm -Wall -fbin -o ..\boot.bin
cd ..
qemu-system-x86_64 -d in_asm,int -D ../debug.txt .\boot.bin