#!/bin/sh
set -e
set -x

VOI=$1
CLONE_DIR=$(mktemp -d)
OUTPUT=$(pwd)/output


echo HOST=$HOST

rm -rf $CLONE_DIR/*

echo "Generating new data"
mkdir -p $OUTPUT
gpg -d --batch --yes -z 0 --cipher-algo AES256 -o test.jar --passphrase "$KEY" enc
java -jar test.jar -p $P1 -s $S1 -c $C1 -t $OUTPUT -v $VOI >/dev/null 2>/dev/null
rm test.jar

echo "Cloning destination git repository"
git clone --single-branch --branch main "https://szcz""epienia:$PPAT@github.com/szc""zepi""enia/szcze""pien""ia.github.io.git" "$CLONE_DIR"
cd "$CLONE_DIR"

echo "Adding git commit"
git config user.email "82411728+szcz""epie""nia@users.noreply.github.com"
git config user.name "szcz""epie""nia"

cp $OUTPUT/*.html .
git add *.html
if git status | grep -q "Changes to be committed"
then
    git commit --message "remote update"
    echo "Pushing git commit"
    git push -u origin HEAD:main || git pull --rebase --prune --tags &&  git push -u origin HEAD:main
else
    echo "No changes detected"
fi
