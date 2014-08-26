#!/usr/bin/env bash
set -eo pipefail; [[ -n "$PLUSHU_TRACE" ]] && set -x

case "$1" in
  git-receive-pack|git-upload-pack|git-upload-archive)
    cmd=$1
    repo=$2
    repo_path=$PLUSHU_ROOT/repos/$repo.git

    # Call hook to announce we're going to run the git command
    PLUSHU_REPO_NAME=$repo GIT_DIR=$repo_path "$PLUSHU_ROOT/lib/plushook" \
      git-command "$cmd" "$repo_path"

    # Actually run the git command
    PLUSHU_REPO_NAME=$repo GIT_DIR=$repo_path "$cmd" "$repo_path"

    # Mark that we handled this command
    export PLUSHU_COMMAND_HANDLED=$1
    ;;
esac