#!/bin/bash

comment=`date +%g%m%d`
rm -rf public
rm -rf /dev/shm/public
git clone -b gh-pages https://github.com/GrazerComputerClub/Blog.git /dev/shm/public
ln -s /dev/shm/public public

#/bin/bash update.sh
rsync -v ../Blog/config.toml config.toml
rsync -rv --delete ../Blog/content/* content
rsync -rv --delete ../Blog/static/* static
hugo

cd public
git status
while true; do
	read -p "Alle Änderungen übertragen? (ja/nein): " jn
	case $jn in
		ja | js ) break;;
		nein | No ) exit;;
		* ) echo "Bitte ja oder nein eingeben.";;
	esac
done
git add *
git commit -a -m ${comment}
git push
rm -rf public
rm -rf /dev/shm/public


