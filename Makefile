# *Dependencies*
# sudo apt install lowdown

DOCS_DIR=docs/notes docs/blog
NAV=fragments/nav.fragment
HEADER=fragments/header.fragment
RESUME_HEADER_PUBLIC=fragments/resume-public.fragment
RESUME_HEADER_PRIVATE=fragments/resume-private.fragment
FOOTER=fragments/footer.fragment
HTML=fragments/html.fragment
HTML_END=fragments/html-end.fragment
DATE_STR != date "+%B %d, %Y"

INDEX=docs/index.html
RESUME=docs/resume.html
RESUME_PRIVATE=docs/resume-private.html
RESUME_PUBLIC=docs/resume-public.html
CV=docs/david-jenei-cv.pdf
CSS=style.css
PAGES=$(INDEX) $(RESUME) $(RESUME_PRIVATE) $(RESUME_PUBLIC) docs/blog.html docs/radar.html docs/notes.html
POSTS=$(patsubst blog/%.md,docs/blog/%.html,$(wildcard blog/*.md))
NOTES=$(patsubst notes/%.md,docs/notes/%.html,$(wildcard notes/*.md))

$(DOCS_DIR):
	mkdir -p $(@)

docs/%.pre: %.md | $(DOCS_DIR)
	cat $^ | \
		sed 's/\.md/.html/g' | \
		lowdown -o $@ \
		-Thtml \
		--html-no-skiphtml \
		--html-no-escapehtml \
		--html-no-owasp \
		--html-no-num-ent \
	        -mdate="${DATE_STR}"

define html_envelope
	TITLE="$(shell grep -oP '^title:\s*\K.*' $(1))" envsubst < $(HTML) > $@
endef

define html_end
	cat $(HTML_END) >> $@
endef

docs/resume-%.html: docs/resume.pre fragments/resume-%.fragment
	$(call html_envelope,resume.md) &&				\
		envsubst < fragments/resume-$*.fragment >> $@ &&	\
		cat $< >> $@ &&						\
	$(html_end)

$(INDEX): docs/index.pre $(HTML) $(NAV) $(HEADER) $(FOOTER) $(HTML_END)
	$(call html_envelope, about.md) &&				\
	        cat $(NAV) >> $@ &&					\
	        cat $(HEADER) >> $@ &&					\
		cat $< >> $@ &&						\
                cat $(FOOTER) >> $@ &&					\
	$(html_end)

$(RESUME): docs/resume.pre $(HTML) $(NAV) $(HEADER) $(FOOTER) $(HTML_END)
	$(call html_envelope, resume.md) &&				\
	        cat $(NAV) >> $@ &&					\
	        cat $(HEADER) >> $@ &&					\
		cat $< >> $@ &&						\
                cat $(FOOTER) >> $@ &&					\
	$(html_end)

docs/%.html: docs/%.pre $(NAV) $(FOOTER) $(HTML_END)
	$(call html_envelope, $*.md) &&					\
	        cat $(NAV) >> $@ &&					\
		cat $< >> $@ && 					\
                cat $(FOOTER) >> $@ &&					\
	$(html_end)

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
