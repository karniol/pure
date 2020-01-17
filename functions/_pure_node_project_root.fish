function _pure_node_project_root
    set --local node_project_root (command git rev-parse --show-toplevel 2>/dev/null)
    if test $status -ne 0
        set --local cwd (pwd)
        set --local found
        for _x in (seq 20)
            if test (pwd) = "/"
                break
            end
            set found (test -e "package.json"; and echo 1)
            if test -n "$found"
                set node_project_root (pwd)
                break
            end
            cd ..
        end
        cd "$cwd"
    end
    echo "$node_project_root"
end