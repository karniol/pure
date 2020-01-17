function _pure_node_project_root
    set --local node_project_root (command git rev-parse --show-toplevel 2>/dev/null)

    # could not find git repository root, look for package.json up in the tree
    if test $status -ne 0
        set --local path (pwd)
        set --local found

        for _x in (seq 20)
            set path (realpath $path)

            if test $path = "/"
                break
            end

            set found (test -e "$path/package.json"; and echo 1)

            if test -n "$found"
                set node_project_root $path
                break
            end

            set path $path"/.."
        end
    end

    echo "$node_project_root"
end
