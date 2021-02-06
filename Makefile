index_path = 'dist/index'

all: init-index-remote init-index pull-index push-index

init-index-remote:
	(git remote rm gh-readme 2>/dev/null \
		&& git remote add gh-readme https://github.com/$(GH_USER)/$(GH_USER).git) \
		|| git remote add gh-readme https://github.com/$(GH_USER)/$(GH_USER).git

init-index: init-index-remote
	[[ -d $(index_path) ]] || git subtree add --prefix $(index_path) gh-readme master --squash -m '🤖 add index subtree'

pull-index: init-index
	git subtree pull --prefix $(index_path) gh-readme master --squash -m '🤖 pull index subtree'

push-index: pull-index
	git subtree push --prefix $(index_path) gh-readme master --squash

.PHONY: all pull-index push-index init-index init-index-remote
