# Makefile for Latex work

CLASSES = $(wildcard *.cls)
TEXFILE = main.tex
DIAGRAM = $(wildcard *.dia)
DIAGRAM_IMG = $(wildcard img/*.dia)
IMAGE_SVG = $(wildcard *.svg)
IMAGE_SVG_IMG = $(wildcard img/*.svg)

IMAGE_SVG_ALL := $(IMAGE_SVG) $(IMAGE_SVG_IMG)
IMAGE_SVG_PDF := $(IMAGE_SVG_ALL:.svg=.pdf)

.PHONY: clean view

$(TEXFILE:.tex=.pdf): $(TEXFILE) $(CLASSES) \
	$(DIAGRAM:.dia=.pdf) $(DIAGRAM_IMG:.dia=.pdf) \
	$(IMAGE_SVG:.svg=.pdf) $(IMAGE_SVG_IMG:.svg=.pdf)
	pdflatex $(TEXFILE)
# Not very nice hack to get references right
	pdflatex $(TEXFILE)

# Static Rule, so it is used instead of the implicit eps to pdf rule.
# Requires ImageMagick
$(IMAGE_SVG_PDF): %.pdf : %.svg
	convert $< $@

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
	$(DIAGRAM:.dia=.eps) \
	$(DIAGRAM_IMG:.dia=.pdf) \
	$(DIAGRAM_IMG:.dia=.eps) \
	$(IMAGE_SVG:.svg=.pdf) \
	$(IMAGE_SVG:.svg=.eps) \
	$(IMAGE_SVG_IMG:.svg=.pdf) \
	$(IMAGE_SVG_IMG:.svg=.eps)
