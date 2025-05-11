#!/bin/zsh

# Autor: Marcos Antonio de Carvalho
# Descrição: (Download) faz um clone do projeto do Github na maquina local
# Criado: 2023  Refatorado em 2025

# Vai para o diretório do projeto
cd ~/github || exit
logfile="./clone.log"
rm $logfile

start=$(date +%s)
node=$(uname -n)
now=$(date +'%A, %d de %B de %Y at %H:%M')
pwd=$(pwd)

# Cabeçalho do Log
echo "Clone Log" >$logfile 
echo $now >>$logfile 

# Configura a 'branch' (ramo)
echo "1. Configura a branch para 'main'" >>$logfile 
git branch -M main >/dev/null 2>&1

# Adiciona pasta no remote:
echo "2. Adiciona pasta local no remote" >>$logfile 
git remote add $1 git@github.com:owl-arch/$1.git >/dev/null 2>&1

# Mostra em letras gigantes o nome do projeto/repositório
figlet "clone" | lolcat -t -p 1
echo "Projeto: $1 ($pwd/$1)" | lolcat -t -p 3

# Clona o projeto do github para pasta local
echo "3. Clona o projeto do repositório do github para pasta local" >>$logfile 
# git clone git@github.com:owl-arch/$1.git 

if [ -d "./$1" ]; then
    echo "A pasta '$1' já existe. Abortando o clone." | tee -a $logfile
    echo "Remova ou renomeie essa pasta e tente novamente."
    exit 1
else
    git clone git@github.com:owl-arch/$1.git
fi




# Remove pasta do remote
echo "4. Remove pasta local do remote" >>$logfile 
git remote remove $1 >/dev/null 2>&1

# Horário de fim
end=`date +%s`

#-- Runtime 
runtime=$((end-start))
echo
date
echo "Runtime $runtime seconds"
echo "Runtime $runtime seconds" >>$logfile 
echo ""

# Volta para o diretório de onde veio
cd - >/dev/null 2>&1

