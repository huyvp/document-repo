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

## 1. useState():

```jsx
import { useState } from "react";

function Demo() {
  const courses = [
    {
      id: 1,
      name: "html",
    },
    {
      id: 2,
      name: "Java",
    },
    {
      id: 3,
      name: "Javascript",
    },
  ];

  const handleClick = (value) => {
    const isChecked = checkbox.includes(value);
    if (isChecked) return setCheckbox(checkbox.filter((i) => i !== value));
    else return setCheckbox([...checkbox, value]);
  };
  const [state, setState] = useState("");
  const [radio, setRadio] = useState();
  const [checkbox, setCheckbox] = useState([]);

  console.log(checkbox);

  return (
    <div className="Demo" style={{ padding: 30 }}>
      <h2>Two-way bilding with input</h2>
      <input value={state} onChange={(e) => setState(e.target.value)} />
      <button onClick={() => setState("Changed")}>Submit</button>

      <h2>Two-way bilding with radio</h2>
      {courses.map((course) => {
        return (
          <div key={course.id}>
            <input
              type="radio"
              onChange={() => setRadio(course.id)}
              checked={radio === course.id}
            ></input>
            {course.name}
          </div>
        );
      })}
      <h2>Two-way bilding with checkbox</h2>
      {courses.map((course) => {
        return (
          <div key={course.id}>
            <input
              type="checkbox"
              onChange={() => handleClick(course.id)}
              checked={checkbox.includes(course.id)}
            ></input>
            {course.name}
          </div>
        );
      })}
    </div>
  );
}

export default Demo;
```

## 2. useEffect

- Dùng call api, update DOM, listen DOM event, clear timer,...
- **useEffect(callback):**
  - Gọi sau mỗi lần component re-render
  - Gọi callback một lần sau khi component mounted (thêm vào DOM)
- **useEffect(callback, []):**
  - chỉ gọi một lần sau khi component mounted
- **useEffect(callback, [deps])**
  - deps là 1 biến (lưu vào useState)
  - Gọi lại mỗi khi deps thay đổi
- **Clean up function**
  - Luôn return một listener sau mỗi useEffect để tránh memory leak return () => {}
  - Luôn được gọi sau component unmounted
  - Luôn được gọi trước callback khi lần 2 re-render

## 3. useLayoutEffect

- Gần giống useEffect
- Khác biệt: useEffect sẽ chạy cleanUp và callback trước re-render còn useLayoutEffect thì ngược lại:
  - useEffect: update state => update dom => render-ui => cleanUp => callback
  - useLayoutEffect: update state => update dom => cleanUp => callback => render-ui

## 3. useRef

- Khi component re-render thì biến dùng chung cho hàm => undifined => dùng useRef để chuyển biến ra ngoài component
- **const ref = useRef(initValue)** sẽ return obj
- Lấy giá trị: **ref.current**

## 4. useMemo

- Giảm tính toán cần thiết nếu component re-render, useMemo(callback, [deps]), useMemo(callback, [])

## 5. useCallback

- Tương tự useRef nhưng dùng cho arrow function khi chuyền prop cho component con. Kết hợp với "memo".

## 6. useReducer:

Thay thế cho useState nếu quá phức tạp.

```jsx
1: initState
2: Action
3: reducer
4: dispatch
```

## 7. useContext:

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
