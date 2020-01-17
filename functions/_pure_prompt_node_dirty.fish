function _pure_prompt_node_dirty
    set --local node_version_ok
    set --local node_dirty_symbol
    set --local node_dirty_color

    # node version in `.nvmrc`
    set --local repo_root (command git rev-parse --show-toplevel 2>/dev/null)
    set --local nvmrc_path "$repo_root/.nvmrc"
    set --local nvmrc_version (test -e "$nvmrc_path"; and head -n 1 "$nvmrc_path")

    # version from `node -v`
    set --local node_version (node -v | head -n 1 | sed "s/^v//g")

    # major version
    if test -z "$node_version_ok"
        set --local node_version_major (echo "$node_version" | sed -E "s/([0-9]+)\.*[0-9]*\.*[0-9]*/\1/")
        if test "$node_version_major" = "$nvmrc_version"
            set node_version_ok "true"
        end
    end

    # current node version's codename from `nvm ls`
    if test -z "$node_version_ok"
        set --local node_version_code (nvm ls | grep "$node_version" \
            | sed "s/[0-9]//g" \
            | sed "s/\.//g" \
            | sed "s/[()]//g" \
            | sed "s/ //g" \
            | sed "s/\/current//g"
        )
        if test "$node_version_code" = "$nvmrc_version"
            set node_version_ok "true"
        end
    end

    # full version
    if test -z "$node_version_ok"
        if test "$node_version" = "$nvmrc_version"
            set node_version_ok "true"
        end
    end

    # flag still not set: invalid version
    if test -z "$node_version_ok"
        set node_dirty_symbol "$pure_symbol_node_dirty"
        set node_dirty_color (_pure_set_color $pure_color_node_dirty)
    end

    echo "$node_dirty_color$node_dirty_symbol"
end
