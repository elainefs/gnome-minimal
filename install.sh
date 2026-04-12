#!/bin/bash

# ================================================
# Gnome Minimal Install
# Licensed under the MIT License
# by Elaine Ferreira <https://github.com/elainefs/gnome-minimal>
# ================================================

cat <<'EOF'
  ____ _   _  ___  __  __ _____   __  __ ___ _   _ ___ __  __    _    _     
 / ___| \ | |/ _ \|  \/  | ____| |  \/  |_ _| \ | |_ _|  \/  |  / \  | |    
| |  _|  \| | | | | |\/| |  _|   | |\/| || ||  \| || || |\/| | / _ \ | |    
| |_| | |\  | |_| | |  | | |___  | |  | || || |\  || || |  | |/ ___ \| |___ 
 \____|_| \_|\___/|_|  |_|_____| |_|  |_|___|_| \_|___|_|  |_/_/   \_\_____|
EOF

echo "Olá, você está preste a instalar o Gnome Mínimo"
echo "Deseja continuar? [S/n]"
read install
if [ "$install" == "s" -o "$install" == "S" -o "$install" == "" ]; then
    echo "##### Atualizando seu sistema #####"

    apt update && apt upgrade -y

    echo "--- Atualização do sistema finalizada! ---"

    echo "##### Instalação da Interface Gráfica Gnome Iniciada #####"

    apt install --no-install-recommends gnome-session -y

    echo "--- Instalação da Interface Gráfica Gnome Finalizada ---"

    echo "##### Instalação dos pacotes essenciais #####"

    apt install --no-install-recommends gdm3 nautilus tilix gedit evince gnome-tweaks gnome-control-center gnome-calculator network-manager gnome-software gnome-shell-extensions gnome-shell-extension-manager seahorse libsecret-1-0 libsecret-1-dev gparted pulseaudio shotwell vlc gnome-sushi ffmpegthumbnailer libgdk-pixbuf2.0-bin ntfs-3g dosfstools wget curl gvfs-backends mtp-tools build-essential libmagic1 sudo firefox-esr vim fzf ripgrep tmux jq -y

    echo "--- Instalação dos pacotes essenciais Finalizada ---"

    echo "##### Instalação dos firmwares #####"

    apt install firmware-linux firmware-linux-free firmware-linux-nonfree -y

    echo "--- Instalação dos firmwares Finalizada ---"

    echo "##### Instalação de codecs #####"

    apt install libavcodec-extra gstreamer1.0-libav gstreamer1.0-plugins-ugly gstreamer1.0-vaapi -y

    echo "--- Instalação dos codecs Finalizada ---"

    echo "Configurações de rede..."

    echo "[main]
plugins=ifupdown,keyfile

[ifupdown]
managed=true" >/etc/NetworkManager/NetworkManager.conf

    echo "Configurações de rede finalizada!"

    echo "Deseja instalar o suporte a apps Flatpaks? [S/n]"
    read flatpak
    if [ "$flatpak" == "s" -o "$flatpak" == "S" -o "$flatpak" == "" ]; then
        echo "##### Instalando suporte a Flatpaks #####"
        apt install flatpak -y
        apt install gnome-software-plugin-flatpak -y
        flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    fi

    echo "Deseja instalar o suporte a apps Snaps? [S/n]"
    read snap
    if [ "$snap" == "s" -o "$snap" == "S" -o "$snap" == "" ]; then
        echo "##### Instalando suporte a Snaps #####"
        apt update -y
        apt install snapd -y
        snap install core
    fi

    echo "Deseja instalar a Snap Store? [S/n]"
    read snapstore
    if [ "$snapstore" == "s" -o "$snapstore" == "S" -o "$snapstore" == "" ]; then
        echo "##### Instalando Snap Store #####"
        snap install snap-store
    fi

    echo "##### Configurar ambiente de desenvolvimento #####"

    echo "Deseja instalar o Visual Studio Code? [S/n]"
    read vscode
    if [ "$vscode" == "s" -o "$vscode" == "S" -o "$vscode" == "" ]; then
        echo "##### Instalando o Visual Studio Code #####"

        wget "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" -O vscode.deb
        dpkg -i vscode.deb
        apt install -f -y
        rm vscode.deb
    fi

    echo "Deseja instalar o Filezilla? [S/n]"
    read filezilla
    if [ "$filezilla" == "s" -o "$filezilla" == "S" -o "$filezilla" == "" ]; then
        echo "##### Instalando o Filezilla #####"
        apt install filezilla -y
    fi

    echo "Deseja instalar o Nodejs? [S/n]"
    read nodejs
    if [ "$nodejs" == "s" -o "$nodejs" == "S" -o "$nodejs" == "" ]; then
        echo "##### Instalando o Nodejs #####"
        apt install nodejs -y
    fi

    echo "Deseja instalar o Virt Manager? [S/n]"
    read virtmanager
    if [ "$virtmanager" == "s" -o "$virtmanager" == "S" -o "$virtmanager" == "" ]; then
        echo "##### Instalando o Virt Manager #####"
        apt install virt-manager -y
    fi

    echo "##### Instalar ferramentas de manipulação de imagens #####"

    echo "Deseja instalar o Inkscape? [S/n]"
    read inkscape
    if [ "$inkscape" == "s" -o "$inkscape" == "S" -o "$inkscape" == "" ]; then
        echo "##### Instalando o Inkscape #####"
        apt install --no-install-recommends inkscape -y
    fi

    echo "Deseja instalar o Gimp? [S/n]"
    read gimp
    if [ "$gimp" == "s" -o "$gimp" == "S" -o "$gimp" == "" ]; then
        echo "##### Instalando o Gimp #####"
        apt install --no-install-recommends gimp -y
    fi

    user=$(users)
    echo "Deseja adicionar o usuário $user ao grupo sudo? [S/n]"
    read addusersudo
    if [ "$addusersudo" == "s" -o "$addusersudo" == "S" -o "$addusersudo" == "" ]; then
        usermod -aG sudo $user
        echo "$user adicionado ao grupo sudo"
    fi

    echo "****** Parabéns!!******
      Seu Gnome Mínimo está instalado.
Para desfrutar da sua nova instalação você precisa reiniciar o sistema."
    echo "Reiniciar sistema agora? [S/n]"
    read restart
    if [ "$restart" == "s" -o "$restart" == "S" -o "$restart" == "" ]; then
        systemctl reboot
    fi

else

    echo "Instalação abortada!"

fi
