#!/bin/bash
rm -rf /tmp/myblog_container/*
cp -rp /root/blog-docs/* /tmp/myblog_container/
git add --all
git commit -m "test"
git push -u origin master

