function _pure_prompt_node_dirty
    set --local project_root (_pure_node_project_root)
    set --local node_version_ok

    set --local node_dirty_symbol
    set --local node_dirty_color

    set --local nvmrc "$project_root/.nvmrc"
    if not test -e "$nvmrc"
        # no `.nvmrc`: anything goes
        set node_version_ok 1
    else
        # node version in `.nvmrc`
        set --local nvmrc_version (head -n 1 "$nvmrc" | sed "s/^v//g")
    end

    # current node version
    set --local node_version (node -v | head -n 1 | sed "s/^v//g")
    if test -z "$node_version_ok"
        if test "$node_version" = "$nvmrc_version"
            set node_version_ok 1
        end
    end

    # current node major version
    if test -z "$node_version_ok"
        set --local node_version_major (echo "$node_version" | grep --color=never -o "[[:digit:]]\+" | head -n 1)
        if test "$node_version_major" = "$nvmrc_version"
            set node_version_ok 1
        end
    end

    # current node version codename from `nvm ls`
    if test -z "$node_version_ok"
        set --local node_version_code (nvm ls | grep "$node_version" | grep --color=never -o "[[:alpha:]]\+/[[:alpha:]]\+")
        if test "$node_version_code" = "$nvmrc_version"
            set node_version_ok 1
        end
    end

    # flag still empty, must be invalid version
    if test -z "$node_version_ok"
        set node_dirty_symbol "$pure_symbol_node_dirty"
        set node_dirty_color (_pure_set_color $pure_color_node_dirty)
    end

    echo "$node_dirty_color$node_dirty_symbol"
end
