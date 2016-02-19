#!/bin/bash
# this script backs up my ~/bin to ~/backups using rsync

cd ~
rsync -avHAXS bin backups
