#!/bin/ash
# Autor: Marcos Antonio de Carvalho
# Descrição: Instalações necessarias do ALPINE 

cd ~/alpine || exit

#-- Header
clear
echo "Alpine Linux  -  Setup 2025"
echo "by Marcos Antonio de Carvalho"

echo ""
date=$(date)
start=$(date +%s)

# *****************************
#   Configurando /root/.zshrc
# *****************************
echo "☑️ Configurando arquivo: /root/.zshrc"
echo '
# Alpine on WSL - Setup 2025
# by Marcos Antonio de Carvalho
# /root/.zshrc

# Configuração Básica do ZSH
# --------------------------

export PATH=$HOME/bin:/usr/local/bin:$PATH
export HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=1000
autoload -Uz compinit && compinit

' > ~/.zshrc

# ****************************
#   Configurando /etc/passwd
# ****************************
echo "☑️ Configurando arquivo: /etc/passwd"
# Edita o shell padrão do usuário atual para zsh
# Atenção: Você deve logado como root ou tiver permissão para editar /etc/passwd.
sed -i -e 's/\/ash/\/zsh/' /etc/passwd
echo ""


#  *****************************************
#    Definindo a configuração do OH-MY-ZSH
#  *****************************************

echo "☁️ Download do tema OH-MY-ZSH... powerlevel10k"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k >/dev/null 2>&1

# Cópia a minha pré-configuração 
cp ./.config/.p10k.zsh ~/.p10k.zsh

echo "☑️ Configurando OH-MY-ZSH... $HOME/.oh-my-zsh"
# OH-MY-ZSH
# ---------
# configurando do oh--mu-zsh
echo '

# OH-MY-ZH
# --------

# Caminho para a instalação do Oh My Zsh.
export ZSH="$HOME/.oh-my-zsh"

# Define o nome do tema a ser carregado --- se definido como "random", ele irá
# carregar um tema aleatório cada vez que o Oh My Zsh for carregado. Nesse caso,
# para saber qual tema específico foi carregado, execute: echo $RANDOM_THEME
# Veja https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Define a lista de temas para escolher ao carregar aleatoriamente
# Definir esta variável quando ZSH_THEME=random fará com que o zsh carregue
# um tema desta variável em vez de procurar em $ZSH/themes/
# Se definido como um array vazio, esta variável não terá efeito.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

' >> ~/.zshrc

#  **********************************
#    Definindo plugins do OH-MY-ZSH
#  **********************************

# zsh-syntax-highlighting
echo "☁️ Download do plugin 'zsh-syntax-highlighting'"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting >/dev/null 2>&1

# zsh-autosuggestions
echo "☁️ Download do plugin 'zsh-autosuggestions'"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions >/dev/null 2>&1

# K
echo "☁️ Download do plugin 'k'"
git clone https://github.com/supercrabtree/k ~/.oh-my-zsh/custom/plugins/k  >/dev/null 2>&1
# Fiz alterações para ficar mais bacana
#git clone https://github.com/dev-carvalho/k .oh-my-zsh/custom/plugins/k >/dev/null 2>&1
# cp -r ./k.zsh-plugin .oh-my-zsh/custom/plugins/k >/dev/null 2>&1

echo "☑️ Setup plugin 'k'"
# Guarda o plugin K original e depois cópia um novo com as minhas alterações do plugin K
cp ~/.oh-my-zsh/custom/plugins/k/k.sh ~/.oh-my-zsh/custom/plugins/k/k.sh.original
cp ./.config/k.sh ~/.oh-my-zsh/custom/plugins/k
echo ""

echo '
# Plugins para OH-MY-ZH
# ----------------------

# Quais plugins você gostaria de carregar?
# Os plugins padrão podem ser encontrados em $ZSH/plugins/
# Plugins personalizados podem ser adicionados em $ZSH_CUSTOM/plugins/
# Formato de exemplo: plugins=(rails git textmate ruby ​​lighthouse)
# Adicione com cuidado, pois muitos plugins tornam a inicialização do shell mais lenta.
# plugins=(git)
plugins=(git zsh-syntax-highlighting zsh-autosuggestions k)

source $ZSH/oh-my-zsh.sh

' >> ~/.zshrc


#  *****************************************
#    Definindo os comandos mais utilizados
#  *****************************************
echo "☑️ Configurando shell: /root/.zshrc ($SHELL)"

# configurando comandos
echo '
# Exportar variáveis
# ------------------

export EDITOR=vi
export PATH="$HOME/bin:$PATH"


# Alias
# -----

# Informações sobre Arquivos e Diretórios
alias k="k -A --human --sort W"
alias l="exa -laF"

# SYSTEM - Informações sobre Sistema operacional
alias os="figlet System | neofetch" 

# Beautiful git log graph shortcut (shown in the top image)
alias glog="git log --oneline --all --graph --decorate  $*"
alias gstatus="git status"

# Diversos
alias cls=clear

' >> ~/.zshrc

# bash: ~/.bashrc
# ash: ~/.profile

# ***********************************
#   Configurando o nome do hostname
# ***********************************
hostname="Alpine"
echo "☑️ Configurando arquivo: /etc/hostname -> $hostname"
echo $hostname > /etc/hostname
hostname $hostname

# ******************************************
#   Configurando o timezone para São Paulo
# ******************************************
tz="America/Sao_Paulo"
echo "☑️ Configurando arquivo: /etc/localtime -> $tz"
apk add --no-cache tzdata > /dev/null 2>&1  \
&& cp /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime \
&& echo $tz > /etc/timezone \
&& apk del tzdata > /dev/null 2>&1 

#-- Runtime
echo ""
end=$(date +%s)
date
runtime=$((end - start))
echo "Runtime $runtime seconds"
echo ""

cd - >/dev/null 2>&1

# rm ~/.zcompdump*
# rm ~/install.sh