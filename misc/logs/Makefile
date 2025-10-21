logfiles=$(wildcard ortest/*.log)
jsonfiles=$(patsubst %.log,%.json,$(logfiles))

dirname=$(shell echo html/archive/`date +'%Y-%m-%d'`)

gen: parse gen-report
	mkdir -p html/images
	rm -f html/*.*
	./gen-report ortest
	mkdir -p $(dirname)
	cp main.css html/
	cp new_icon.gif html/images
	cp html/*.* $(dirname)/

.PHONY: pull parse upload gen regen

regen: clean gen

parse: $(jsonfiles)

pull:
	./sync

serve:
	mkdir -p logs/
	nginx -p .

#%.json: %.log parse-logs
%.json: %.log
	./parse-logs -o $@ $<

upload:
	./upload

clean:
	find ortest -name "ortest_2025102*.json" | xargs rm || true
