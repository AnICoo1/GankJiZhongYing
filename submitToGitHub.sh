read -p "输入提交内容：" submitStr
echo "开始提交"
echo "git add *" >> submitToGitHub.sh
echo "git status" >> submitToGitHub.sh
echo "git commit -m \"$submitStr\"" >> submitToGitHub.sh
echo "git pull" >> submitToGitHub.sh
echo "git push" >> submitToGitHub.sh
echo "提交成功"
git add *
git status
git commit -m "全文展开按钮测试"
git pull
git push
