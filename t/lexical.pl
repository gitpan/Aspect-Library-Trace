#!/usr/bin/perl

use strict;
use Aspect;
use Aspect::Library::Trace;

SCOPE: {
	# The foo functions should appear, the bar functions should not
	my $aspect = aspect Trace => call qr/^Foo::foo/;
	Foo::foo1();
	Foo::foo2();
}

Foo::foo2();

BEGIN {
	package Foo;

	sub foo1 {
		foo2();
	}

	sub foo2 {
		bar1();
	}

	sub bar1 {
		foo3();
	}

	sub foo3 {
		return 1;
	}

	1;
}
