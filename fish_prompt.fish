function fish_prompt
    set -l retc "#D1001F"
    test $status = 0; and set retc "#A000FF"

    set -q __fish_git_prompt_showupstream
    or set -g __fish_git_prompt_showupstream auto

    function _nim_prompt_wrapper
        set retc $argv[1]
        set -l field_name $argv[2]
        set -l field_value $argv[3]

        set_color normal
        set_color $retc
        echo -n '─'
        set_color "#A000FF"
        echo -n '['
        set_color normal
        test -n $field_name
        and echo -n $field_name:
        set_color $retc
        echo -n $field_value
        set_color "#A000FF"
        echo -n ']'
    end

    set_color $retc
    echo -n '┬─'
    set_color "#A000FF"
    echo -n '['

    if functions -q fish_is_root_user; and fish_is_root_user
        set_color "#D1001F"
    else
        set_color "#D1001F"
    end

    echo -n $USER
    set_color "#A000FF"
    echo -n @

    if test -z "$SSH_CLIENT"
        set_color "#A000FF"
    else
        set_color "#7202B9"
    end

    echo -n (prompt_hostname)
    set_color "#D1001F"
    echo -n :(prompt_pwd)
    set_color "#A000FF"
    echo -n ']'

    _nim_prompt_wrapper "#D1001F" '' (date +%X)

    function fish_mode_prompt
    end

    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        set -l mode
        switch $fish_bind_mode
            case default
                set mode (set_color --bold "#D1001F")N
            case insert
                set mode (set_color --bold "#A000FF")I
            case replace_one
                set mode (set_color --bold "#A000FF")R
                echo '[R]'
            case replace
                set mode (set_color --bold "#7202B9")R
            case visual
                set mode (set_color --bold "#A000FF")V
        end
        set mode $mode(set_color normal)
        _nim_prompt_wrapper $retc '' $mode
    end

    set -q VIRTUAL_ENV_DISABLE_PROMPT
    or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV
    and _nim_prompt_wrapper $retc V (basename "$VIRTUAL_ENV")

    set -l prompt_git (fish_git_prompt '%s')
    test -n "$prompt_git"
    and _nim_prompt_wrapper $retc G $prompt_git

    type -q acpi
    and test (acpi -a 2> /dev/null | string match -r off)
    and _nim_prompt_wrapper $retc B (acpi -b | cut -d' ' -f 4-)

    echo

    set_color normal
    for job in (jobs)
        set_color $retc
        echo -n '│ '
        set_color "#A000FF"
        echo $job
    end

    set_color normal
    set_color $retc
    echo -n '╰─>'
    set_color "#FFC700"
    echo -n '-(Deum?)>: '
    set_color normal
end
