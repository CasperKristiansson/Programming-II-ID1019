# Task 6 - Prime Numbers
Your task is to write a function that returns a list of all prime numbers from 2 to any number p that is given as an argument to the function. You must make three solutions and then investigate whether there is any difference in driving times between the three versions. All versions are an implementation of Eratosthenes sieve.

The first solution
Create a list of all integers between 2 and the given number n. You can use the call Enum.to_list (2..n) to create the list of numbers. The first number in the list is a prime number and it should be the first number in the list that we generate. Now remove all numbers in the rest of the list that are divisible by the first number, use the function belt / 2. If the result is an empty list, we are ready, otherwise you have found the next prime number.

The second solution
As in the first solution, you must create a list of all integers between 2 and the given number n. Also create a list of all prime numbers that you have found, which of course is initially an empty list. Pick the numbers from the list of all numbers, one by one, and check if it is divisible by any of the prime numbers you found. If it is divisible by a prime number, we discard it, but if it is not divisible by any prime number, we have found a new prime number that you add last in the list of prime numbers. When you have no numbers left, you have found all prime numbers.

The third solution
The third solution is identical to the second solution with the difference that when we find a prime number, we first add it to the list of prime numbers. When we have no numbers left, we take and turn the list of prime numbers so that they come in numerical order.