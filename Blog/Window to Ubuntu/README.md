### 🪟 Windows – Cấu trúc thư mục

Trong Windows, mọi thứ xoay quanh ổ đĩa ký hiệu chữ cái (C:, D:, E:...):

C:\
 ├── Program Files\
 ├── Program Files (x86)\
 ├── Windows\
 ├── Users\
 │ ├── Admin\
 │ └── Guest\
 ├── Documents and Settings\ (cũ, từ XP)  
 └── ...  
D:\
 └── Data, Movies, Projects...

C: thường chứa hệ điều hành.

D, E...: thường là phân vùng dữ liệu riêng.

Program Files: nơi cài ứng dụng.

Users\Tên_user: nơi lưu tài liệu cá nhân (Documents, Downloads, Desktop).

👉 Điểm chính: Windows quản lý file theo ổ đĩa, mỗi ổ có cây thư mục riêng.

### 🐧 Linux (Ubuntu) – Cấu trúc thư mục

Trong Linux, không có khái niệm C:, D:.
Mọi thứ bắt đầu từ một gốc duy nhất là / (root directory).

Ví dụ cây thư mục cơ bản của Ubuntu:

/
├── bin/ # lệnh cơ bản (ls, cp, mv, cat...)  
├── boot/ # file khởi động, kernel  
├── dev/ # thiết bị (ổ cứng, USB) dưới dạng file  
├── etc/ # file cấu hình hệ thống  
├── home/ # thư mục cá nhân của user  
│ ├── huyvp/  
│ │ ├── Desktop/  
│ │ ├── Documents/  
│ │ ├── Downloads/  
│ │ └── ...  
├── lib/ # thư viện hệ thống (giống DLL của Windows)  
├── media/ # nơi mount USB/CD/DVD  
├── mnt/ # nơi mount tạm ổ đĩa  
├── opt/ # ứng dụng cài thêm (giống Program Files)  
├── root/ # thư mục riêng của user root (admin)  
├── sbin/ # lệnh quản trị (shutdown, fdisk, mount...)  
├── tmp/ # file tạm  
├── usr/ # ứng dụng & thư viện người dùng  
│ ├── bin/ # lệnh thường (ls, vim, python...)  
│ ├── lib/ # thư viện  
│ └── share/ # tài nguyên chung  
└── var/ # log, dữ liệu động (database, cache)

### 🔑 So sánh nhanh

Windows Ubuntu/Linux  
Có nhiều ổ đĩa (C:, D:, E:) Chỉ có một gốc /, mọi thứ nằm dưới đó

C:\Program Files <=> /usr/bin, /usr/lib, /opt  
C:\Users\Tên_user\Documents <=> /home/username/Documents  
C:\Windows\System32 <=> /bin, /sbin, /lib  
C:\Temp /tmp  
Ký tự ổ đĩa cố định Thiết bị mount động vào /mnt hoặc /media
File config thường nằm trong Registry File config dạng text trong /etc

### 📌 Lưu ý khi bạn chuyển sang Ubuntu

Không còn C, D: thay vào đó bạn mount ổ D của Windows vào /mnt/d hoặc /media/username/DATA.

Thư mục cá nhân: thay thế cho C:\Users\huyvp là /home/huyvp.

Phần mềm: thay vì "cài vào Program Files", phần mềm được quản lý qua APT (apt install) và nằm trong /usr/bin, /usr/lib, /opt.

Config: không có registry, mà tất cả cấu hình là file text trong /etc hoặc trong ~/.config/.

👉 Nếu bạn quen kiểu "ổ C: để hệ điều hành, ổ D: để dữ liệu", thì trong Ubuntu bạn có thể:

Dùng phân vùng riêng cho /home (giống ổ D, chứa toàn bộ dữ liệu cá nhân).

/ (root) giống như ổ C, chứa hệ điều hành.
