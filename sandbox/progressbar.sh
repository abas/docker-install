#!/bin/bash

pass='number1 number2 number 3 number4 number12 number13 number14 number15 number16'
chk='number15'
result="Not Found!"

echo
echo -n "Working... "
echo -ne "\033[1;32m\033[7m\033[?25l"

for i in $pass ; do
   sleep .4s
   if [ "$i" == "$chk" ]; then
      result="  Found ^_^"
      break
   else
      echo -n " "
   fi
done

echo -ne "\r\033[0m\033[K\033[?25h"
echo $result
echo