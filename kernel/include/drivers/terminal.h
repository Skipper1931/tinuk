#include <stddef.h>

#pragma once

class Terminal {
	public:
		virtual void write(const char* str) = 0;
};