export ARCH := x86_64

export OBJDIR := build
export KDIR := kernel

QEMUFLAGS := -cdrom tinuk.img -smp 8

.PHONY: all qemu qemu-debug install kernel clean

all: install

qemu: install
	qemu-system-$(ARCH) $(QEMUFLAGS) 

qemu-debug: install
	qemu-system-$(ARCH) $(QEMUFLAGS) -s -S

install: kernel
	mkdir -p $(OBJDIR)/boot
	cp $(OBJDIR)/kernel.elf $(OBJDIR)/boot/
	mkbootimg bootboot.json tinuk.img

kernel:
	$(MAKE) -f $(KDIR)/Makefile

clean:
	$(MAKE) -f $(KDIR)/Makefile clean
	rm -rf $(OBJDIR)
