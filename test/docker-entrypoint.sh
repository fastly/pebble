#!/bin/sh -x

# Exec sh if no command is provided.
if [ $# -eq 0 ]; then
    exec /bin/sh
fi

# Run the Go command provided as arguments to this script.
# The first argument must correspond to a Go command
# in the ./cmd/ directory. The rest of the arguments
# are passed to the Go command.

# if the first argument is one of the commands in ./cmd/, run it
if [ -d "./cmd/${1}" ]; then
    # This is a debug build with race detection enabled.
    export GORACE="halt_on_error=1" # halt the program on race detection
    exec go run \
        -mod=vendor \
        -race \
        -v \
        ./cmd/${@}
fi

# Otherwise, run it as a shell command
exec "$@"
