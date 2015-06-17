.PHONY: all ec2 fc test clean
.PRECIOUS: samples/ortest-fc.ob samples/ortest-ec2.ob samples/ortest-fb.ob samples/ortest-sol.ob samples/ortest-mac.ob

ec2: openresty-tester.pl

all: ec2 fc fb sol mac

fc: ortest-fc.pl
fb: ortest-fb.pl
sol: ortest-sol.pl
mac: ortest-mac.pl

openresty-tester.pl: ortest-ec2.pl
	cp -p $< $@

%.pl: samples/%.ob opsboy lib/OpsBoy/Grammar.pm
	./opsboy -o $@ $<

%.ob: %.ob.tt
	tpage $< > $@ || (rm $@; exit 1)

test: all
	./ortest-ec2.pl check -k --git-pull
	./ortest-fc.pl check -k --git-pull

clean:
	rm -f openresty-tester.pl ortest-*.pl samples/*.ob

lib/OpsBoy/Grammar.pm: grammar/opsboy.pgx
	perl -Ilib -MOpsBoy::Grammar=compile
