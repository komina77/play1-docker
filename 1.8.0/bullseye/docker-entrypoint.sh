#!/bin/sh

# Execute command or start shell
if [ $# -eq 0 ]; then
    exec /bin/sh
else
    exec "$@"
fi
