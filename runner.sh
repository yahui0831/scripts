#!/usr/bin/env bash

CONFIG_TEMPLATE=$1
CNT=$2
V2X=$3
PY1=$4
PY2=$5
LOG_DIR=$6


CONFIG_DIR=""

gen_random_str() {
	tr -dc A-Za-z0-9 </dev/urandom | head -c $1 ; echo ''
}

gen_random_json() {
	random_str=$(gen_random_str 13)
	filename=$(basename $CONFIG_TEMPLATE .json)_$1.json
	jq --arg rs0 "$random_str" \
		--arg rs1 "sensors/$random_str" \
		--arg rs2 "relayanalytics/$random_str" \
		'.Camera[0].sensor = $rs0 |
		.Camera[0].mqtt_topic_sensors = $rs1 |
		.Camera[0].mqtt_topic_analytics = $rs2' \
		$CONFIG_TEMPLATE > $CONFIG_DIR/$filename
	
}

# Parse config files directory
CONFIG_DIR=$(dirname $CONFIG_TEMPLATE)

# Generate $CNT json files
for i in {1..17}; do
	gen_random_json $i
done

for f in $(ls $CONFIG_DIR/*.json); do
	fn=$(basename $f .json)
	eval "$V2X -c $f" &> $LOG_DIR/v2x_$fn.log &
	ss=$(jq .Camera[0].sensor $f)
	st=$(jq .Camera[0].mqtt_topic_analytics $f)
	eval "$PY1 -s $ss -t $st &> $LOG_DIR/py1_$fn.log &"
	eval "$PY2 -s $ss -t $st &> $LOG_DIR/py2_$fn.log &"
done
