function _pure_prompt_node \
    --description 'Print Node version information and whether it is different from .nvmrc or .node-version'

    if test $pure_enable_node != true
        return
    end

    set --local has_node (which node)
    if test -z "$has_node"
        return
    end

    set --local project_root (_pure_node_project_root)
    set --local contains_package_file (test -e "$project_root/package.json"; and echo 1)

    if test -n "$contains_package_file"
        set --local node_prefix "node.js"
        set --local node_color (_pure_set_color $pure_color_node)

        set --local node_prompt
        set node_prompt "$node_color$node_prefix"
        set node_prompt $node_prompt (_pure_prompt_node_version)(_pure_prompt_node_dirty)

        echo "$node_prompt"
    end
end
