DIRECTORIES="app1 module1";
PATH=`pwd`
for i in $DIRECTORIES;
do
    cd $PATH/$i;
    pwd;
    npm install;
    npm run test:single;
done
