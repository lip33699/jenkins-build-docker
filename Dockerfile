FROM nginx:latest 
RUN sed -i 's/nginx/adams/g' /usr/share/nginx/html/index.html
EXPOSE 80

