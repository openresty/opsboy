logfiles=$(wildcard ortest/*.log)
jsonfiles=$(patsubst %.log,%.json,$(logfiles))

dirname=$(shell echo html/archive/`date +'%Y-%m-%d'`)

.PHONY: pull parse upload gen

parse: $(jsonfiles)

pull:
	./sync

gen: parse gen-report
	-mkdir -p html/images
	-rm html/*.*
	./gen-report ortest
	mkdir -p $(dirname)
	cp -u main.css html/
	cp -u new_icon.gif html/images
	cp html/*.* $(dirname)/

%.json: %.log parse-logs
	./parse-logs -o $@ $<

upload:
	./upload

