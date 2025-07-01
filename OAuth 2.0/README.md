# TÀI LIỆU HỌC TẬP: LỘ TRÌNH OAUTH2 VỚI SPRING BOOT 3

## Mục lục

1. [Overview of OAuth2](./1.Overview%20of%20OAuth2/README.md)
2. [Main components of OAuth2](./2.Main%20components%20of%20OAuth2/README.md)
3. [Other core concepts](./3.Other%20core%20concepts/README.md)
4. [Grant Types](./4.Grant%20Types/README.md)
5. [Integrate with external IdP](./5.Integrate%20with%20external%20IdP/README.md)
6. [Build your own OAuth2 Server](./6.Build%20your%20own%20OAuth2%20Server/README.md)
7. [Additional information and community support](./7.Additional%20information%20and%20community%20support/README.md)

---

## I. TỔNG QUAN VỀ OAUTH2 VÀ TẦM QUAN TRỌNG

OAuth2 được giới thiệu là một trong những từ khóa "**đang rất là hot và được các bạn quan tâm ở cái thời điểm hiện tại**". Mức độ quan tâm này xuất phát từ việc OAuth2 là một **tiêu chuẩn được sử dụng "rất rộng rãi"** và có thể thấy "**ở khắp mọi nơi trong cuộc sống hàng ngày**" của chúng ta.

- **Ví dụ minh họa:** Một trong những ứng dụng dễ thấy nhất của OAuth2 là các tùy chọn đăng nhập/đăng ký như "**Continue with Google**" hoặc "**Continue with Facebook**" khi bạn tương tác với các dịch vụ trực tuyến. Các chức năng này thực chất đều được xây dựng dựa trên OAuth2.
- **Thách thức và sự tò mò:** Mặc dù phổ biến, OAuth2 cũng được nhận định là "**khá là khó hiểu**", điều này lại "**kích thích cái sự tò mò của các bạn rất nhiều**".
- **Mục tiêu của series:** Series video này không chỉ làm rõ chính xác OAuth2 là gì, tại sao nó được sử dụng phổ biến, và cách vận dụng nó vào các ứng dụng. Trọng tâm là **tiếp tục phát triển "identity service"** mà người hướng dẫn đã cùng xây dựng trong khóa học Spring Boot cơ bản trước đó, để **tích hợp nó với OAuth2**.

  ![image](https://github.com/user-attachments/assets/84055844-8199-47cc-a884-e965cdb486e7)

## II. LỘ TRÌNH HỌC CHI TIẾT TRONG SERIES

Series này được cấu trúc thành một lộ trình học từng bước, từ các khái niệm cơ bản đến việc triển khai nâng cao.

### 1. Các Khái niệm Cơ bản nhất:

- Tìm hiểu định nghĩa chính xác về **OAuth2 là gì và OpenID là gì** (một khái niệm thường đi kèm với OAuth2).
- Phân tích **khi nào và tại sao nên sử dụng OAuth2**, cũng như các trường hợp mà nó phát huy tác dụng lớn nhất và khi nào nó không hiệu quả.

### 2. Các Thành phần Chính (Actors) trong Giao thức OAuth2:

- Nắm vững các thực thể tham gia vào một giao thức OAuth2, bao gồm:
  - **Resource Owner:** Người sở hữu tài nguyên.
  - **Resource Server:** Người cung cấp khả năng truy cập tới tài nguyên đó.
  - **Client**.
  - **Authorization Server:** Một thành phần được nhấn mạnh là "**rất là quan trọng**".

### 3. Các Khái niệm Cốt lõi khác của OAuth2:

- Sau khi hiểu các thành phần chính, series sẽ đi sâu vào các khái niệm nền tảng khác:
  - **Service Provider:** Là gì và vai trò của nó trong bức tranh chung của OAuth2.
  - **Scope:** Phạm vi quyền hạn được cấp.
  - **ID Token, Access Token, Refresh Token:** Các loại token quan trọng được sử dụng trong luồng OAuth2.
  - **Discovery Endpoints:** Các điểm cuối để cấu hình (config) một OAuth2 server.

### 4. Tìm hiểu sâu về Grant Types (Các luồng ủy quyền):

- Đây là một phần quan trọng, tập trung vào cách thức trao đổi credential để lấy được Access Token hoặc ID Token.
- Các **Grant Type phổ biến** sẽ được nghiên cứu chi tiết:
  - **Password**.
  - **Client Credential**.
  - **Authorization Code**.
  - **Implicit**.
- Mỗi luồng này định nghĩa một giao thức khác nhau để hoạt động.

### 5. Tích hợp Hệ thống hiện tại với một OAuth2 Identity Provider (IdP) bên ngoài:

- Đây là phần thực hành quan trọng, hướng dẫn cách tích hợp hệ thống của bạn với các IdP lớn đã cung cấp hệ thống thông qua OAuth2, như **Google, Facebook, GitHub, hoặc Apple**.
- **Tập trung vào Google:** Người hướng dẫn sẽ cụ thể hóa việc tích hợp với Google, đồng thời khẳng định rằng cách làm với các hệ thống khác cũng "**tương tự nhau**" do đều tuân theo tiêu chuẩn OAuth2.
- **Khái niệm Consent:** Tìm hiểu về "**consent**" – chính là **thỏa thuận giữa người dùng và ứng dụng** về việc cung cấp thông tin, đảm bảo ứng dụng chỉ có thể truy cập những thông tin mà người dùng đồng ý.
- **Onboarding người dùng:** Hướng dẫn cách **đưa (onboarding) một người dùng từ hệ thống OAuth2 IdP** (ví dụ: từ Google) vào hệ thống nội tại hiện có của bạn. Quá trình này sẽ tuân theo các "**best practice**" đang được sử dụng phổ biến trong các công ty lớn.
- **Xác thực và Ủy quyền (Authentication & Authorization):** Sau khi người dùng được onboard, khóa học sẽ chỉ ra cách xử lý việc "**authentication và authorization với user đó**" bằng cả **hệ thống nội tại của bạn và khi user đăng nhập bằng Google** trong các tình huống khác nhau.

### 6. Tự xây dựng một OAuth2 Server của riêng mình:

- Là một bước nâng cao, series sẽ chứng minh rằng việc **tự xây dựng một OAuth2 server của riêng bạn là "không phải là một điều quá xa xôi" và "hoàn toàn có thể làm được"** dựa trên Spring Framework và Spring Security.
