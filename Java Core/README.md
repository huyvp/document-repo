> 💡 This template explains our QA process for shipping bug-free software.

## **1. Kiểu dữ liệu**

### Primitive data

![image](https://github.com/user-attachments/assets/e76925bc-9f3a-4af6-86f5-6f43fead5b42)


### Reference data

**Kiểu dữ liệu tham chiếu** là kiểu dữ liệu của đối tượng. Biến của kiểu dữ liệu tham chiếu chỉ chứa địa chỉ của đối tượng dữ liệu tại bộ nhớ **Stack**. Đối tượng dữ liệu lại nằm ở bộ nhớ **Heap**. Một số kiểu dữ liệu cụ thể như các **mảng** (Array), **lớp đối tượng** (Class) hay kiểu **lớp giao tiếp** (Interface).

Ví dụ: String, bản chất String là một mảng lưu nhiều kí tự (char). Việc khai báo **String name = ‘KTEAM’** có thể diễn đạt như sau:

![image2](https://github.com/user-attachments/assets/4546447f-b1c9-4022-9da7-64de912a7e64)


## **2. Quản Lý Bộ Nhớ**

![image3](https://github.com/user-attachments/assets/cdbd2a5b-30f2-4d97-88e3-108d4dbd5e6c)

![image4](https://github.com/user-attachments/assets/39e8b70d-3563-4439-ae07-e4f7c7fcee09)

![image5](https://github.com/user-attachments/assets/99434ce3-0bda-48d8-9c89-4d0813c62185)

![image6](https://github.com/user-attachments/assets/3edce364-3dff-47e5-8865-7e92115f4e4c)

## **3. Các tính chất cơ bản**

- **Tính đóng gói (Encapsulation)**:
  - Dữ liệu và hành động liên quan tới dữ liệu của lớp nào thì gói gọn bên trong lớp đó.
  - Ví dụ: Các thuộc tính để private.
- **Tính kế thừa (Inheritance)**:
  - Thừa hưởng đặc trưng các lớp khác.
- **Tính đa hình (Polymorphism)**:
  - Overloading khi biên dịch, overwrite khi runtime.
- **Tính trừu tượng (Abstraction)**:
  - Chỉ tiết lộ những thành phần thiết yếu với người dùng, ẩn dấu đi những thông tin quan trọng và không cần thiết.
  - Thể hiện qua abstract, interface.

## **4. Abstract class vs Interface**

- **Khi nào cần sử dụng abstract class**:

  - Khi nhóm đối tượng liên quan cần chia sẻ chung một đoạn code hay tính năng nào đó. Đưa các thành phần chung vào lớp abstract và các lớp con liên quan sẽ kế thừa lớp abstract này.
  - Có thể dùng non-static, non-final để có thể truy cập và sửa đổi.
  - Có thể dùng được nhiều các access modifier khác nhau.

- **Khi nào sử dụng interface**:
  - Đạt được tính trừu tượng hoàn toàn.
  - Đa kế thừa.
  - Muốn các lớp không liên quan với nhau cũng có thể sử dụng được các tính năng interface.
  - Không thể tạo đối tượng mới bằng `new`.
  - Sử dụng tính trừu tượng trong OOP.

| **Tiêu chí**    | **Abstract class**                            | **Interface**                                   |
| --------------- | --------------------------------------------- | ----------------------------------------------- |
| Constructor     | Có thể chứa constructor                       | Không hỗ trợ                                    |
| Kiểu biến       | final, non-final, static, non-static          | final, static                                   |
| Hằng số         | Có hoặc không                                 | Mặc định hằng số                                |
| Đa kế thừa      | Không hỗ trợ                                  | Có thể kế thừa nhiều interface                  |
| Đa thực thi     | Có thể extend lớp khác và implement interface | Chỉ có thể extend interface khác                |
| Access modifier | Hỗ trợ tất cả                                 | Chỉ có public + private (Java > 9)              |
| Mục đích        | Lớp cha chung cho các nhóm lớp liên quan      | Định ra hành động có thể dùng chung cho các lớp |
| Tốc độ          | Nhanh                                         | Chậm vì phải điều hướng                         |

## **5. Public, private, protected**

| **Modifier** | **Class** | **Package** | **Subclasses** | **World** |
| ------------ | --------- | ----------- | -------------- | --------- |
| Public       | ✔         | ✔           | ✔              | ✔         |
| Protected    | ✔         | ✔           | ✔              | ❌        |
| No modifier  | ✔         | ✔           | ❌             | ❌        |
| Private      | ✔         | ❌          | ❌             | ❌        |

### Một số kí hiệu:

- `(-)` Private
- `(+)` Public
- `(#)` Protected

## **6. Java Collections**

![image7](https://github.com/user-attachments/assets/9d4d1b2a-8395-4453-a848-0e6718ace962)


- **Set**: không có giá trị trùng lặp >< List.
- Tập trung sử dụng `ArrayList`, `TreeSet` và `Stack`.

### Một số hàm trong Java Collection:

| Phương thức   | Mô tả                    |
| ------------- | ------------------------ |
| `add(o)`      | Thêm phần tử mới         |
| `clear()`     | Xóa tất cả phần tử       |
| `isEmpty()`   | Kiểm tra rỗng            |
| `iterator()`  | Trả lại iterator         |
| `remove(o)`   | Xóa phần tử              |
| `size()`      | Trả về số lượng phần tử  |
| `contains(o)` | Kiểm tra tồn tại phần tử |

### **Stream API**

- **stream()**: xử lý tuần tự
- **parallelStream()**: xử lý song song

| Phương thức                           | Mô tả                |
| ------------------------------------- | -------------------- |
| `forEach()`                           | Lặp qua từng phần tử |
| `map()`                               | Chuyển đổi đối tượng |
| `filter()`                            | Lọc theo tiêu chí    |
| `limit()`                             | Giới hạn kích thước  |
| `collect()`                           | Trả lại danh sách    |
| `allMatch(), anyMatch(), noneMatch()` | Kiểm tra điều kiện   |

- **Thống kê**: count, min, max, sum, average
  - `IntSummaryStatistics`, `LongSummaryStatistics`, `DoubleSummaryStatistics`

```java
IntSummaryStatistics stats = numbers.stream().mapToInt(x -> x).summaryStatistics();
System.out.println("Max is: " + stats.getMax());
System.out.println("Min is: " + stats.getMin());
```
