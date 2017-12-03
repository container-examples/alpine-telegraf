#!/bin/sh

chmod +x /usr/bin/gosu

echo "Start Telegraf"
/usr/bin/gosu telegraf /usr/bin/telegraf