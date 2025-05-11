#!/bin/zsh
# Autor: Marcos Antonio de Carvalho
# Descrição: Instalações necessarias do ALPINE 

cd ~/alpine || exit

# ***************************
#   Definindo acesso Github
# ***************************
repository="owl-arch"
email="marcos.antonio.carvalho@gmail.com"

#-- Header
clear
echo "Alpine Linux  -  Github 2025"
echo "by Marcos Antonio de Carvalho"
echo "Install and Setup"

echo ""
date=$(date)
start=$(date +%s)
source ./utils.zsh

# ********************************************
#   Atualizando a lista de pacotes do Alpine
# ********************************************
echo "🔄 Atualizando lista de pacotes."
apk update >/dev/null 2>&1 # Atualiza a lista de PACKAGES

# Instala os pacotes de interesse
for comando in git openssh; do
  package_install $comando
done
echo ""

# ********************************************
#   Configurando o GIT para acessar o Github
# ********************************************
echo "Configurando GIT para acessar GitHub."

echo "☑️ Configurando usuário: $repository"
git config --global user.name $repository

echo "☑️ Configurando eMail: $email"
git config --global user.email $email

echo "☑️ Configurando editor padrão: VSCode"
git config --global core.editor "code --wait" # padrão VSCode

git config --list > ~/.cache/gitconfig &
echo ""

# ********************
#   Configurando SSH
# ********************
echo "☑️ Gerando par de chave para OpenSSH."
KEY_FILE="$HOME/.ssh/id_ed25519"

# Verifica se a chave já existe
if [ -f "$KEY_FILE" ] || [ -f "$KEY_FILE.pub" ]; then
    echo "🚨 As chaves '$KEY_FILE' já existem."
    echo -n "❓ Deseja sobrescrevê-las? (s/N): "
    read confirm
    case "$confirm" in
        [sS]|[sS][iI][mM])
            echo "Sobrescrevendo chaves..."
            rm -f "$KEY_FILE" "$KEY_FILE.pub"
            ;;
        *)
            echo "Operação cancelada pelo usuário."
            exit 1
            ;;
    esac
fi


# Gera nova chave SSH sem perguntar
ssh-keygen -t ed25519 -f "$KEY_FILE" -N "" -q

echo ""
echo "Nova chave Privada criada em: $KEY_FILE"
echo -n "Sua chave Pública: "
cat $KEY_FILE.pub

echo ""
echo "☑️ Adicione a chave privada ao ssh-agent (OpenSSH)."



echo ""
echo "Adicione a chave pública à sua conta no GitHub:"
echo ' - Abra as configurações da sua conta no GitHub.'
echo ' - Vá em "Chaves SSH e GPG".'
echo ' - Clique em "Nova chave SSH".'
echo " - Cole o conteúdo da sua chave pública ($KEY_FILE.pub) no campo de chave"
echo ' - Dê um título descritivo à sua chave.'



# git add .
# git commit -m "Test Alpine Linux"
# git branch -M main
# git remote add alpine git@github.com:owl-arch/alpine.git 
# git push -uf alpine main 
# git remote remove alpine

# vi /etc/ssh/sshd_config
# PermitRootLogin yes
# PasswordAuthentication yes

# NÃO PRECISA DISSO PARA ACESSAR GITHUB !!!
# eval "$(ssh-agent -s)"
# ssh-add ~/.ssh/id_ed25519


rc-update add sshd > /dev/null 2>&1 # Habilite o serviço do SSH para iniciar com o sistema
rc-service sshd start > /dev/null 2>&1 # Inicie o serviço do SSH

#-- Runtime
echo ""
end=$(date +%s)
date
runtime=$((end - start))
echo "Runtime $runtime seconds"
echo ""

cd - >/dev/null 2>&1
