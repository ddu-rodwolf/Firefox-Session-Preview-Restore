#!/usr/bin/env python3
import lz4.block
import signal
import sys


# Gracefully handle broken pipe
signal.signal(signal.SIGPIPE, signal.SIG_DFL)


def decode_jsonlz4(path):
    with open(path, 'rb') as f:
        magic = f.read(8)
        if magic != b'mozLz40\0':
            raise Exception("Invalid file header.")
        data = f.read()
        print(lz4.block.decompress(data).decode('utf-8'))


if __name__ == "__main__": # for scalability, ie. modularity, safety, and reusability, ie. from decode_jsonlz4 import decode_session|
    if len(sys.argv) != 2:
        print("Usage: decode_jsonlz4.py <session_file>")
        sys.exit(1)
    decode_jsonlz4(sys.argv[1])
