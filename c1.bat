echo off
nasm -f bin -o %2 %1

\dd if=/dev/zero of=%3 bs=1474560 count=1
\dd if=%2 of=%3

VBoxManage startvm FreeDDos