all: index

init-index:
	git subtree add --prefix index gh-readme master --squash

push-index:
	git subtree push --prefix index gh-readme master

.PHONY: all push-index pull-index
