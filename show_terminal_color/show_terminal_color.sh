#!/bin/bash

# 8基础色模式
SGRmode()
{
for((i=30;i<38;i++))
do
    printf "\033[${i}m$\033[0m"
done
printf " <- standard  front color"
echo -e "\033[0m"

for((i=30;i<38;i++))
do
    printf "\033[1;${i}m$\033[0m"
done
printf " <- highlight front color"
echo -e "\033[0m"

for((i=40;i<48;i++))
do
    printf "\033[${i}m \033[0m"
done
printf " <- standard  back  color"
echo -e "\033[0m"
}

# 256色阶模式
GRDmode()
{
for((i=0;i<8;i++))
do
    printf "\033[38;5;${i}m$\033[0m"
done
printf " <- standard front color"
echo -e "\033[0m"
for((i=8;i<16;i++))
do
    printf "\033[38;5;${i}m$\033[0m"
done
printf " <- highlight front color"
echo -e "\033[0m"
for((i=16;i<232;i=i+36))
do
for((j=0;j<36;j++))
do
    k=`expr $j + $i`
    printf "\033[38;5;${k}m$\033[0m"
done
printf " <- [%3d ~ %3d] front color" ${i} ${k}
echo -e "\033[0m"
done
for((i=232;i<256;i++))
do
    printf "\033[38;5;${i}m$\033[0m"
done
printf " <- graylevel front color"
echo -e "\033[0m"

for((i=0;i<8;i++))
do
    printf "\033[48;5;${i}m \033[0m"
done
printf " <- standard  back color"
echo -e "\033[0m"
for((i=8;i<16;i++))
do
    printf "\033[48;5;${i}m \033[0m"
done
printf " <- highlight back color"
echo -e "\033[0m"
for((i=16;i<232;i=i+36))
do
for((j=0;j<36;j++))
do
    k=`expr $j + $i`
    printf "\033[48;5;${k}m \033[0m"
done
printf " <- [%3d ~ %3d] back color" ${i} ${k}
echo -e "\033[0m"
done
for((i=232;i<256;i++))
do
    printf "\033[48;5;${i}m \033[0m"
done
printf " <- graylevel back color"
echo -e "\033[0m"
}

# RGB模式
RGBmode()
{
for((i=0;i<=256;i=i+32))
do
    if [ ${i} -eq 256 ];then
        i=255
    fi
for((j=0;j<=256;j=j+32))
do
    if [ ${j} -eq 256 ];then
        j=255
    fi
for((k=0;k<=256;k=k+32))
do
    if [ ${k} -eq 256 ];then
        k=255
    fi
    printf "\033[38;2;${i};${j};${k}m$\033[0m"
done
done
echo -e "\033[0m"
done

for((i=0;i<=256;i=i+32))
do
    if [ ${i} -eq 256 ];then
        i=255
    fi
for((j=0;j<=256;j=j+32))
do
    if [ ${j} -eq 256 ];then
        j=255
    fi
for((k=0;k<=256;k=k+32))
do
    if [ ${k} -eq 256 ];then
        k=255
    fi
    printf "\033[48;2;${i};${j};${k}m \033[0m"
done
done
echo -e "\033[0m"
done
}

if [ -z "$1" ]; then
    echo -e "PARAM: SGR|RGB|GRD."
elif [ $1 == "RGB" ];then
    RGBmode
elif [ $1 == "GRD" ];then
    GRDmode
elif [ $1 == "SGR" ];then
    SGRmode
else
    echo -e "PARAM: SGR|RGB|GRD."
fi

