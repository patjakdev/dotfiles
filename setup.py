#!/usr/bin/env python
import os.path
import sys

repo = os.path.abspath(os.path.dirname(__file__))
for f in os.listdir(repo):
    target = os.path.join(repo, f)
    if not target == os.path.abspath(__file__) and not f.startswith("."):
        print target
        print f
        print os.path.join(os.path.expanduser("~"), ".%s-bad" % f)
        os.symlink(target, os.path.join(os.path.expanduser("~"), ".%s-bad" % f))
