REM Keep cmd window open until script finishes in case of error
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

git add --all
git commit -m "update"
git push

echo "Done"
