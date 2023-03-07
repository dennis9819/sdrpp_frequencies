#!/bin/bash

INPUT_FILE=$1
INPUT_PREFIX=$2
OUTPUT_FILE="$3"

touch $OUTPUT_FILE || {
  echo "Cannot write to $OUTPUT_FILE"
  exit 1
}

echo "Input file: $INPUT_FILE"
[ -f $INPUT_FILE ] || {
  echo "Input file not found"
  exit 1
}
echo "Pefix:      $INPUT_PREFIX"
[ -z $INPUT_PREFIX ] && {
  echo "No prefix defined!"
}

echo "fCount:     $(cat $INPUT_FILE | wc -l)"
echo "Output:     $OUTPUT_FILE"
echo "================================="
echo "Generate json for sdr++..."

echo "{\"bookmarks\":{" > $OUTPUT_FILE
while IFS= read -r line; do
  NAME="${INPUT_PREFIX}$(echo $line | cut -d ',' -f 1)"
  FREQ="$(echo $line | cut -d ',' -f 2)"
  echo "\"$NAME\":{\"bandwidth\":12500.0,\"frequency\":$(echo "scale=1 ; $FREQ * 1000000" | bc),\"mode\":0}," >> $OUTPUT_FILE
done <<< "$(cat $INPUT_FILE | sort -n)"
sed '$ s/.$//' -i $OUTPUT_FILE
echo "}}" >> $OUTPUT_FILE
cat $OUTPUT_FILE | jq > $OUTPUT_FILE.tmp
mv $OUTPUT_FILE.tmp $OUTPUT_FILE

echo "Done!"
