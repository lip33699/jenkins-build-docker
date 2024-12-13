
FROM nginx:latest

# Créer le fichier index.html s'il n'existe pas
RUN echo "Welcome to nginx!" > /usr/share/nginx/html/index.html && \
    sed -i 's/nginx/adams/g' /usr/share/nginx/html/index.html

# Exposer le port utilisé par nginx
EXPOSE 80
