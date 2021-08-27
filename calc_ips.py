#!/usr/bin/env python3


import re
import sys
import statistics
from pathlib import Path


def calc_data_average(file_path):
    ips_data_list = []
    fps_data_list = []
    for file in Path(file_path).iterdir():
        file = str(file)
        if not file.endswith("log"):
            continue

        log_content = Path(file).read_text()
        for i in re.split('\n', log_content):
            if "IPS(" not in i:
                continue
            p1 = re.compile(r'IPS[(](.*?)[)]', re.S)
            p2 = re.compile(r'FPS[(](.*?)[)]', re.S)
            ips_data = re.findall(p1, i)
            fps_data = re.findall(p2, i)
            ips_data_list.append(float(ips_data[0]))
            fps_data_list.append(float(fps_data[0]))

    del(ips_data_list[0])
    del(fps_data_list[0])
    print("IPS: " + str(statistics.mean(ips_data_list)))
    print("FPS: " + str(statistics.mean(fps_data_list)))


def demo():
    if len(sys.argv) < 2:
        print("Warning: please specify a directory!")
        sys.exit(1)
    file_path = sys.argv[1]
    calc_data_average(file_path)


if __name__ == "__main__":
    demo()
