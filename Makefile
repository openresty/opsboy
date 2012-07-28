.PHONY: all ec2 fc test clean
.PRECIOUS: samples/ortest-fc.ob samples/ortest-ec2.ob

all: ec2 fc

ec2: openresty-tester.pl
fc: ortest-fc.pl

openresty-tester.pl: ortest-ec2.pl
	cp -p $< $@

%.pl: samples/%.ob opsboy
	./opsboy -o $@ $<

%.ob: %.ob.tt
	tpage $< > out.ob && mv out.ob $@

test: all
	./ortest-ec2.pl check -k --git-pull
	./ortest-fc.pl check -k --git-pull

clean:
	rm -f openresty-tester.pl ortest-*.pl samples/*.ob

