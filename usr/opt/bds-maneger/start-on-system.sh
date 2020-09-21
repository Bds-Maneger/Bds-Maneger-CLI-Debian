#!/bin/bash

### BEGIN INIT INFO
# Provides:             bds-maneger
# Required-Start:       $network
# Required-Stop:        
# Default-Start:        2 3 4 5
# Default-Stop:         
# Short-Description:    Minecraft Manager stating Minecraft Bedrock Server
### END INIT INFO

NAME="BDS"
if [[ "$EUID" -ne 0 ]]; then
echo "Você não está executando o service com root ou sudo";exit 1
fi
startsh23(){
        screen -dmS bedrock BDS
}
stopsh23(){
    screen -S bedrock -p 0 -X stuff 'say server in stop en 10 Sec\n'
    sleep 5
    screen -S bedrock -p 0 -X stuff 'say server in stop en 5 Sec\n'
    sleep 1
    screen -S bedrock -p 0 -X stuff 'say server is stopping\n'
	screen -S bedrock -p 0 -X stuff 'stop\n'
    while [ true ]
    do 
        if ! screen -list | grep -q "bedrock"; then
            bds-backup
            break
        else
            echo "Servidor ainda está executando, não fazeremos backup ainda"
        fi
    done
}
restartsh23(){
if ! screen -list | grep -q "bedrock"; then
    echo "Servidor não está ligado ou Não foi possivel reinicia."
else
    	stopsh23
        startsh23
fi
}
case "$1" in 
    start) startsh23 ;;
    stop) stopsh23 ;;
    restart) restartsh23;;
esac
exit 0
