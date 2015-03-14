.PHONY: all ec2 fc test clean
.PRECIOUS: samples/ortest-fc.ob samples/ortest-ec2.ob samples/ortest-fb.ob samples/ortest-sol.ob

all: ec2 fc fb sol

ec2: openresty-tester.pl
fc: ortest-fc.pl
fb: ortest-fb.pl
sol: ortest-sol.pl

openresty-tester.pl: ortest-ec2.pl
	cp -p $< $@

%.pl: samples/%.ob opsboy
	./opsboy -o $@ $<

%.ob: %.ob.tt
	tpage $< > $@

test: all
	./ortest-ec2.pl check -k --git-pull
	./ortest-fc.pl check -k --git-pull

clean:
	rm -f openresty-tester.pl ortest-*.pl samples/*.ob

grammar-compile:
	perl -Ilib -MOpsBoy::Grammar=compile
