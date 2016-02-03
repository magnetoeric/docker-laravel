FROM nginx:1.7
ADD config /root/config
RUN mv /root/config/nginx.conf /etc/nginx/nginx.conf \
    && mv /root/config/servers /etc/nginx/servers
