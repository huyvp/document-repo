### Monolithic Architecture
- Người dùng truy cập Front End (Web/Mobile)
- Front End chuyển hướng login đến Keycloak IDP
- Keycloak IDP xác thực và trả về token
- Front End gửi request (kèm accessToken) đến Web application (Spring Boot)
- Web application xác thực accessToken với Keycloak IDP
![image](https://github.com/user-attachments/assets/e9cb7344-8ce6-4b04-a608-f211cd77eba2)

### Microservices Architecture
- Người dùng truy cập Front End (Web/Mobile)
- Front End chuyển hướng login đến Keycloak IDP
- Keycloak IDP xác thực và trả về token
- Front End gửi request (kèm accessToken) đến API Gateway (Spring Cloud Gateway)
- API Gateway xác thực accessToken với Keycloak IDP
- API Gateway chuyển tiếp request đến các microservice phía sau (Profile Service, Other Microservices...)
- Profile Service có thể liên hệ với Keycloak IDP để lấy thông tin user profile
- Các microservice khác xử lý nghiệp vụ tương ứng
![image](https://github.com/user-attachments/assets/bd9a8d84-5948-459d-8d71-73d6b90fd7d3)