/*
 * Project  Name: None
 * File / Folder: kern.c
 * File Language: c
 * First Created: 2007.08.09 08:49:37
 * Last Modified: 2007.11.01 09:36:52
 */

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
