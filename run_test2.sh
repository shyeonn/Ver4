#!/bin/sh

echo "예제를 시작합니다"

sleep 10 &
sleep 15 &

echo "모든 명령이 병렬로 실행되었습니다"

WORK_PID=`jobs -l | awk '{print $2}'`
wait $WORK_PID

echo "모든 명령이 종료되었습니다"