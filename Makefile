SITE=davidjenei.com

#################################################################################
# HTML PAGES
#################################################################################

INDEX_HTML=docs/index.html
NOTES_HTML=docs/notes.html
BLOG_HTML=docs/blog.html
RESUME_HTML=docs/resume.html
RESUME_PRIVATE=docs/resume-private.html
RESUME_PUBLIC=docs/resume-public.html

HTMLS=$(INDEX_HTML) $(RESUME_HTML) $(RESUME_PRIVATE) $(RESUME_PUBLIC) \
	$(BLOG_HTML) docs/radar.html docs/notes.html docs/tags.html

POST_HTMLS=$(patsubst blog/%.md,docs/blog/%.html,$(wildcard blog/*.md))
NOTES_HTMLS=$(patsubst notes/%.md,docs/notes/%.html,$(wildcard notes/*.md))
TAG_HTMLS=$(patsubst tags/%.md,docs/tags/%.html,$(wildcard tags/*.md))

DOC_DIRS=docs/tags docs/notes docs/blog
STYLE=docs/style.css

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

POSTS != ls -t blog/*md
NOTES != ls notes/*.md
RECENT != ls -t notes/*md | head -n 5
TAGS != grep -oPh '^tags:\s*\K.*' notes/*.md	 	\
        | tr -d '\#'				 	\
        | tr ' ' '\n'					\
        | sort -u

tags:
	@mkdir $@

# Use variables instead of command substitution, because parameter expansion
# gives more readable code when dealing with missing metadata

READ_METADATA = \
	TITLE=`grep -oP "^title: \K.*" $${file} || echo $${file}`; 	\
	DESC=`grep -oP "^description: \K.*" $${file}`;			\
	MATURITY=`grep -oP "^maturity: \K.*" $${file}`;			\
	TAGS=`grep -oP "^tags: \K.*" $${file}`;				\
	WORDS=`cat $${file} | wc -w`;					\
	DATE=`stat --format="%y" $${file} | cut -d' ' -f1`;

PRINT_METADATA = \
	$(READ_METADATA)						\
									\
	printf "[%s](../$${file})  "	                         	\
		"$${TITLE}" >> $@;					\
	echo >> $@;							\
	printf "*%s%s%s%s*"						\
		"$${DESC:+$$DESC · }"					\
		"$${MATURITY:+$$MATURITY · }"				\
		"$${WORDS:+$$WORDS words · }" 				\
		"$${DATE}"						\
		>> $@ ;							\
									\
	for _tag in $$TAGS; do                                          \
	       TAG=$$(echo $${_tag} | tr -d '\#');                      \
	       echo -n " · [$${_tag}](../tags/tag_$${TAG}.md)" >> $@;	\
	done;                                                           \
	echo >> $@;							\
	echo >> $@;

PRINT_METADATA_SHORT = \
	$(READ_METADATA)						\
									\
	printf "* [%s](./$${file}) · "					\
		"$${TITLE}" >> $@;					\
									\
	printf "*%s%s*"							\
		"$${MATURITY:+$$MATURITY · }"				\
		"$${WORDS:+$$WORDS words}" 				\
		>> $@ ;							\
									\
	for _tag in $$TAGS; do                                          \
	       TAG=$$(echo $${_tag} | tr -d '\#');                      \
	       echo -n " · [$${_tag}](../tags/tag_$${TAG}.md)" >> $@;	\
	done;                                                           \
	echo >> $@;


tags/tag_%.md: $(NOTES) | tags
	@echo "title: #$*" > $@
	@echo >> $@
	@echo "# Notes tagged with #$* { .tag }" >> $@
	@echo >> $@
	@for file in $$(grep -l "^tags:.*#$*\b" notes/*.md); do		\
		$(PRINT_METADATA)					\
    	done

tags.md: $(NOTES)
	@echo > $@
	@for tag in $(TAGS); do \
		echo -n "* [$${tag}](tags/tag_$${tag}.md)\t" >> $@; 	\
		grep -o "^tags:.*#$${tag}\b" notes/*.md | wc -l >> $@; 	\
	done

posts.md: $(POSTS)
	@echo > $@
	@for file in $(POSTS); do					\
		$(PRINT_METADATA)					\
	done

recent.md: $(RECENT)
	@echo "## Recent updates { .recent }" > $@
	@echo >> $@
	@for file in $(RECENT); do					\
		$(PRINT_METADATA_SHORT)					\
	done

.PHONY:
gen-tags: tags.md $(patsubst %,tags/tag_%.md,$(TAGS))

#################################################################################
# BUILD HTML
#################################################################################

REL_PATH = realpath --relative-to=$$(dirname $@)
GET_TITLE = grep -oP "^title:\s*\K.*" $${file} 2>/dev/null

define html_envelope
	@file="$(1)";		\
	printf "$(HEAD_HTML)" `$(REL_PATH) $(STYLE)` "`$(GET_TITLE)`" > $@

	@echo "$(PREPEND)" >> $@
	@cat $2  >> $@
	@test -z $(RAW) && printf "$(FOOTER_HTML)" `$(REL_PATH) $(INDEX_HTML)`	\
						`$(REL_PATH) $(BLOG_HTML)`	\
						`$(REL_PATH) $(NOTES_HTML)`	\
						`$(REL_PATH) $(RESUME_HTML)`	\
						>> $@ || true

	@echo "$(BODY_END_HTML)" >> $@

	@tidy --tidy-mark no -q -i -m $@
	@echo "$@ generated"
endef

HEAD_HTML = 									\
	<!doctype html> 							\
	<html lang="en" id="top"> 						\
	<head> 									\
	  <meta charset="utf-8">						\
	  <meta name="viewport" content="width=device-width,initial-scale=1">	\
	  <link rel="icon" href="data:,">					\
	  <link rel="stylesheet" href="%s">		 			\
	  <title>%s - $(SITE)</title> 						\
	</head> 								\
	<body>									\
	  <nav>									\
	    <a href="\#menu">Menu &ShortDownArrow;</a>				\
	</nav>									\

BODY_END_HTML =									\
	</body>									\
	</html>

FOOTER_HTML =									\
	<footer role="contentinfo">						\
	  <hr> 									\
	  <h3 id="menu">Navigation</h3>						\
	    <ul>								\
	      <li> <a href="%s">About</a> </li> 				\
	      <li> <a href="%s">Posts</a> </li>					\
	      <li> <a href="%s">Notes</a> </li>					\
	      <li> <a href="%s">Resume</a> </li>				\
	      <li> <a href="\#top">Back to top &uarr;</a>			\
	    </ul>								\
	  <small>								\
  	    The content for this site is 					\
	    <a href="http://creativecommons.org/licenses/by-sa/4.0/">CC BY-SA 4.0</a>. \
	    <br>								\
	    The <a href="https://github.com/davidjenei/davidjenei.com">code for this site</a> is	\
	    <a href="https://github.com/davidjenei/davidjenei.com/blob/main/LICENSE">MIT</a>. \
	    <br>								\
	    Made with markdown,							\
	    <a href="https://kristaps.bsd.lv/lowdown/">lowdown</a>		\
	    and									\
	    <a href="https://www.gnu.org/software/make/">make</a>.		\
	    Inspired by <a href="https://git.sr.ht/~bt/barf">barf</a>.		\
	  </small> 								\
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

docs/blog.html: docs/blog.pre docs/posts.pre

docs/%.html: docs/%.pre
	$(call html_envelope, $*.md, $^ )

docs/notes.html: docs/notes.pre docs/tags.pre docs/recent.pre

$(INDEX_HTML): PREPEND=$(BIO_HTML)
$(RESUME_HTML): PREPEND=$(BIO_HTML)

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
	- rm -r $(DOC_DIRS)

.PHONY: publish
publish: all
	rsync -azh docs/ $(SITE):~/static

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

