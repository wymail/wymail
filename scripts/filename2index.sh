#!/usr/bin/env python3

import sys,re

emoji_pattern = re.compile("["
        u"\U0001F600-\U0001F64F"  # emoticons
        u"\U0001F300-\U0001F5FF"  # symbols & pictographs
        u"\U0001F680-\U0001F6FF"  # transport & map symbols
        u"\U0001F1E0-\U0001F1FF"  # flags (iOS)
                           "]+\-", flags=re.UNICODE)

def main():
    for line in sys.stdin:
        filename = line.rstrip().lstrip()
        (rawtitle,) = re.search(r'^\d+-(.+)\.md$', filename).groups()
        title = rawtitle.replace('-', ' ')
        sys.stdout.write('### ['+title+']')
        sys.stdout.write('(https://drojas.github.io/dist/blog/'+emoji_pattern.sub(r'', re.sub(r'\.md$', '.html', filename))+')')
        sys.stdout.write('\n')

if __name__=='__main__':
    main()
