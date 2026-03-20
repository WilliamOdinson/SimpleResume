LATEXMK := latexmk -pdf -pdflatex="pdflatex -shell-escape %O %S" -interaction=nonstopmode

.PHONY: default clean

default:
	$(LATEXMK) main.tex
	$(LATEXMK) -c
	rm -rf svg-inkscape/

clean:
	$(LATEXMK) -C
	rm -rf svg-inkscape/
