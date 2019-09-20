# Makefile for Latex work

CLASSES = $(wildcard *.cls)
TEXFILE = main.tex
DIAGRAM = $(wildcard *.dia)

.PHONY: clean view

$(TEXFILE:.tex=.pdf): $(TEXFILE) $(CLASSES) $(DIAGRAM:.dia=.pdf)
	pdflatex $(TEXFILE)
# Not very nice hack to get references right
	pdflatex $(TEXFILE)

%.pdf: %.eps
	epstopdf $<

%.eps: %.dia
	dia -e $@ $<

view: $(TEXFILE:.tex=.pdf)
	evince $(TEXFILE:.tex=.pdf)

clean:
	@rm -f \
	$(TEXFILE:.tex=.aux) \
	$(TEXFILE:.tex=.log) \
	$(TEXFILE:.tex=.out) \
	$(TEXFILE:.tex=.toc) \
	$(TEXFILE:.tex=.pdf) \
	$(DIAGRAM:.dia=.pdf) \
	$(DIAGRAM:.dia=.eps)
