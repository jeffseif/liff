#! /bin/bash

# Functions

function txt_to_rows {
    while read LINE ; do

        if grep -q '^[A-Z]\{2,\} ' <<< "${LINE}" ; then
            # Word and part o speech!
            IFS='^' read -r WORD PART <<< $(sed 's/^\([A-Z][A-Z ]\+\) (\(.\+\))/\1^\2\n/' <<< "${LINE}") ;
            WORD=$(echo ${WORD} | tr '[:upper:]' '[:lower:]') ;
            PART=$(echo ${PART}) ;
        elif [ ! -z "${WORD}" ] && grep -q '.' <<< "${LINE}" ; then
            # Definition
            DEFN=$(echo ${LINE}) ;
            echo "\"${WORD}\":[\"${PART}\",\"${DEFN}\"]," ;
            WORD='' ;
        fi
    done 
}

function rows_to_dict {
    echo "var DICT = \`{" ;
    while read ROW ; do
        echo "${ROW}" ;
    done | sed '$ s/.$//' ;
    echo "}\`;" ;
}


txt_to_rows | rows_to_dict ;
