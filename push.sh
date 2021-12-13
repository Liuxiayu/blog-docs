#!/bin/bash
cp -rp /root/test/blog-docs/* /tmp/myblog_container/
git add --all
git commit -m "test"
git push -u origin master

