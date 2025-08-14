#!/bin/sh
a=20
b=10

echo "Values: a=$a, b=$b"
echo "Addition (a + b): $((a + b))"
echo "Subtraction (a - b): $((a - b))"
echo "Multiplication (a * b): $((a * b))"
echo "Division (a / b): $((a / b))"
echo "Modulus (a % b): $((a % b))"

c=$b
echo "Assignment (c = b): Now c = $c"

if [ "$a" -eq "$b" ]; then
  echo "a is equal to b"
else
  echo "a is NOT equal to b"
fi

if [ "$a" -ne "$b" ]; then
  echo "a is NOT equal to b"
else
  echo "a is equal to b"
fi

