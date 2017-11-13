
function add_bom_to_file() {
  if [ $# -eq 0 ]
  then
    echo usage $0 files ...
    exit 1
  fi

  if [ ! -f "$1" ]
  then
    echo Not a file: "$file" 1>&2
    exit 1
  fi

  if od -N 3 -t x1 $1 |grep 'ef bb bf' >/dev/null 2>&1
  then
    echo "$1 already has BOM"
  else
    echo -n -e "\xef\xbb\xbf" > /tmp/$$.tmp
    cat $1 >>/tmp/$$.tmp
    mv /tmp/$$.tmp $1
    echo "added BOM to file $1"
  fi
}


function add_bom_to_files() {
  for filename in $@
  do
    add_bom_to_file $filename
  done
}

add_bom_to_files $@
