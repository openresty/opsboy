.PHONY: all test

all: openresty-tester.pl

openresty-tester.pl: samples/openresty-tester.ob opsboy
	./opsboy -o $@ $<

%.ob: %.ob.tt
	tpage $< > $@

test: all
	./openresty-tester.pl check

