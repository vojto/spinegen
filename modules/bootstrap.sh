curl -L -k -o bootstrap.zip "http://twitter.github.com/bootstrap/assets/bootstrap.zip"
rm -rf public/bootstrap
unzip bootstrap.zip -d public
rm bootstrap.zip