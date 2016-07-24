all: html epub

pdf: build-dir assets
	echo 'Building pdfs...'
	pandoc students.md -fmarkdown-implicit_figures --listings -H listings-setup.tex --latex-engine=xelatex -o build/students.pdf

slides: build-dir assets
	echo 'Building slides...'
	pandoc -s -S -t revealjs students.md -o slides/slides.html
	git clone https://github.com/hakimel/reveal.js.git slides/reveal.js
	cd slides && python -m SimpleHTTPServer

html: build-dir assets
	echo 'Building web pages...'
	pandoc teachers.md -f markdown -t html -s -o build/teachers.html
	pandoc students.md -f markdown -t html -s -o build/students.html

epub: build-dir assets
	echo 'Building ebooks...'
	pandoc teachers.md -f markdown -t epub -s -o build/teachers.epub
	pandoc students.md -f markdown -t epub -s -o build/students.epub

clean:
	rm -rf build

assets: build-dir
	cp -r assets/ build/

build-dir:
	mkdir -p build

.PHONY: all html epub pdf slides
