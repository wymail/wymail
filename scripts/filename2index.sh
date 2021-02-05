#!/usr/bin/env python3

import sys,re

def main():
    for line in sys.stdin:
        filename = line.rstrip().lstrip()
        (rawtitle,) = re.search(r'^\d+-(.+)\.md$', filename).groups()
        title = rawtitle.replace('-', ' ')
        sys.stdout.write('['+title+']')
        sys.stdout.write('(./dist/blog/'+re.sub(r'\.md$', '.html', filename)+')')
        sys.stdout.write('\n')

if __name__=='__main__':
    main()
