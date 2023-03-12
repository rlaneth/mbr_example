#!/bin/bash
nasm src/demo.asm -o bin/demo
if [[ $1 == "--run" ]]; then
  qemu-system-i386 -fda bin/demo
fi