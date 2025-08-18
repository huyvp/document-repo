# SHRINK trong SQL Server

## 1. SHRINK là gì?

`SHRINK` trong SQL Server là quá trình thu hồi không gian trống trong file dữ liệu (`.mdf`, `.ndf`) hoặc file log (`.ldf`). Không gian trống được tạo ra do các thao tác như `DELETE`, `TRUNCATE`, `DROP TABLE`, `DROP/REBUILD INDEX`,... nhưng không được SQL Server tự động thu hồi.

> **Lưu ý:** `SHRINK` không xóa dữ liệu thật, mà chỉ thu hồi vùng nhớ không sử dụng.

---

## 2. Vì sao cần SHRINK?

### ✳ Do `DELETE`

- Khi xóa dữ liệu bằng `DELETE`, các trang dữ liệu bị đánh dấu là trống nhưng không giải phóng khỏi file.
- SQL Server giữ các trang trống để tái sử dụng, tránh việc mở rộng file nhiều lần.

🔸 **Ví dụ dễ hiểu:**

> Một lớp học có 50 bộ bàn ghế. Khi 10 học sinh chuyển trường (xóa dữ liệu), bàn ghế vẫn được giữ nguyên cho lớp, không nhường cho lớp khác.

### ✳ Do `TRUNCATE`

- `TRUNCATE` xóa toàn bộ bảng và các trang được giải phóng về cho database.
- Lúc này có thể dùng `SHRINK` để thu hồi không gian trống và giảm kích thước file `.mdf`.

### ✳ Do `DROP TABLE`, `DROP/REBUILD INDEX`

- Giải phóng dữ liệu tương tự `TRUNCATE`, có thể SHRINK được.

### ✳ File log (`.ldf`)

- Nếu `Recovery Model = FULL`, cần chạy `BACKUP LOG` trước khi SHRINK log file:

```sql
BACKUP LOG YourDatabase TO DISK = 'NUL';
DBCC SHRINKFILE (YourLogFile, TARGET_SIZE_MB);
```

- Nếu `Recovery Model = SIMPLE`, có thể SHRINK trực tiếp:

```sql
DBCC SHRINKFILE (YourLogFile, TARGET_SIZE_MB);
```

---

## 3. Các câu lệnh SHRINK

| Loại SHRINK                    | Lệnh sử dụng                                        |
| ------------------------------ | --------------------------------------------------- |
| SHRINK toàn bộ DB              | `DBCC SHRINKDATABASE (YourDatabase);`               |
| SHRINK file dữ liệu cụ thể     | `DBCC SHRINKFILE (YourDataFile, TARGET_SIZE_MB);`   |
| SHRINK file log                | Xem phần log ở trên                                 |
| SHRINK không gây fragmentation | `DBCC SHRINKDATABASE (YourDatabase, TRUNCATEONLY);` |

---

## 4. Phân mảnh (Fragmentation) là gì?

### ✅ Định nghĩa

Phân mảnh là hiện tượng dữ liệu không được lưu trữ liên tục, gây tốn thời gian truy xuất.

#### 📘 Ví dụ:

Nếu chương sách (dữ liệu) bị đặt rải rác (phân mảnh), bạn sẽ phải lật sách nhiều lần → chậm.

### 📌 Loại phân mảnh:

- **Internal Fragmentation**: Page chứa ít dữ liệu (ví dụ: chỉ 30% dung lượng). Do xóa, cập nhật.
- **External Fragmentation**: Các page bị xếp không liên tiếp nhau trên đĩa.

---

## 5. Cách kiểm tra phân mảnh

```sql
SELECT
    dbschemas.[name] as 'Schema',
    dbtables.[name] as 'Table',
    dbindexes.[name] as 'Index',
    indexstats.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, 'LIMITED') AS indexstats
    INNER JOIN sys.tables dbtables ON dbtables.[object_id] = indexstats.[object_id]
    INNER JOIN sys.schemas dbschemas ON dbtables.[schema_id] = dbschemas.[schema_id]
    INNER JOIN sys.indexes AS dbindexes ON dbindexes.[object_id] = indexstats.[object_id]
        AND indexstats.index_id = dbindexes.index_id
WHERE indexstats.avg_fragmentation_in_percent > 10
ORDER BY indexstats.avg_fragmentation_in_percent DESC;
```

---

## 6. Xử lý phân mảnh

| Mức phân mảnh | Hành động    |
| ------------- | ------------ |
| 5–30%         | `REORGANIZE` |
| >30%          | `REBUILD`    |

### Lệnh ví dụ:

```sql
-- Reorganize chỉ mục
ALTER INDEX [YourIndex] ON [YourTable] REORGANIZE;

-- Rebuild chỉ mục
ALTER INDEX [YourIndex] ON [YourTable] REBUILD;
```

---

## 7. SHRINK có phải lúc nào cũng tốt?

🔸 Không hẳn. SHRINK thường xuyên có thể gây ra phân mảnh nghiêm trọng, làm giảm hiệu suất truy vấn.

### 👉 Khuyến nghị:

- Chỉ nên SHRINK sau khi xóa lượng lớn dữ liệu.
- Sau khi SHRINK nên `REBUILD INDEX`.
- Không nên SHRINK thường xuyên nếu DB vẫn đang phát triển.
