#!/usr/bin/env python

def ordered_permutations(letters, length):
    if length == 0:
        yield []
        return
    for l in letters:
        for p in ordered_permutations(letters, length - 1):
            yield [l] + p

if __name__ == '__main__':
    import sys

    letters, length = map(str.strip, open(sys.argv[1]).readlines())
    for perm in ordered_permutations(letters.replace(' ', ''), int(length)):
        print ''.join(perm)
