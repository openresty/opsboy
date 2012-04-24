.PHONY: all test

all: openresty-tester.pl

openresty-tester.pl: samples/openresty-tester.ob opsboy
	./opsboy -o $@ $<

%.ob: %.ob.tt
	tpage $< > out.ob && mv out.ob $@

test: all
	./openresty-tester.pl check

