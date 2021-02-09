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
blog_posts := $(wildcard $(blog_src)/*.md)
blog := $(patsubst $(blog_src)/%.md,$(blog_dist)/%.html,$(blog_posts))

all: $(blog) blog_index profile

clean:
	(rm -fr $(dist_path) || true) && mkdir -p {$(profile_dist),$(blog_dist)}

$(blog_dist)/%.html : $(blog_src)/%.md
	pandoc -f gfm -i $< -t html -o $@

blog_index: $(blog)
	ls $(blog_src) | ./scripts/filename2index.sh | pandoc -f gfm -t html -o $(blog_dist)/index.html

profile: ./README.md
	cat ./README.md > $(profile_dist)/README.md \
		&& pandoc -f gfm -i $(profile_dist)/README.md -t html -o ./index.html

##################################################################################

init-profile-remote:
	(git remote rm $(profile_remote) 2>/dev/null \
		&& git remote add $(profile_remote) $(profile_remote_url)) \
		|| git remote add $(profile_remote) $(profile_remote_url)

deploy-profile:
	git subtree push --prefix $(profile_prefix) $(profile_remote) master --squash

.PHONY: all deploy-profile init-profile-remote clean

# init-profile: init-profile-remote
# 	[[ -d $(profile_dist) ]] \
# 		|| git subtree add --prefix $(profile_dist) $(profile_remote) master -m '🤖 add profile subtree'

# pull-profile: init-profile
# 	git subtree pull --prefix $(profile_dist) $(profile_remote) master -m '🤖 pull profile subtree'
