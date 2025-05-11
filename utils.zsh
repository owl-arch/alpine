# *****************
#   Função do APK
# *****************
package_remove (){
  if ( apk info  | grep "^$1" >/dev/null 2>&1 ) 
  then
    echo "☑️ Removendo $1 .. Removido!"   
    apk del $1 >/dev/null 2>&1 
  else  
    echo "🚨 Removendo $1.. Não instalado."
  fi
}

package_install (){
  if ( apk info  | grep "^$1" >/dev/null 2>&1 ) 
  then
    echo "🚨 Lançando instalação $1 .. Já instalado."
  else  
    echo "🚀 Lançando instalação $1 .. Instalado!"   
    apk add $1 >/dev/null 2>&1 
  fi
}