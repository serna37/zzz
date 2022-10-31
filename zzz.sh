echo "=========================================================="
echo ">>> (0/7). START"
echo ">>> (1/7). MAKE ~/.uranometria/* (if exist skip, add necronomicon)"
mkdir -p ~/.uranometria/forge/snips ~/.uranometria/stella ~/.uranometria/zodiac
cat - << "EOF" >> ~/.uranometria/necronomicon.md
# note
{{{
	- note1
		> description
}}}

# tasks
{{{
	- [ status] sample title
		> description
}}}

# issue
{{{
	- issue1
		> description
}}}

# static snippets
{{{
	- git
		git status
		git fetch --all
		git pull
		git checkout . && git clean -df && git status
		git status --short
		git status --short | awk '{print $2}' | xargs
		git log -n 3
		git log --no--merges origin/develop..target_branch
		git show commitid
	- kind 1
		some command and so on
		some command and so on
}}}

# archive
{{{
	- 2022-11-03
		- [ status] sample title
			> description
		- [ status] sample title
			> description
}}}

EOF
echo ">>> (2/7). MAKE ~/.uranometria/forge/backup.sh (over write)"
cat - << "EOF" > ~/.uranometria/forge/backup.sh
read -sp "Key: " pass
if [ "silver" != "${pass}" ]; then
  exit
fi
cd ~/.uranometria/zodiac
LIMIT=12
PREFIX=ふしぎなおくりもの
FOLDER_NAME=${PREFIX}`date '+%Y-%m-%d'`
# bk
if [ ! -e ./${FOLDER_NAME} ]; then
  mkdir ${FOLDER_NAME}
fi
cp -f ../necronomicon.md ${FOLDER_NAME}
cp -rf ../stella ${FOLDER_NAME}
cp -rf ../forge ${FOLDER_NAME}
# delete over limit
CNT=`ls -l | grep ^d | wc -l`
if [ ${CNT} -gt ${LIMIT} ]; then
  ls -d */ | sort | head -n $((CNT-LIMIT)) | xargs rm -rf
fi
# chk
ls -ail
EOF
echo ">>> (3/7). MAKE ~/.uranometria/forge/omnibus.sh (over write)"
cat ~/.local/zzz/omnibus.sh > ~/.uranometria/forge/omnibus.sh
chmod 777 ~/.uranometria/forge/omnibus.sh
echo ">>> (4/7). MAKE ~/.uranometria/forge/kill.sh (over write)"
cat - << "EOF" > ~/.uranometria/forge/kill.sh
~/.vim/pack/plugins/start/fzf/uninstall
rm -rf ~/.vim ~/.local
EOF
chmod 777 ~/.uranometria/forge/kill.sh
echo ">>> (5/7). MAKE ~/.vimrc (over write)"
echo "source ~/.local/zzz/.vimrc" > ~/.vimrc
echo ">>> (6/7). MAKE ~/.uranometria/forge/snips/global.json (add write)"
cat ~/.local/zzz/global.json >> ~/.uranometria/forge/snips/global.json
echo ">>> (7/7). END"
echo "=========================================================="
ls -ail ~/.uranometria
