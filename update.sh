rsync -v ../Blog/config.toml config.toml
rsync -rv --delete ../Blog/content/* content
rsync -rv --delete ../Blog/static/* static
hugo
chromium-browser "http://127.0.0.1:1313/Blog/" &
hugo -D server
