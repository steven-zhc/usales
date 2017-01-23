# MySQL
Running mysql
> docker run --name mysql -v D:/Library/usales/database:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=uadmin -p 3306:3306 -d mysql:latest

# usales-ugly

## Initial workspace
> cp ./../build/libs/*.war ./

## Build image
> docker build -t usales-ugly .

## Running container

- Windows
    docker run --rm --name usales-ugly -v D:/Library/usales/application-production.yml:/app/application-production.yml -p 8080:8080 -d usales-ugly
- Linux/Mac