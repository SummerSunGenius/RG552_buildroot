#!/bin/bash

BR_LAST_MERGE_COMMIT=198bdaadd03f75fe959c21089c354d36c90069bc
git diff --name-only $BR_LAST_MERGE_COMMIT > buildroot.anbernic.diff

cat buildroot.anbernic.diff                              |
    grep -vE '^board/anbernic/'                          | # anbernic board
    grep -vE '^configs/anbernic-'                        | # anbernic defconfig
    grep -vE '^scripts/linux'                            | # anbernic utilities
    grep -vE '^package/anbernic/'                        | # anbernic packages
    grep -vE '^\.gitignore$'
