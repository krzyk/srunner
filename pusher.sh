#!/bin/bash
set -e
set -x

ALL_VOIS="WIELKOPOLSKIE DOLNOŚLĄSKIE WARMIŃSKO_MAZURSKIE KUJAWSKO_POMORSKIE LUBELSKIE LUBUSKIE MAŁOPOLSKIE PODKARPACKIE OPOLSKIE ŚLĄSKIE PODLASKIE MAZOWIECKIE ŁÓDZKIE ŚWIĘTOKRZYSKIE POMORSKIE ZACHODNIOPOMORSKIE"

USER_ID=$1
USER_COUNT=$2
CLONE_DIR=$(mktemp -d)
OUTPUT=$(pwd)/output

echo "USER_ID=$USER_ID, USER_COUNT=$USER_COUNT"

VOIS=$(echo $ALL_VOIS | awk '{for (i = '$USER_ID'; i <= NF; i+='$USER_COUNT') {print $i}}')
#VOIS=$ALL_VOIS

echo "VOIS = $VOIS";

P_VARNAME=P$1
S_VARNAME=S$1
C_VARNAME=C$1

echo "$P_VARNAME $S_VARNAME $C_VARNAME"

P=${!P_VARNAME}
S=${!S_VARNAME}
C=${!C_VARNAME}

echo HOST=$HOST

rm -rf $CLONE_DIR/*

echo "Generating new data"
gpg -d --batch --yes -z 0 --cipher-algo AES256 -o test.jar --passphrase "$KEY" enc

JAR_DIR=$(pwd)

echo "Cloning destination git repository"
git clone --single-branch --branch main "https://szcz""epienia:$PPAT@github.com/szc""zepi""enia/szcze""pien""ia.github.io.git" "$CLONE_DIR"
cd "$CLONE_DIR"

git config user.email "82411728+szcz""epie""nia@users.noreply.github.com"
git config user.name "szcz""epie""nia"

for VOI in $VOIS; do
    cd $JAR_DIR
    rm -rf $OUTPUT
    mkdir -p $OUTPUT
    java -jar test.jar --credentials $P1:$S1:$C1,$P2:$S2:$C2 -t $OUTPUT -v $VOI --bot-key $BOT_KEY --chat-id $CHAT_ID

    cd "$CLONE_DIR"
    git pull --rebase --prune --tags

    rsync -av $OUTPUT/ .
    git add -v -A
    git add _includes/stats

    if git status | grep -q "Changes to be committed"
    then
        git commit --message "remote update"
        echo "Pushing git commit"
        git push -u origin HEAD:main || git pull --rebase --prune --tags &&  git push -u origin HEAD:main || git pull --rebase --prune --tags &&  git push -u origin HEAD:main
    else
        echo "No changes detected"
    fi

done

