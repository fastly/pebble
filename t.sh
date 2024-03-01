#!/bin/sh
# This script runs tests in containers.

# Fail on error, undefined, and uninitialized variables
set -eu

# Run the standalone tests in a container
docker compose \
    --file docker-compose.yml \
    --file test/docker-compose.yml \
    run --build --rm \
    test-standalone

# Run the integration tests in containers
test_services='
    test-integration-chisel
    test-integration-eggsampler
'
for test_service in $test_services; do
    docker compose \
        --file docker-compose.yml \
        --file test/docker-compose.yml \
        run --build --rm --use-aliases \
        "$test_service"
done

# Clean up test containers and volumes
docker compose down --volumes
