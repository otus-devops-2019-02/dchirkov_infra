#!/bin/bash
cat <<EOF > /etc/systemd/system/puma.service
[Unit]
Description=Puma HTTP Server
After=network.target
[Service]
Type=simple
User=dmitry_n_chirkov
WorkingDirectory=/home/dmitry_n_chirkov/reddit
ExecStart=/usr/local/bin/puma
[Install]
WantedBy=multi-user.target
EOF
systemctl daemon-reload
systemctl enable puma.service
