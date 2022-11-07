#/bin/sh

### ============================================================================
### Removes .DS_Store files from Hedge Checkpoint checksum MHL files
###
### Usage:
### sh mhl-scrub.sh <file>
###
### @author NaanProphet
### version 0.1
### ============================================================================

verbose=false

function log () {
    if [[ "$verbose" = true ]]; then
        echo "$@"
    fi
}

CHECKPOINT_FILE=${1}
SEARCH_FOR=.DS_Store
NUM_LINES_BEFORE_MATCH=1
NUM_LINES_AFTER_MATCH=6

matchLines=($(grep "${SEARCH_FOR}" -n "${CHECKPOINT_FILE}" | cut -f1 -d:))

deleteArg=
for i in ${matchLines[@]}
do 
	let start=$i-$NUM_LINES_BEFORE_MATCH
	let end=$i+$NUM_LINES_AFTER_MATCH
	log "$i: [${start},${end}d]";
	
	if [ ! -z "$deleteArg" ]
	then
		deleteArg="${deleteArg};"
	fi
	
	deleteArg+="${start},${end}d"
done

log "${deleteArg}"
sed -i.bak -e "${deleteArg}" "${CHECKPOINT_FILE}"


### Special thanks to:
# https://stackoverflow.com/a/42934324
# https://stackoverflow.com/a/2112496
# https://ryanstutorials.net/bash-scripting-tutorial/bash-arithmetic.php
# https://stackoverflow.com/a/13360181
# https://www.cyberciti.biz/faq/bash-for-loop/
# https://stackoverflow.com/a/39611811
