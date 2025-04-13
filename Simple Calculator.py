file_name = "Simple Calculator"

num1 = (input("Enter the first number: "))

operation = input("Enter +, -, *")

num2 = (input("Enter the second number: "))

if operation == "+":
    result = num1 + num2
    print("{num1} + {num2} = {result}")
if operation == "-":
    result = num1 - num2
    print("{num1} - {num2} = {result}")
if operation == "*":
    result = num1 * num2
    print("{num1} * {num2} = {result}")
