#!/bin/bash

cd /home/s882765/Oppgaver/overblikk/
FILES=*
for f in $FILES
do
   if [[ "$f" == *.py ]]; then
     echo -e "\n$f Syscalls: " >> sammenlikn.tc
     python $f |& strace |& wc -l &>> sammenlikn.tc
     { time python $f ; } 2>> sammenlikn.tc

   elif [[ "$f" == *.java ]]; then
     echo -e "\n$f Syscalls:" >> sammenlikn.tc
     javac $f; jc=${f::-5}
     java $jc |& strace |& wc -l &>> sammenlikn.tc
     { time java $jc ; } 2>> sammenlikn.tc

   elif [[ "$f" == *.c ]]; then
     echo -e "\n$f Syscalls:" >> sammenlikn.tc
     gcc $f
     strace ./a.out |& wc -l &>> sammenlikn.tc
     { time ./a.out ; } 2>> sammenlikn.tc     

   elif [[ "$f" == *.o ]]; then
     echo -e "\n$f Syscalls:" >> sammenlikn.tc
     gcc $f
     strace ./a.out |& wc -l &>> sammenlikn.tc
     { time ./a.out ; } 2>> sammenlikn.tc

   elif [[ "$f" == *.sh ]]; then
     echo -e "\n$f Syscalls:" >> sammenlikn.tc
     strace ./$f |& wc -l &>> sammenlikn.tc
     { time ./$f ; } 2>> sammenlikn.tc

   elif [[ "$f" == *.s ]]; then
     echo -e "\n$f Syscalls" >> sammenlikn.tc
     gcc $f
     strace ./a.out |& wc -l &>> sammenlikn.tc
     { time ./a.out ; } 2>> sammenlikn.tc

   fi
done

cat sammenlikn.tc

fILES=*

for f in $FILES
do
   if [[ "$f" == *.tc ]]; then
   rm $f
   fi
done
