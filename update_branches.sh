#!/bin/bash

UPSTREAM_REPO="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/istio/istio.git"
BRANCHES=$(git branch -r | grep -E "origin/release-[0-9]+.[0-9]+$" | cut -d "/" -f 2)

for branch in $BRANCHES; do
    git checkout $branch
    git pull upstream $branch --rebase
    git push origin $branch
    echo "Updated $branch"
done

for branch in $BRANCHES; do
    git checkout -b tetrate-$branch
    git rebase $branch
    git push origin tetrate-$branch
    echo "Update tetrate-$branch"
done