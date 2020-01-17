function _pure_prompt_nvm \
    --description 'Print node version information and whether it is different from .nvmrc'

    if test $pure_enable_nvm != true
        return
    end

    set --local is_git_repository (command git rev-parse --is-inside-work-tree 2>/dev/null)
    set --local has_node (which node)
    if test -n "$is_git_repository" -a -n "$has_node"
        set --local node_prefix "node.js"
        set --local node_color (_pure_set_color $pure_color_node)
        set --local node_prompt "$node_color$node_prefix"
        set node_prompt $node_prompt (_pure_prompt_node_version)(_pure_prompt_node_dirty)
        echo "$node_prompt"
    end
end
