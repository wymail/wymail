all: index-remote init-index pull-index push-index

index-remote:
	(git remote rm gh-readme 2>/dev/null && git remote add gh-readme https://github.com/$(GH_USER)/$(GH_USER).git) || git remote add gh-readme https://github.com/$(GH_USER)/$(GH_USER).git

init-index: index-remote
	[[ -d index ]] || git subtree add --prefix index gh-readme master --squash

pull-index: init-index
	git subtree pull --prefix index gh-readme master --squash -m '🤖 pull index subtree'

push-index: pull-index
	git subtree push --prefix index gh-readme master --squash

.PHONY: all push-index init-index index-remote
