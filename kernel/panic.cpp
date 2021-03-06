#include <kernel/panic.h>
#include <kernel/io.h>
#include <kernel/drivers/vesa.h>

[[noreturn]] extern "C" void _hang(); // _hang function in boot.asm

[[noreturn]] void kpanic(const char* msg) {
	static bool panicking = false;

	// If kpanic is called again, during the handling of a panic
	if(panicking) {
		_hang();
	}

	panicking = true;

	Color::ARGB red;
	red.red = 255;
	red.green = 0;
	red.blue = 0;
	red.alpha = 0;

	IO::get_terminal()->set_fg(red);

	IO::printk("KERNEL PANIC: %s", msg);
	_hang();
}
