#!/bin/sh

if [ $(pgrep -f -c -x '/bin/sh /opt/update-pubblog.sh') -gt 1 ]; then
	exit 0
fi

mkdir /opt/pubblog-static-staging

wget -O - https://pubblog.in.trilliumstaffing.com/ | diff /opt/pubblog-static-staging/index.html -
if [ $? -eq 0 ]; then
	wget -O - https://pubblog.in.trilliumstaffing.com/images/ | diff /opt/pubblog-static-staging/images/index.html -
	if [ $? -eq 0 ]; then
		exit 0
	fi
fi

rm /opt/pubblog-static-staging/index.html
rm /opt/pubblog-static-staging/images/index.html
wget --mirror --no-parent --page-requisites --adjust-extension -P /opt/pubblog-static-staging --no-host-directories https://pubblog.in.trilliumstaffing.com/ https://pubblog.in.trilliumstaffing.com/images/
cp -R /opt/pubblog-static-staging /opt/pubblog-static-staging-repl
find /opt/pubblog-static-staging-repl -type f -exec sed -i 's/https:\/\/pubblog\.in\.trilliumstaffing\.com\//\/blog\//g' {} + 
rsync -r --delete /opt/pubblog-static-staging-repl/* /var/www/blog/ > /dev/null
rm -r /opt/pubblog-static-staging-repl
