/*
 * mykernel/link.ld
 *
 * Copyright (C) 2017 - 2020 bzt (bztsrc@gitlab)
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 *
 * This file is part of the BOOTBOOT Protocol package.
 * @brief An example linker script for sample kernel
 *
 */

mmio  = 0xfffffffff8000000;                    /* these are configurable for level 2 loaders */
fb    = 0xfffffffffc000000;

PHDRS
{
  boot PT_LOAD;
}

ENTRY(_start)

SECTIONS
{
    . = 0xffffffffffe00000;
    bootboot  	= ALIGN(4K); . += 4K;
    environment = ALIGN(4K); . += 4K;

	.text : ALIGN(4K) {
		KEEP(*(.text))
	} :boot

	.rodata : ALIGN(4K) {
		*(.rodata)
	} :boot

	.data : ALIGN(4K) {
		*(.data)
	} :boot

	.bss : ALIGN(4k) {
		*(COMMON)
		*(.bss)
	} :boot
}
