# Integrate with Keycloak

### 1. Prerequisites
- docker

### 2. Install
- Run keycloak default  

    `sh
        docker run quay.io/keycloak/keycloak:25.0.0
    `  

- Run keycloak on port 8180  

    `sh
        docker run -d  --name keycloak -p 8180:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:25.0.0 start-dev
    `  
    + Port default of keycloak: 8080  
    + start-dev: Run with dev

### 2. Steps
#### Create new app session - realm
#### Create new client: as a client of a resource server  
- Authentication flow: compare with OAuth2
    - Standard flow <=> authentication code  
    - Direct access grand <=> username/password
    - Implicit flow <=> authentication token  
    - Service account roles <=> Client credential



