## Dùng Google Sheets làm Database cho hệ thống hàng trệu User? 😃😃😃

Levels.fyi, một trang web nghề nghiệp dành cho các chuyên gia, đã đạt được hàng triệu người dùng bằng cách sử dụng một giải pháp Database độc đáo: Google Sheets! Trong những năm đầu, mọi dữ liệu lương – hơn 100k bản ghi – được nhồi vào một file JSON duy nhất, tải thẳng xuống trình duyệt.  
Không server phức tạp, không tối ưu hóa sớm, chỉ có Google Sheets, điều này giúp họ tập trung phát triển sản phẩm, tiết kiệm chi phí hạ tầng, và dễ dàng vận hành mà không cần bảo trì server. Sự đơn giản tột độ đã giúp họ scale lên 2 triệu user/tháng.  
Vậy họ đã làm như nào??? 🤔🤔🤔

- Thành phần hệ thống:
  Hệ thống của Levels.fyi sử dụng:
  Google Forms: Nơi người dùng nhập dữ liệu ban đầu.
  Google Sheets: Lưu trữ toàn bộ dữ liệu.
  AWS Lambda: Xử lý dữ liệu và logic nghiệp vụ.
  AWS API Gateway: Cầu nối giữa frontend và backend.
- Quy trình ghi dữ liệu (Write Flow)
  Ví dụ: Khi người dùng thêm một mức lương mới:
  Phiên bản đầu tiên: Người dùng nhập trực tiếp qua giao diện Google Forms.
  Phiên bản sau này: Giao diện riêng và validate dữ liệu ngay trên frontend.

1. Frontend gọi API Gateway công khai.
2. API Gateway kích hoạt hàm Lambda.
3. Lambda xử lý và thêm dữ liệu vào Google Sheets.

- Quy trình đọc dữ liệu (Read Flow)
  Để hiển thị dữ liệu (như biểu đồ lương):
  Xử lý dữ liệu: AWS Lambda lấy dữ liệu từ Google Sheets và tạo tệp JSON.
  Lưu trữ: Tệp JSON được lưu trên AWS S3.
  Phân phối: Sử dụng AWS Cloudfront (CDN) để cache tệp JSON.
  Tải về: Trình duyệt người dùng tải tệp JSON và xử lý phía client (tính toán, vẽ biểu đồ…).

---

System design không phải lúc nào cũng cần "hoành tráng" – Đôi khi, trong giai đoạn đầu của startup, việc ưu tiên tốc độ phát triển và tiết kiệm chi phí quan trọng hơn việc xây dựng công nghệ phức tạp, giúp tập trung vào giá trị cốt lõi và thử nghiệm ý tưởng nhanh chóng 😁😁😁

Tổng hợp: Cộng Đồng System Design Việt Nam:
Nguồn: https://www.levels.fyi/blog/scaling-to-millions-with-google-sheets.html
