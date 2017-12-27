#!/bin/sh

REMOTE="$1"

# Copy these file to .git/hooks/pre-push and fill these values
COMMIT_PUSHER=
GITHUB_STATUS_TOKEN=
GITHUB_OWNER=
GITHUB_REPO=

while read local_ref COMMIT_SHA REMOTE_REF remote_sha
do

git push --no-verify $REMOTE $COMMIT_SHA:$REMOTE_REF

curl -u $COMMIT_PUSHER:$GITHUB_STATUS_TOKEN https://api.github.com/repos/$GITHUB_OWNER/$GITHUB_REPO/statuses/$COMMIT_SHA -d "{\"state\": \"success\", \"target_url\": \"https://github.com/$GITHUB_OWNER/$GITHUB_REPO/commits\", \"description\": \"This commit was pushed by @$COMMIT_PUSHER.\", \"context\": \"certified-origin/$COMMIT_PUSHER\"}"

done
