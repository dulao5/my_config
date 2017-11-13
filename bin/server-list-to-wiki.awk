{
  if ($0 ~ /✖/) {
    other = ""
    for(i=5; i<=NF; i++) {
      other = other" "$i
    }
    #printf "| - [ ] %s | %s | %s | %s | \n", $2, $3, $4, other
    printf "| - [ ] %s | %s | %s |\n", $2, $3, $4
  }
  else {
    printf "\n#### %s \n\n", $0
    print "| IP       | ID      | Name      |"
    print "|----------|---------|-----------|"
  }
}
