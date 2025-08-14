#!/usr/bin/env bash
set -eu
IFS=$'\n\t'

# ===== Function: Organize Files by Type =====
organize_files() {
    echo "Enter directory path:"
    read -r dir

    if [ ! -d "$dir" ]; then
        echo "Error: Directory not found!"
        return
    fi

    cd "$dir" || return

    # Include non-hidden files only. (If you want hidden files too, uncomment the next line.)
    # files=(.* * .??*)
    for file in *; do
        # skip if no match (when directory empty)
        [ -e "$file" ] || continue

        # skip directories
        if [ -f "$file" ]; then
            # treat dotfiles and files without a dot as "no_ext"
            if [[ "$file" != *.* || "$file" = .* ]]; then
                folder="no_ext"
            else
                ext="${file##*.}"
                # normalize extension to lowercase
                folder="$(tr '[:upper:]' '[:lower:]' <<<"$ext")"
            fi

            mkdir -p -- "$folder"
            # move file safely (overwrite prompt avoided using -n; remove -n if you want replace)
            mv -n -- "$file" "$folder"/ 2>/dev/null || mv -- "$file" "$folder"/
        fi
    done

    echo "✅ Files organized successfully."
}

# ===== Function: Scan Network for Active Hosts =====
scan_network() {
    echo "Enter subnet (examples: '192.168.121.' or '192.168.121.0/24'):"
    read -r subnet

    # determine prefix (first 3 octets + dot)
    prefix=""
    # if user gave CIDR like x.x.x.x/24
    if [[ "$subnet" == */* ]]; then
        base="${subnet%%/*}"
        # extract first three octets
        IFS='.' read -r o1 o2 o3 o4 <<< "$base"
        if [[ -z "$o1" || -z "$o2" || -z "$o3" ]]; then
            echo "Error: Couldn't parse CIDR. Use format x.x.x.x/24 or x.x.x.x/xx."
            return
        fi
        prefix="${o1}.${o2}.${o3}."
    else
        # if user gave a dotted prefix that ends with a dot, accept it
        if [[ "$subnet" =~ ^([0-9]{1,3}\.){3}$ ]]; then
            prefix="$subnet"
        else
            # try to accept a host IP (like 192.168.121.137) and strip the last octet
            if [[ "$subnet" =~ ^([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})\.[0-9]{1,3}$ ]]; then
                prefix="${BASH_REMATCH[1]}."
            else
                echo "Error: Invalid subnet format. Use '192.168.121.' or '192.168.121.0/24' or a host IP like '192.168.121.137'."
                return
            fi
        fi
    fi

    echo "Scanning subnet ${prefix}0/24 ... (this will ping 1..254)"
    # Use xargs for controlled parallelism if available
    seq 1 254 | xargs -n1 -P50 -I{} bash -c "ping -c 1 -W 1 ${prefix}{} >/dev/null 2>&1 && echo 'UP: ${prefix}{}' || true"

    echo "✅ Scan complete."
}

# ===== Main Menu =====
while true; do
    cat <<'MENU'
===== Shell Utility Toolkit =====
1. Organize Files by Type
2. Scan Network for Active Hosts
3. Exit
Enter your choice:
MENU
    read -r choice
    case "$choice" in
        1) organize_files ;;
        2) scan_network ;;
        3) echo "Exiting..."; break ;;
        *) echo "Invalid choice! Please enter 1, 2, or 3." ;;
    esac
done

