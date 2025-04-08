[Docker+Fundamentas+for+Beginner.pdf](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/ac2350d6-5097-4c31-8673-e5e446f0234a/DockerFundamentasforBeginner.pdf)

**docker(cho chạy trên 1 host và từng container)
-> docker compose(chạy trên 1 host và nhiều container)
-> docker swarm(chạy trên nhiều host và nhiều container)**

## **Container**

- Bao gồm ứng dụng và các dependence của ứng dụng.
- Đóng gói các ứng dụng riêng biệt cùng với library và dependence.
- Đảm bảo toàn vẹn ứng dụng khi triển khai trên ứng dụng.

## **Docker**

- Docker là nền tảng container orchestration (Quản lí vòng đời container).
- Docker cho phép dễ dàng triển khai dịch vụ dưới dạng container.

## Install

- **Linux ubuntu:**
  sudo apt update
  sudo apt install docker.io
  sudo usermod -aG docker ${USER}: Cấp quyền cho user hiện tại dùng docker không cần phải sử dụng sudo
  sudo systemctl status docker: check trạng thái docker.
  sudo systemctl enable docker: cấu hình docker mở khi mở máy.
  sudo systemctl start docker: khởi động dịch vụ Docker ngay lập tức mà không cần khởi động lại

## **Container lifecycle**

![Capture PNG](https://github.com/user-attachments/assets/c965fe0b-efad-4967-af33-5c1372e7c53c)

- docker pull: Download một docker image từ docker hub
- docker create: Tạo container từ docker image
- docker start: chuyển container dạng created thành started
- docker run: trực tiếp chạy một container từ một docker image
- docker stop/start: tắt/ bật một container
- docker pause/unpause: Tạm dừng process trong container.

## **Docker command**

**Container:**

- **docker run**: Chạy container trong Attach mode tức là container sẽ chạy trên foreground. Sẽ thấy đầu ra của container trực tiếp trong terminal và terminal sẽ bị chiếm dụng bởi quá trình của container.
- **docker run -d**: Chạy container Nginx trong chế độ nền (detached mode). Terminal sẽ trả về một ID container và bạn có thể tiếp tục sử dụng terminal.
- **docker rm**: Xóa container đạng ở trạng thái stopped. Phải ở trạng thái stoped mới có thể xóa được container
- **docker ps**: Show các container đang running
- **docker ps -a**: Show tất cả các contain**er**
- **docker stop:** Dừng một container
- **docker exec:** Thực thi một câu lệnh bên trong container.
- **docker log:** Show log của container. Option -f: xem log dạng realtime
- **docker inspect:** Xem thông tin của container( về ip, mount, network, ….)
- **docker rm $(docker ps -aq):** Xóa toàn bộ container

**Image:**

- **docker pull:** download docker image. Nếu là môi trường private cần sử dụng **docker login** trước khi pull image về
- **docker images:** Liệt kê các docker image
  - Option: --quite: Chỉ xem id của image
- **docker rmi:** Xóa một docker image
- **docker run -it:** khi chạy Container cho phép người dùng tương tác với Container Shell (-i)
  và cho phép gắn một Terminal (tty) cho phép hiển thị shell promt và Output
- **docker rmi $(docker images -q):** Xóa toàn bộ image

## Keep Container Running

Container được sinh ra với mục đích thực hiện một tác vụ, job cụ thể.

Container ở trạng thái running khi nó vẫn còn thực thi một tác vụ, một job và chuyển sang trạng thái Stopped khi tác vụ hoặc job được hoàn thành

Để thực thi một tác vụ, command hay script ta có thể sử dụng câu lệnh **CMD** hoặc **Entrypoint** trong Dockerfile

- **CMD** Nhận tham số khi chạy docker run để overide command được chỉ định trong CMD
- **Entrypoint** Nhận tham số khi chạy docker run để làm tham số cho Entrypoint

![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/71c27433-c9dd-47c8-8f87-2bfa63ab12ed/Untitled.png)

- CMD có thể sử dụng theo các format sau trong Dockerfile
  CMD executable, param1, param2 CMD sleep 5
  CMD [executable, param1, param2] CMD [“sleep”, “5”]
- ENTRYPOINT có thể sử dụng theo các format sau trong Dockerfile
  ENTRYPOINT executable, param1, param2
  ENTRYPOINT [executable, param1, param2]
  ENTRYPOINT node, app.js
  ENTRYPOINT [“node”, “app.js”]

## Docker Registry

**Optimize Docker Image Size**

- Sử dụng base image (FROM) size nhỏ
- Sử dụng multi-stage build. Tách nhỏ các stage, tách bước buid dứng dụng rồi mới buid image
- Tối thiểu hóa số layers. Gọp các câu lệnh để giảm số layer.
- Sử dụng cơ chế caching
- Sử dụng DockerIgnore
- docker buid -t tag_name -f Dockerfile . / Build docker image
  --no-cache: Nếu chạy 1 lần docker sẽ lưu cache, nếu muốn build ko dùng cache từ lần đầu

## Docker Network

- Thành phần cho phép container giao tiếp với mạng bên ngoài và các container với nhau. Bao gồm 3 chế độ khác nhau: bridge, none, host
- Bridge network: là mode network cho phép container giao tiếp với nhau và giao tiếp với bên ngoài. Giống như switch cho phép container cắm một card mạng ảo và nhận một địa chỉ Ip từ dải bridge network.Container sẽ đi ra mạng ngoài thông qua default gateway
- None network: là mode network nhằm tách biệt, cô lập containers với mạng bên ngoài. docker run nginx --network=none
- Host network: là mode network cho phép container sử dụng Network stack(IP) của host(sử dụng chung network interface)
- Overlay network: Cho phép container trên nhiều host vật lí có thể giao tiếp với nhau.

## Docker Storage

- File system: là cách tổ chức và lưu trữ các file trong các thiết bị lưu trữ, cung cấp thứ tự phân cấp cho các thư mục, thư mục con và files
- Union fileSystem: Là file system đặc biệt cho phép gộp nội dung của nhiều thư mục lại với nhau, khi truy cập tới các file system khác nhau thì sẽ được truy cập đến giao diện duy nhất là union system
- Layer Architecture: là kiến trúc xếp trồng lên nhau để tạo thành image. Mỗi layer được tạo ra từ một command trong docker file. Sử dụng union system để tạo một file system duy nhất.
- Copy-on-write: kỹ thuật cho phép chia sẻ dữ liệu giữa các container( chia sẻ dữ liệu của image layer). Dữ liệu về bản chất sẽ không bị dư thừa mà chỉ tham chiếu tới dữ liệu thật(dữ liệu image layer).
- Khi khởi tạo container thì tất cả các file tạo ra khi khởi chạy sẽ nằm trong container layer(read-write). Lúc này container layer bao gồm các file copy từ image layer và các file được tạo mới khi run container. Khi xóa container thì container layer sẽ bị xóa.
- Các file trong image layer(read only) chỉ đọc và không thể sửa đổi.
- **Volumes**
  - Cho phép lưu trữ dữ liệu bền vững và tách biệt khỏi vòng đời của container
  - Có hai loại:
    - Named volume: đường dẫn đến volume là mặc định (var/lib/docker/...)
    - Bind mounts: cho phép chỉ định đường dẫn cụ thể volume (By user customize)
- **docker volume prune:** Xóa tất cả các volume
- **docker volume rm**: Xóa một volume
- **docker volume create**: Tạo mới một volume
- **docker volume ls**: Liệt kê volume
- **docker volume inspect**: Xem thông tin volume
- **docker run -d -it -name nginx --mount type=volume,source=nginx-volume,target=/app-data nginx**: Run docker với option --mount type là default
- **docker run -d -it -name nginx -v nginx-volume:/app-data nginx**: Run container với option -volume
- **docker run -d -it -name nginx --mount type=bind,source=/data/nginx-volume,target=/app-data nginx**: Run docker với option --mount type là Bind
- **docker run -d -it -name nginx -v /data/nginx-volume**:/app-data nginx: Run container với option -volume

## Docker Engine

Bao gồm ba thành phần chính:

- Docker CLI (Command Line Interface)
- REST API (Tiếp nhận các yêu cầu từ Docker CLI)
- Docker Daemon (Quản lí vòng đời của Containers)

Nếu đứng trên một host khác sử dụng:

docker -H=remote-docker-engine:2375 (docker -H=10.123.2.1:2375 run nginx)

**Namespace**

- Container sẽ tách biệt với Host và các containers khác ở các namespaces.
- Khi container chạy thì các tiến trình (process) trong container sẽ được mapping với một tiến trình trong máy host. Như vậy **process** là cách mà hệ điều hành cấp phát tài nguyên (RAM, CPU, IO) cho container.
- **Cgroups** là tính năng của linux kernel cho phép giới hạn và giám sát tài nguyên RAM, CPU, IO bandwith cấp phát cho các tiến trình (process).
  - docker run --cpus = 5 ubuntu
  - docker run --memory=100m

## Docker Compose

- Công cụ cho phép triển khai đồng thời nhiều containers
- Sử dụng file dạng yaml để cấu hình
  ![Untitled](https://prod-files-secure.s3.us-west-2.amazonaws.com/977c89a6-d1d1-4d17-80a5-f6c00e1e98f7/e21bcaa9-1801-4e0b-94ca-b014157d3a38/Untitled.png)

### Docker Swarm

- Cho phép triển khai workload chạy container dạng cluster
- Cluster của docker swarm bao gồm:
  1. Swarm manager: Điều phối, lập lịch chạy container, quản lí hoạt động của cluster
     docker swarm init
  2. Swarm node(worker node): Chaỵ workload container
     docker swarm join --token <token>
