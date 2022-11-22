function getopsdemo {
  reversed=0
  forced=0
  while [[ $# -gt 0 ]]; do
    if [[ $1 == "-r" ]]; then
      reversed=1
      shift
      continue
    elif [[ $1 == "-f" ]]; then
      forced=1
      shift
      continue
    fi
    break
  done

  if [[ $# -lt 1 ]]; then echo "must supply file arg"; return; fi

  # Demo
  if [[ $reversed == 1 ]]; then echo "REVERSED is true"; fi
  if [[ $forced == 1 ]]; then echo "FORCED is true"; fi
  echo "file: $1"
}
