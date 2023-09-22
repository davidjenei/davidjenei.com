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

DOCS_DIR=docs
NAV=nav.fragment
HEADER=header.fragment
RESUME_HEADER=resume.fragment
FOOTER=footer.fragment
DATE=date.fragment
DATE_STR != date "+%d %B %Y"

INDEX=docs/index.html
RESUME=docs/resume.html
RESUME_PRIVATE=docs/resume-private.html
RESUME_PDF=docs/resume-pdf.html
CV=docs/david-jenei-cv.pdf
CSS=style.css
PAGES=$(INDEX) $(RESUME) $(RESUME_PRIVATE) $(RESUME_PDF) docs/blog.html docs/radar.html docs/notes.html
POSTS=$(patsubst blog/%.md,docs/blog/%.html,$(wildcard blog/*.md))
NOTES=$(patsubst notes/%.md,docs/notes/%.html,$(wildcard notes/*.md))

all : $(PAGES) $(CV) $(POSTS) $(NOTES)

$(DOCS_DIR):
	mkdir -p $(@)

docs/%.html : $(NAV) %.md $(FOOTER)
	mkdir -p $(@D)
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
$(RESUME_PRIVATE) : resume-private.fragment resume.md
$(RESUME_PDF) : resume-public.fragment resume.md

$(RESUME_PRIVATE):
	cat $^ | \
		sed 's/%phone/${PHONE}/g' | \
		lowdown $(LOWDOWN_HTML_OPTIONS) -mcss="style.css" -mtitle="$(TITLE)" -o $@

# TODO: Generate pdf. For now I'll just upload here the manually exported pdf.
$(CV) : davidjenei.pdf
	cp $< $@

clean:
	- rm $(PAGES) $(CV) $(POSTS) $(NOTES)

publish: all
	rsync --rsh='ssh -p30509' -avzh docs/ $(CSS) profile.jpg davidjenei.com:~/static

.PHONY: all clean publish

