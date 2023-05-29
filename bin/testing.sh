function __treemux_create_worktree() {
    if [ -z "$1" ]; then
        branch_name=$(git branch | fzf | sed -e 's/^. //')
    else
        branch_name="$1"
        # When creating a new branch, 99% of the time we want to start over the default branch
        default_branch=$(git symbolic-ref --short refs/remotes/origin/HEAD)
        if [ $? -ne 0 ]; then
            echo "Trying to get default branch failed"
            return 1
        fi

        git branch $branch_name $default_branch

        if [ $? -ne 0 ]; then
            echo "Trying to create $branch_name from $default_branch failed"
            return 1
        fi
    fi

    if [ -z "$branch_name" ]; then
        echo "No branch was selected"
        return 1
    fi

    git_root_directory=$(echo $(git rev-parse --absolute-git-dir) | sed -e "s/\.git.*$//")

    new_directory="$git_root_directory/.wt/$branch_name"
    git worktree add $new_directory $branch_name

    if [ $? -ne 0 ]; then
        echo "Creating worktree $new_directory failed"
        return 1
    fi

    session_name="$(basename $git_root_directory)/$branch_name"

    # before_hook
    cp .env $new_directory

    dmux -c "" "upmi" -s $session_name -w server $new_directory
    dmux -c "v." "clear" -s $session_name -w editor $new_directory

    # force "last saved time" for tmux-continuum, so that it saves next time with new/deleted sessions
    timestamp_in_last_15_min="$((($(date +%s) - 16 * 60)))"
    tmux set-option -g "@continuum-save-last-timestamp" $timestamp_in_last_15_min

    # after_hook

    echo "Worktree $new_directory created as a new tmux session!"
    return 0
}

function __treemux_delete_worktree() {
    git_root_directory=$(echo $(git rev-parse --absolute-git-dir) | sed -e "s/\.git.*$//")

    # add: only list sessions from this repository, based on git root directory name
    session_name=$(tmux list-sessions -F '#{session_name}' | grep '' | grep $(basename $git_root_directory) | fzf)
    if [ -z "$session_name" ]; then
        echo "No worktree was selected"
        return 1
    fi

    branch_name=$(echo $session_name | sed -e "s/.*\///")
    worktree_directory=".wt/$branch_name"

    git worktree remove $worktree_directory
    if [ $? -ne 0 ]; then
        echo "Deleting worktree $worktree_directory failed"
        return 1
    fi

    tmux kill-session -t $session_name

    # force "last saved time" for tmux-continuum, so that it saves next time with new/deleted sessions
    timestamp_in_last_15_min="$((($(date +%s) - 16 * 60)))"
    tmux set-option -g "@continuum-save-last-timestamp" $timestamp_in_last_15_min

    echo "Worktree $worktree_directory and correspondent tmux session were deleted!"
    return 0
}

function __treemux_new_session_from_existing_worktree() {
    branch_name=$(git branch --show-current)

    if [ -z "$branch_name" ]; then
        echo "No branch was detected"
        return 1
    fi

    git_root_directory=$(echo $(git rev-parse --absolute-git-dir) | sed -e "s/\.git.*$//")
    current_directory=$(pwd)
    session_name="$(basename $git_root_directory)/$branch_name"

    dmux -c "" "upmi" -s $session_name -w server $current_directory
    dmux -c "v." "clear" -s $session_name -w editor $current_directory

    echo "New tmux session created from existing branch $branch_name in directory $current_directory!"
    return 0
}
# test this when not inside tmux
treemux() {
    # add guard for non git repositories

	cmd=$1
	shift

	if [ "$cmd" = "create" ] || [ "$cmd" = "c" ]; then
		__treemux_create_worktree $@
	elif [ "$cmd" = "delete" ] || [ "$cmd" = "d" ]; then
		__treemux_delete_worktree $@
	elif [ "$cmd" = "re-session" ] || [ "$cmd" = "rs" ]; then
		__treemux_new_session_from_existing_worktree $@
	elif [ "$cmd" = "run" ] || [ "$cmd" = "r" ]; then
        $@
	else
        echo "Unknown parameters passed to treemux: $cmd $@"
	fi
}
