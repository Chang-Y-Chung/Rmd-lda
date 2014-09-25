#!/usr/bin/env python

import sys
import re

def main(fn):
    start = re.compile(r'<pre class="stata"><code>')
    finish = re.compile(r"</code></pre>")

    with open(fn + "_pre.html", "r") as fin, open(fn + ".do", "w") as fout:
        fout.write("/**\n")
        for line in fin:
            fout.write(re.sub(start, "*/\n", re.sub(finish, "\n/**\n", line)))
        fout.write("*/\n")

if __name__ == "__main__":
    main(sys.argv[1])
