# 📚 Cơ chế hoạt động của React từ CSR đến Re-render qua Babel

## I. 🌐 Cơ chế Client-Side Rendering (CSR) trong React

### 1. Khái niệm

**Client-Side Rendering (CSR)** là cơ chế trong đó việc render giao diện (HTML) được xử lý **trên trình duyệt của người dùng**, chứ không phải trên server.

Thay vì server trả về HTML đầy đủ cho mỗi lần truy cập, nó chỉ trả về một **file HTML trống và file JavaScript**. React sau đó sẽ chịu trách nhiệm "lấp đầy" nội dung giao diện trên client.

---

### 2. Các bước hoạt động của CSR trong React:

#### 📌 Bước 1: Trình duyệt gửi request đến server

Server trả về:

```html
<!-- index.html -->
<html>
  <head>
    <title>React App</title>
  </head>
  <body>
    <div id="root"></div>
    <script src="/static/js/main.js"></script>
  </body>
</html>
```

> Chỉ có một thẻ `<div id="root">` là vùng mount của React.

#### 📌 Bước 2: Trình duyệt tải file JS chứa toàn bộ ứng dụng React

File này được Webpack/Vite build từ mã nguồn React của bạn.

#### 📌 Bước 3: ReactDOM "gắn" ứng dụng vào DOM thật

```js
const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App />);
```

Kết quả: Giao diện bắt đầu hiển thị sau khi JS chạy.

#### 📌 Bước 4: Khi người dùng tương tác

→ Không reload trang
→ React tự động cập nhật UI tại đúng vị trí thay đổi
→ Cảm giác ứng dụng "nhanh như app gốc"

---

### 3. Ưu và Nhược điểm của CSR

| Ưu điểm                                   | Nhược điểm                                  |
| ----------------------------------------- | ------------------------------------------- |
| Giao diện mượt, không reload              | SEO kém hơn do HTML ban đầu rỗng            |
| Dễ xây dựng ứng dụng động, giàu tương tác | Thời gian tải lần đầu lâu nếu bundle JS lớn |
| Dễ dùng, triển khai đơn giản              | Không hỗ trợ tốt trên trình duyệt tắt JS    |

---

## II. ⚛️ React Element – Đơn vị cơ bản để xây dựng UI

### 1. Khái niệm

React Element là một **object JavaScript mô tả một thành phần giao diện**.
Nó không phải là DOM thật, mà là một phần của Virtual DOM.

Ví dụ:

```jsx
const element = <h1>Hello</h1>;
```

→ Sau khi biên dịch bằng babel:

```js
const element = React.createElement("h1", null, "Hello");
```

---

### 2. Cấu trúc React Element sau khi tạo

```js
const element = {
  type: "h1",
  props: {
    children: "Hello",
  },
};
```

> React dùng những object này để xây dựng **Virtual DOM tree**, sau đó mới quyết định cách hiển thị lên giao diện.

---

## III. 🔌 ReactDOM – Kết nối React với DOM thật

### 1. Vai trò của `react-dom`

Thư viện `react-dom` giúp React:

- Mount giao diện vào DOM thật (`div#root`)
- Tương tác với DOM (render, update, unmount)

---

### 2. Ví dụ khởi động ứng dụng React:

```jsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App />);
```

> `App` là component gốc, được React tạo Virtual DOM → `ReactDOM` render lên DOM thật.

---

### 3. So sánh `react` và `react-dom`:

| Thư viện    | Chức năng chính                                          |
| ----------- | -------------------------------------------------------- |
| `react`     | Tạo element, quản lý state, hooks, Virtual DOM           |
| `react-dom` | Render UI React vào DOM thật, xử lý mount/update/unmount |

---

## IV. 🔁 Cơ chế Re-render & Babel – JSX → React Element

---

### 1. JSX là gì?

JSX là cú pháp mở rộng của JavaScript, cho phép viết mã giống HTML:

```jsx
const element = <h1>Hello</h1>;
```

Nhưng **trình duyệt không hiểu JSX**, vì thế cần một trình biên dịch: **Babel**.

---

### 2. Babel hoạt động như thế nào?

Babel là **JavaScript compiler** giúp chuyển đổi:

- JSX → `React.createElement(...)`
- ES6+ → ES5 (cho trình duyệt cũ)

Ví dụ:

```jsx
const element = <p className="greeting">Hi!</p>;
```

→ Babel biên dịch thành:

```js
const element = React.createElement("p", { className: "greeting" }, "Hi!");
```

---

### 3. Cấu trúc `React.createElement`:

```js
React.createElement(
  type, // HTML tag hoặc Component
  props, // object chứa attributes và sự kiện
  ...children // nội dung bên trong
);
```

---

### 4. Cơ chế Re-render trong React

#### Khi nào component được render lại?

- Khi `state` hoặc `props` thay đổi

#### Điều gì xảy ra?

1. React gọi lại component để tạo **Virtual DOM mới**
2. So sánh DOM ảo mới và cũ (**diffing**)
3. Tìm sự khác biệt
4. **Chỉ cập nhật đúng phần đó** trên DOM thật (**reconciliation**)

---

### 5. Cơ chế này giúp gì?

✅ **Tối ưu hiệu năng**: tránh việc render lại toàn bộ trang
✅ UI luôn **đồng bộ với dữ liệu**
✅ Không bị giật lag, UX mượt mà

---

## V. 🧪 Ví dụ đầy đủ minh họa luồng từ JSX → UI:

```jsx
// App.jsx
import React, { useState } from "react";

function App() {
  const [count, setCount] = useState(0);

  return (
    <div>
      <h1>Count: {count}</h1>
      <button onClick={() => setCount(count + 1)}>Increase</button>
    </div>
  );
}
```

```jsx
// main.jsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App />);
```

---

## VI. 🔄 Tổng kết toàn bộ quy trình React hoạt động:

| Giai đoạn              | Mô tả                                                    |
| ---------------------- | -------------------------------------------------------- |
| **1. CSR**             | Render UI trên trình duyệt, không reload trang           |
| **2. JSX**             | Cú pháp mô tả UI, dễ viết dễ đọc                         |
| **3. Babel**           | Biên dịch JSX → React.createElement (JS thuần)           |
| **4. React Element**   | Object mô tả DOM node, được dùng để xây dựng Virtual DOM |
| **5. Virtual DOM**     | DOM ảo, giúp React tính toán trước khi cập nhật thật     |
| **6. ReactDOM.render** | Mount component React vào DOM thật (`div#root`)          |
| **7. Re-render**       | Khi state/props thay đổi → diff → update DOM hiệu quả    |

---

### Babel sẽ biên dịch JSX thành:

```js
const element = React.createElement("h1", { className: "title" }, "Hello");
```

---

### Hàm `React.createElement(type, props, ...children)`

Tạo ra một React Element:

```js
{
  type: 'h1',
  props: { className: 'title', children: 'Hello' }
}
```

→ Dùng để dựng **Virtual DOM**

---

## VI. ✳️ Cài Đặt Thủ Công Babel + Webpack (Để học sâu JSX → JS)

### 1. ✅ Khởi tạo project:

```bash
mkdir react-babel-webpack
cd react-babel-webpack
npm init -y
```

---

### 2. ✅ Cài đặt thư viện:

```bash
npm install react react-dom
npm install --save-dev webpack webpack-cli webpack-dev-server
npm install --save-dev babel-loader @babel/core @babel/preset-env @babel/preset-react
```

---

### 3. ✅ Tạo cấu trúc thư mục:

```
/react-babel-webpack
  /src
    App.jsx
    index.jsx
  index.html
  webpack.config.js
  babel.config.json
```

---

### 4. ✅ `babel.config.json`

```json
{
  "presets": ["@babel/preset-env", "@babel/preset-react"]
}
```

---

### 5. ✅ `webpack.config.js`

```js
const path = require("path");

module.exports = {
  entry: "./src/index.jsx",
  output: {
    path: path.resolve(__dirname, "dist"),
    filename: "bundle.js",
  },
  resolve: {
    extensions: [".js", ".jsx"],
  },
  module: {
    rules: [
      {
        test: /\.jsx?$/,
        exclude: /node_modules/,
        use: "babel-loader",
      },
    ],
  },
  devServer: {
    static: "./dist",
    port: 3000,
  },
  mode: "development",
};
```

---

### 6. ✅ `index.html`

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
  </head>
  <body>
    <div id="root"></div>
    <script src="bundle.js"></script>
  </body>
</html>
```

---

### 7. ✅ `src/index.jsx`

```jsx
import React from "react";
import ReactDOM from "react-dom/client";
import App from "./App";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App />);
```

---

### 8. ✅ `src/App.jsx`

```jsx
import React, { useState } from "react";

function App() {
  const [count, setCount] = useState(0);
  return (
    <div>
      <h1>Count: {count}</h1>
      <button onClick={() => setCount(count + 1)}>+1</button>
    </div>
  );
}

export default App;
```

---

### 9. ✅ Chạy ứng dụng:

```bash
npx webpack serve
```

→ Mở trình duyệt tại: [http://localhost:3000](http://localhost:3000)
→ JSX sẽ được biên dịch thành JS thuần và render vào `div#root`
