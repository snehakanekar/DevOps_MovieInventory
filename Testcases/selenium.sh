nohup Xvfb :10 -ac &
export DISPLAY=:10
firefox --safe-mode &
python test.py

