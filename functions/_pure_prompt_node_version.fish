function _pure_prompt_node_version
    set --local node_version (node -v | sed s/^v//g) # current node version
    set --local node_color (_pure_set_color $pure_color_node)

    echo "$node_color$node_version"
end
