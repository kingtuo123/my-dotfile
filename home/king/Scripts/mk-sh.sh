#!/bin/bash

if [[ $# -eq 0 ]];then
	echo "Error: require filename"
	exit 1 
fi

filename=$1

if [[ "$filename" =~ [^0-9a-zA-Z._-] ]];then
	echo "Error: unexpected character"
	exit 2
fi

if [[ ${filename##*.} != "sh" ]];then
	filename=${filename}.sh
fi


if [[ -f "$filename" ]];then
	echo "Skip: ${filename@Q} already exist"
else
	echo "Create: ${filename@Q}"
	touch "${filename}" && chmod +x "${filename}"
	echo "#!/bin/bash" >> "${filename}"
fi

