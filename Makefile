SRC = main
OUT = resume

.PHONY: all clean

all:
	latexmk -lualatex -shell-escape -jobname=$(OUT) $(SRC).tex
	latexmk -c -jobname=$(OUT) $(SRC).tex

clean:
	latexmk -C -jobname=$(OUT) $(SRC).tex
