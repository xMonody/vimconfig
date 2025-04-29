#!/usr/bin/bash

cat firefox.asc | gpg --yes --dearmor -o firefox.gpg
cat chrome.asc | gpg --yes --dearmor -o chrome.gpg
cat wezterm.asc | gpg --yes --dearmor -o wezterm.gpg

#cat mysql.asc | gpg --yes --dearmor -o mysql.gpg
#cat llvm.asc | gpg --yes --dearmor -o llvm.gpg
#cat mariadb.asc | gpg --yes --dearmor -o mariadb.gpg

sudo mv *.gpg /etc/apt/keyrings

# deb [signed-by=/etc/apt/keyrings/firefox.gpg] https://packages.mozilla.org/apt mozilla main
# deb [signed-by=/etc/apt/keyrings/chrome.gpg] https://repo.debiancn.org bookworm main
# deb [signed-by=/etc/apt/keyrings/wezterm.gpg] https://apt.fury.io/wez/ * *

# deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-20 main

# deb https://mirrors.ustc.edu.cn/mysql-repo/apt/debian bookworm mysql-8.4-lts
# deb https://mirrors.ustc.edu.cn/mysql-repo/apt/debian bookworm mysql-tools

# http://sfo1.mirrors.digitalocean.com/mariadb/repo/11.8/debian bookworm main

