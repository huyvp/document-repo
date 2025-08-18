DoorDash Tối Ưu Redis Như Nào cho Recommendation Engine?
Recommendation Engine của DoorDash dựa vào dữ liệu real-time (vector embeddings, …) được lưu trên Redis để cập nhật recommendation cho mỗi user (đây là thiết kế đến thời điểm năm 2020). Tuy nhiên với cấu hình mặc định của Redis không thể xử lý hàng chục triệu reads trên giây. Do đó, DoorDash cần phải tối ưu Redis để tiết kiệm không gian lưu trữ và tăng read throughput.
Kết quả:

- 298 GB → 112 GB RAM
- Average CPU utilization per 10M reads/s: 208 vCPUs → 72 vCPU
- Overall latency: dropped by about 40%
  Key takeaways:
- Dùng Hash, thay vì String → tiết kiệm CPU và Memory, nhất là CPU.
- Ném feature name (field in hash) bằng xxHash algorithm → tiết kiệm memory.
- Vector embedding hoặc integer list được serialized bằng protobuf → memory + latency.
- Float nếu có nhiều giá trị 0 thì lưu dạng String → memory.
- Ném integer list bằng Snappy → memory + latency.

Mọi người đọc thêm ở dưới nha:  
👉 Source: [https://careersatdoordash.com/.../building-a-gigascale.../ ](https://careersatdoordash.com/blog/building-a-gigascale-ml-feature-store-with-redis/?fbclid=IwY2xjawKFs7NleHRuA2FlbQIxMABicmlkETFnRnVPWTZoZ0ZnY3dJYVdmAR6dZq0h8G2Fn8OvZljgrpJc50-KIXHJ-W6JE8nDMJ_MIkfIw_rRnilAEKLH3w_aem_eConpyzdIAxRjj7P8wNp8A)
