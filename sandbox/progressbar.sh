#!/bin/bash

result="Not Found!"

echo
echo -n "Working... "
echo -ne "\033[1;32m\033[7m\033[?25l"

complete=100
for i in {1..100} ; do
   sleep .4s
   if [ "$i" == "$complete" ]; then
      result="  Complete!"
      break
   else
      echo -n " "
   fi
done

echo -ne "\r\033[0m\033[K\033[?25h"
echo $result
echo