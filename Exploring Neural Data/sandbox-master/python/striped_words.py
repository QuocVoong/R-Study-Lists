""" Counts "striped" words in text. We consider a word to be "striped" (zebra) 
if vowels and consonants take turns. """

VOWELS = "AEIOUY"
CONSONANTS = "BCDFGHJKLMNPQRSTVWXZ"

import re

def check_striped(w):
    """ Checks if a given w(-ord) is striped according to the task rules. """
    last = 2
    for l in w:
        if l in VOWELS and (last == 1 or last == 2):
            last = 0
        elif l in CONSONANTS and (last == 0 or last == 2):
            last = 1
        else:
            return False
    return True
    
def checkio(text):
    r = 0
    words = re.split('\W+' ,text.upper())

    for w in words:
        if not w.isalpha() or len(w) < 2:
            continue
        r += 1 if check_striped(w) else 0
    return r

print checkio(u"My name is ...") == 3, "All words are striped"
print checkio(u"Hello world") == 0, "No one"
print checkio(u"My name is Valentin123 ...") == 3, "AlphaNumerical"
print checkio(u"A quantity of striped words.") == 1, "Only of"
print checkio(u"Dog, cat,mouse,bird. Human.") == 3, "Dog, cat and human"
