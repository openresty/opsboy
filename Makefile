.PHONY: all test

all: openresty-tester.pl

openresty-tester.pl:
	./opsboy -o openresty-tester.pl samples/openresty-tester.ob

test: all
	./openresty-tester.pl check

