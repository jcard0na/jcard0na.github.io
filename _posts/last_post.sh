LAST_POST=`ls -t *.md | head -1`
git add $LAST_POST
vim $LAST_POST
