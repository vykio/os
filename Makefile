TARGET = i686-elf
ISODIR = isodir

assemble:
	$(TARGET)-as boot.s -o boot.o
	
build:
	$(TARGET)-gcc -c kernel.c -o kernel.o -std=gnu99 -ffreestanding -O2 -Wall -Wextra
	$(TARGET)-gcc -T linker.ld -o os.bin -ffreestanding -O2 -nostdlib boot.o kernel.o -lgcc
	mkdir -p $(ISODIR)/boot/grub
	cp os.bin $(ISODIR)/boot/os.bin
	cp grub.cfg $(ISODIR)/boot/grub/grub.cfg
	grub-mkrescue -o os.iso $(ISODIR)
	
run:
	qemu-system-i386 -cdrom os.iso
