## 📦 Định dạng file trên Linux và so sánh với Windows

| Định dạng Linux                         | Cách cài đặt trên Ubuntu                                                                         | Tương đương Windows                                | Ghi chú                                                       |
| --------------------------------------- | ------------------------------------------------------------------------------------------------ | -------------------------------------------------- | ------------------------------------------------------------- |
| **.deb** (Debian package)               | `sudo apt install ./file.deb` hoặc `sudo dpkg -i file.deb`                                       | `.msi` hoặc `setup.exe`                            | Gói cài đặt chuẩn của Debian/Ubuntu. Có metadata, dependency. |
| **.rpm** (Red Hat package)              | Chuyển đổi bằng `alien file.rpm` → `.deb`, sau đó cài                                            | `.msi`                                             | Chuẩn của RHEL, Fedora, CentOS.                               |
| **.AppImage**                           | `chmod +x file.AppImage && ./file.AppImage`                                                      | **Portable .exe**                                  | Chạy trực tiếp, không cần cài, tự đóng gói đầy đủ.            |
| **.tar.gz / .tar.xz** (archive)         | Giải nén `tar -xvzf file.tar.gz` rồi build thủ công (`./configure && make && sudo make install`) | `.zip` / `.rar` hoặc source code `.7z`             | Thường là mã nguồn hoặc phần mềm đóng gói thô.                |
| **.bin**                                | `chmod +x file.bin && ./file.bin`                                                                | `.exe`                                             | File nhị phân tự chạy.                                        |
| **.sh** (shell script)                  | `chmod +x file.sh && ./file.sh`                                                                  | `.bat` hoặc `.cmd`                                 | Script cài đặt / chạy lệnh tự động.                           |
| **Snap package (.snap)**                | `sudo snap install package-name`                                                                 | Microsoft Store App                                | Dạng containerized, độc lập, cross-distro.                    |
| **Flatpak (.flatpak)**                  | `flatpak install package-name`                                                                   | Microsoft Store App                                | Tương tự Snap, dùng cho nhiều distro.                         |
| **Source code (.c, .cpp, .py, .go, …)** | Build/compile thủ công: `make`, `gcc`, `python file.py`                                          | `.sln` (Visual Studio), `.csproj`, source code zip | Dành cho developer, không phải installer.                     |

---

## 📌 Tóm tắt nhanh

* `.deb` = **installer chuẩn của Ubuntu/Debian** (giống `.msi`).
* `.AppImage` = **portable app** (giống `.exe portable`).
* `.tar.gz` = **nén source code hoặc app**, phải giải nén/build (giống `.zip`).
* `.sh` = **script cài đặt** (giống `.bat`).
* Snap/Flatpak = **app store package**, giống Microsoft Store.

---

👉 Như vậy, trên Ubuntu, bạn có 3 cách chính để cài phần mềm:

1. **apt (repository)** → giống Windows Update + Store.
2. **.deb thủ công** → giống tải file `.exe/.msi` rồi cài.
3. **AppImage/Snap/Flatpak** → giống Portable App hoặc Microsoft Store App.
## 🛠️ Package Manager phổ biến trên Linux
| Package Manager                      | Distro chính                          | Lệnh cơ bản                     | Windows tương đương                 | Ghi chú                                            |
| ------------------------------------ | ------------------------------------- | ------------------------------- | ----------------------------------- | -------------------------------------------------- |
| **APT (Advanced Package Tool)**      | Ubuntu, Debian, Linux Mint            | `sudo apt install <pkg>`        | Windows Store + `winget`            | Quản lý `.deb`, tự xử lý dependency.               |
| **DPKG (Debian Package)**            | Ubuntu, Debian                        | `sudo dpkg -i file.deb`         | Chạy `.msi` trực tiếp               | Low-level, không tự xử lý dependency.              |
| **DNF (Dandified YUM)**              | Fedora, RHEL, CentOS                  | `sudo dnf install <pkg>`        | Windows Store / Chocolatey          | Quản lý `.rpm`.                                    |
| **YUM (Yellowdog Updater Modified)** | RHEL, CentOS cũ                       | `sudo yum install <pkg>`        | Chocolatey (già hơn)                | Tiền thân của DNF.                                 |
| **Zypper**                           | openSUSE                              | `sudo zypper install <pkg>`     | Winget                              | Quản lý `.rpm` cho SUSE.                           |
| **Pacman**                           | Arch Linux, Manjaro                   | `sudo pacman -S <pkg>`          | Scoop                               | Nhanh, gọn, kiểu rolling release.                  |
| **Snap**                             | Ubuntu (default), cross-distro        | `sudo snap install <pkg>`       | Microsoft Store                     | Containerized app.                                 |
| **Flatpak**                          | Fedora, Ubuntu (opt-in), cross-distro | `flatpak install flathub <pkg>` | Microsoft Store                     | Tương tự Snap, sandbox tốt.                        |
| **Portage (emerge)**                 | Gentoo                                | `emerge <pkg>`                  | Không có (dạng compile from source) | Build phần mềm từ source theo nhu cầu.             |
| **Nix**                              | NixOS, cross-distro                   | `nix-env -i <pkg>`              | Scoop / portable apps               | Hệ quản lý package riêng biệt, reproducible build. |


