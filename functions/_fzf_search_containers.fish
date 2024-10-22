function _fzf_search_containers --description "Search the output of git log and preview commits. Replace the current token with the selected commit hash."
    set -f selected_ps_lines (
                    # skip header
        docker ps -a | tail -n +2 | \
        _fzf_wrapper --ansi \
            --multi \
            --prompt="Docker>" \
            --query=(commandline --current-token)
        )
    set names (for line in $selected_ps_lines; echo $line; end | awk '{print $NF}')

    commandline --current-token --replace (string join ' ' $names)

    commandline --function repaint
end
