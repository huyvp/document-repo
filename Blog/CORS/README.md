## CORS

Ae lập trình web chắc không ít lần đập bàn phím vì cái lỗi đỏ lòm "CORS error" trên console đúng không? 😅 Hồi mới làm web, mình cũng hoang mang, không hiểu sao trang A lại không gọi được API từ trang B, rồi thì SOP, CORS, CSRF nó là cái gì mà rối rắm vậy.  
Mình muốn chia sẻ lại góc nhìn dễ hiểu nhất, hy vọng ae nào đang bắt đầu còn mơ hồ sẽ thấy sáng tỏ hơn nhé!

1. Người Gác Cổng Khó Tính - Same-Origin Policy (SOP) 🚪
   Tưởng tượng trình duyệt là một tòa nhà chung cư, còn mỗi tab bạn mở là một căn hộ (website). SOP giống như ông bảo vệ khó tính, ổng có luật: "Căn hộ nào thì chỉ được xem đồ đạc trong căn hộ đó thôi, không được tự tiện ngó sang nhà hàng xóm!".  
   "Nhà hàng xóm" ở đây tức là một "Origin" (Nguồn gốc) khác. Origin được xác định bởi 3 thứ: Giao thức (http/https) + Tên miền (google.com, mybank.com) + Cổng (80, 443). Chỉ cần khác 1 trong 3 là thành "hàng xóm" rồi.  
   Tại sao lại có luật này? Để bảo vệ bạn đó! Nếu không có SOP, bạn đang đăng nhập Facebook ở tab 1, lỡ tay bấm vào link lạ mở ra tab 2 (evil.com). Trang evil.com này có thể lén lút gửi yêu cầu sang tab 1 đọc trộm tin nhắn, danh sách bạn bè của bạn. Ghê chưa! SOP chặn đứng chuyện này. Nó là luật của trình duyệt, nhớ nhé!
2. Giấy Thông Hành - Cross-Origin Resource Sharing (CORS) 📜
   Ông bảo vệ SOP khó quá cũng khổ. Web giờ cần gọi API tùm lum, lấy font từ CDN, nhúng nội dung từ bên thứ ba... Chẳng lẽ cấm hết?
   Thế là CORS ra đời, như cái "giấy thông hành". Server (chủ nhà) có thể cấp giấy này để nói với ông bảo vệ (trình duyệt): "À, thằng myuikit.com này là người quen, cho nó vào lấy cái font chữ nhé!". Server làm điều này bằng cách gửi một cái "dấu mộc" đặc biệt trong phản hồi gọi là header Access-Control-Allow-Origin. Trình duyệt thấy dấu này hợp lệ thì mới cho phép trang web kia nhận dữ liệu.
3. Khoan! Sao Có Lúc POST Vẫn Đi Được? Simple vs Preflight Request 🤔  
   Đây là khúc nhiều người rối nè. "Rõ ràng khác origin, sao có lúc tôi thấy request POST vẫn gửi đi, chỉ là không đọc được kết quả, có lúc thì bị chặn ngay từ đầu?".
   Bí mật nằm ở chỗ trình duyệt chia yêu cầu cross-origin làm 2 loại:  
   Simple Requests: Mấy cái cơ bản như GET, HEAD, và POST kiểu submit form HTML truyền thống (application/x-www-form-urlencoded hoặc multipart/form-data). Với loại này, trình duyệt nghĩ "chắc không nguy hiểm lắm", nên nó gửi yêu cầu đi luôn (kèm cả cookie của trang đích!). Sau đó, nó mới kiểm tra "giấy thông hành" CORS trong phản hồi. Nếu không có giấy, nó không cho đọc kết quả, báo lỗi CORS.  
   Non-Simple/Preflighted Requests: Mấy cái phức tạp hơn như PUT, DELETE, POST gửi JSON (application/json), hoặc yêu cầu có header phức tạp hơn (các bạn có thể tự tìm hiểu thêm). Trình duyệt cẩn thận hơn, nó gửi một tin nhắn OPTIONS (gọi là preflight) hỏi server trước: "Ê server, lát nữa tao tính gửi yêu cầu POST JSON từ abc.com nè, mày duyệt không?". Nếu server không trả lời "OK" kèm giấy thông hành CORS hợp lệ cho cái preflight này, trình duyệt sẽ hủy luôn, không gửi request chính đi nữa.  
   => Đó là lý do bạn thấy lúc thì lỗi CORS báo ngay (preflight fail), lúc thì request vẫn đi trong tab Network nhưng code JS không nhận được gì (simple request bị chặn đọc).
4. Lỗ Hổng Chết Người - Cross-Site Request Forgery (CSRF) 💀
   Nguy hiểm nằm ở cái "Simple Request" đó! Vì nó được gửi đi luôn và mang theo cookie xác thực của bạn, kẻ xấu (trang evil.com) có thể lợi dụng.
   Tưởng tượng: Bạn đang đăng nhập mybank.com. Bạn lỡ click vào link quảng cáo, mở ra trang evil.com. Trang này có thể chứa một cái form ẩn tự động submit một yêu cầu POST (simple request!) đến mybank.com/transfer?to=hacker&amount=10000. Trình duyệt ngoan ngoãn gửi request này đi, kèm luôn cookie chứng minh bạn đang đăng nhập mybank.com. Server mybank.com thấy yêu cầu hợp lệ (có cookie mà), thế là tiền của bạn không cánh mà bay! 💸  
   Điều đáng sợ là evil.com không cần đọc kết quả trả về làm gì, nó chỉ cần hành động chuyển tiền được thực hiện. SOP/CORS bó tay với vụ này vì nó chỉ tập trung vào việc đọc dữ liệu cross-origin thôi!
5. Ai Mới Là Người Hùng Chống CSRF? 🛡️  
   Không phải SOP/CORS, mà chính là server phải tự bảo vệ mình khỏi CSRF. Các cách phổ biến:
   - CSRF Tokens: Server tạo một mã bí mật, duy nhất cho mỗi phiên làm việc, nhúng vào form. Khi submit, mã này phải được gửi kèm. Trang evil.com không biết mã này nên request giả mạo sẽ bị từ chối.
     SameSite Cookies: Thuộc tính mới của cookie giúp trình duyệt biết khi nào thì không nên gửi cookie đi kèm yêu cầu cross-origin.

### Kết Lại:

SOP: Luật cơ bản của trình duyệt, chặn đọc cross-origin.
CORS: Cách server cho phép nới lỏng SOP một cách có kiểm soát.
Simple vs Preflight: Giải thích tại sao có lúc request đi, lúc bị chặn ngay.
CSRF: Lỗ hổng nguy hiểm lợi dụng simple request + cookie, SOP/CORS không cản được.
Server Defenses (CSRF Token, SameSite): Vũ khí chính chống lại CSRF.
Hiểu rõ mấy cái này không chỉ giúp fix lỗi CORS mà còn giúp code web an toàn hơn hẳn. Hy vọng bài viết này giúp bạn "thông não" phần nào! 💪
