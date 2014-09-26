#!/usr/bin/env python

import sys
import re
import HTMLParser

def main(fn):
    h = HTMLParser.HTMLParser()
    start = re.compile(r'<pre class="stata"><code>')
    finish = re.compile(r"</code></pre>")
    inCode = False

    with open(fn + "_pre.html", "r") as fin, open(fn + ".do", "w") as fout:
        fout.write("/**\n")
        for line in fin:
            if start.search(line) is not None:
                line = re.sub(start, "*/\n", line)
                inCode = True
            elif finish.search(line) is not None:
                line = re.sub(finish, "\n/**\n", line)
                line = h.unescape(line)
                inCode = False
            if inCode: line = h.unescape(line)
            fout.write(line)
        fout.write("*/\n")

if __name__ == "__main__":
    main(sys.argv[1])
