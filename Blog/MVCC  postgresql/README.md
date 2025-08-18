## MVCC trong postgresql là gì

MVCC (Multi-Version Concurrency Control) là cơ chế kiểm soát concurrency để xử lí nhiều transaction đồng thời mà không lock bảng hay dòng. Thay vì lock, Postgresql duy trì nhiều phiên bản của 1 dòng, cho phép đọc và ghi có thể thực hiện cùng lúc trên 2 phiên bản mà không ảnh hưởng lẫn nhau.

### Tuple

Ở trong postgresql thì 1 row được gọi là 1 tuple. Khi 1 row được insert, update hay delete, Postgresql quản lý nhiều version của 1 tuple để đảm bảo tính nhất quán (consistency) và tính cô lập (isolation) cho các transaction đồng thời.

### Tuple version

Tuple version dùng để trỏ tới 1 phiên bản cụ thể của 1 row trong bảng. Thay vì sửa, xóa trực tiếp bản ghi, postgresql sẽ tạo ra 1 tuple mới và được lưu trữ trong 1 vùng gọi là Heap (sẽ nói kĩ hơn ở bài sau)

### Các thành phần trong tuple

#### xmin (insert transaction id)

- id của transaction đã tạo ra phiên bản này của tuple (tạo ra có thể là insert hoặc update)
- 1 tuple được nhìn thấy (visible) với transaction nếu transaction id hiện tại lớn hơn hoặc bằng với xmin

#### xmax: (delete transaction id)

- id của transaction dùng để đánh dấu 1 phiên bản đã bị xóa (do bị xóa hoặc bi update bởi 1 transaction khác)
- nếu xmax = 0 tức là đó là phiên bản vẫn còn "sống" (chưa bị xóa đi)

#### ctid

- địa chỉ vật lí của tuple. Do tuple được lưu trữ trên heap nên ctid chính là địa chỉ của tuple ở trên heap.

#### flags

- đánh dấu 1 tuple là live, deleted hay frozen

### Vòng đời của 1 tuple

#### Insert

- 1 tuple mới được tạo ra khi row được thêm mới
- xmin = transaction id hiện tại, xmax = 0 (tuple đang "sống")

#### Update

- khi update 1 row thì 1 tuple mới được tạo ra
- đối với tuple cũ, xmax = transaction id vừa update
- đối với tuple mới, xmin = transaction id vừa update và xmax = 0

#### Delete

- tuple vẫn còn trên heap, chỉ được đánh dấu là bị xóa
- xmax = transaction delete

Có thể thấy rằng với bất kì hành động ghi nào vào db thì postgresql lại tạo ra 1 version mới, như vậy dung lượng có thể tăng lên rất nhiều. Đối với bảng có index, các tuple trong index cũng được tạo ra cùng với bảng chính. Để giải quyết vấn đề đó, postgresql có 1 cơ chế gọi là Vacuum dùng để dọn các tuple không còn hoạt động, về vacuum mình sẽ chia sẻ ở 1 bài khác.

### Ví dụ:

Giả sử có bảng accounts có 2 giá trị id và balance

```sql
    CREATE TABLE accounts (
        id SERIAL PRIMARY KEY,
        balance NUMERIC(10, 2) NOT NULL
    );
```

Insert 1 bản ghi

```sql
   INSERT INTO accounts (id, balance) VALUES (1, 100);
```

Kiểm tra lại bản ghi vừa insert

```sql
    SELECT xmin, xmax, ctid, * FROM accounts;
```
![1](https://github.com/user-attachments/assets/739406ea-ce90-4f96-8508-af5fc8a36a53)

Kết quả: có thể thấy rằng transaction insert vừa rồi là 842, và tuple có ctid (địa chỉ trên heap) là (0,1) Thử update bản ghi

```sql
    UPDATE accounts SET balance = 120 WHERE id = 1;
```
![2](https://github.com/user-attachments/assets/104c5794-cf3e-44f1-8739-f85a61f6e011)

Kết quả: có thể thấy rằng xmin bản ghi mới là 844, tức transaction 844 đã tạo ra 1 tuple mới. Để kiểm tra lại các dead tuple, cần sử dụng extension pageinspect

```sql
    CREATE EXTENSION IF NOT EXISTS pageinspect;

    SELECT t_xmin::text AS xmin, t_xmax::text AS xmax, t_ctid::text AS ctid
    FROM heap_page_items(get_raw_page('accounts', 0));
```
![3](https://github.com/user-attachments/assets/09517ab6-0281-4e58-8ab4-8dd1eaa04ea5)

Có thể thấy rằng lần insert đầu tiên có xmin là 842, sau khi update 2 lần thì tuple mới nhất có xmin là 844 và xmax là 0 (live tuple). Đến đây thì mình nhận ra 1 điều rất thú vị đó là mặc dù lần insert đầu tiên có ctid là (0,1) nhưng lần sau nó đã chuyển thành (0, 2), và 2 tuple sau lại có cùng ctid (0, 3). Mình thử tìm hiểu thì thấy rằng postgres tận dụng vùng nhớ để cùng lưu 2 tuple dead và live có thể dùng chung.

### Những vấn đề với MVCC

Do phải lưu trữ nhiều phiên bản khác nhau nên có thể gây ra tình trạng bùng nổ storage bao gồm cả index goi là index bloat. Nếu bảng có nhiều index, thì một cập nhật nhỏ của row có thể gây ra update rất nhiều các index làm tăng dung lượng.
Tiến trình Vacuum có thể giúp dọn dẹp các version cũ nhưng phải mất công quản lí bảo trì cũng như monitor.
