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

DOC_DIRS=docs/tags docs/notes docs/blog

.PHONY: all
all : $(HTMLS) $(POST_HTMLS) $(NOTES_HTMLS) $(TAG_HTMLS)

#################################################################################
# MARKDOWN TO HTML
#################################################################################

LOWDOWN_ARGS= -Thtml \
	--html-no-skiphtml \
	--html-no-escapehtml \
	--html-no-owasp \
	--html-no-num-ent

$(DOC_DIRS):
	@mkdir -p $@

docs/%.pre: %.md | $(DOC_DIRS)
	@cat $< | sed 's/\.md/.html/g' | lowdown -o $@ $(LOWDOWN_ARGS)

#################################################################################
# BUILD TAGS
#################################################################################

NOTES=$(wildcard notes/*.md)
RECENT=$(shell ls -t notes/*md | head -n 5)
TAGS=$(shell grep -oPh '^tags:\s*\K.*' notes/*.md	 \
        | tr -d '#'					 \
        | tr ' ' '\n'					 \
        | sort -u)

tags:
	@mkdir $@

tags/tag_%.md: $(NOTES) | tags
	@echo "title: #$*" > $@
	@echo >> $@
	@echo "# Notes tagged with #$* { .tag }" >> $@
	@echo >> $@
	@for file in $$(grep -l "^tags:.*#$*\b" notes/*.md); do			\
		TITLE=$$(grep -oP "^title: \K.*" $${file} || echo $${file});	\
		DESC=$$(grep -oP "^description: \K.*" $${file});		\
		MATURITY=$$(grep -oP "^maturity: \K.*" $${file});		\
		WORDS=$$(cat $${file} | wc -w);					\
		TAGS=$$(grep -oP "^tags: \K.*" $${file});			\
		DATE=$$(stat --format="%y" $${file} | cut -d' ' -f1);		\
		printf "* [%s](../$${file})\n"					\
			"$$TITLE" >> $@;					\
		echo >> $@; 							\
		printf "\t *%s%s%s words · %s*"					\
			"$$DESC$${DESC:+ · }"					\
			"$${MATURITY:+$$MATURITY · }"				\
			"$$WORDS" 						\
			"$$DATE"						\
			>> $@ ;							\
		for _tag in $$TAGS; do                                          \
                       TAG=$$(echo $${_tag} | tr -d '#');                       \
                       echo " · [$${_tag}](../tags/tag_$${TAG}.md)" >> $@;	\
                done;                                                           \
		echo >> $@;							\
    	done

tags.md: $(NOTES)
	@echo "Building tags.md..."
	@echo > $@
	@$(foreach tag,$(TAGS), 	\
		echo -n "* [$(tag)](tags/tag_$(tag).md)\t" >> $@; \
		grep -o "^tags:.*#$(tag)\b" notes/*.md | wc -l >> $@; \
	)

recent.md: $(RECENT)
	@echo "## Recent updates { .recent }" > $@
	@echo >> $@
	@for file in $(RECENT); do			\
		TITLE=$$(grep -oP "^title: \K.*" $${file} || echo $${file});	\
		DESC=$$(grep -oP "^description: \K.*" $${file});		\
		TAGS=$$(grep -oP "^tags: \K.*" $${file});			\
		WORDS=$$(cat $${file} | wc -w);					\
		MATURITY=$$(grep -oP "^maturity: \K.*" $${file});		\
		DATE=$$(stat --format="%y" $${file} | cut -d' ' -f1);		\
		printf "* [%s](../$${file})\n"					\
			"$$TITLE" >> $@;					\
		echo >> $@; 							\
		printf "\t *%s%s%s words*"					\
			"$$DESC$${DESC:+ · }"					\
			"$${MATURITY:+$$MATURITY · }"				\
			"$$WORDS" 						\
			>> $@ ;							\
		for _tag in $$TAGS; do                                          \
                       TAG=$$(echo $${_tag} | tr -d '#');                       \
                       echo -n " · [$${_tag}](tags/tag_$${TAG}.md)" >> $@;      \
                done;                                                           \
		echo " · *$${DATE}*" >> $@;					\
		echo >> $@;							\
	done

.PHONY:
gen-tags: tags.md $(patsubst %,tags/tag_%.md,$(TAGS))

#################################################################################
# BUILD HTML
#################################################################################

define html_envelope
	@TITLE="$(shell grep -oP "^title:\s*\K.*" $(1) 2>/dev/null)"; \
	printf "$(HEAD_HTML)" "$${TITLE}" > $@
	@test -z $(RAW) && echo "$(NAV_HTML)" >> $@ || true
	@echo "$(PREPEND)" >> $@
	@cat $2  >> $@
	@test -z $(RAW) && echo "$(FOOTER_HTML)" >> $@ || true
	@echo "$(BODY_END_HTML)" >> $@

	@tidy --tidy-mark no -q -i -m $@
	@echo "$@ generated"
endef

HEAD_HTML = 									\
	<!DOCTYPE html> 							\
	<html lang="en"> 							\
	<head> 									\
	  <meta charset="utf-8">						\
	  <meta name="viewport" content="width=device-width,initial-scale=1">	\
	  <link rel="stylesheet" href="/style.css">	 			\
	  <title>%s - $(SITE)</title> 						\
	</head> 								\
	<body>

NAV_HTML = 									\
	<nav>									\
 	  <a href="/">About</a> • 						\
	  <a href="/blog">Posts</a> •						\
	  <a href="/notes">Notes</a> •						\
	  <a href="/resume">Resume</a>						\
	</nav>

BODY_END_HTML =									\
	</body>									\
	</html>

FOOTER_HTML =									\
	<footer>								\
	<hr>									\
  	  <a href="http://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a> | \
	  This website was made using markdown,					\
	  <a href="https://kristaps.bsd.lv/lowdown/">lowdown</a>		\
	  and									\
	  <a href="https://www.gnu.org/software/make/">make</a>.		\
	</footer>

BIO_HTML =									\
	<div id="header">							\
	  <div>				 					\
	    <h1>Dávid Jenei</h1>			 		        \
	    $(TITLE_HTML)							\
	    Budapest, HU • 							\
	    <a href="mailto:info@davidjenei.com">info@davidjenei.com</a>	\
	    $(PHONE_HTML)							\
	  </div> 								\
	  <div>									\
	    <img src="./profile.jpg" alt="profile" />				\
	  </div> 								\
	</div>

docs/%.html: docs/%.pre
	$(call html_envelope, $*.md, $^ )

docs/notes.html: docs/notes.pre docs/tags.pre docs/recent.pre

$(INDEX): PREPEND=$(BIO_HTML)
$(RESUME): PREPEND=$(BIO_HTML)

#################################################################################
# RESUMES
#################################################################################

docs/resume-%.html: PREPEND=$(BIO_HTML)
docs/resume-%.html: RAW=yes
docs/resume-%.html: TITLE_HTML=<p>Embedded Software Engineer</p>
docs/resume-%.html: docs/resume.pre
	$(call html_envelope, resume.md, $^)

docs/resume-private.html: PHONE_HTML=• <a href="tel:${PHONE}">${PHONE}</a>

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

