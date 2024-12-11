.POSIX: true

SHELL = /bin/sh

CSS ?= styles.css
PANDOC := pandoc
WKHTMLTOPDF := wkhtmltopdf
RM := rm
HTMLFLAGS := --section-divs --css $(CSS) --standalone --from markdown+yaml_metadata_block+link_attributes+definition_lists --to html5
WKFLAGS := -B 4mm -T 10mm -L 0mm -R 4mm -q -s A4 --enable-local-file-access

.PHONY: all
all: CV.de.html CV.de.pdf CV.de.txt CV.en.html CV.en.pdf CV.en.txt

CV.de.html: CV.de.md CV.de.md styles.css
	@$(PANDOC) $(HTMLFLAGS) --metadata title="Lebenslauf" -o CV.de.html -s CV.de.md

CV.en.html: CV.en.md CV.en.md styles.css
	@$(PANDOC) $(HTMLFLAGS) --metadata title="Curriculum Vitae" -o CV.en.html -s CV.en.md

CV.de.pdf: CV.de.html CV.de.md styles.css
	@$(WKHTMLTOPDF) $(WKFLAGS) CV.de.html CV.de.pdf

CV.en.pdf: CV.en.html CV.en.md styles.css
	@$(WKHTMLTOPDF) $(WKFLAGS) CV.en.html CV.en.pdf

CV.de.txt: CV.de.md
	@$(PANDOC) --standalone --from markdown+yaml_metadata_block+smart+link_attributes --to plain -o CV.de.txt -s CV.de.md

CV.en.txt: CV.en.md
	@$(PANDOC) --standalone --from markdown+yaml_metadata_block+smart+link_attributes --to plain -o CV.en.txt -s CV.en.md

.PHONY: clean
clean:
	@$(RM) -f CV.*.html CV.*.pdf CV.*.docx CV.*.txt
