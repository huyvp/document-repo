# Keycloak Seri

## Mục lục

1. [Integrate a profile service with Keycloak](./1.Integrate%20a%20profile%20service%20with%20Keycloak/README.md)
2. [Build Identity and Profile Management capabilities](./2.Build%20Identity%20and%20Profile%20Management%20capabilities/README.md)
3. [Config Spring Security với Keycloak](./3.Config%20Spring%20Security%20v%E1%BB%9Bi%20Keycloak/README.md)
4. [Config Keycloak login với ReactJS Web-app](./4.Config%20Keycloak%20login%20v%E1%BB%9Bi%20ReactJS%20Web-app/README.md)
5. [Configure SSO](./5.Configure%20SSO/README.md)
6. [Social Login with Google, Facebook, ...](./6.Social%20Login%20with%20Google%2C%20Facebook%2C%20.../README.md)
7. [Configure Keycloak ready for production](./7.Configure%20Keycloak%20ready%20for%20production/README.md)

8. Integrate a profile service with Keycloak
   - Keycloak sẽ chỉ cung cấp Identity và Authorization. Thông tin user phải quản lý thông qua một service
9. Build Identity and Profile Management capabilities
   - Cung cấp API cho user - verify email, change password, ...
10. Config Spring Security với Keycloak
11. Config Keycloak login với ReactJS Web-app
12. Configure SSO
13. Social Login with Google, Facebook, ...
14. Configure Keycloak ready for production
    - Security
    - Database
    - Monitoring

Monolithic Architecture

- Người dùng truy cập Front End (Web/Mobile)
- Front End chuyển hướng login đến Keycloak IDP
- Keycloak IDP xác thực và trả về token
- Front End gửi request (kèm accessToken) đến Web application (Spring Boot)
- Web application xác thực accessToken với Keycloak IDP

Microservices Architecture

- Người dùng truy cập Front End (Web/Mobile)
- Front End chuyển hướng login đến Keycloak IDP
- Keycloak IDP xác thực và trả về token
- Front End gửi request (kèm accessToken) đến API Gateway (Spring Cloud Gateway)
- API Gateway xác thực accessToken với Keycloak IDP
- API Gateway chuyển tiếp request đến các microservice phía sau (Profile Service, Other Microservices...)
- Profile Service có thể liên hệ với Keycloak IDP để lấy thông tin user profile
- Các microservice khác xử lý nghiệp vụ tương ứng
