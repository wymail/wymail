# P A N B L O K E
#
# Pandoc
#       Blog
#           MaKe

blog_src = ./blog
dist_path = ./dist
blog_dist = ./dist/blog
profile_dist = ./dist/profile
profile_prefix = 'dist/profile'
profile_remote = 'gh-profile'
profile_remote_url = 'https://github.com/$(GH_USER)/$(GH_USER).git'
blog_posts := $(wildcard $(blog_src)/*.md) \
							$(wildcard $(blog_src)/*.org)
blog := $(patsubst $(blog_src)/%.org,$(blog_dist)/%.html, \
				$(patsubst $(blog_src)/%.md,$(blog_dist)/%.html,$(blog_posts)))

all: $(blog) blog_index profile

clean:
	(rm -fr $(dist_path) || true) && mkdir -p {$(profile_dist),$(blog_dist)}

########### BLOG #############

$(blog_dist)/%.html : $(blog_src)/%.md
	pandoc -i $< -t html -o $@ --template ./templates/root.html

$(blog_dist)/%.html : $(blog_src)/%.org
	pandoc -f org -i $< -t html -o $@ --template ./templates/root.html

blog_index: $(blog)
	ls $(blog_src) \
		| ./scripts/filename2index.sh \
		| pandoc -t html -o $(blog_dist)/index.html --template ./templates/root.html

########### PROFILE #############

profile: ./README.md
	bash -c 'cat ./README.md \
		| tee >(pandoc -t gfm -o $(profile_dist)/README.md) \
		| pandoc -t html -o ./index.html --template ./templates/root.html'

########### DEPLOY #############

deploy-profile:
	git subtree push --prefix $(profile_prefix) $(profile_remote) master --squash

########### INIT #############

init-profile-remote:
	(git remote rm $(profile_remote) 2>/dev/null \
		&& git remote add $(profile_remote) $(profile_remote_url)) \
		|| git remote add $(profile_remote) $(profile_remote_url)

init-profile: init-profile-remote
	[[ -d $(profile_dist) ]] \
		|| git subtree add --prefix $(profile_dist) $(profile_remote) master -m '🤖 add profile subtree'

########################

.PHONY: all deploy-profile init-profile-remote init-profile clean
