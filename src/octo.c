
#include <stdint.h>

struct octoword {
	uint64_t lo;
	uint64_t hi;
};

// BUG: Assumes that the number will not overflow
int parse_uint128_t(const char *src, struct octoword *output)
{
	if(!src || !output) {
		return -1;
	}
	output->lo = output->hi = 0;

	while(*src) {
		// Multiply old value by 2
		uint64_t old = output->lo;
		output->hi <<= 1;
		output->lo <<= 1;
		if(old >> 63) {
			output->hi += 1;
		}

		// Multiply old value by 5 (0b101)
		old = output->lo;
		// hi *= 5
		output->hi += (output->hi << 2);
		output->lo <<= 2;
		if(old >> 62) {
			output->hi += old >> 62;
		}
		uint64_t max = old > output->lo ? old : output->lo;
		output->lo += old;
		if(max > output->lo) {
			output->hi += 1;
		}


		old = output->lo;
		output->lo += *src - '0';
		// If adding the digit caused a carry, it will be a 1-bit carry
		if(output->lo < old) {
			output->hi += 1;
		}

		++src;
	}
	return 0;
}
