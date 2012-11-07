#!/usr/bin/env python

def index_of_all(s, sub):
    i = 0
    while True:
        i = s.find(sub, i)
        if i != -1:
            yield i + 1
            i += 1
        else:
            return

if __name__ == '__main__':
    import sys

    s, t = open(sys.argv[1]).read().split()
    print ' '.join(map(str, index_of_all(s, t)))
