> 💡 This template explains our QA process for shipping bug-free software.

---

## **1. Kiểu dữ liệu**

### Primitive data

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/a3047f5a-308b-4e1a-b787-db2d2e5f3deb/image.png)

### Reference data

**Kiểu dữ liệu tham chiếu** là kiểu dữ liệu của đối tượng. Biến của kiểu dữ liệu tham chiếu chỉ chứa địa chỉ của đối tượng dữ liệu tại bộ nhớ **Stack**. Đối tượng dữ liệu lại nằm ở bộ nhớ **Heap**. Một số kiểu dữ liệu cụ thể như các **mảng** (Array), **lớp đối tượng** (Class) hay kiểu **lớp giao tiếp** (Interface).

Ví dụ: String, bản chất String là một mảng lưu nhiều kí tự (char). Việc khai báo **String name = ‘KTEAM’** có thể diễn đạt như sau:

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/a1fd8861-c084-4c27-b7de-9a5b96c99f15/image.png)

---

## **2. Quản Lý Bộ Nhớ**

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/2135a8c6-b664-4c19-97bd-33036739baaa/image.png)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/8f0dffd6-c9bb-43f5-a4f5-cc132a9f6da6/image.png)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/6336f5ba-6123-42d0-92f5-35055f65f2f0/image.png)

![image.png](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/ddcb0d8e-fa76-4ebe-b7fe-ec85efb9ee96/image.png)

---

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

---

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

---

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

---

## **6. Java Collections**

![collections-hierarchy](http://www.startertutorials.com/corejava/wp-content/uploads/2018/02/collections-hierarchy.png)

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

---

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
