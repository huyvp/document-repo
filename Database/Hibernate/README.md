# 🔧 PHẦN 1: KIẾN TRÚC HIBERNATE

## 1.1. Sơ đồ kiến trúc Hibernate

```
       Application
           │
       Hibernate API
           │
 ┌────────┴─────────┐
 │                  │
SessionFactory  Configuration
       │                  │
     Session          Mapping metadata
       │
  Transaction
       │
   JDBC + SQL
       │
   Database (RDBMS)
```

## 1.2. Thành phần chính

| Thành phần       | Mô tả                                                                                  |
| ---------------- | -------------------------------------------------------------------------------------- |
| `Configuration`  | Load file cấu hình (`hibernate.cfg.xml`), khởi tạo `SessionFactory`.                   |
| `SessionFactory` | Singleton, được tạo một lần duy nhất khi ứng dụng start. Dùng để tạo `Session`.        |
| `Session`        | Đại diện cho kết nối tới DB. Dùng để thao tác với entity (save, update, delete, etc.). |
| `Transaction`    | Quản lý giao dịch (commit/rollback).                                                   |
| `Query`          | Đại diện cho HQL hoặc Native SQL query.                                                |
| `Entity Classes` | Class Java ánh xạ với bảng DB.                                                         |

---

# ⚙️ PHẦN 2: CÁCH HIBERNATE HOẠT ĐỘNG

## 2.1. Quy trình từ ứng dụng → cơ sở dữ liệu

1. **Ứng dụng tạo SessionFactory** từ `hibernate.cfg.xml`.
2. **Session được tạo ra từ SessionFactory** → tương ứng 1 kết nối DB.
3. **Session quản lý lifecycle của các entity object**:

   - Gọi `save()`, `update()`, `delete()`, `get()`,...

4. Hibernate chuyển object thành SQL dựa trên ánh xạ (ORM).
5. Hibernate sử dụng JDBC để gửi SQL đến DB.
6. Hibernate nhận kết quả từ DB → map về object Java.

---

# 📦 PHẦN 3: DỰ ÁN VÍ DỤ THỰC TẾ

## 3.1. Cấu trúc thư mục

```
src/
├── hibernate.cfg.xml
└── com.example.hibernate/
    ├── HibernateUtil.java
    ├── User.java
    └── MainApp.java
```

---

## 3.2. File cấu hình `hibernate.cfg.xml`

```xml
<!DOCTYPE hibernate-configuration PUBLIC
        "-//Hibernate/Hibernate Configuration DTD 3.0//EN"
        "http://hibernate.sourceforge.net/hibernate-configuration-3.0.dtd">
<hibernate-configuration>
    <session-factory>

        <!-- JDBC connection -->
        <property name="hibernate.connection.driver_class">com.mysql.cj.jdbc.Driver</property>
        <property name="hibernate.connection.url">jdbc:mysql://localhost:3306/testdb</property>
        <property name="hibernate.connection.username">root</property>
        <property name="hibernate.connection.password">1234</property>

        <!-- Dialect -->
        <property name="hibernate.dialect">org.hibernate.dialect.MySQLDialect</property>

        <!-- Hibernate settings -->
        <property name="hibernate.show_sql">true</property>
        <property name="hibernate.hbm2ddl.auto">update</property>

        <!-- Entity mapping -->
        <mapping class="com.example.hibernate.User"/>

    </session-factory>
</hibernate-configuration>
```

---

## 3.3. Entity: `User.java`

```java
package com.example.hibernate;

import jakarta.persistence.*;

@Entity
@Table(name = "users")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name")
    private String name;

    @Column(name = "age")
    private int age;

    public User() {}

    public User(String name, int age) {
        this.name = name;
        this.age = age;
    }

    // Getter, Setter
}
```

---

## 3.4. Hibernate Utility: `HibernateUtil.java`

```java
package com.example.hibernate;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;

public class HibernateUtil {
    private static final SessionFactory sessionFactory;

    static {
        try {
            sessionFactory = new Configuration()
                                .configure("hibernate.cfg.xml")
                                .buildSessionFactory();
        } catch (Throwable ex) {
            System.err.println("Failed to create sessionFactory: " + ex);
            throw new ExceptionInInitializerError(ex);
        }
    }

    public static SessionFactory getSessionFactory() {
        return sessionFactory;
    }
}
```

---

## 3.5. Main: `MainApp.java`

```java
package com.example.hibernate;

import org.hibernate.Session;
import org.hibernate.Transaction;

public class MainApp {
    public static void main(String[] args) {
        Session session = HibernateUtil.getSessionFactory().openSession();
        Transaction tx = null;

        try {
            tx = session.beginTransaction();

            // Tạo user mới
            User user = new User("Huy", 25);
            session.save(user);

            // Đọc user
            User u = session.get(User.class, 1L);
            System.out.println("User: " + u.getName());

            // Update
            u.setAge(30);
            session.update(u);

            // Delete
            // session.delete(u);

            tx.commit();
        } catch (Exception e) {
            if (tx != null) tx.rollback();
            e.printStackTrace();
        } finally {
            session.close();
        }

        HibernateUtil.getSessionFactory().close();
    }
}
```

---

# 📚 PHẦN 4: MỞ RỘNG & TỐI ƯU

## 4.1. Các chiến lược fetch

- `FetchType.LAZY`: tải dữ liệu khi cần → tối ưu hiệu suất.
- `FetchType.EAGER`: tải luôn toàn bộ → tiện nhưng tốn tài nguyên.

## 4.2. Hạn chế N+1 problem

- Dùng `JOIN FETCH` trong HQL:

```java
String hql = "SELECT u FROM User u JOIN FETCH u.roles";
```

## 4.3. Hibernate Cache (caching entity)

- **Level 1 cache**: session-level (mặc định).
- **Level 2 cache**: sessionFactory-level (cần config thêm, dùng Ehcache, Infinispan,...)

---

# ✅ TỔNG KẾT

| Yếu tố           | Mô tả                                 |
| ---------------- | ------------------------------------- |
| Hibernate là gì? | ORM framework giúp Java ↔ DB          |
| Cốt lõi là gì?   | Session, Transaction, SessionFactory  |
| Làm gì?          | Chuyển object Java thành SQL tự động  |
| Ưu điểm          | Code sạch, dễ maintain, ít lỗi        |
| Nhược điểm       | Cần hiểu rõ ánh xạ và tối ưu truy vấn |

# ✅ Mối quan hệ giữa JPA vs Hibernate:

| Thành phần    | Mô tả                                                                                                       |
| ------------- | ----------------------------------------------------------------------------------------------------------- |
| **JPA**       | Là **một chuẩn** (Java Persistence API) được định nghĩa bởi Java EE để làm việc với database thông qua ORM. |
| **Hibernate** | Là **một hiện thực (implementation)** phổ biến nhất của JPA.                                                |

---

## 🔍 Chi tiết mối liên hệ

| Tiêu chí                      | JPA (Java Persistence API)                       | Hibernate                                                                        |
| ----------------------------- | ------------------------------------------------ | -------------------------------------------------------------------------------- |
| **Bản chất**                  | Giao diện (API), định nghĩa chuẩn ORM trong Java | Framework cụ thể để triển khai JPA                                               |
| **Do ai phát triển**          | Oracle (Sun Microsystems trước đó)               | Red Hat (JBoss)                                                                  |
| **Chức năng chính**           | Chỉ định cách ánh xạ object ↔ database           | Cung cấp đầy đủ công cụ thực hiện ORM, cache, lazy loading, SQL generation, v.v. |
| **Có thể hoạt động độc lập?** | Không (vì là API)                                | Có thể (dùng Hibernate Core)                                                     |
| **Ví dụ cụ thể**              | `@Entity`, `@Id`, `EntityManager`, `Query`       | `SessionFactory`, `Session`, `CriteriaBuilder`, `HQL`, `@GenericGenerator`       |

---

## 🏗️ Ví dụ liên hệ

Bạn có thể code một ứng dụng ORM Java bằng JPA **và dùng Hibernate như là provider**.

```xml
<!-- Ví dụ Maven -->
<dependency>
  <groupId>org.hibernate.orm</groupId>
  <artifactId>hibernate-core</artifactId>
  <version>6.1.7.Final</version>
</dependency>
<dependency>
  <groupId>jakarta.persistence</groupId>
  <artifactId>jakarta.persistence-api</artifactId>
  <version>3.1.0</version>
</dependency>
```

```java
// Đây là code JPA chuẩn
@Entity
public class User {
    @Id
    @GeneratedValue
    private Long id;

    private String name;
}
```

```java
// Nhưng Hibernate là engine thực thi
EntityManagerFactory emf = Persistence.createEntityManagerFactory("myUnit");
EntityManager em = emf.createEntityManager();
```

Trong `persistence.xml`, bạn khai báo:

```xml
<persistence-unit name="myUnit">
    <provider>org.hibernate.jpa.HibernatePersistenceProvider</provider>
    ...
</persistence-unit>
```

---

## 🧠 Tóm lại

- **JPA là “giao diện”, Hibernate là “thằng cài đặt”**.
- Hibernate **tuân theo JPA**, nhưng cũng cung cấp **nhiều tính năng mở rộng riêng**.
- Trong các ứng dụng thực tế (đặc biệt Spring Boot), bạn **code theo JPA API**, nhưng bên dưới Hibernate vẫn là "engine" thực hiện.

---

Nếu bạn muốn mình phân tích thêm về:

- Sự khác biệt giữa `EntityManager` (JPA) vs `Session` (Hibernate),
- Các tính năng riêng của Hibernate không có trong JPA,
- Cách chuyển Hibernate thuần → JPA chuẩn

Hãy nói nhé, mình sẽ làm rõ từng phần.
