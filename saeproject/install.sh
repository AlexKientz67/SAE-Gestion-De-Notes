#!/bin/bash

set -e

echo "[+] Mise à jour du système..."
apt update
apt full-upgrade -y

echo "[+] Installation des paquets..."
apt install -y git python3 python3-pip nginx

echo "[+] Clonage du projet..."
cd /opt

if [ ! -d "SAE-Gestion-De-Notes" ]; then
    git clone https://github.com/AlexKientz67/SAE-Gestion-De-Notes.git
fi

cd /opt/SAE-Gestion-De-Notes

echo "[+] Installation des dépendances Python..."
pip3 install --break-system-packages -r requirements.txt
pip3 install --break-system-packages gunicorn

echo "[+] Recherche de Gunicorn..."
GUNICORN_PATH=$(which gunicorn)

echo "[+] Création du service systemd..."

cat > /etc/systemd/system/gunicorn.service << EOF
[Unit]
Description=Gunicorn Django
After=network.target

[Service]
User=root
WorkingDirectory=/opt/SAE-Gestion-De-Notes/saeproject
ExecStart=${GUNICORN_PATH} \
 --workers 3 \
 --bind 127.0.0.1:8000 \
 saeproject.wsgi:application

[Install]
WantedBy=multi-user.target
EOF

echo "[+] Activation du service Gunicorn..."
systemctl daemon-reload
systemctl enable gunicorn
systemctl restart gunicorn

echo "[+] Création de la configuration Nginx..."

cat > /etc/nginx/sites-available/saeproject << 'EOF'
server {
    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    location /static/ {
        alias /opt/SAE-Gestion-De-Notes/saeproject/staticfiles/;
    }

    location / {
        proxy_pass http://127.0.0.1:8000;

        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}
EOF

echo "[+] Activation du site..."
ln -sf /etc/nginx/sites-available/saeproject /etc/nginx/sites-enabled/saeproject
rm -f /etc/nginx/sites-enabled/default

echo "[+] Export des fichiers statiques..."
cd /opt/SAE-Gestion-De-Notes/saeproject
python3 manage.py collectstatic --noinput || true

echo "[+] Vérification de Nginx..."
nginx -t

echo "[+] Redémarrage des services..."
systemctl restart nginx
systemctl restart gunicorn

echo
echo "========================================="
echo " Installation terminée"
echo "========================================="
echo
echo "Vérifier le statut :"
echo "  systemctl status gunicorn"
echo "  systemctl status nginx"
echo
echo "Configurer la base de données dans :"
echo "  /opt/SAE-Gestion-De-Notes/saeproject/saeproject/settings.py"
echo