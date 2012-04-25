logfiles=$(wildcard ortest/*.log)
jsonfiles=$(patsubst %.log,%.json,$(logfiles))

.PHONY: pull parse

parse: $(jsonfiles)

pull:
	./sync

gen:
	./gen-report ortest

%.json: %.log parse-logs
	./parse-logs -o $@ $<

