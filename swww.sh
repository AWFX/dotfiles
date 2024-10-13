#!/bin/bash

sudo dnf install cargo -y
sudo dnf install lz4 -y
sudo dnf install lz4-devel -y

git clone https://github.com/LGFae/swww.git
cd swww
cargo build --release

sudo cp target/release/swww /usr/bin/swww
sudo cp target/release/swww-daemon /usr/bin/swww-daemon

sudo rm -rf swww
