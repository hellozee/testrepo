#!/bin/bash

UPSTREAM_REPO="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/istio/istio.git"
BRANCHES=$(git branch -r | grep -E "release-[0-9]+.[0-9]+$" | cut -d "/" -f 2 )

[[ ! $(git config remote.upstream.url) ]] && git remote add upstream $UPSTREAM_REPO

echo $BRANCHES

for branch in $BRANCHES; do
    git checkout $branch
    git pull upstream $branch --rebase --tags
    git push origin $branch
    echo "Updated $branch"
done

for branch in $BRANCHES; do
    git checkout $branch
    git checkout -b tetrate-$branch
    git rebase $branch
    git rebase hellozee
    git push origin tetrate-$branch
    echo "Update tetrate-$branch"
done