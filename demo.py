#!/usr/bin/env python3


import re
import sys
from pathlib import Path


def great_than_5000_v1(text):
    for i in re.split('\n|\t|,', text):
        if "_conf=" not in i:
            continue

        m = re.match('_conf={ \'([0-9]+)\' }', i.strip())
        if m is None:
            continue

        vstr = m.groups()[0]
        try:
            v = int(vstr)
            if v > 5000:
                print(v)
        except Exception as e:
            print(e)


def demo():
    if len(sys.argv) < 2:
        print("Warning: please specify a file!")
        sys.exit(1)

    log_file = Path(sys.argv[1])
    if not log_file.is_file():
        print("Error: file {} does not exist!".format(sys.argv[1]))
        sys.exit(1)

    try:
        great_than_5000_v1(log_file.read_text())
    except Exception as e:
        print(e)


if __name__ == "__main__":
    demo()
