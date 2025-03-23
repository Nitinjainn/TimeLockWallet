echo "enter value for a";
read a
echo "enter value for b";
read b
i=1
while [ "$i" -eq 1 ]
do
echo "Choose one"
echo "1.Add"
echo "2.diff"
echo "3.product"
echo "4.division"
echo "5.reminder"
echo "6.exit"
echo "enter your choice "
read choice 
case $choice in 
1) sum=`expr $a + $b`
echo $sum;;
2) diff=`expr $a - $b`
echo $diff;;
3) mul=`expr $a \* $b`
echo $mul;;
4) divi=`expr $a / $b`
echo $divi;;
5) rem=`expr $a % $b`
echo $rem;;
6) echo "exiting"
i=0;;
*) echo "enter valid input";;
esac
done
