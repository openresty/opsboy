logfiles=$(wildcard ortest/*.log)
jsonfiles=$(patsubst %.log,%.json,$(logfiles))

dirname=$(shell echo html/archive/`date +'%Y-%m-%d'`)

.PHONY: pull parse upload gen

parse: $(jsonfiles)

pull:
	./sync

gen: parse gen-report
	rm html/*.*
	./gen-report ortest
	mkdir -p $(dirname)
	cp main.css html/
	cp html/*.* $(dirname)/

%.json: %.log parse-logs
	./parse-logs -o $@ $<

upload:
	./upload

