{
  if ($0 ~ /✖/) {
    printf "%s\t%s\n", $2, $4
  }
  else {
    printf "\t# %s \n", $0
  }
}
