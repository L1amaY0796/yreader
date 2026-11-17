# yreader

[中文](#中文) | [English](#english)

## 中文

輕量的終端機電子書閱讀器。單一檔案，只需要 Python 3.7 以上的標準函式庫，不用安裝任何額外套件。
可在 Linux、macOS 的終端機，以及 Windows 的 PowerShell / cmd 使用。

支援格式：epub、mobi / azw / prc、azw3 (KF8)、fb2、html、txt。有 DRM 保護的檔案無法讀取。

### 安裝（Linux / macOS）

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

### 安裝（Windows PowerShell）

需要先有 Python 3.7 以上（[python.org](https://www.python.org/downloads/)，或 `winget install Python.Python.3.13`）以及 Windows 10 以上。

在 PowerShell 貼上這一行即可，會詢問介面語言：

```powershell
irm https://raw.githubusercontent.com/L1amaY0796/yreader/main/install.ps1 | iex
```

或是從 clone 下來的資料夾安裝：

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

安裝程式會把程式放到 `%LOCALAPPDATA%\Programs\yreader`，並把這個資料夾加進使用者的 `PATH`。之後在 PowerShell 或 cmd 都可以直接用：

```powershell
yreader ebook.epub
```

- 建議使用 Windows Terminal（Windows 11 內建），中文字型與顯示效果最好。
- 閱讀紀錄存在 `%APPDATA%\yreader\history.json`。
- 更新：重跑一次安裝指令。移除：刪掉 `%LOCALAPPDATA%\Programs\yreader` 資料夾。

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
- `yreader --list`：列出可閱讀的檔案（見下方）

### 列出檔案

```bash
yreader --list
```

列出目前資料夾裡可閱讀的檔案（epub、mobi、azw、azw3、prc、fb2、html、txt），一行一個。也可以寫成 `yreader -list`。要其他篩選方式，用 `ls` 就可以了。

### 按鍵

| 按鍵 | 功能 |
| --- | --- |
| 空白 → ↓ PgDn j l | 下一頁 |
| ← ↑ PgUp k h | 上一頁 |
| 數字 + Enter | 跳到指定頁碼 |
| g / G | 第一頁 / 最後一頁 |
| [ / ] | 上一章 / 下一章 |
| t | 目錄 |
| Tab / Shift-Tab | 選取本頁的下一個 / 上一個連結或圖片 |
| Enter | 開啟選取的連結（註解、內文連結）；圖片則用外部程式開啟 |
| Backspace / b | 返回跳轉前的位置 |
| m | 在此頁加入 / 移除書籤 |
| M | 書籤清單 |
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

### 圖片

圖片在內文裡顯示為 `<image>`。用 `Tab` 選到它再按 `Enter`，會把圖片取出來交給系統預設的看圖程式開啟：

- Windows：預設的相片檢視程式
- WSL：Windows 那邊的預設程式
- macOS：`open`
- Linux 桌面：`xdg-open`（需要圖形環境）

想指定程式可以設定環境變數，例如 `export YREADER_IMAGE_VIEWER=feh`。沒有圖形環境（例如純 SSH）時，圖片會存到暫存資料夾並顯示路徑。暫存檔在離開 yreader 時自動刪除。

包在連結裡的圖片以連結為準，按 Enter 是前往連結。

### 書籤

- `m`：在目前這頁加入書籤；這頁已有書籤時再按一次就是移除。有書籤的頁面，狀態列會顯示 `[書籤]`。
- `M`：開啟書籤清單，顯示章節、開頭文字與頁碼。↑↓ 選擇、Enter 前往、`d` 刪除、Esc 關閉。

每本書可以有多個書籤，離開時跟閱讀位置一起保存。前往書籤後按 Backspace 可回到原處。

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

離開時自動保存每本書的閱讀位置與書籤，以及顏色、語言與版面設定，存放在 `~/.local/share/yreader/history.json`
（或 `$XDG_DATA_HOME/yreader/`；Windows 是 `%APPDATA%\yreader\`）。位置以段落記錄，改變終端機視窗大小後仍會回到同一處。

## English

A lightweight ebook reader for the terminal. It is a single file that needs only the Python 3.7+ standard library and no extra packages.
It runs in Linux and macOS terminals, and in PowerShell / cmd on Windows.

Formats: epub, mobi / azw / prc, azw3 (KF8), fb2, html, txt. DRM-protected files cannot be read.

### Install (Linux / macOS)

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

### Install (Windows PowerShell)

Requires Python 3.7+ ([python.org](https://www.python.org/downloads/), or `winget install Python.Python.3.13`) and Windows 10 or later.

Paste this into PowerShell; it asks for the interface language:

```powershell
irm https://raw.githubusercontent.com/L1amaY0796/yreader/main/install.ps1 | iex
```

Or, from a clone:

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

The installer puts the program in `%LOCALAPPDATA%\Programs\yreader` and adds that folder to your user `PATH`, so `yreader ebook.epub` works in both PowerShell and cmd. Windows Terminal is recommended for the best CJK rendering. The reading history is kept in `%APPDATA%\yreader\history.json`.

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
- `yreader --list`: list readable files (see below)

### Listing files

`yreader --list` (or `yreader -list`) prints the readable files in the current folder (epub, mobi, azw, azw3, prc, fb2, html, txt), one per line. For any other filtering, use `ls`.

### Keys

| Key | Action |
| --- | --- |
| Space → ↓ PgDn j l | Next page |
| ← ↑ PgUp k h | Previous page |
| Number + Enter | Go to page |
| g / G | First / last page |
| [ / ] | Previous / next chapter |
| t | Table of contents |
| Tab / Shift-Tab | Select next / previous link or image on the page |
| Enter | Follow the selected link; open a selected image externally |
| Backspace / b | Go back to where you were |
| m | Add / remove a bookmark on this page |
| M | Bookmark list |
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

### Images

Images appear as `<image>` in the text. Select one with `Tab` and press `Enter` to extract it and open it in the system's default image viewer (the default app on Windows and WSL, `open` on macOS, `xdg-open` on a Linux desktop).

Set `YREADER_IMAGE_VIEWER` to use a specific program, e.g. `export YREADER_IMAGE_VIEWER=feh`. Without a graphical environment the image is saved to a temporary folder and its path is shown. Temporary files are removed when yreader exits.

### Bookmarks

- `m`: bookmark the current page; press it again on a bookmarked page to remove it. Bookmarked pages show `[BM]` in the status bar.
- `M`: open the bookmark list (chapter, first words, page). Up/Down to select, Enter to go, `d` to delete, Esc to close.

A book can have any number of bookmarks; they are saved on exit together with the reading position.

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

The position and bookmarks of each book, plus the color, language and layout settings, are saved on exit to `~/.local/share/yreader/history.json` (or `$XDG_DATA_HOME/yreader/`).
