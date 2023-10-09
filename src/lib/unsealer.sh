#! /usr/bin/env bash

function use_key() {
	local address="$1"
	local key="$2"

	local payload="{
		\"key\": \"${key}\"
	}"

	curl --request POST \
		--header "Content-Type: application/json" \
		--data "${payload}" \
		--max-time "${UNSEALER_REQUEST_TIMEOUT_SECONDS}" \
		"${address}" \
		|| (echo "use_key(): failed with exit status $?"; return 1)
}

function start_unsealing_loop() {
	local address="$1"
	local -n keys="$2"

	local i=1
	while :; do
		echo "This is the attempt number #${i}"

		for key in "${keys[@]}"; do
			local hash="$(get_hash $key)"

			use_key "$address" "$key" \
			&& echo "Key with SHA256 {$hash} successully applied." \
			|| echo "start_unsealing_loop(): failed to apply key {$hash}."

			sleep "${UNSEALER_TIME_BETWEEN_REQUESTS_SECONDS}"
		done

		sleep "${UNSEALER_TIME_BETWEEN_LOOPS_SECONDS}"
		(( i++ ))
	done
}

function get_hash() {
	echo -n "$1" | sha256sum --zero | awk '{print $1}'
}