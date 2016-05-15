
all: html epub


html: build-dir assets
	pandoc teachers.md -f markdown -t html -s -o build/teachers.html

epub: build-dir assets
	pandoc teachers.md -f markdown -t epub -s -o build/teachers.epub

clean:
	rm -rf build

assets: build-dir
	cp -r assets/ build/

build-dir:
	mkdir -p build

.PHONY: all html epub
