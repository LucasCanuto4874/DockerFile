#!/bin/bash
echo "Atualizando os pacotes"
sudo apt update && sudo apt upgrade -y 

sleep 2
echo "Verificando se o Java esta instalado"
java -version

if [ $? = 0 ];
    then 
        echo "Java esta instalado na máquina"
    else 
        echo "Não tem Java instalado"
        echo "Deseja instalar Java? S ou N"
        read opcao 

        if [\"$opcao\" == \"S\"];
            then
                echo "Instalando Java"
                sudo apt install openjdk-17-jre

        fi
fi

sleep 2
echo "Verificando se o Python está instalado"
python --version

if [ $? = 0 ];
    then 
        echo "Python esta instalado na máquina"
    else 
        echo "Não tem Java e Python instalado"
        echo "Deseja instalar Python? S ou N"
        read opcao 

        if [\"$opcao\" == \"S\"];
            then
                echo "Instalando Python"
                sudo apt install python3 && sudo apt install python3-pip

        fi
fi

sleep 2

echo "Verificando se o Docker está instalado"
docker --version

if [ $? = 0 ];
    then 
        echo "O Docker está instaldo na máquina"
    else 
        echo "Não tem Docker instalado"
        echo "Deseja instalar o Docker? S ou N"
        read opcao

        if [\"$opcao\" == \"S\"];
            then
                echo "Instalando Docker"
                sudo apt install docker.io
        fi
fi      

echo "Clonando o repositorio do Docker File"
git clone https://github.com/LucasCanuto4874/DockerFile.git

echo "Acessando repositorio do projeto"
cd DockerFile

sleep 2

echo "Criando a imagem do servidor web"
sudo docker build -f DockerfileNode -t servidor-web 

sleep 2

echo "Criando a imagem do banco de dados"
# -f usado para especificar o arquivo Dockerfile pois tem nome diferente do padrão
sudo docker build -f DockerfileBD -t banco-de-dados ./aplicacao/src/database/

sleep 2

echo "Criando o container do servidor web"
sudo docker run -d --name container-servidorweb -p 8080:8080 servidor-web

sleep 2

echo "Criando o container do banco de dados"
sudo docker run -d --name banco-novascan -p 3306:3306 banco-de-dados

sleep 2

echo "Acessando o container do repositorio da NovaScan"
sudo docker exec -it container-servidorweb bash

# Dentro do bash do container

sudo apt-get update && apt-get install nano

echo "Iniciando o servidor web"

sleep 2

npm i
npm start









