#!/bin/bash

dir="$1"

curdate=$(date +%Y:%m:%d:::%T)
png=".png"
filename=$curdate$png
fulllocation=$dir$filename
scrot "$fulllocation" --select

printf "\\\\begin{figure}[h]\n"
printf "\t\\includegraphics[width=\\\\textwidth]{%s}\n" "$curdate"
printf "\t\\centering\n"
printf "\\\\end{figure}\n\n"

# change this to wait for a new file to appear and only then output the file name
#exa "$dir" --sort newest | head -n1
