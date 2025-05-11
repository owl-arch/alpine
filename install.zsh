#!/bin/ash
# Autor: Marcos Antonio de Carvalho
# Descrição: Instalações necessarias do ALPINE 

cd ~/alpine || exit

# Reset instalação
rm -r .oh-my-zsh/
rm -r ~/.config
rm ~/.zcompdump*
rm ~/.zshrc*
rm ~/.p10k.zsh
rm ~/install.sh

ls -la ~

#-- Header
clear
echo "Alpine Linux  -  Install 2025"
echo "by Marcos Antonio de Carvalho"

echo ""
date=$(date)
start=$(date +%s)
source ./utils.zsh

# ********************************************
#   Atualizando a lista de pacotes do Alpine
# ********************************************
echo "🔄 Atualizando lista de pacotes"
apk update >/dev/null 2>&1 # Atualiza a lista de PACKAGES

# Instala os pacotes de interesse
for comando in zsh python3 curl neofetch htop exa figlet coreutils; do
  package_install $comando
done
echo ""

# **********************
#   Instalar Oh My Zsh
# **********************
# Check '~/.oh-my-bash'
if [ -d ~/.oh-my-zsh ]; then
    echo "🚨 Ainda instalado o oh-my para ZSH."
    # Remove a instalação anterior  
    echo "☑️ Removendo oh-my para ZSH." 
    rm -r ~/.oh-my-zsh; 
fi
echo "🚀 Lançando instalação oh-my-zsh." 
curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output ~/install.sh
chmod +x ~/install.sh
. "/root/install.sh" >/dev/null 2>&1 & 

#-- Runtime
echo ""
end=$(date +%s)
date
runtime=$((end - start))
echo "Runtime $runtime seconds"
echo ""

cd - >/dev/null 2>&1


# Reinicie o shell
# exec zsh
