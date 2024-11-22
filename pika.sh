#!/bin/bash
# Setup PikaOS Linux
# Ver. 1.0

#####################################################################
#  ____    ____  __                                                 #
#  \   \  /   / |__| ____ ________    ____    _______ ___  ___      #
#   \   \/   /  ___ |   _|\__   __\ /   _  \ |  __   |\  \/  /      #
#    \      /  |   ||  |_   |  |   |   |_|  ||  | |__| \   /        #
#     \____/   |___||____|  |__|    \_____ / |__|       |_|         #
#                                                                   #
# Victory Linux Install script                                      #
# https://github.com/VictoryTek                                     #
#####################################################################


echo -e "-----------------------------------------------------------------"
echo -e "   ____    ____  __                                              "
echo -e "   \   \  /   / |__| ____ ________    ____    _______ ___  ___   "
echo -e "    \   \/   /  ___ |   _|\__   __\ /   _  \ |  __   |\  \/  /   "
echo -e "     \      /  |   ||  |_   |  |   |   |_|  ||  | |__| \   /     "
echo -e "      \____/   |___||____|  |__|    \_____ / |__|       |_|      "
echo -e "                                                                 "
echo -e "-----------------------------------------------------------------"
echo -e "    █████╗     █████╗  ██████╗ ██████╗██████╗ ██████╗  █████╗    "
echo -e "  ██╔════██╗ ██╔════██╗██╔══██╗  ██╔═╝██╔══██╗  ██╔═╝██╔════██╗  "
echo -e "   ████╗    ██╔╝       ██║  ██║  ██║  ██║  ██║  ██║   ████╗      "
echo -e "      ████╗ ██║        ██████╔╝  ██║  ██████╔╝  ██║      ████╗   "
echo -e "  ██╗    ██╗ ██╗    ██║██║  ██║  ██║  ██╔═══╝   ██║  ██╗    ██╗  "
echo -e "    █████╔═╝   █████╔═╝██║  ██║██████╗██║       ██║    █████╔═╝  "
echo -e "    ╚════╝     ╚════╝  ╚═╝  ╚═╝╚═════╝╚═╝       ╚═╝    ╚════╝    "
echo -e "-----------------------------------------------------------------"

# Make sure each command executes properly
check_exit_status() {

	if [ $? -eq 0 ]
	then
		echo
		echo "Success"
		echo
	else
		echo
		echo "[ERROR] Update Failed! Check the errors and try again"
		echo
		
		read -p "The last command exited with an error. Exit script? (y/n) " answer

            if [ "$answer" == "y" ]
            then
                exit 1
            fi
	fi
}

function greeting() {
	clear
	
echo "+-----------------------------------------------------------------+"
echo "|-------   Hello, $USER. Let's setup Victory-Edition.  -----------|"
echo "+-----------------------------------------------------------------+"
echo -e "-------------------         PikaOS         ---------------------"
echo -e "----------------------------------------------------------------"
echo -e "  ____    ____  __                                              "
echo -e "  \   \  /   / |__| ____ ________    ____    _______ ___  ___   "
echo -e "   \   \/   /  ___ |   _|\__   __\ /   _  \ |  __   |\  \/  /   "
echo -e "    \      /  |   ||  |_   |  |   |   |_|  ||  | |__| \   /     "
echo -e "     \____/   |___||____|  |__|    \_____ / |__|       |_|      "
echo -e "                                                                "
echo -e "----------------------------------------------------------------"
echo -e "                ██████╗ ██████╗██╗  ██╗ █████╗                  "
echo -e "                ██╔═══██╗ ██╔═╝██║  ██║██╔══██╗                 "
echo -e "                ██████╔═╝ ██║  ██████╔╝███████║                 "
echo -e "                ██╔═══╝   ██║  ██║  ██║██║  ██║                 "
echo -e "                ██║     ██████╗██║  ██║██║  ██║                 "
echo -e "                ╚═╝     ╚═════╝╚═╝  ╚═╝╚═╝  ╚═╝                 "
echo -e "----------------------------------------------------------------"
echo -e " DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK. "
echo -e "----------------------------------------------------------------"

echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "++++++++         This is NOT a silent install           ++++++++"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

	
#	sleep 5s
	echo "To-Do List"
	echo 
	echo "Give this PC a Name"
	echo "Update the system"
	echo "Remove unwanted packages"
	echo "Remove Unwanted Startup Apps"
	echo "Install Layered Packages"
	echo "Install Packages"
	echo "Install Flatpaks"
	echo "Install QEMU Virtualization"
	echo "Download Favorite Wallpaper"
	echo "Install Themeing"
	echo
	echo "If you dont want one of these in the list to run,"
	echo "then edit the script and remove it."
	echo
	echo "ARE YOU READY TO START? [y,n]"
	read input

	# did we get an input value?
	if [ "$input" == "" ]; then

	   echo "Nothing was entered by the user"

	# was it a y or a yes?
	elif [[ "$input" == "y" ]] || [[ "$input" == "yes" ]]; then

	   echo "You replied $input, you are ready to start"
	   echo
	   echo "Starting VictoryPIkaOS install script."
	   echo
	   sleep 3s

	# treat anything else as a negative response
	else

	   echo "You replied $input, you are not ready"
	   echo
	   exit 1

fi

	echo
	
	check_exit_status
}

# Set the Hostname
hostname () {
	
	echo "############################"
	echo "|     Set the PC Name.     |"
	echo "############################"
	echo
	sleep 6s
	if [ $(whoami) = "root"  ];
then
    useradd -m -G wheel,libvirt -s /bin/bash $username 
	passwd $username
	cp -R /root/PikaOS /home/$username/
    chown -R $username: /home/$username/PikaOS
	read -p "Please name your computer:" nameofmachine
	echo $nameofmachine > /etc/hostname
else
	sudo nano /etc/hostname
fi
	echo

	check_exit_status
}

# Updating 
update () {

	echo "###########################"
	echo "|        Updating         |"
	echo "###########################"
	echo
	sleep 6s
	echo	
	pikman upgrade;
	echo
	check_exit_status
}

# Removing unwanted pre-installed packages
debloat () {

	echo "#############################"
	echo "|        Debloating         |"
	echo "#############################"
	echo

	sleep 6s
	PKGS=(
	'simple-scan'
	'gnome-weather'
	'gnome-clocks'

	)

for PKG in "${PKGS[@]}"; do
    echo "REMOVING: ${PKG}"
    pikman remove "$PKG" -y
done
	echo

	check_exit_status
}

# Install Systems
install_systems  () {

	echo "###########################"
	echo "|   Installing Systems    |"
	echo "###########################"
	echo
	sleep 6s
	echo
	echo "INSTALLING Homebrew"
	sleep 3s
	echo
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo
	test -d ~/.linuxbrew && eval "$(~/.linuxbrew/bin/brew shellenv)"
	echo
	test -d /home/linuxbrew/.linuxbrew && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
	sleep 6s
	echo
	echo "INSTALLING Distrobox"
	sleep 3s
	echo
	curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
	echo
	sudo groupadd podman
	echo
	sudo usermod -aG podman $USER
	echo
	distrobox --version
	sleep 6s
	echo
}

# Installing Layord Packages
install_layered () {

	echo "################################"
	echo "| Installing Layered Packages  |"
	echo "################################"
	echo

sleep 6s

PKGS=(
'gparted'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    pikman install "$PKG"
done
echo

	check_exit_status
}

# Installing Packages
install_pkgs () {

	echo "###############################"
	echo "|     Installing Packages.    |"
	echo "###############################"
	echo

sleep 6s

PKGS=(
'autojump'
'dialog'
'meson'
'ncdu'
'pipx'
'progress'
'starship'
'swtpm'
'tldr'
'trash-cli'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    brew install "$PKG"
done

	# Tailscale
	# Add Tailscale's GPG key
	sudo mkdir -p --mode=0755 /usr/share/keyrings
	echo
	curl -fsSL https://pkgs.tailscale.com/stable/debian/sid.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
	echo
	# Add the tailscale repository
	curl -fsSL https://pkgs.tailscale.com/stable/debian/sid.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list
	echo
	# Install Tailscale
	pikman update && pikman install tailscale
	echo
	sleep 3s
	
	# Wezterm
#	brew install --cask wezterm
	curl -LO https://github.com/wez/wezterm/releases/download/20240203-110809-5046fc22/WezTerm-20240203-110809-5046fc22-Ubuntu20.04.AppImage
	chmod +x WezTerm-20240203-110809-5046fc22-Ubuntu20.04.AppImage
	sleep 3s

	# Starship
#	curl -sS https://starship.rs/install.sh | sh
#	sleep 3s

	# Gnome Extension Cli
	pipx install gnome-extensions-cli --system-site-packages 
	sleep 3s
	echo
	busctl --user call org.gnome.Shell /org/gnome/Shell org.gnome.Shell Eval s 'Meta.restart("Restarting…")'
	echo

	check_exit_status
}
	
# Installing Flatpaks
install_flatpaks () {

	echo "###############################"
	echo "|     Installing Flatpaks.    |"
	echo "###############################"
	echo

    flatpak install --system flathub com.bitwarden.desktop -y
	flatpak install --system flathub com.brave.Browser -y
	flatpak install --system flathub org.gnome.Boxes -y
	flatpak install --system flathub it.mijorus.gearlever -y
	#flatpak install --system flathub io.frama.tractor.carburetor -y
	flatpak install --system flathub io.github.shiftey.Desktop -y
	flatpak install --system flathub com.discordapp.Discord -y
	flatpak install --system flathub org.prismlauncher.PrismLauncher -y
	flatpak install --system flathub com.simplenote.Simplenote -y
	#flatpak install --system flathub net.nokyan.Resources -y
	flatpak install --system flathub com.rustdesk.RustDesk -y
    flatpak install --system flathub com.vscodium.codium -y
	flatpak install --system flathub dev.deedles.Trayscale -y
	flatpak install --system flathub ca.desrt.dconf-editor -y
	flatpak install --system flathub org.gimp.GIMP -y
	flatpak install --system flathub org.freedesktop.Piper -y
	flatpak install --system flathub io.github.flattool.Warehouse -y
	flatpak install --system flathub io.github.zen_browser.zen -y
	sleep 3s
	echo

	check_exit_status

}

# Install QEMU & Virt Manager
install_virtualization () {

	echo "###############################"
	echo "|  Installing Virtualization. |"
	echo "###############################"
	echo

	echo
	pikman install qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager;
	echo

	check_exit_status
	
}

# Installing Extensions
install_extensions () {

	echo "###############################"
	echo "|    Installing Extensions.   |"
	echo "###############################"
	echo

	sleep 6s

PKGS=(
'azwallpaper@azwallpaper.gitlab.com'
'dash-to-dock@micxgx.gmail.com'
'openbar@neuromorph'
'tiling-assistant@leleat-on-github'

)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    gext install "$PKG"
done

}

# Put the wallpaper
wallpaper () {

	echo "#########################################"
	echo "|     Setting up Favorite Wallpaper.    |"
	echo "#########################################"
	echo
	sleep 6s
	cd ~/
    git clone https://github.com/VictoryTek/wallpaper.git
	echo

	check_exit_status

}

# Installing Appearance
install_appearance () {

	echo "###############################"
	echo "|    Installing Appearance.   |"
	echo "###############################"
	echo

	# Icons & Cursor
	cd $HOME/PikaOS/
	git clone https://github.com/daniruiz/flat-remix
	git clone https://github.com/daniruiz/flat-remix-gtk
	git clone https://github.com/bikass/kora.git
	wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Classic.tar.xz
	tar -xvf Bibata-Modern-Classic.tar.xz
	wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.tar.xz
	mkdir Meslo
	tar -xvf Meslo.tar.xz -C Meslo
	rm -rf Meslo/LICENSE.txt
	rm -rf Meslo/README.md
	mkdir ~/.local/share/fonts
	cp Meslo/* ~/.local/share/fonts
	fc-cache -vf
	sleep 3s
	echo

	check_exit_status

}

# finish
function restart() {
	read -p "Are You ready to restart now? (y/n) " answer 

            if [ "$answer" == "y" ]
            then
            	cecho
		echo "---------------------------------------"
		echo "----        PikaOS part 1          ----"
		echo "----     has been installed!       ----"
		echo "---------------------------------------"*/
		echo
		
		echo Restart 
		echo or 
		echo restart gnome shell 
		echo & 
		echo run script 2, finish.sh
		echo
		check_exit_status
		
		echo
		echo "Restarting in 15s"
		sleep 15s
                shutdown -r now

            if [ "$answer" == "n" ]
            then
		exit 1

            fi
        fi

}

greeting
hostname
update
debloat
install_systems
install_layered
install_pkgs
install_flatpaks
install_virtualization
install_extensions
wallpaper
install_appearance
restart