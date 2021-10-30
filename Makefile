LATEX=xelatex
BIBTEX=bibtex
STEM=main

all : commands

## commands   : show all commands.
commands :
	@grep -E '^##' Makefile | sed -e 's/## //g'

## counts      : get tex word counts
counts :
	find . -type f -name "*.tex" | xargs texcount 2>/dev/null | grep -w "Words in text:" | cut -d : -f 2 | awk '{Total=Total+$$1} END {print "Total is: " Total}'

## pdf        : re-generate PDF
pdf :
	${LATEX} -synctex=1 -interaction=nonstopmode ${STEM}
	makeindex main.nlo -s nomencl.ist -o main.nls
#	${BIBTEX} ${STEM}
	${LATEX} -synctex=1 -interaction=nonstopmode ${STEM}
	${LATEX} -synctex=1 -interaction=nonstopmode ${STEM}

## clean      : clean up junk files.
clean :
	rm -f $$(cat .gitignore)
	rm -f ./*/*.synctex.gz ./*/*.xdv ./*/*.nlo
