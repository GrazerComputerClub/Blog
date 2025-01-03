echo --- prepare folder cache ---
killall hugo
#rm -rf public
rm -rf /dev/shm/public
ln -s /dev/shm/public public

echo --- rsync local ---
rsync -v ../Blog/config.toml config.toml
rsync -rv --delete ../Blog/content/* content
rsync -rv --delete ../Blog/static/* static

echo --- run hugo ---
hugo
chromium "http://127.0.0.1:1313/" &
hugo -D server
