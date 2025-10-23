![](https://f8-zpcloud.zdn.vn/7588597425538060564/7d5396ec953c4d62142d.jpg)

## git --version

https://xuanthulab.net/git-va-github/ https://xuanthulab.net/git-va-github/

# Thiết lập ban đầu

- git config --global [user.name](http://user.name/) "<Tên người dùng>"
- git config --global user.email "<Địa chỉ mail>"
- Xem lại hoặc thay đổi:
  git config user.email
  git config [user.name](http://user.name/)
  git config --list
- Xem số lượng commit của mọi người
  git shortlog -sn --no-merges 

# Tạo local repository mới

- mkdir <dirname>: tạo thư mục mới
- cd tutorial: di chuyển đến thư mục
- git init: sử dụng lệnh init để di chuyển đến thư mục

# Lưu thông tin đã thay đổi để chuẩn bị commit

- git status: kiểm tra trạng file thái thư mục
- git add <file> <file2>...: đăng ký file vào trong Index
- git add . : đăng ký tất cả file vào trong Index
- git status: Hiển thị tất cả thông tin file
  - s: Hiển thị thông tin ngắn gọn hơn
- git stash: Lưu file tạm thời ko cho add vào staging (khi git status ko thấy thay đổi file)
  - git stash list : Xem tất cả stash
  - git stash apply stash@{\_}: Lấy ra khỏi stash nhưng ko xóa khỏi stash
  - git stash pop stash@{\_}: Lấy ra khỏi stash nhưng xóa khỏi stash
  - git stash clear: xóa tất cả stash.
- git checkout HEAD <tên file>: Hủy thay đổi file-trở về ở HEAD trước = git checkout HEAD <tên file>
- git checkout HEAD~1 <tên file> : Quay lại file ở commit cũ
- git restore <tên file> : Hủy thay đổi file ở working dir

# Commit File

- git commit -m "<chú thích commit thay đổi>": commit lên repository
  - a: Thực hiện tương đương git add rồi tự động chạy commit
  - amend: sửa commit (chỉ cần sửa message). Nếu commit cũ lỗi thì tự tạo commit mới
- git reset --soft HEAD~1: Hủy commit và chuyển xuống vùng staging để có thể commit lại
- git reset --hard HEAD~1: Hủy commit hoàn toàn (xóa cả trong staging)
- git reset <hash commit> : reset về comit trước
- git log: Hiển thị lịch sử của repository
  - p -2: Hiển thị chi tiết 2 log 2 commit cuối
  - 2: hiển thị log 2 commit cuối cùng
  - -oneline(--author --grep=”cmt của commit”): Hiển thị thông tin trong cùng 1 dòng
  - - star hoặc -- shortstat: Hiển thị ngắn gọn hơn
- git checkout <6 kí tự đầu của commit cần quay lại>: Quay lại commit cũ
- git diff <tên file>: Xem file đã thay đổi gì ở thư mục làm việc(so sánh thay đổi ở working directory vs staging)
- git restore --staged <tên file> : Hủy thay đổi file ở staging

# Đẩy file lên remote repository

- git remote -v: xem trạng thái file có thể được push chưa
- git remote add origin <link of repository>: thêm đuôi origin cho file
- git push origin <tên nhánh>: đẩy file lên remote
- git pull origin <tên nhánh>: cập nhật code từ nhánh
- git clone origin <tên nhánh>: clone code về máy local
- git diff --staged <tên file>: Xem file đã thay đổi gì ở staging (so sánh thay đổi ở local repo vs staging)

# Làm việc với nhánh

- git branch <tên nhánh mới>: tạo nhánh mới
- git branch : xem nhánh trên remote
- git branch -a : hiển thị các branch cả local và remote
- git restore . : Hồi phục tất cả các file đã dùng lệnh
- git checkout <tên nhánh>: chuyển sang nhánh mong muốn
- git switch<tên nhánh>: chuyển sang nhánh mong muốn
- git branch -d <tên nhánh> : xóa nhánh
- git checkout -b <tên nhánh> : tạo branch + checkout sang branch đó
- git merge <tên nhánh>: Hợp nhất code sang nhánh chính(đứng trên nhánh chính)
- git branch -r: check xem có bao nhiêu nhánh trên remote repo

