#!/bin/sh

number_two() {
    echo "Reshwanth online ... Over"
}

number_one() {
    echo "Om online ... Over"
    number_two
}

# Start by calling number_one
number_one

