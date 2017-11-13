{
  if ($0 ~ /✖/) {
    other = ""
    for(i=5; i<=NF; i++) {
      other = other" "$i
    }
    printf "  \"%s\",\t# %s  %s\n", $2, $3, $4
  }
  else {
    printf "  # %s \n", $0
  }
}
