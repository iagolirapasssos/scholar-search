#+---------------------------------------+
#|Programa: scholar-search               |
#|Autor: Francisco Iago Lira Passos      |
#|Função: Pesquisar e fazer estatísticas |
#|        das mesma usando o mecanismo   |
#|        da Google Search               |
#|Data: 10-09-2017                       |
#+---------------------------------------+
#!/bin/bash
export object=$1
export ylo=$2
export yhi=$3

function capture (){
     name=$(echo $object | sed 's/+/-/g')
     echo '' > grafico-$name-pubsVsAnos.dat
     for (( i=$ylo; i<=$yhi; i++ ))
     do 
        rm -f scholar?q=*
        link="https://scholar.google.com/scholar?q=$object&hl=en&as_sdt=0%2C5&as_ylo=$i&as_yhi=$i"
        sublink="/scholar?q=$object&hl=en&as_sdt=0%2C5&as_ylo=$i&as_yhi=$i"
        wget $link --referer=$link
        filename="scholar?q=$object&hl=en&as_sdt=0%2C5&as_ylo=$i&as_yhi=$i"
        pubs=`cat $filename | sed 's/About/\n/g' | sed '/results/!d; s/results.*//g; s/ \|,//g'`
        clear
        echo $i"    "$pubs >> grafico-$name-pubsVsAnos.dat
     done
     exit 0
}

if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]; then
clear
echo "
     +--------------------------------------------------+
     |    Para ter uma boa experiência com o script     |
     |    Recomendamos que siga conforme o exemplo:     |
     |==================================================|
     | ./scholar-search.sh forensic+computing 1991 2017 |
     | ./scholar-search.sh carbon+nanotubes 1991 2017   |
     |==================================================|
     |       Obs: Não esqueça de separar com '+'!       |
     +--------------------------------------------------+"
else
     capture
fi
