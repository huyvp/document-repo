# msssql
docker run -e 'ACCEPT_EULA=Y' --name mssql -e 'SA_PASSWORD=mssq@12345' -p 1433:1433 -v vmssql:/var/opt/mssql -d mcr.microsoft.com/mssql/server:2019-latest
# postgresql
docker run --name postgresql -e POSTGRES_PASSWORD=hh1122334455 -e POSTGRES_USER=postgres -p 5432:5432 -d -v vpostgresql:/var/lib/postgresql/data postgres:16.2
# neo4j
docker run -d --name neo4j --publish=7687:7687 --publish=7474:7474 -e 'NEO4J_AUTH=neo4j/neo4j123456' neo4j:latest
# redis
docker run -d --name redis -p 6379:6379 redis redis-server --requirepass "TmGNTwGNqgexF9jE4rB8LDy3u3S3i41oHAzCaOvnb6Y="
# node
docker run -d --rm --entrypoint sh node:22-alpine

# Thêm NodeSource repo cho Node.js 20.x (có thể thay bằng 22.x nếu muốn mới hơn) 
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - 
# Cài Node.js 
sudo apt install -y nodejs

docker volume create --name sonarqube_data
docker volume create --name sonarqube_logs
docker volume create --name sonarqube_extensions

docker run -d --name sonarqube -p 9000:9000 -e SONAR_JDBC_URL=jdbc:sqlserver://localhost;databaseName=SonarQube;encrypt=True;trustServerCertificate=true;loginTimeout=30; -e SONAR_JDBC_USERNAME=sa -e SONAR_JDBC_PASSWORD=mssq@12345 -v sonarqube_data:/opt/sonarqube/data -v sonarqube_extensions:/opt/sonarqube/extensions -v sonarqube_logs:/opt/sonarqube/logs <image_name>

Sonarqube setup:
# Create database:
	CREATE DATABASE SonarQube
	COLLATE SQL_Latin1_General_CP1_CS_AS;
# Change properties file(D:\sonarqube-10.1.0.73491\conf)
	sonar.jdbc.username=sa
	sonar.jdbc.password=mssq@12345
	sonar.jdbc.url=jdbc:sqlserver://localhost;databaseName=SonarQube;encrypt=True;trustServerCertificate=true;loginTimeout=30;