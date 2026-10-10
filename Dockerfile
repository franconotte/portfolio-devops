FROM cgr.dev/chainguard/nginx

COPY index.html /usr/share/nginx/html/
COPY style.css  /usr/share/nginx/html/
COPY theme.js /usr/share/nginx/html/
EXPOSE 8080
