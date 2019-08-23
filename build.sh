#!/bin/sh

set -eux

rm -rf bin
mkdir bin

GOOS=linux GOARCH=amd64 go build -i -o bin/buildkite-agent-linux-amd64 &
GOOS=darwin GOARCH=amd64 go build -i -o bin/buildkite-agent-darwin-amd64 &
GOOS=windows GOARCH=amd64 go build -i -o bin/buildkite-agent-windows-amd64.exe &
wait

mkdir -p "$HOME/buildkite-builds"
./bin/buildkite-agent-darwin-amd64 start \
    --debug \
    --tags "queue=philwo" \
    --build-path "$HOME/buildkite-builds" \
    --health-check-addr "localhost:8080" \
    --token "b07a69d207e083cbfa2382a17a6b082def4cb1ca739beebb82"
