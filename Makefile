# *Dependencies*
# sudo apt install lowdown

LOWDOWN_HTML_OPTIONS= \
	-sThtml \
	--html-no-skiphtml \
	--html-no-escapehtml \
	--html-no-owasp \
	--html-no-num-ent \
	-mcss="/style.css" \
	-mphone="${PHONE}" \
	-mdate="${DATE_STR}"

DOCS_DIR=docs/notes docs/blog
NAV=fragments/nav.fragment
HEADER=fragments/header.fragment
RESUME_HEADER=fragments/resume.fragment
FOOTER=fragments/footer.fragment
DATE_STR != date "+%B %d, %Y"

INDEX=docs/index.html
RESUME=docs/resume.html
RESUME_PRIVATE=docs/resume-private.html
RESUME_PDF=docs/resume-pdf.html
CV=docs/david-jenei-cv.pdf
CSS=style.css
PAGES=$(INDEX) $(RESUME) $(RESUME_PRIVATE) $(RESUME_PDF) docs/blog.html docs/radar.html docs/notes.html
POSTS=$(patsubst blog/%.md,docs/blog/%.html,$(wildcard blog/*.md))
NOTES=$(patsubst notes/%.md,docs/notes/%.html,$(wildcard notes/*.md))

$(DOCS_DIR):
	mkdir -p $(@)

docs/%.html : $(NAV) %.md $(FOOTER)
	cat $^ | \
		sed 's/\.md/.html/g' | \
		lowdown $(LOWDOWN_HTML_OPTIONS) -mtitle="davidjenei - $*" > $@

$(INDEX) : TITLE="about"
$(INDEX) : $(NAV) $(HEADER) index.md $(FOOTER) | $(DOCS_DIR)
$(RESUME) : TITLE="resume"
$(RESUME) : $(NAV) $(HEADER) resume.md $(FOOTER)

$(INDEX) $(RESUME) :
	cat $^ | \
		sed 's/\.md/.html/g' | \
		lowdown $(LOWDOWN_HTML_OPTIONS) -mtitle="davidjenei - $(TITLE)" -o $@

$(RESUME_PRIVATE) : TITLE=David Jenei resume
$(RESUME_PRIVATE) : fragments/resume-private.fragment resume.md
$(RESUME_PDF) : fragments/resume-public.fragment resume.md

$(RESUME_PRIVATE):
	cat $^ | \
		sed 's/%phone/${PHONE}/g' | \
		lowdown $(LOWDOWN_HTML_OPTIONS) -mcss="style.css" -mtitle="$(TITLE)" -o $@

# TODO: Generate pdf. For now I'll just upload here the manually exported file.
$(CV) : davidjenei.pdf
	cp $< $@

.PHONY: clean
clean:
	- rm $(PAGES) $(CV) $(POSTS) $(NOTES)

.PHONY: publish
publish: all
	rsync -avzh docs/ $(CSS) profile.jpg davidjenei.com:~/static

.PHONY: help
help:
	@echo "usage: make [OPTIONS] <target>"
	@echo "  Options:"
	@echo "    > PHONE Set phone number for resume"
	@echo "Targets:"
	@echo "  all: Build /notes, /blog and the index pages"
	@echo "  publish: Upload html docs to the server"
	@echo "  $(RESUME_PRIVATE): Build resume with phone number"
	@echo "  $(RESUME_PDF): Build resume without phone number"

.PHONY: all
all : $(PAGES) $(CV) $(POSTS) $(NOTES)
