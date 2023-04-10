FROM nginx:latest

# デフォルトで用意されている個別設定ファイルを削除
RUN rm -f /etc/nginx/conf.d/*

COPY ./docker/nginx/nginx.conf /etc/nginx/nginx.conf

# Nginxをforeground起動
CMD /usr/sbin/nginx -g 'daemon off;' -c /etc/nginx/nginx.conf