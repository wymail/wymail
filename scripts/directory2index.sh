#!/usr/bin/env python3

import sys,re

def main():
    for line in sys.stdin:
        dirname = line.rstrip().lstrip()
        title = dirname.replace('-', ' ')
        sys.stdout.write('### ['+title+']')
        sys.stdout.write('('+dirname+'/index.html'+')')
        sys.stdout.write('\n')

if __name__=='__main__':
    main()
