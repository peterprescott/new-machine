
#######################################
# Silence virtual console default beep
#######################################

# Check if the service file exists
if ! sudo systemctl list-unit-files --type=service | grep -q 'silence-console.service'; then
    silencer=$(cat << EOF
[Unit]
Description=Silence virtual console default beep

[Service]
Type=oneshot
Environment=TERM=linux
StandardOutput=tty
TTYPath=/dev/console
ExecStart=/usr/bin/setterm -blength 0

[Install]
WantedBy=multi-user.target
EOF
    )

    sudo tee "/etc/systemd/system/silence-console.service" > /dev/null <<EOT
$silencer
EOT

    sudo systemctl daemon-reload
    sudo systemctl enable silence-console
    sudo systemctl start silence-console

    echo "Service silence-console created and started."
else
    echo "Service silence-console already exists. Skipping."
fi

#######################################

