# wrapper for systemd and SysVinit
# use : 
# service_manager start mysql
function service_manager() {
    local ACTION=$1
    local SERVICE=$2

    if systemctl is-system-running > /dev/null 2>&1; then
        sudo systemctl $ACTION $SERVICE
    else
        sudo service $SERVICE $ACTION
    fi
}

# function for showing a gum multiselect list
# use :
#  multi_select "this is the header" "option1" "option2" "option3" "option4"
# or
#  multi_select "this is the header" "file"
multi_select() {
    local header=$1
    local input=$2
    local options=()
    local filtered_options=()

    # Check if input is existing file 
    if [ -f "$input" ]; then
        mapfile -t options < <(grep -v '^\s*#' "$input" | grep -v '^\s*$')
    else
        # No file, arguments are options
        shift
        options=("$@")
    fi

    # Filter options : only show what is not in composer.json
    for opt in "${options[@]}"; do
        # strip options from package ( --dev)
        pkg_name=$(echo "$opt" | awk '{print $1}')
        
        # Check composer.json
        if [ -f "composer.json" ] && grep -q "\"$pkg_name\"" composer.json; then
            continue 
        else
            filtered_options+=("$opt")
        fi
    done


    while true; do
        selection=$(gum choose --padding "0 1" --no-limit --header "$header" "${filtered_options[@]}")
        # selection=$(gum choose --padding "0 1" --no-limit --header "$header" "${options[@]}")

        [ -z "$selection" ] && return 1

        local count=$(echo "$selection" | grep -c '^')
        # Calculation: 1 (blanc line) + 1 (Selection:) + 1 (blanc line) + selected lines
        local total=$((count + 3))


        echo -e "\nSelectie:\n" >&2
        echo "$selection" | sed 's/^/- /' >&2
        
        if gum confirm "Agreed to install additional packages above ?"; then
            # Erase preview and prompt
            echo -ne "\e[${total}A\e[J" >&2
            echo "$selection"
            return 0
        else 
            # Also erase when not agreed
            echo -ne "\e[${total}A\e[J" >&2
        fi
    done
}

# adds messages to a to do list
# use : add_to_do "message"
add_to_do() {
    touch /tmp/setup_todo_list 2>/dev/null
    chmod 666 /tmp/setup_todo_list 2>/dev/null
    printf -- "  %s\n" "$1" >> /tmp/setup_todo_list
}

# adds packages to a post install list
# use : add_post_install "package"
add_post_install() {
    touch /tmp/post_install_list 2>/dev/null
    chmod 666 /tmp/post_install_list 2>/dev/null
    printf -- "%s\n" "$1" >> /tmp/post_install_list
}

# adds messages to a setup checklist
# use : add_to_check "message"
add_to_check() {
    touch /tmp/setup_checklist 2>/dev/null
    chmod 666 /tmp/setup_checklist 2>/dev/null
    printf -- "  %s\n" "$1" >> /tmp/setup_checklist
}

# adds packages to a install list
# use : add_to_install "package"
add_to_install() {
    touch /tmp/additional_packages 2>/dev/null
    chmod 666 /tmp/additional_packages 2>/dev/null
    printf -- "%s\n" "$1" >> /tmp/additional_packages
}

filter_new_packages() {
    local INSTALLED_FILE="$1"
    local TODO_FILE="$2"
    local PROJECT_NAME="$3" # We hebben de projectnaam nodig om specifiek te filteren

    # 1. Maak een tijdelijke lijst van wat er al is voor DIT project
    # We halen alleen de packages op en strippen de "PROJECT_NAME:" prefix
    local ALREADY_INSTALLED=$(grep "^${PROJECT_NAME}:" "$INSTALLED_FILE" | cut -d':' -f2)

    # 2. Gebruik grep -v (inverse) en -f (file/list) om de TODO lijst te filteren
    # We gebruiken <<< om de variabele als een "file" aan grep te voeren
    if [ -z "$ALREADY_INSTALLED" ]; then
        # Niets geïnstalleerd? Geef de hele todo lijst terug
        cat "$TODO_FILE"
    else
        grep -vFx -f <(echo "$ALREADY_INSTALLED") "$TODO_FILE"
    fi
}