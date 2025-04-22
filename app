#!/bin/bash

# Pilihan aplikasi
app=$(zenity --list --title="Pilih Aplikasi" \
    --column="Aplikasi" "telnet" "ssh" "http" "ftp")

# Kalau batal dipilih, keluar
if [ -z "$app" ]; then
    exit
fi

# Pilihan tindakan
action=$(zenity --list --title="Pilih Aksi Firewall" \
    --column="Aksi" "ACCEPT" "REJECT" "DROP")

if [ -z "$action" ]; then
    exit
fi

# Mapping aplikasi ke port
case $app in
    telnet)
        port=23
        ;;
    ssh)
        port=22
        ;;
    http)
        port=80
        ;;
    ftp)
        port=21
        ;;
    *)
        zenity --error --text="Aplikasi tidak valid!"
        exit 1
        ;;
esac

# Eksekusi iptables
sudo iptables -A INPUT -p tcp --dport $port -j $action

# Konfirmasi
zenity --info --text="Firewall di-set: $action koneksi $app (port $port)"
