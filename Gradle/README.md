# Tổng Quan Về Gradle Cho Dự Án Java và Android

---

## 1. Gradle là gì?

Gradle là một công cụ tự động hoá quy trình build dự án. Nó hỗ trợ build, test, đóng gói, deploy cho các dự án Java, Android, Groovy, Kotlin...

---

## 2. Các thành phần cơ bản trong file `build.gradle`

| Thành phần        | Mục đích                                      | Ví dụ                                       |
| ----------------- | --------------------------------------------- | ------------------------------------------- |
| `plugins`         | Thêm plugin hỗ trợ build                      | `id 'java'`, `id 'com.android.application'` |
| `group`/`version` | Xác định danh tính project                    | `group = 'com.example'`                     |
| `repositories`    | Nguồn tải thư viện                            | `mavenCentral()`                            |
| `dependencies`    | Khai báo thư viện sử dụng                     | `implementation 'junit:junit:4.13.2'`       |
| `tasks`           | Tạo task tùy chỉnh                            | `task hello { doLast { println 'hi' } }`    |
| `application`     | Cấu hình class chính cho Java App             | `mainClass = 'com.example.App'`             |
| `android`         | Block cấu hình Android (chỉ dùng cho Android) | `compileSdkVersion 34`                      |

---

## 3. So sánh Gradle trong Java và Android

### Java Project

```groovy
plugins {
    id 'java'
    id 'application'
}

application {
    mainClass = 'com.example.App'
}
```

### Android Project

```groovy
plugins {
    id 'com.android.application'
}

android {
    compileSdkVersion 34
    defaultConfig {
        applicationId "com.example"
        minSdkVersion 21
        targetSdkVersion 34
    }
}
```

**Khác nhau chính:**

- Android dùng plugin Android và block `android {}`
- Java dùng plugin `java`, `application`
- Android build phức tạp hơn, có nhiều config hơn

---

## 4. Các file cấu hình quan trọng trong Gradle

| File                        | Vai trò                                         |
| --------------------------- | ----------------------------------------------- |
| `build.gradle`              | Cấu hình cho từng module                        |
| `settings.gradle`           | Khai báo tên root project và module con         |
| `gradle.properties`         | Lưu biến toàn cục và bảo mật                    |
| `gradlew`, `gradlew.bat`    | Gradle wrapper script chạy Gradle               |
| `gradle-wrapper.properties` | Cấu hình version Gradle (dùng wrapper)          |
| `.gradle/`                  | Thư mục cache build, có thể xoá khi clean build |

### Lưu ý:

- `gradle.properties` có thể được đặt tại root project hoặc `~/.gradle/`
- `gradle-wrapper.properties` sẽ quyết định version Gradle dùng khi chạy bằng wrapper (`./gradlew`)
- `settings.gradle` rất quan trọng trong multi-module để khai báo các module con

---

## 5. Về `repositories` – Maven Central và Private Repository

### Tại sao là `mavenCentral()`?

- `mavenCentral()` là kho thư viện phổ biến nhất, chứa hầu hết thư viện open-source.
- Được đảm bảo độ tin cậy, tốc độ ổn định và tự động cấu hình sẵn bởi Gradle.

### Ngoài ra còn có:

- `jcenter()` (đã deprecated)
- `google()` (dành cho Android)

### Nếu dùng private repository (như Nexus, Artifactory):

```groovy
repositories {
    maven {
        url "https://nexus.company.local/repository/maven-releases/"
        credentials {
            username = nexusUsername
            password = nexusPassword
        }
    }
}
```

- Nên khai báo username/password trong `gradle.properties`:

```properties
nexusUsername=myuser
nexusPassword=secretpass
```

- Có thể dùng nhiều repository:

```groovy
repositories {
    maven { url "https://nexus.company.local/..." }
    mavenCentral() // fallback
}
```

---

## 6. Làm sao để biết plugin có tương thích với Gradle version?

- Kiểm tra documentation chính thức:

  - [https://plugins.gradle.org](https://plugins.gradle.org)
  - [https://developer.android.com/studio/releases/gradle-plugin](https://developer.android.com/studio/releases/gradle-plugin) (cho Android)

- Với Android Plugin:

  - Có bảng tương thích giữa `Android Gradle Plugin` và `Gradle Version`

| Android Plugin | Yêu cầu Gradle Version |
| -------------- | ---------------------- |
| 8.1.0          | 8.0 - 8.4              |
| 7.4.2          | 7.5 - 7.6              |
| 7.0.4          | 7.0 - 7.2              |

- Với plugin khác: tìm `compatibility` trong trang của plugin tại plugins.gradle.org

- Khi dùng sai version, Gradle sẽ báo lỗi rõ ràng khi chạy `./gradlew build`

---

## 7. Sử dụng repository nội bộ (VD: Nexus)

```groovy
repositories {
    maven {
        url "https://nexus.company.local/repository/maven-public/"
        credentials {
            username = nexusUsername
            password = nexusPassword
        }
    }
}
```

- Biến `nexusUsername`, `nexusPassword` có thể để trong `gradle.properties`
- Luôn để mật khẩu ra ngoài file `build.gradle`

---

## 8. Ví dụ Java Multi-Module Project

### Cấu trúc

```
multi-project-demo/
├── settings.gradle
├── build.gradle (root)
├── app/
│   └── build.gradle
│   └── src/main/java/com/example/app/App.java
└── utils/
    └── build.gradle
    └── src/main/java/com/example/utils/StringUtils.java
```

### settings.gradle

```groovy
rootProject.name = 'multi-project-demo'
include 'app', 'utils'
```

### build.gradle (root)

```groovy
plugins {
    id 'java'
}

allprojects {
    group = 'com.example'
    version = '1.0.0'

    repositories {
        mavenCentral()
    }
}
```

### utils/build.gradle

```groovy
plugins {
    id 'java'
}
```

### app/build.gradle

```groovy
plugins {
    id 'java'
    id 'application'
}

dependencies {
    implementation project(':utils')
}

application {
    mainClass = 'com.example.app.App'
}
```

### StringUtils.java

```java
package com.example.utils;

public class StringUtils {
    public static String shout(String input) {
        return input.toUpperCase() + "!";
    }
}
```

### App.java

```java
package com.example.app;

import com.example.utils.StringUtils;

public class App {
    public static void main(String[] args) {
        System.out.println(StringUtils.shout("hello gradle multi-module"));
    }
}
```

### Chạy project

```bash
./gradlew build
./gradlew :app:run
```

> Kết quả: `HELLO GRADLE MULTI-MODULE!`

---

## 9. Ví dụ Android Multi-Module Project

### Cấu trúc

```
android-multi/
├── settings.gradle
├── build.gradle (root)
├── app/
│   └── build.gradle
└── core/
    └── build.gradle
```

### settings.gradle

```groovy
rootProject.name = "android-multi"
include ':app', ':core'
```

### Root build.gradle

```groovy
buildscript {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        classpath 'com.android.tools.build:gradle:8.1.0'
    }
}

allprojects {
    repositories {
        google()
        mavenCentral()
    }
}
```

### core/build.gradle

```groovy
plugins {
    id 'com.android.library'
}

android {
    namespace "com.example.core"
    compileSdk 34

    defaultConfig {
        minSdk 21
    }
}
```

### app/build.gradle

```groovy
plugins {
    id 'com.android.application'
}

android {
    namespace "com.example.app"
    compileSdk 34

    defaultConfig {
        applicationId "com.example.app"
        minSdk 21
        targetSdk 34
        versionCode 1
        versionName "1.0"
    }
}

dependencies {
    implementation project(':core')
    implementation 'androidx.appcompat:appcompat:1.6.1'
}
```

---

## 10. Tóm tắt

- Gradle giúc tự động hoá quy trình build
- Hỗ trợ Java và Android một cách linh hoạt
- Nên dùng Gradle Wrapper để đồng bộ version trong team
- Cần biết các file cấu hình quan trọng: `build.gradle`, `settings.gradle`, `gradle.properties`, `gradlew`
- Biết cách tổ chức multi-module project giúp chia tách chức năng rõ ràng
- Quản lý repositories đúng cách giúp tối ưu hiệu suất build và bảo mật
- Kiểm tra compatibility giữa plugin và Gradle version là điều quan trọng khi nâng cấp

---

_Nếu bạn muốn tiếp tục: tôi có thể hướng dẫn Gradle cho Spring Boot, viết plugin tùy chỉnh, hoặc tích hợp CI/CD với Gradle._
