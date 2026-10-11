#!/bin/sh

# Shell script to sync input files.

rsync -auEvP --files-from="SyncFileList.txt" /Users/fernst/Library/texmf/tex/latex/ ..
