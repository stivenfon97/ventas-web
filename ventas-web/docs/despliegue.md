docker build -t ventas-web .


docker run -d -p 8080:80 --name ventas -e "APP_ENV=local" -e "APP_DEBUG=true" -e "APP_KEY=base64:6nQ4oIZyVcQ61HtJ6IV4eqMAH5jNZ+zodPlS5Bco52U=" -e "APP_URL=http://localhost:8080" -e "DB_CONNECTION=mysql" -e "DB_HOST=host.docker.internal" -e "DB_PORT=3306" -e "DB_DATABASE=ventas" -e "DB_USERNAME=root" -e "DB_PASSWORD=" ventas-web