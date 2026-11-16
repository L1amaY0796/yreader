# yreader

輕量的終端機電子書閱讀器。單一檔案，只需要 Python 3.7 以上（標準函式庫，含 curses），不用安裝任何額外套件。

支援格式：epub、mobi / azw / prc、azw3 (KF8)、fb2、html、txt。有 DRM 保護的檔案無法讀取。

## 安裝

```bash
install -m 755 yreader ~/.local/bin/yreader
```

（或 `sudo install -m 755 yreader /usr/local/bin/yreader`）

## 使用

```bash
yreader ebook.epub
```

- `yreader`（不帶檔名）：開啟上次閱讀的書
- `yreader -c green ebook.epub`：指定文字顏色（white / green / blue）
- `yreader --dump ebook.epub`：輸出純文字

## 按鍵

| 按鍵 | 功能 |
| --- | --- |
| 空白 → ↓ PgDn j l | 下一頁 |
| ← ↑ PgUp k h | 上一頁 |
| 數字 + Enter | 跳到指定頁碼 |
| g / G | 第一頁 / 最後一頁 |
| [ / ] | 上一章 / 下一章 |
| t | 目錄 |
| Tab / Shift-Tab | 選取本頁的下一個 / 上一個連結 |
| Enter | 開啟選取的連結（註解、內文連結） |
| Backspace / b | 返回跳轉前的位置 |
| c | 切換文字顏色（白 / 綠 / 藍） |
| ? | 按鍵說明 |
| q | 離開 |

圖片一律顯示為 `<image>`。

## 閱讀紀錄

離開時自動保存每本書的閱讀位置與顏色設定，存放在 `~/.local/share/yreader/history.json`
（或 `$XDG_DATA_HOME/yreader/`）。位置以段落記錄，改變終端機視窗大小後仍會回到同一處。
