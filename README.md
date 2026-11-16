# yreader

[中文](#中文) | [English](#english)

## 中文

輕量的終端機電子書閱讀器。單一檔案，只需要 Python 3.7 以上（標準函式庫，含 curses），不用安裝任何額外套件。

支援格式：epub、mobi / azw / prc、azw3 (KF8)、fb2、html、txt。有 DRM 保護的檔案無法讀取。

### 安裝

用安裝程式（會詢問介面語言：中文或 English）：

```bash
git clone https://github.com/L1amaY0796/yreader.git
cd yreader
./install.sh
```

預設裝到 `~/.local/bin`；要裝到別處就給路徑，例如 `sudo ./install.sh /usr/local/bin`。

也可以只下載單一檔案，第一次執行時同樣會詢問語言：

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/L1amaY0796/yreader/main/yreader -o ~/.local/bin/yreader
chmod +x ~/.local/bin/yreader
```

如果執行 `yreader` 時找不到指令，代表 `~/.local/bin` 不在 `PATH` 裡，把這行加進 `~/.bashrc`：

```bash
export PATH="$HOME/.local/bin:$PATH"
```

更新時重跑一次安裝即可；移除則是 `rm ~/.local/bin/yreader`。

### 使用

```bash
yreader ebook.epub
```

- `yreader`（不帶檔名）：開啟上次閱讀的書
- `yreader -c green ebook.epub`：指定文字顏色（white / green / blue）
- `yreader -w 60 ebook.epub`：指定內文最大欄寬
- `yreader --lang en`：切換介面語言（zh / en）
- `yreader -e big5 old.txt`：強制指定文字編碼
- `yreader --dump ebook.epub`：輸出純文字

### 按鍵

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
| / | 搜尋 |
| n / N | 下一個 / 上一個搜尋結果 |
| Esc | 結束搜尋並回到搜尋前的頁面 |
| - / + | 縮小 / 加大欄寬 |
| s | 段落間距 開 / 關 |
| d | 行距 單行 / 雙行 |
| c | 切換文字顏色（白 / 綠 / 藍） |
| L | 切換介面語言（中文 / English） |
| ? | 按鍵說明 |
| q | 離開 |

圖片一律顯示為 `<image>`。

### 搜尋

按 `/` 輸入關鍵字後按 Enter，會跳到目前頁面之後的第一個結果，所有符合的文字都會反白（不分大小寫）。

- `n` / `N`：下一個 / 上一個結果
- `Esc`：結束搜尋，直接回到搜尋前停留的頁面
- `Enter`：結束搜尋但留在目前這頁（之後仍可用 Backspace 回去）
- `/` 後直接按 Enter：重複上一次的搜尋

### 版面

終端機程式無法改變字的大小（那是終端機的字型設定，通常是 `Ctrl` + `+` / `-`），但可以調整版面：

- `-` / `+`：縮小 / 加大內文欄寬（也可用 `yreader -w 60` 指定）
- `s`：段落之間是否空一行；關閉時改用首行縮排，一頁能放更多字
- `d`：單行 / 雙行行距

這些設定會記住，下次開啟時沿用。

### 介面語言

安裝時（或第一次執行時）選擇，之後隨時可改：

- 閱讀中按 `L`
- 或執行 `yreader --lang zh` / `yreader --lang en`

### 文字與編碼

- 書的內容是什麼語言都可以：中日韓文字以雙倍寬度排版，組合符號（越南文、泰文、希伯來文母音、日文濁音等）會跟著前一個字，不會被拆到下一行。
- 終端機需要使用 UTF-8（現在的 Linux 發行版預設都是），並且字型要有對應的字，否則會顯示成方框或問號，這是終端機與字型的限制。
- 非 UTF-8 的舊檔案會自動判斷 Big5、GBK、Shift-JIS、EUC-JP、EUC-KR、UTF-16。判斷錯誤或是其他編碼（例如俄文 cp1251）時，用 `-e` 指定一次，之後會記住。
- 阿拉伯文、希伯來文等由右至左的文字，是否正確排列取決於終端機本身（GNOME Terminal、Konsole 等有支援，多數其他終端機沒有）。

### 閱讀紀錄

離開時自動保存每本書的閱讀位置，以及顏色、語言與版面設定，存放在 `~/.local/share/yreader/history.json`
（或 `$XDG_DATA_HOME/yreader/`）。位置以段落記錄，改變終端機視窗大小後仍會回到同一處。

## English

A lightweight ebook reader for the terminal. It is a single file that needs only Python 3.7+ (standard library, including curses) and no extra packages.

Formats: epub, mobi / azw / prc, azw3 (KF8), fb2, html, txt. DRM-protected files cannot be read.

### Install

With the installer (it asks for the interface language, Chinese or English):

```bash
git clone https://github.com/L1amaY0796/yreader.git
cd yreader
./install.sh
```

It installs to `~/.local/bin` by default; pass a directory to install elsewhere, e.g. `sudo ./install.sh /usr/local/bin`.

Or download just the one file; it asks for the language on first run:

```bash
mkdir -p ~/.local/bin
curl -fsSL https://raw.githubusercontent.com/L1amaY0796/yreader/main/yreader -o ~/.local/bin/yreader
chmod +x ~/.local/bin/yreader
```

### Usage

```bash
yreader ebook.epub
```

- `yreader` (no file): reopen the last book
- `yreader -c green ebook.epub`: text color (white / green / blue)
- `yreader -w 60 ebook.epub`: maximum text width
- `yreader --lang zh`: change the interface language (zh / en)
- `yreader -e cp1251 old.txt`: force a text encoding
- `yreader --dump ebook.epub`: print plain text

### Keys

| Key | Action |
| --- | --- |
| Space → ↓ PgDn j l | Next page |
| ← ↑ PgUp k h | Previous page |
| Number + Enter | Go to page |
| g / G | First / last page |
| [ / ] | Previous / next chapter |
| t | Table of contents |
| Tab / Shift-Tab | Select next / previous link on the page |
| Enter | Follow the selected link (footnotes, cross-references) |
| Backspace / b | Go back to where you were |
| / | Search |
| n / N | Next / previous match |
| Esc | End the search and return to the page where it started |
| - / + | Narrower / wider text |
| s | Paragraph spacing on / off |
| d | Line spacing single / double |
| c | Cycle text color (white / green / blue) |
| L | Switch interface language |
| ? | Help |
| q | Quit |

Images are shown as `<image>`.

### Search

Press `/`, type some text and press Enter. It jumps to the first match from the current page onward and highlights every match (case-insensitive).

- `n` / `N`: next / previous match
- `Esc`: end the search and jump straight back to the page you were on before searching
- `Enter`: end the search but stay on the current page (Backspace still takes you back)
- `/` then Enter: repeat the last search

### Layout

A terminal program cannot change the font size (that is a terminal setting, usually `Ctrl` + `+` / `-`), but the layout is adjustable:

- `-` / `+`: narrower / wider text column (or `yreader -w 60`)
- `s`: blank line between paragraphs on / off; when off, paragraphs get a first-line indent instead
- `d`: single / double line spacing

These settings are remembered.

### Text and encodings

- Books in any language work. CJK text is laid out double-width, and combining marks stay attached to their base character.
- The terminal must use UTF-8 and have a font with the needed glyphs; otherwise characters show as boxes or question marks.
- Non-UTF-8 files are detected automatically for Big5, GBK, Shift-JIS, EUC-JP, EUC-KR and UTF-16. For anything else (or a wrong guess), pass `-e` once and it is remembered for that book.
- Right-to-left scripts (Arabic, Hebrew) are ordered correctly only in terminals that support bidirectional text (e.g. GNOME Terminal, Konsole).

### Reading history

The position in each book, plus the color, language and layout settings, are saved on exit to `~/.local/share/yreader/history.json` (or `$XDG_DATA_HOME/yreader/`).
