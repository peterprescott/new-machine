
#######################################
# Silence virtual console default beep
#######################################

# Check if the service file exists
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

# also try this
sudo sed -i 's/#\ set\ bell-style\ none/set\ bell-style\ none' /etc/inputrc

# and this
sudo xset -b off

echo "Service silence-console created and started."
#######################################

