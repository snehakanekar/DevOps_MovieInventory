nohup Xvfb :10 -ac &
export DISPLAY=:10
firefox --safe-mode &
python test.py
cat test_result.log
if [ `cat test_result.log |tail -n 1|grep OK` == "OK" ]; then
    result=100
else
   TotalTestcases=`cat test_result.log |tail -n 3|head -n 1 |cut -f2 -d" "`
   TotalFailure=`cat test_result.log |tail -n 1|cut -d"=" -f2|cut -d")" -f1`
   result=$(echo "scale=2;(($TotalTestcases-$TotalFailure)/$TotalTestcases)*100" | bc -l)

fi
echo "Success percentage: "$result"%"
