#include <stdio.h>

int ke(v)
	int v;
{
	unsigned int c;
	for(c=0;v;++c) {
		v &= v-1;
	}
	return c;
}

int st(v)
	int v;
{
	char* s;
	return 0;
}

int main(void) {
	++1;
}
