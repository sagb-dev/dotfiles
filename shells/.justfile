list-recipes:
	just -ul

bios:
	systemctl reboot --firmware-setup

check-battery-conservation-mode:
	#!/usr/bin/env bash
	FILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"
	cat $FILE

battery-conservation-mode:
	#!/usr/bin/env bash
	FILE="/sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode"

	CURRENT_VALUE=$(cat "$FILE")

	# Toggle the value
	if [[ "$CURRENT_VALUE" -eq 0 ]]; then
		NEW_VALUE=1
	else
		NEW_VALUE=0
	fi

	echo "$NEW_VALUE" | sudo tee "$FILE" > /dev/null

	echo "Conservation mode set to $NEW_VALUE"

accelerometer-fix:
	#!/usr/bin/env bash

	# If it fails
	sudo semodule -r iio-sensor-proxy-exception
	sudo ausearch -m avc -c "iio-sensor-prox" --raw | audit2allow -M iio-sensor-proxy-exception
	sudo semodule -i iio-sensor-proxy-exception.pp
	sudo systemctl restart iio-sensor-proxy

amd-5500-laptop-improvement:
	#!/usr/bin/env bash
	# rpm-ostree kargs --append-if-missing="amd_pstate=active"
	rpm-ostree kargs --append-if-missing="amd_pstate=guided"

secure-boot-check:
	mokutil --sb-state

sync-clock:
	#!/usr/bin/env bash

	sudo systemctl enable --now systemd-timesyncd
	sudo systemctl restart systemd-timesyncd

kinoite-setup-flatpak:
	#!/usr/bin/env bash

	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install flathub -y \
		com.brave.Browser \
		com.calibre_ebook.calibre \
		com.discordapp.Discord \
		com.google.Chrome \
		com.logseq.Logseq \
		md.obsidian.Obsidian \
		org.kde.kclock \
		org.kde.kcolorchooser \
		org.kde.kid3 \
		org.keepassxc.KeePassXC \
		org.localsend.localsend_app \
		org.mozilla.Thunderbird \
		org.qbittorrent.qBittorrent \
		org.strawberrymusicplayer.strawberry \
		org.torproject.torbrowser-launcher \
		org.videolan.VLC

	flatpak uninstall --delete-data -y \
		org.kde.elisa \
		org.kde.kmahjongg \
		org.kde.kmines \
		org.kde.kolourpaint \
		org.kde.krdc \
		org.kde.skanpage

	flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
	flatpak override --user --filesystem=xdg-config/gtk-3.0:ro # setup GTK theming for Chrome

	flatpak install flathub-beta net.mkiol.SpeechNote

# org.getmonero.Monero \
# org.mozilla.firefox \

silverblue-setup-flatpaks:
	#!/usr/bin/env bash

	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	flatpak install fedora -y \
		org.fedoraproject.MediaWriter \
		org.gnome.Calculator \
		org.gnome.Calendar \
		org.gnome.Characters \
		org.gnome.Connections \
		org.gnome.Contacts \
		org.gnome.Evince \
		org.gnome.Extensions \
		org.gnome.Logs \
		org.gnome.Loupe \
		org.gnome.Maps \
		org.gnome.NautilusPreviewer \
		org.gnome.Snapshot \
		org.gnome.Weather \
		org.gnome.baobab \
		org.gnome.clocks \
		org.gnome.font-viewer

	flatpak uninstall --delete-data -y \
		org.qbittorrent.qBittorrent \
		org.gnome.TextEditor

	flatpak uninstall -y \
		org.keepassxc.KeePassXC \
		org.localsend.localsend_app

	flatpak install flathub -y \
		app.drey.EarTag \
		app.drey.KeyRack \
		ca.desrt.dconf-editor \
		ca.edestcroix.Recordbox \
		com.belmoussaoui.Decoder \
		com.brave.Browser \
		com.discordapp.Discord \
		com.github.flxzt.rnote \
		com.github.neithern.g4music \
		com.github.tchx84.Flatseal \
		com.github.wwmm.easyeffects \
		com.google.Chrome \
		com.logseq.Logseq \
		com.microsoft.Edge \
		com.usebottles.bottles \
		com.vivaldi.Vivaldi \
		io.frama.tractor.carburetor \
		io.github.celluloid_player.Celluloid \
		io.github.efogdev.mpris-timer \
		io.github.giantpinkrobots.varia \
		io.github.suchnsuch.Tangent \
		md.obsidian.Obsidian \
		org.gnome.Boxes \
		org.gnome.Builder \
		org.gnome.Firmware \
		org.gnome.World.Secrets \
		org.gnome.gitlab.somas.Apostrophe \
		org.gnome.gitlab.somas.Apostrophe.Plugin.TexLive \
		org.gnome.seahorse.Application \
		org.mozilla.Thunderbird \
		org.mozilla.firefox \
		org.musicbrainz.Picard \
		org.nickvision.tagger \
		org.nicotine_plus.Nicotine \
		org.torproject.torbrowser-launcher \
		re.sonny.Junction

silverblue-setup-extensions:
	#!/usr/bin/env bash

	# xdg-open https://extensions.gnome.org/extension/615/appindicator-support/
	# xdg-open https://extensions.gnome.org/extension/4481/forge/
	xdg-open https://extensions.gnome.org/extension/4269/alphabetical-app-grid/
	xdg-open https://extensions.gnome.org/extension/5500/auto-activities/
	xdg-open https://extensions.gnome.org/extension/5724/battery-health-charging/
	xdg-open https://extensions.gnome.org/extension/2645/brightness-control-using-ddcutil/
	xdg-open https://extensions.gnome.org/extension/517/caffeine/
	xdg-open https://extensions.gnome.org/extension/1319/gsconnect/
	xdg-open https://extensions.gnome.org/extension/1336/run-or-raise/
	xdg-open https://extensions.gnome.org/extension/4736/smart-auto-move/
	xdg-open https://extensions.gnome.org/extension/4805/panel-corners/
	xdg-open https://extensions.gnome.org/extension/3193/blur-my-shell/
	xdg-open https://extensions.gnome.org/extension/3396/color-picker/
	xdg-open https://extensions.gnome.org/extension/779/clipboard-indicator/
	xdg-open https://extensions.gnome.org/extension/307/dash-to-dock/
	xdg-open https://extensions.gnome.org/extension/2639/hide-minimized/

setup-rust:
	#!/usr/bin/env bash
	source ~/.profile
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	[[ -f "$CARGO_HOME/env" ]] && source "$CARGO_HOME/env"
	rustup install nightly
	rustup component add \
		clippy \
		rustfmt \
		rust-analyzer

setup-brew:
	#!/usr/bin/env bash
	source ~/.profile
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	# depends on dotfiles being stowed
	brew bundle

setup-containers:
	#!/usr/bin/env bash
	source ~/.profile
	# depends on brew setup, because the /home/linuxbrew directory structure to be present
	distrobox assemble create
	# chech distrobox.ini in $HOME directory
	distrobox enter general

setup-java:
	#!/usr/bin/env bash
	source ~/.profile
	curl -s "https://get.sdkman.io?rcupdate=false" | bash
	[[ -s "$SDKMAN_DIR" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
	sdk install java
	sdk install maven
	sdk install gradle

setup-python:
	#!/usr/bin/env bash
	asdf plugin add python https://github.com/asdf-community/asdf-python.git
	asdf install python latest

setup-node:
	#!/usr/bin/env bash
	source ~/.profile
	asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
	asdf install nodejs lts
	corepack enable pnpm
	corepack enable yarn # bun is at Brewfile
	# Install globally
	pnpm add -g \
		@olrtg/emmet-language-server \
		bash-language-server \
		neovim

setup-ruby:
	#!/usr/bin/env bash
	source ~/.profile
	# most setup depends in `brew bundle`
	rbenv install $(rbenv install -l | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1)
	rbenv global $(rbenv install -l | grep -E '^[0-9]+\.[0-9]+\.[0-9]+$' | tail -1)
	echo "you'll probably have to be inside a distrobox container to install this lsp"
	gem install ruby-lsp

setup-kanata:
	#!/usr/bin/env bash
	source ~/.profile
	# depends on rust setup
	cargo install kanata
	grep -E '^input:' /usr/lib/group | sudo tee -a /etc/group
	sudo usermod -aG input $USER
	sudo groupadd uinput
	sudo usermod -aG uinput $USER
	echo 'KERNEL=="uinput", GROUP="uinput", MODE:="0660"' | sudo tee /etc/udev/rules.d/99-uinput.rules
	systemctl --user enable kanata.service

setup-nvim:
	#!/usr/bin/env bash
	source ~/.profile
	# depends on rust setup
	cargo install bob-nvim
	bob install nightly
	bob use nightly

setup-others:
	#!/usr/bin/env bash
	sudo update-ca-trust
	systemctl --user daemon-reload
	systemctl --user enable --now podman-auto-update.timer
