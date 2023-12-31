#! /usr/bin/env bash

. "./lib.sh"

UNSEALER_VAULT_ADDRESS=http://localhost:8200
UNSEALER_VAULT_UNSEAL_ENDPOINT=/v1/sys/unseal

UNSEALER_REQUEST_TIMEOUT_SECONDS=10
UNSEALER_TIME_BETWEEN_REQUESTS_SECONDS=1
UNSEALER_TIME_BETWEEN_LOOPS_SECONDS=15

KEYS=(
	"09387bae1ed9bbdef9e6e9bf4cff27363b59b15ddec33b0ab312e07c8410cddbb7"
	"2c661e0c5ee7ba30ba04bcedfa98c22d469dff1548ddc331e43527409d421a5648"
	"15a03db5999e999b60b97c2eb9bc04876ef0deaf0253a7fc558b4204971ac987cd"
)

start_unsealing_loop "${UNSEALER_VAULT_ADDRESS}${UNSEALER_VAULT_UNSEAL_ENDPOINT}" "KEYS"
