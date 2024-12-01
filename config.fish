if status is-interactive
    # Commands to run in interactive sessions can go here
end

function ls
	eza --long --binary --git --git-repos --grid
end

function fuz
	fzf
end
