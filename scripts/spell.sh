npm run spellcheck
if [ $? -eq 0 ]; then
    echo YAY
else
    npm run spellcheck:interactive

fi