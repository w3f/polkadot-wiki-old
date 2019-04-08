npm run spellcheck
if [ $? -eq 0 ]; then
    echo YAY
else
    echo "Spell errors found in your files, please see the report above."
fi