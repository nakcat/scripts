#!/bin/bash
# エンターが押されるとLINE Notifyを送る

# tag 定義
LOGGER_TAG='LINE_NOTYFY'
# message 定義
MESSAGE='ボタンが押されたよ'
# 連続実行を抑止する
SLEEP_TIME=5
EXEC_INTERVAL=0
# LINE_TOKENが環境変数に定義されていなければ終了
if [ -z "$LINE_TOKEN" ]; then
    echo 'LINE_TOKEN が定義されていません'
    exit 1
fi

while :
do
    read -p '>>'
    if [ "_$EXEC_INTERVAL" = "_$(($(date +%s) / $SLEEP_TIME))" ]; then
        continue
    else
        EXEC_INTERVAL=$(($(date +%s) / $SLEEP_TIME))
    fi
    CURL_RETURN=$( \
        curl \
            -X POST \
            -H "Authorization: Bearer $LINE_TOKEN" \
            -F "message=$MESSAGE" https://notify-api.line.me/api/notify \
            2> /dev/null \
    )
    logger -t "$LOGGER_TAG" "$CURL_RETURN"
done
