# NOTE for output if run from script the stuff stays private bash or ./
# NOTE for output function order does not matter
# NOTE must be sourced so that funcs are defined

# Unrolls a bash defined function by recursivly expanding functions (only functions, no alias or var)
# first-args functions to be unrolled
# -e excluded funcs
# . unroll.sh buildall testall -e hg git

toUnroll=$(mktemp) #$toUnroll
unrolled=$(mktemp) #$unrolled

if grep "\-e" <(echo "$@") >/dev/null; then
  echo "$@" | grep -oP ".*(?= \-e)" > $toUnroll
else
  echo "$@" > $toUnroll
fi

echo -n "# Unrolling:"
cat $toUnroll

excludes=$(echo "$@" | grep -oP "\-e \K.*")

until diff $unrolled $toUnroll > /dev/null; do 
  cp $toUnroll $unrolled; 
  # set -x
  declare -f $(cat $unrolled) | grep -ow -f <(declare -F | grep -oP "declare -f \K\S*") | sort -u | grep -v -w -f <(echo $excludes | tr " " "\n") | paste -sd " " > $toUnroll;
  # set +x
done

echo "# Unrolled:"
echo -n "# "
cat $unrolled
declare -f $(cat $unrolled)

rm $unrolled $toUnroll

