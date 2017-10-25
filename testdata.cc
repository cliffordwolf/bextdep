/*
 *  Copyright (C) 2017  Clifford Wolf <clifford@clifford.at>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <assert.h>

uint32_t xorshift32()
{
	static uint32_t x32 = 314159265;
	x32 ^= x32 << 13;
	x32 ^= x32 >> 17;
	x32 ^= x32 << 5;
	return x32;
}

uint64_t xorshift64()
{
	uint64_t r = xorshift32();
	return (r << 32) | xorshift32();
}

uint32_t bext32(uint32_t v, uint32_t mask)
{
	uint32_t c = 0, m = 1;
	while (mask) {
		uint32_t b = mask & -mask;
		if (v & b)
			c |= m;
		mask -= b;
		m <<= 1;
	}
	return c;
}

uint64_t bext64(uint64_t v, uint64_t mask)
{
	uint64_t c = 0, m = 1;
	while (mask) {
		uint64_t b = mask & -mask;
		if (v & b)
			c |= m;
		mask -= b;
		m <<= 1;
	}
	return c;
}

uint32_t bdep32(uint32_t v, uint32_t mask)
{
	uint32_t c = 0, m = 1;
	while (mask) {
		uint32_t b = mask & -mask;
		if (v & m)
			c |= b;
		mask -= b;
		m <<= 1;
	}
	return c;
}

uint64_t bdep64(uint64_t v, uint64_t mask)
{
	uint64_t c = 0, m = 1;
	while (mask) {
		uint64_t b = mask & -mask;
		if (v & m)
			c |= b;
		mask -= b;
		m <<= 1;
	}
	return c;
}

uint32_t grev32(uint32_t x, int k)
{
	if (k &  1) x = ((x & 0x55555555) <<  1) | ((x & 0xAAAAAAAA) >>  1);
	if (k &  2) x = ((x & 0x33333333) <<  2) | ((x & 0xCCCCCCCC) >>  2);
	if (k &  4) x = ((x & 0x0F0F0F0F) <<  4) | ((x & 0xF0F0F0F0) >>  4);
	if (k &  8) x = ((x & 0x00FF00FF) <<  8) | ((x & 0xFF00FF00) >>  8);
	if (k & 16) x = ((x & 0x0000FFFF) << 16) | ((x & 0xFFFF0000) >> 16);
	return x;
}

uint64_t grev64(uint64_t x, int k)
{
	if (k &  1) x = ((x & 0x5555555555555555ull) <<  1) | ((x & 0xAAAAAAAAAAAAAAAAull) >>  1);
	if (k &  2) x = ((x & 0x3333333333333333ull) <<  2) | ((x & 0xCCCCCCCCCCCCCCCCull) >>  2);
	if (k &  4) x = ((x & 0x0F0F0F0F0F0F0F0Full) <<  4) | ((x & 0xF0F0F0F0F0F0F0F0ull) >>  4);
	if (k &  8) x = ((x & 0x00FF00FF00FF00FFull) <<  8) | ((x & 0xFF00FF00FF00FF00ull) >>  8);
	if (k & 16) x = ((x & 0x0000FFFF0000FFFFull) << 16) | ((x & 0xFFFF0000FFFF0000ull) >> 16);
	if (k & 32) x = ((x & 0x00000000FFFFFFFFull) << 32) | ((x & 0xFFFFFFFF00000000ull) >> 32);
	return x;
}

void write_testdata(const char *filename, int xlen, bool bextdep, bool grev)
{
	assert(xlen == 32 || xlen == 64);

	FILE *f = fopen(filename, "w");
	assert(f != nullptr);

	for (int i = 0; i < 1024; i++)
	{
		char op;

		if (!bextdep)
			op = 'g';
		else if (!grev)
			op = "ed"[xorshift32() % 2];
		else
			op = "edg"[xorshift32() % 3];

		int seq = i % 256;

		if (!grev)
			seq += 16;

		if (!bextdep && seq >= 16)
			seq += 32;

		if (xlen == 32)
		{
			const static uint32_t constants32[4] = {
				0x00000000,
				0x00000001,
				0x80000000,
				0xffffffff
			};

			uint32_t a = xorshift32();
			uint32_t b = xorshift32();
			uint32_t r;
			int mode;

			if (seq < 48) {
				op = "ged"[seq / 16];
				a = constants32[seq % 4];
				b = constants32[(seq / 4) % 4];
			}

			switch (op)
			{
			case 'e':
				mode = 0;
				r = bext32(a, b);
				break;
			case 'd':
				mode = 1;
				r = bdep32(a, b);
				break;
			case 'g':
				mode = 2;
				r = grev32(a, b);
				break;
			default:
				abort();
			}

			fprintf(f, "%1x%08x%08x%08x\n", mode, int(r), int(b), int(a));
		}
		else
		{
			const static uint64_t constants64[4] = {
				0x0000000000000000,
				0x0000000000000001,
				0x8000000000000000,
				0xffffffffffffffff
			};

			uint64_t a = xorshift64();
			uint64_t b = xorshift64();
			uint64_t r;
			int mode;

			if (seq < 48) {
				op = "ged"[seq / 16];
				a = constants64[seq % 4];
				b = constants64[(seq / 4) % 4];
			}

			switch (op)
			{
			case 'e':
				mode = 0;
				r = bext64(a, b);
				break;
			case 'd':
				mode = 1;
				r = bdep64(a, b);
				break;
			case 'g':
				mode = 2;
				r = grev64(a, b);
				break;
			default:
				abort();
			}

			fprintf(f, "%1x%016llx%016llx%016llx\n", mode, (long long)(r), (long long)(b), (long long)(a));
		}
	}

	fclose(f);
}

int main()
{
	write_testdata("testdata32.hex", 32, true, false);
	write_testdata("testdata32g.hex", 32, true, true);
	write_testdata("testdata32go.hex", 32, false, true);
	write_testdata("testdata64.hex", 64, true, false);
	write_testdata("testdata64g.hex", 64, true, true);
	write_testdata("testdata64go.hex", 64, false, true);
	return 0;
}

