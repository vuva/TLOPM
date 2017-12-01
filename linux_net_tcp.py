#!/usr/bin/env python

# -*- coding: utf-8 -*-
import re
import sys
import time
import csv


outputFile1 = open('logs/outage/sender-cwnd-1.csv', 'w', newline='')
outputWriter1 = csv.writer(outputFile1)

outputFile2 = open('logs/outage/sender-cwnd-2.csv', 'w', newline='')
outputWriter2 = csv.writer(outputFile2)


columns = ("seq", "uid", "inode", "local", "remote", "timeout","cwnd")
title = dict()
for c in columns:
    title[c] = c

def split_every_n(data, n):
    return [data[i:i+n] for i in range(0, len(data), n)]

def convert_linux_netaddr(address):

    hex_addr, hex_port = address.split(':')

    addr_list = split_every_n(hex_addr, 2)
    addr_list.reverse()

    addr = ".".join(map(lambda x: str(int(x, 16)), addr_list))
    port = str(int(hex_port, 16))

    return "{}:{}".format(addr, port)

def format_line(data):
    return ("%(seq)-4s %(uid)5s %(local)25s %(remote)25s %(timeout)8s %(inode)8s %(cwnd)8s" % data) + "\n"

def get_info():
    rv = []
    for info in sockets:
        _ = re.split(r'\s+', info)
        if '10.1.1.2' not in convert_linux_netaddr(_[2]):
            continue
        try:
            _tmp = {
                'seq': _[0],
                'local': convert_linux_netaddr(_[1]),
                'remote': convert_linux_netaddr(_[2]),
                'uid': _[7],
                'timeout': _[8],
                'inode': _[9],
                'cwnd':_[15],
            }
            print(_tmp)
            print(_[15])
            if '10.1.2.2' in _tmp['local'] and _[15] != 10:
                outputWriter1.writerow([time.time(), _tmp['local'], _tmp['cwnd']])
            elif '10.1.3.2' in _tmp['local'] and _[15] != 10:
                outputWriter2.writerow([time.time(), _tmp['local'], _tmp['cwnd']])

        except Exception as e:
            print(e)
            print(info)
            continue
        rv.append(_tmp)

    if len(rv) > 0:
        sys.stderr.write(format_line(title))

        for _ in rv:
            sys.stdout.write(format_line(_))


while True:
    try:
        print(time.time())
        with open('/proc/net/tcp') as f:
            lineno = 0
            sockets = []
            for line in f:
                lineno += 1
                if lineno == 1:
                    continue

                sockets.append(line.strip())
        f.close()
        get_info()
        time.sleep(0.1)
    except KeyboardInterrupt:
        outputFile1.close()
        outputFile2.close()
        exit(1)



