#!/usr/bin/env bash

# eg: backup.sh dotdata.txt | pigz --fast > ~/backups.tgz
usage() {
    echo "Usage: $(basename "$0") <backup_list>" >&2
    exit 1
}

[[ $# -ne 1 ]] && usage

readarray list < "$1"
excludes=()
nonexist=()
exist=()

for item in "${list[@]}"; do
    eval item="$item"
    if [[ -e $item ]]; then
        exist+=("$item")
    else
        nonexist+=("$item")
    fi
done

echo Final files to backup: >&2
for item in "${exist[@]}"; do
    printf '    %s\n' "$(du -sh "$item" 2>/dev/null)" >&2
done
echo >&2

echo Files not exist: >&2
printf '    %s\n' "${nonexist[@]}" >&2
echo >&2

echo Files patterns ignored: >&2
printf '    %s\n' "${excludes[@]}" >&2
echo >&2

echo Progress: >&2
tar -C "$HOME" -cf - "${exist[@]#$HOME/}" "${excludes[@]/#/--exclude=}" -P |
    pv -s "$(du -csb "${exist[@]}" |
    tail -1 |
    awk '{print $1}')"
