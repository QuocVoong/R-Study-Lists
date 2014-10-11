""" This function returns a string with the transcription of a given number.
Works for number greater than zero less than 1000
"""
FIRST_TEN = ["one", "two", "three", "four", "five", "six", "seven",
             "eight", "nine"]
SECOND_TEN = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen",
              "sixteen", "seventeen", "eighteen", "nineteen"]
OTHER_TENS = ["twenty", "thirty", "forty", "fifty", "sixty", "seventy",
              "eighty", "ninety"]
HUNDRED = "hundred"

def checkio(number):
    r = FIRST_TEN[number/100-1] + " " + HUNDRED + " " if number > 99 else ""

    if number > 9:    
        if (number / 10 % 10) == 1:
            r += SECOND_TEN[number%10]
            return r
        elif (number / 10 % 10) > 1:
            r += OTHER_TENS[number/10%10-2] + " "

    if (number % 10) > 0 and number not in range(10,20):
        r += FIRST_TEN[number%10-1]

    return r.rstrip()

print checkio(int(raw_input('Enter an integer 0 > i > 1000: ')))
