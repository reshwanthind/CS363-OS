#!/bin/sh

# Define function with parameters and return value
Hello() {
    echo "Hello $1 $3"
    return 10
}

# Call the function with three arguments
Hello Nookala Sai Reshwanth

# Capture return value (must do this immediately after the call)
ret=$?
echo "Return value is $ret"

# --- optional: capture function output (string) AND its return code ---
out=$(Hello Nookala Sai Reshwanth)
ret_out=$?
echo "Function output: $out"
echo "Return value (when captured): $ret_out"

