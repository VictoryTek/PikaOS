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
# https://github.com/VictoryLinux                                   #
#####################################################################


echo -e "----------------------------------------------------------------"
echo -e "  ____    ____  __                                              "
echo -e "  \   \  /   / |__| ____ ________    ____    _______ ___  ___   "
echo -e "   \   \/   /  ___ |   _|\__   __\ /   _  \ |  __   |\  \/  /   "
echo -e "    \      /  |   ||  |_   |  |   |   |_|  ||  | |__| \   /     "
echo -e "     \____/   |___||____|  |__|    \_____ / |__|       |_|      "
echo -e "                                                                "
echo -e "----------------------------------------------------------------"
echo -e "     ██   ██╗   █████╗    ██████╗   █████╗ ██████╗  █████╗      "
echo -e "     ███  ██║  ██    ██╗  ██    ██╗██╔══██╗██   ██╗██╔══██╗     "
echo -e "     ██║█ ██║ ██      ██╗ ██████╔═╝███████║██████╔╝███████║     "
echo -e "     ██║ ███║  ██    ██╔╝ ██    ██╗██║  ██║██║  ██║██║  ██║     "
echo -e "     ██║  ██║   ██████╔╝  ██████╔═╝██║  ██║██║  ██║██║  ██║     "
echo -e "     ╚═╝  ╚═╝   ╚═════╝   ╚═════╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝     "
echo -e "----------------------------------------------------------------"

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
echo -e "----------------------------------------------------------------"
echo -e "  ____    ____  __                                              "
echo -e "  \   \  /   / |__| ____ ________    ____    _______ ___  ___   "
echo -e "   \   \/   /  ___ |   _|\__   __\ /   _  \ |  __   |\  \/  /   "
echo -e "    \      /  |   ||  |_   |  |   |   |_|  ||  | |__| \   /     "
echo -e "     \____/   |___||____|  |__|    \_____ / |__|       |_|      "
echo -e "                                                                "
echo -e "----------------------------------------------------------------"
echo -e "     ██   ██╗   █████╗    ██████╗   █████╗ ██████╗  █████╗      "
echo -e "     ███  ██║  ██    ██╗  ██    ██╗██╔══██╗██   ██╗██╔══██╗     "
echo -e "     ██║█ ██║ ██      ██╗ ██████╔═╝███████║██████╔╝███████║     "
echo -e "     ██║ ███║  ██    ██╔╝ ██    ██╗██║  ██║██║  ██║██║  ██║     "
echo -e "     ██║  ██║   ██████╔╝  ██████╔═╝██║  ██║██║  ██║██║  ██║     "
echo -e "     ╚═╝  ╚═╝   ╚═════╝   ╚═════╝  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝     "
echo -e "----------------------------------------------------------------"
echo -e " DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK. "
echo -e "----------------------------------------------------------------"

echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"
echo -e "++++++++         This is NOT a silent install           ++++++++"
echo -e "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++"

	
#	sleep 5s
	echo "ARE YOU READY TO START? [y,n]"
	read input

	# did we get an input value?
	if [ "$input" == "" ]; then

	   echo "Nothing was entered by the user"

	# was it a y or a yes?
	elif [[ "$input" == "y" ]] || [[ "$input" == "yes" ]]; then

	   echo "You replied $input, you are ready to start"
	   echo
	   echo "Starting VictoryNobara install script."
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
function hostname() {
	
	echo "############################"
	echo "|     Set the PC Name.     |"
	echo "############################"
	echo
	sleep 6s
	if [ $(whoami) = "root"  ];
then
    useradd -m -G wheel,libvirt -s /bin/bash $username 
	passwd $username
	cp -R /root/VictoryNobara /home/$username/
    chown -R $username: /home/$username/VictoryNobara
	read -p "Please name your computer:" nameofmachine
	echo $nameofmachine > /etc/hostname
else
	sudo nano /etc/hostname
fi
	echo
	check_exit_status
}

# Updating 
function update() {

	echo "###########################"
	echo "|        Updating         |"
	echo "###########################"
	echo
	sleep 6s
	echo	
	sudo apt update -y;
    echo
    sudo apt upgrade -y;
	echo
	check_exit_status
}

# Removing unwanted pre-installed packages
function debloat() {

	echo "#############################"
	echo "|        Debloating         |"
	echo "#############################"
	echo

	sleep 6s
	PKGS=(
	'simple-scan'
	'gnome-weather'

	)

for PKG in "${PKGS[@]}"; do
    echo "REMOVING: ${PKG}"
    sudo apt remove "$PKG" -y
done
	echo
	check_exit_status
}

# Installing Packages
function install() {

	echo "###############################"
	echo "|     Installing Packages.    |"
	echo "###############################"
	echo

sleep 6s

PKGS=(
'alacarte'
'autofs'
'autojump'
'breeze-cursor-theme'
'bpytop'
'caffeine'
'celluloid' # video players
'dialog'
'dkms'
'fastfetch'
'filelight'
'fonts-firacode'
'gimp' # Photo editing
'gwenview'
'htop'
#'kernel-devel'
#'kernel-headers'
'kmail'
'kmag'
'meson'
'mono-complete'
'ncdu'
'onboard'
'piper'
'fonts-powerline'
'progress'
'libqt5x11extras5-dev'
'sassc'
'snapper'
'swtpm'
'terminator'
'xfonts-terminus'
'timeshift'
'tldr'
'trash-cli'
'unrar'
'ufw'
'variety'
'virtualbox'
'virtualbox-ext-pack'


)

for PKG in "${PKGS[@]}"; do
    echo "INSTALLING: ${PKG}"
    sudo apt install "$PKG" -y
done


	# AppimageLauncher
	cd ~/home/$(whoami)/Downloads
	wget https://github.com/TheAssassin/AppImageLauncher/releases/download/v2.2.0/appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
	echo
	sudo rpm -i appimagelauncher-2.2.0-travis995.0f91801.x86_64.rpm
	echo
	cd ~/
	echo
	sleep 3s
	apt module install nodejs:15
	sleep 3s
	echo

	# Starship
	curl -sS https://starship.rs/install.sh | sh
	sleep 3s

	# Brave Browser
	sudo apt install apt-plugins-core
	echo
	sudo apt config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/x86_64/
	echo
#	sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
	echo
	sudo apt install brave-browser -y
	sleep 3s

	# Sound Codecs
	sudo apt install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel -y
	echo
	sudo apt install lame\* --exclude=lame-devel -y
	echo
	sudo apt group upgrade --with-optional Multimedia -y
	sleep 3s
	
	# Flatpaks
    flatpak install flathub com.bitwarden.desktop -y
	flatpak install flathub io.github.shiftey.Desktop -y
	flatpak install flathub org.prismlauncher.PrismLauncher -y
	flatpak install flathub com.simplenote.Simplenote -y
    flatpak install flathub com.vscodium.codium -y
	flatpak install flathub dev.deedles.Trayscale -y
	flatpak install flathub com.mattjakeman.ExtensionManager -y
	flatpak install flathub it.mijorus.gearlever -y
	flatpak install flathub io.github.zen_browser.zen -y

	sleep 3s

	#Extensions

	#Tiling-Assistant
	cd ~
	git clone https://github.com/Leleat/Tiling-Assistant.git && cd Tiling-Assistant/scripts
	chmod +x build.sh
	./build.sh -i
	sleep 3s

	#Extension-list
	cd ~
#	git clone https://github.com/tuberry/extension-list.git && cd extension-list
#	make && make install
	git clone --recurse-submodules https://github.com/tuberry/extension-list.git && cd extension-list
	meson setup build && meson install -C build
	# meson setup build -Dtarget=system && meson install -C build # system-wide, default --prefix=/usr/local
	sleep 3s

	#Tray-Icons-Reloaded
	cd ~
	git clone https://github.com/MartinPL/Tray-Icons-Reloaded.git
	mv $HOME/Tray-Icons-Reloaded ~/.local/share/gnome-shell/extensions/trayIconsReloaded@selfmade.pl
	sleep 3s

	#Gnome 4x Overview UI Tune
	cd ~
	git clone https://github.com/axxapy/gnome-ui-tune.git
	mv $HOME/gnome-ui-tune ~/.local/share/gnome-shell/extensions/gnome-ui-tune@itstime.tech
	sleep 3s

	#Vitals
	cd ~
	git clone https://github.com/corecoding/Vitals.git
	mv $HOME/Vitals ~/.local/share/gnome-shell/extensions/Vitals@CoreCoding.com
	sleep 3s
	check_exit_status

	#Caffene
	cd ~
	git clone https://github.com/eonpatapon/gnome-shell-extension-caffeine
	mv $HOME/gnome-shell-extension-caffeine ~/.local/share/gnome-shell/extensions/Vitals@CoreCoding.com
	sleep 3s
	check_exit_status
}

# Put the wallpaper
function backgrounds() {

	echo "#########################################"
	echo "|     Setting up Favorite Wallpaper.    |"
	echo "#########################################"
	echo
	sleep 6s
	cd ~/
    git clone https://gitlab.com/dwt1/wallpapers.git

	check_exit_status
}

#
function configs() {
	
	echo "##################################"
	echo "|     Setting Format changes.    |"
	echo "##################################"
	echo
	sleep 6s
   	echo
    	export PATH=$PATH:~/.local/bin
    	cp -r $HOME/PikaOS/configs/* $HOME/.config/
    	echo
	# enable pre configured bashrc file
    	mv $HOME/.config/bashrc $HOME/.config/.bashrc
    	mv $HOME/.config/.bashrc $HOME
    	echo
	# create a face icon
    	mv $HOME/.config/face $HOME/.config/.face
    	mv $HOME/.config/.face $HOME
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
		echo run script 2, victory-finish.sh
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
#install
#backgrounds
#configs
#restart
