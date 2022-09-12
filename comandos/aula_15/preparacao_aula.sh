###### Arquivo de preparação para a aula de replicação ######

1º Clone a máquina AlmaLinux_8.4_pkg: O nome da nova máquina vai ser AlmaLinux_8.4_pkg_replica
2º Ligue *apenas* a AlmaLinux_8.4_pkg_replica 
3º Execute os seguintes comandos na nova máquina (como root):

hostnamectl set-hostname sr1.local

/usr/local/bin/muda_ip 192.168.56.71

4º Desligue a máquina com init 0 e ligue a Alma AlmaLinux_8.4_pkg
5º Execute o seguinte comando na máquina original (AlmaLinux_8.4_pkg), como root

hostnamectl set-hostname sr0.local
