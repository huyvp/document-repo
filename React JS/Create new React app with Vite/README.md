# 📘 Thiết lập dự án React + Vite + ESLint + Prettier + EditorConfig

## 1. Tạo dự án React với Vite

Khởi tạo một project mới với Vite:

```bash
npm create vite@latest my-app
cd my-app
npm install
```

* Chọn **React** làm framework.
* Chọn **JavaScript** hoặc **TypeScript** tuỳ nhu cầu dự án.



## 2. Cài đặt ESLint và Prettier

Cài các package cần thiết:

```bash
npm install -D eslint prettier eslint-plugin-react eslint-plugin-prettier eslint-config-prettier @eslint/js
```

* **eslint** → công cụ linting chính.
* **prettier** → formatter code.
* **eslint-plugin-react** → rule dành riêng cho React.
* **eslint-plugin-prettier** → cho phép ESLint báo lỗi khi code chưa đúng format Prettier.
* **eslint-config-prettier** → tắt rule của ESLint có thể xung đột với Prettier.
* **@eslint/js** → config mặc định từ ESLint.

---

## 3. Cấu hình ESLint

Tạo file `eslint.config.js` ở thư mục gốc:

```js
import js from '@eslint/js'
import globals from 'globals'
import reactHooks from 'eslint-plugin-react-hooks'
import reactRefresh from 'eslint-plugin-react-refresh'
import prettier from 'eslint-plugin-prettier'
import prettierConfig from 'eslint-config-prettier'
import { defineConfig, globalIgnores } from 'eslint/config'

export default defineConfig([
  // Bỏ qua thư mục build/dist khi lint
  globalIgnores(['dist']),
  {
    // Lint cho tất cả file JS/TS, bao gồm cả JSX/TSX
    files: ['**/*.{js,jsx,ts,tsx}'],
    extends: [
      js.configs.recommended,                  // Bộ rule mặc định ESLint cho JavaScript
      reactHooks.configs['recommended-latest'], // Kiểm soát cách dùng React Hooks
      reactRefresh.configs.vite,               // Rule hỗ trợ Fast Refresh của Vite
      prettierConfig,                          // Vô hiệu hóa rule ESLint xung đột với Prettier
    ],
    languageOptions: {
      ecmaVersion: 'latest',       // Cho phép dùng syntax ES mới nhất
      globals: globals.browser,    // Định nghĩa sẵn global variables cho môi trường browser
      parserOptions: {
        ecmaFeatures: { jsx: true }, // Cho phép lint JSX
        sourceType: 'module',        // Sử dụng ES Modules
      },
    },
    plugins: {
      prettier, // Thêm plugin để chạy Prettier như một rule trong ESLint
    },
    rules: {
      // Báo lỗi nếu có biến không dùng,
      // ngoại lệ: bỏ qua biến viết HOA toàn bộ (thường là constants hoặc env variables)
      'no-unused-vars': ['error', { varsIgnorePattern: '^[A-Z_]' }],

      // Trong React 17+ không cần import React trong file JSX => tắt rule này
      'react/react-in-jsx-scope': 'off',

      // Nếu code không tuân theo Prettier thì báo lỗi ESLint
      'prettier/prettier': 'error',
    },
  },
])

```

## 4. Cấu hình Prettier

### 4.1. File `.prettierrc`

```json
{
  "semi": true,             // Luôn thêm dấu ; cuối câu lệnh
  "singleQuote": true,      // Dùng ' thay vì "
  "tabWidth": 2,            // Mỗi tab = 2 khoảng trắng
  "trailingComma": "es5",   // Thêm dấu , khi cú pháp ES5 cho phép
  "printWidth": 80          // Ngắt dòng khi dài quá 80 ký tự
}
```

### 4.2. File `.prettierignore`

```
node_modules
dist
build
```

👉 Bỏ qua các thư mục không cần format.

## 5. Cấu hình EditorConfig

Tạo file `.editorconfig`:

```ini
root = true

[*]
charset = utf-8             # Đặt encoding mặc định
end_of_line = lf            # Xuống dòng theo chuẩn LF (Linux/Mac)
indent_style = space        # Thụt lề bằng space
indent_size = 2             # Mỗi cấp indent = 2 space
insert_final_newline = true # Tự thêm newline cuối file
trim_trailing_whitespace = true # Xoá khoảng trắng thừa cuối dòng

[*.md]
trim_trailing_whitespace = false # Giữ nguyên khoảng trắng trong Markdown
```

👉 Giúp giữ format code đồng nhất giữa nhiều IDE/editor.

## 6. Thêm script vào `package.json`

Mở `package.json` và thêm:

```json
"scripts": {
  "dev": "vite",
  "build": "vite build",
  "preview": "vite preview",
  "lint": "eslint . --ext .js,.jsx,.ts,.tsx",   // Kiểm tra code với ESLint
  "format": "prettier --write ."                 // Tự động format toàn bộ code
}
```

## 7. Cấu hình VSCode (khuyến nghị)

Tạo file `.vscode/settings.json`:

```json
{
  "editor.formatOnSave": true,                        // Format khi lưu file
  "editor.defaultFormatter": "esbenp.prettier-vscode", // Dùng Prettier làm formatter mặc định
  "eslint.validate": [
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact"
  ]
}
```

## 8. Quy trình làm việc

1. Viết code bình thường.
2. Khi **Save** → VSCode sẽ tự format bằng Prettier.
3. Trước khi commit → chạy:

   ```bash
   npm run lint
   ```

   để check lỗi.
4. Nếu có lỗi format → fix nhanh bằng:

   ```bash
   npm run format
   ```

---

✅ Với cấu hình này, team bạn sẽ có một bộ công cụ đầy đủ:

* **ESLint** để đảm bảo chất lượng code.
* **Prettier** để format đồng nhất.
* **EditorConfig** để giữ chuẩn indent/newline giữa nhiều editor.
* **VSCode settings** để tự động hoá format.

