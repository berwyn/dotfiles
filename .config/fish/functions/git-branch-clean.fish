# Defined in /var/folders/jj/wy7hdtkn0j3g978x9dgh3y440000gn/T//fish.Nh16jC/git-branch-clean.fish @ line 1
function git-branch-clean
	for branch in (git branch --merged | grep -v develop)
        echo $branch | tr -d '[:space:]' | xargs git branch -d
    end
end
