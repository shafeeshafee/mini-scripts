#!/bin/bash

# Purpose: script to check if a URL is reachable and print its HTTP status code.


# save user input URL a variable
url=$1

# gets HTTP status code
status_code=$(curl -Is "$url" | head -n1 | cut -d' ' -f2)

# message placeholder to display status to user
status=""
# gets first character in status code. 2, in 200. This is to group what is/isn't reachable
code_group=${status_code:0:1}

case $code_group in
    "1")
        status="Reachable (HTTP Status Code: $status_code). Received informational response."
        ;;
    "2")
        status="Reachable (HTTP Status Code: $status_code). Success connecting to website."
        ;;
    "3")
        status="Reachable (HTTP Status Code: $status_code) but redirected. Additional action is needed."
        ;;
    "4")
        status="Unreachable (HTTP Status Code: $status_code). Client error."
        ;;
    "5")
        status="Reachable (HTTP Status Code: $status_code) but there is a server-side error."
        ;;
    *)
        # as in, the site doesn't exist
        status="Error: DNS doesn't resolve given URL to an IP address on domain server."
        ;;
esac

echo "$status"