#!/bin/bash
#Variaveis
JBOSS_DIRETORIO=/opt/server
HOME_CENTOS=/home/centos
SCRIPTS_INICIALIZACAO=/etc/init.d
CHKCONFIG=`which chkconfig`
ECHO=`which echo`
WGET=`which wget`
#baixa os pacotes para o servidor
yum install vim lsof strace java-1.6.0* httpd php wget bzip2 unzip -y 
#baixa o novo repositorio
#$WGET "http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm"  
$ECHO $JBOSS_DIRETORIO
/bin/wget "http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm" 1> /dev/null 
if [ -f  $PWD/epel-release-7-5.noarch.rpm ]
	then
		rpm -ivh $PWD/epel-release-7-5.noarch.rpm
	else
		$ECHO "Arquivo nao encontrado"
fi
#atualiza o repositorio
yum makecache
#Cria o diretorio do jboss
mkdir $JBOSS_DIRETORIO
#Copia para o diretorio onde ficara o jboss
mv $HOME_CENTOS/jboss-5.1.0.GA-jdk6.zip $JBOSS_DIRETORIO 
#Acessando o diretorio para descompactar
cd $JBOSS_DIRETORIO
#Descompacta o jboss
unzip jboss-5.1.0.GA-jdk6.zip
#Move scrip de inicializacao
mv $HOME_CENTOS/jboss $SCRIPTS_INICIALIZACAO/
#Concede permissao de execucao
chmod +x $SCRIPTS_INICIALIZACAO/jboss
#Adiciona o script na inicialização
$CHKCONFIG jboss on
#Adiciona o java_home jboss_home
cat << EOF >> $HOME/.bashrc
#Instalando java
JAVA_HOME=/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.37.x86_64  
JBOSS_HOME=/opt/server/jboss-5.1.0.GA
PATH=$JAVA_HOME/bin:$PATH  
export PATH  
export JBOSS_HOME  
export JAVA_HOME  
EOF
#Faz reload do arquivo de variaveis do usuario
source $HOME/.bashrc
if [ $(echo "/usr/lib/jvm/java-1.6.0-openjdk-1.6.0.37.x86_64") == $(echo "$JAVA_HOME") ]
 	then
 		$ECHO "Deu certo"
 		
fi
