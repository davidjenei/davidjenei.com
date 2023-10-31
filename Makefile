SITE=davidjenei.com

#################################################################################
# HTML PAGES
#################################################################################

INDEX=docs/index.html
RESUME=docs/resume.html
RESUME_PRIVATE=docs/resume-private.html
RESUME_PUBLIC=docs/resume-public.html

HTMLS=$(INDEX) $(RESUME) $(RESUME_PRIVATE) $(RESUME_PUBLIC) \
	docs/blog.html docs/radar.html docs/notes.html docs/tags.html

POST_HTMLS=$(patsubst blog/%.md,docs/blog/%.html,$(wildcard blog/*.md))
NOTES_HTMLS=$(patsubst notes/%.md,docs/notes/%.html,$(wildcard notes/*.md))
TAG_HTMLS=$(patsubst tags/%.md,docs/tags/%.html,$(wildcard tags/*.md))

.PHONY: all
all : $(HTMLS) $(POST_HTMLS) $(NOTES_HTMLS) $(TAG_HTMLS)

#################################################################################
# MARKDOWN TO HTML
#################################################################################

DATE_STR != date "+%B %d, %Y"
LOWDOWN_ARGS= -Thtml \
	--html-no-skiphtml \
	--html-no-escapehtml \
	--html-no-owasp \
	--html-no-num-ent \
        -mdate="${DATE_STR}"

docs/%.pre: %.md | docs
	@cat $< | sed 's/\.md/.html/g' | lowdown -o $@ $(LOWDOWN_ARGS)

docs:
	@mkdir -p $(DOC_DIRS)

#################################################################################
# BUILD TAGS
#################################################################################

NOTES=$(wildcard notes/*.md)
TAGS=$(shell grep -oPh '^tags:\s*\K.*' notes/*.md	 \
        | tr -d '#'					 \
        | tr ' ' '\n'					 \
        | sort -u)

tags:
	@mkdir $@

tags/tag_%.md: $(NOTES) | tags
	@echo "title: #$*" > $@
	@echo >> $@
	@echo "# Notes about #$*" >> $@
	@echo >> $@
	@for file in $$(grep -l "^tags:.*#$*\b" notes/*.md); do			\
		TITLE=$$(grep -oP "^title: \K.*" $${file} || echo $${file});	\
		DESC=$$(grep -oP "^description: \K.*" $${file});		\
		WORDS=$$(cat $${file} | wc -w);					\
		DATE=$$(stat --format="%y" $${file} | cut -d' ' -f1);		\
		printf "* [%s](../$${file})\n"					\
			"$$TITLE" >> $@;					\
		echo >> $@; 							\
		printf "\t *%s%s words · %s*\n"					\
			"$$DESC$${DESC:+ · }"					\
			"$$WORDS" 						\
			"$$DATE"						\
			>> $@ ;							\
		echo >> $@;							\
    	done

tags.md: $(NOTES)
	@echo "Building tags.md..."
	@echo > $@
	@$(foreach tag,$(TAGS), 	\
		echo -n "* [$(tag)](tags/tag_$(tag).md)\t" >> $@; \
		grep -o "^tags:.*#$(tag)\b" notes/*.md | wc -l >> $@; \
	)

.PHONY:
gen-tags: tags.md $(patsubst %,tags/tag_%.md,$(TAGS))

#################################################################################
# BUILD HTML
#################################################################################

HTML=fragments/html.fragment
NAV=fragments/nav.fragment
HEADER=fragments/header.fragment
FOOTER=fragments/footer.fragment
BODY=fragments/body.fragment
HTML_END=fragments/html-end.fragment

define html_envelope
	@TITLE="$(shell grep -oP '^title:\s*\K.*' $(1) 2>/dev/null) - $(SITE)" envsubst < $(HTML) > $@
	@cat $2 | envsubst '$$PHONE' >> $@
	@cat $(HTML_END) >> $@
	tidy --tidy-mark no -q -i -m $@
endef

DOC_DIRS=docs/tags docs/notes docs/blog

$(DOC_DIRS):
	mkdir -p $@

docs/notes.html: docs/notes.pre docs/tags.pre
	$(call html_envelope, notes.md, fragments/body-tags.fragment $(NAV) $^ $(FOOTER))

docs/resume-%.html: docs/resume.pre fragments/resume-%.fragment
	$(call html_envelope, resume.md, $(BODY) fragments/resume-$*.fragment docs/resume.pre)

$(INDEX): docs/index.pre $(HTML) $(NAV) $(HEADER) $(FOOTER) $(HTML_END)
	$(call html_envelope, index.md, $(NAV) $(BODY) $(HEADER) $< $(FOOTER))

$(RESUME): docs/resume.pre $(HTML) $(NAV) $(HEADER) $(FOOTER) $(HTML_END)
	$(call html_envelope, resume.md, $(BODY) $(NAV) $(HEADER) $< $(FOOTER))

docs/tags/%.html: docs/tags/%.pre $(HTML) $(NAV) $(FOOTER) $(HTML_END) | $(TAGS_DIR)
	$(call html_envelope, tags/$*.md, fragments/body-tag.fragment $(NAV) $< $(FOOTER))

docs/%.html: docs/%.pre $(HTML) $(NAV) $(FOOTER) $(HTML_END)
	$(call html_envelope, $*.md, $(BODY) $(NAV) $< $(FOOTER))

#################################################################################
# TASKS
#################################################################################

.PHONY: clean
clean:
	- @rm $(HTMLS) $(POST_HTMLS) $(NOTES_HTMLS) $(TAG_HTMLS)

.PHONY: publish
publish: all
	rsync -azh docs/ style.css profile.jpg $(SITE):~/static

.PHONY: help
help:
	@echo "usage: make [OPTIONS] <target>"
	@echo "  Options:"
	@echo "    > PHONE Set phone number for resume"
	@echo "Targets:"
	@echo "  all: Build /notes, /blog and the index pages"
	@echo "  publish: Upload html docs to the server"
	@echo "  gen-tags: Create tag pages"
	@echo "  $(RESUME_PRIVATE): Build resume with phone number"
	@echo "  $(RESUME_PUBLIC): Build resume without phone number"

