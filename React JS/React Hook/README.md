```html
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <script
      crossorigin
      src="https://unpkg.com/react@18/umd/react.development.js"
    ></script>
    <script
      crossorigin
      src="https://unpkg.com/react-dom@18/umd/react-dom.development.js"
    ></script>
    <script src="https://unpkg.com/babel-standalone@6/babel.min.js"></script>
    <title>Document</title>
  </head>

  <body>
    <div id="root"></div>
    <script type="text/babel">
      const posts = [
        {
          title: "javascript",
          decs: "java class foe",
        },
        {
          title: "html",
          decs: "java class foe",
        },
      ];

      const Form = {
        Input() {
          return <input />;
        },
        CheckBox() {
          return <input type="checkbox" />;
        },
      };

      function Header() {
        return <div className="header">New header</div>;
      }

      function Content({ data, onClick }) {
        return (
          <React.Fragment>
            <button onClick={() => onClick(data)}>Click me</button>
            {data.map((item) => React.createElement("h3", null, item.title))}
          </React.Fragment>
        );
      }

      function App() {
        const handleClick = (title) => {
          console.log(title);
          console.log(Math.random());
        };
        const type = "CheckBox";
        const Component = Form[type];
        return (
          <div>
            <Header />
            <Content data={posts} onClick={handleClick} />
            <Component />
          </div>
        );
      }

      ReactDOM.render(<App />, document.getElementById("root"));
    </script>
  </body>
</html>
```

# Hooks

### 1. useState():

- Component sẽ được re-render sau khi `setState`
- Initial state chỉ sử dụng cho lần đầu
- Có thể Initial state với callBack

  ```jsx
  // State với callback
  // Đặt callback là hàm tính tổng làm init tránh việc sẽ tính lại biến total nhiều lần
  import { useState } from "react";
  const orders = [100, 200, 300];
  function Component() {
    const [counter, setCounter] = useState(() => {
      const total = orders.reduce((total, cur) => total + cur);
      return total;
    });

    const handleIncrease = () => {
      setCounter((preState) => preState + 1);
    };

    return (
      <div className="App" style={{ padding: 30 }}>
        <h1>{counter}</h1>
        <button onClick={handleIncrease}>Increase</button>
      </div>
    );
  }
  export default Component;
  ```

- Two-way binding

  ```jsx
  import { useState } from "react";

  function Component() {
    const [name, setName] = useState("");
    const [email, setEmail] = useState("");
    const handleSubmit = () => {
      // call api
      console.log({
        name,
        email,
      });
    };
    return (
      <div className="App" style={{ padding: 30 }}>
        <input value={name} onChange={(e) => e.target.value} />
        <input value={email} onChange={(e) => e.target.value} />
        <button onClick={handleSubmit}>Login</button>
      </div>
    );
  }
  export default Component;
  ```

### 2. useEffect

- Dùng call api, update DOM, listen DOM event, clear timer,...
- Gọi callback mỗi khi component được mounted
- Khái niệm `Mounted/Unmounted`: Khi được thẻ được tạo ra và gắn vào dom thì được coi là mounted và ngược lại

- `useEffect(callback):`
  - Gọi sau mỗi lần component re-render
  - Gọi callback một lần sau khi component mounted (thêm vào DOM)
- `useEffect(callback, []):`
  - Chỉ gọi một lần sau khi component mounted (thêm vào DOM)
- `useEffect(callback, [deps])`
  - deps là 1 biến (lưu vào useState)
  - Gọi lại mỗi khi deps thay đổi
- `Clean up function`

  - Luôn return một listener sau mỗi useEffect để tránh memory leak return () => {}
  - Luôn được gọi sau component unmounted
  - Luôn được gọi trước callback khi lần 2 re-render

  ```jsx
  // Ví dụ: Xóa dom event khi component unmount nhưng sự kiện vẫn còn gắn trong DOM. sử dụng cleanup func để xóa DOM event trước khi nó được unmounted

  import { useEffect, useState } from "react";

  function Component() {
    const [showGoToTop, setShowGoToTop] = useState(false);
    useEffect(() => {
      const handleScroll = () => {
        setShowGoToTop(window.scrollY >= 200);
      };
      window.addEventListener("scroll", handleScroll);
      // Cleanup func
      return () => {
        window.removeEventListener("scroll", handleScroll);
      };
    }, []);
    return <div className="App" style={{ padding: 30 }}></div>;
  }
  export default Component;
  ```

  ```jsx
  // Ví dụ: Giải phóng bộ nhớ khi chọn ảnh lên trình duyệt. Khi chọn ảnh làm Avatar. Sẽ tạo ra link tạm(Không mất khi không đóng tab ứng dụng) nên gây rò rỉ bộ nhớ nếu chọn ảnh khác lần 2. nên cần clean link cũ trước khi file mới được chọn

  import { useEffect, useState } from "react";

  function Component() {
    const [avatar, setAvatar] = useState();

    const handleChangeAvt = (e) => {
        const file = e.target.files[0];
        file = URL.createObjectURL(file)
        setAvatar(file);
    };

    useEffect(() => {
      // Cleanup func
      return () => {
        avatar && URL.revokeObjectURL(avatar);
      };
    }, []);

    return (
      <div className="App" style={{ padding: 30 }}>
        <input
          type="file"
          onChange={handleChangeAvt}
        />
        {avatar && (
          <img src={avatar} alt="" width="80%"/>
        )}
    </div>;
    )
  }
  export default Component;
  ```

### 3. useLayoutEffect

- Gần giống useEffect
- Khác biệt: useEffect sẽ chạy cleanUp và callback trước re-render còn useLayoutEffect thì ngược lại:
  - useEffect: update state => update dom => render-ui => cleanUp => callback
  - useLayoutEffect: update state => update dom => cleanUp => callback => render-ui

### 4. useRef

- Khi component re-render thì biến dùng chung cho hàm => undifined => dùng useRef để chuyển biến ra ngoài component
- **const ref = useRef(initValue)** sẽ return obj
- Lấy giá trị: **ref.current**

### 5. useMemo

- Giảm tính toán cần thiết nếu component re-render, useMemo(callback, [deps]), useMemo(callback, [])

### 6. useCallback

- Tương tự useRef nhưng dùng cho arrow function khi chuyền prop cho component con. Kết hợp với "memo".

### 7. useReducer:

Thay thế cho useState nếu quá phức tạp.

```jsx
1: initState
2: Action
3: reducer
4: dispatch
```

### 8. useContext:

- Tạo ra một context. Nếu bọc context cho component cha thì thằng con đều có thể sử dụng. Giảm thiểu chuyền props.

```
1. Create context
2. Provider: Nhận dữ liệu. component cha.
3. Consumer: Nơi sử dụng. import useContext + import provider

```

# **HOC (higher order component)**

- Cách dùng: bọc bên ngoài component
  - **memo**: Tránh re-render component. Sẽ ko re-render nếu không có prop nào thay đổi.
  - **forwardRef**: Bọc component con để truyền rè xuống thằng con.

[🧠 React – Cơ chế Render HTML & Client-Side Rendering](https://www.notion.so/React-C-ch-Render-HTML-Client-Side-Rendering-2299b9aed7d7807ba273cf21071e4657?pvs=21)
