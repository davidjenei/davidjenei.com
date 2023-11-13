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
		DATE=$$(stat --format="%y" $${file} | cut -d' ' -f1);		\
		printf "* [%s](../$${file})\n"					\
			"$$TITLE" >> $@;					\
		echo >> $@; 							\
		printf "\t *%s%s%s words · %s*\n"				\
			"$$DESC$${DESC:+ · }"					\
			"$${MATURITY:+$$MATURITY · }"				\
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
	@echo '<!DOCTYPE html>' > $@
	@echo '<html lang="en">' >> $@
	@echo '<head>' >> $@
	@echo '<meta charset="utf-8">' >> $@
	@echo '<meta name="viewport" content="width=device-width,initial-scale=1">' >> $@
	@echo '<link rel="stylesheet" href="/style.css">' >> $@
	@echo "<title>$(shell grep -oP '^title:\s*\K.*' $(1) 2>/dev/null) - $(SITE)</title>" >> $@
	@echo '</head>' >> $@
	@echo '<body>' >> $@
	@test -z $(RAW) && $(nav) || true
	test -n "$(HEADER)" && $(header) || true
	@cat $2 | envsubst '$$PHONE' >> $@
	@test -z $(RAW) && $(footer) || true
	@echo '</body>' >> $@
	@echo '</html>' >> $@
	tidy --tidy-mark no -q -i -m $@
endef

define nav
	echo '<nav>' >> $@ && \
	echo '<a href="/">About</a> •' >> $@ && \
	echo '<a href="/blog">Posts</a> •' >> $@ && \
	echo '<a href="/notes">Notes</a> •' >> $@ && \
	echo '<a href="/resume">Resume</a>' >> $@ && \
	echo '</nav>' >> $@
endef

define footer
	echo '<footer>' >> $@ && \
	echo '<hr>' >> $@ && \
	echo '<a href="http://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a> |' >> $@ && \
	echo 'This website was made using markdown,' >> $@ && \
	echo '<a href="https://kristaps.bsd.lv/lowdown/">lowdown</a>, and <a href="https://www.gnu.org/software/make/">make</a>.' >> $@ && \
	echo '</footer>' >> $@
endef

define header
	echo '<div id="header">' >> $@ && \
	echo '<div id="column">' >> $@ && \
	echo '<h1 id="name">Dávid Jenei</h1>' >> $@ && \
	echo 'Budapest, HU • <a href="mailto:info@davidjenei.com">info@davidjenei.com</a>' >> $@ && \
	echo '</div>' >> $@ && \
	echo '<div id="image">' >> $@ && \
	echo '<img src="./profile.jpg" alt="profile" />' >> $@ && \
	echo '</div>' >> $@ && \
	echo '</div>' >> $@
endef

DOC_DIRS=docs/tags docs/notes docs/blog

$(DOC_DIRS):
	mkdir -p $@

docs/resume-%.html: docs/resume.pre fragments/resume-%.fragment
	$(call html_envelope, resume.md, fragments/resume-$*.fragment docs/resume.pre)

$(INDEX): HEADER=yes
$(RESUME): HEADER=yes

docs/notes.html: docs/notes.pre docs/tags.pre docs/recent.pre
docs/%.html: docs/%.pre
	$(call html_envelope, $*.md, $^ )

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

