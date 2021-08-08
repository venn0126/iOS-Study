
echo "##################"
echo "Start update version"

# update version 
agvtool new-marketing-version $1

echo "End update version"
echo "##################"


echo "##################"
echo "Start update build"

# update build
agvtool new-version -all $2

echo "End update build"
echo "##################"