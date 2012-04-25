logfiles=$(wildcard ortest/*.log)
jsonfiles=$(patsubst %.log,%.json,$(logfiles))

.PHONY: pull parse upload gen

parse: $(jsonfiles)

pull:
	./sync

gen: parse gen-report
	./gen-report ortest

%.json: %.log parse-logs
	./parse-logs -o $@ $<

upload:
	./upload

