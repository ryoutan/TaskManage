About 5xTraining with me
本資料來源:https://github.com/5xRuby/5xtraining

# 5xTraining: 後端 & DevOps

## 概要

### 開發需求

本教程的主要課題，是要開發一套任務管理系統。這個系統需要做到的事情有：

- 可以簡單地登錄自己的任務
- 可以設定任務的結束時間
- 可以設定任務的優先順序
- 可以管理各種狀態（待處理、進行中、完成）
- 可以依狀態列出不同任務
- 可以依任務的標題、內容進行搜尋
- 可以看到任務的列表，並依優先順序、結束時間等進行排序
- 可以為任務加上分類標籤
- 可以讓使用者登入，並只能看見自己建立的任務

滿足以上需求之後，還會需要如下的管理機制：

- 使用者的管理功能

### 瀏覽器支援

- 預設需要支援 macOS/Chrome 的最新版本

### 開發工具

請以下列程式語言、middleware 的最新版本進行開發。

- Ruby
- Ruby on Rails
- PostgreSQL

server 端請使用：

- Heroku
- 如果你是 DevOps 相關，請在 Linode 或 Digital Ocean 或 Vultr 上建立一台 VM
  - CentOS 7
  - 安裝 Ruby / PostgreSQL 或其它專案需要的東西

※ 本教程中對效能、資安沒有特別的要求，但仍需要有一定的品質。網站效能太差的話，會被要求改善。

## 教程的最終目標

完成本教程後，我們會認為你已經習得以下能力：

- 可以實做基本的 Rails 網站
- 可以將 Rails 專案上線至一般的環境
- 對於已經上線的 Rails 專案，能夠進行功能的追加和資料維護
- 知道如何在 GitHub 發 PR、merge 等協作流程，以及必須的 git 指令
	- 能將 commit 切成適度的大小
	- 能寫出適合的 PR 說明
	- 能針對 code review 進行修正
- 遇到問題時，能夠適時以口頭或線上工具向相關人員（在本例中為導師）求救

## 參考資料

- Git: [https://gitbook.tw/](https://gitbook.tw/)
- Rails: [https://railsbook.tw/](https://railsbook.tw/)

## 必修課題

### 步驟1: 建立 Rails 的開發環境

#### 1-1: 安裝 Ruby

- 利用 [rbenv](https://github.com/rbenv/rbenv) 或 [RVM](https://rvm.io) 安裝最新版本的 Ruby
- 以 `ruby -v` 指令來確認 Ruby 的版本

#### 1-2: 安裝 Rails

- [x]以 gem 指令安裝 Rails
[x] 安裝最新版本的 Rails
[x] 以 `rails -v` 指令來確認 Rails 的版本

#### 1-3: 安裝資料庫（PostgreSQL）

[x] 在你使用的 OS 下安裝 PostgreSQL
	[x] macOS 的話，請以 `brew` 等工具安裝

### 步驟2: 在 GitHub 建立 repo

[x] 在你的環境中安裝 git
	[x] macOS 的話，請以 `brew` 等工具安裝
	[x] 以 `git config` 設定 user name 和 email
[x] 請考慮專案名稱（也等於 repo 名稱）
[x] 建立 repo
	[x] 如果沒有帳號的話，先申請帳號
	[x] 接著產生空白的 repo

### 步驟3: 建立 Rails 專案

[x] 以 `rails new` 指令，建立 app 最低限度的樣板和檔案
[] 在 `rails new` 產生的專案目錄下，建立 `docs` 資料夾，並將本教程文件 commit 進去
	[] 搬進來是為了方便之後開發時可以參考
  [x] 將教程文件寫入 README
[x] 將成品 push 到 GitHub 的 repo
- 將使用的 Ruby 版號寫進 `Gemfile`（也請確認 Rails 版號是否有標明）

### 步驟4: 想像網站成品會是什麼樣子

[x] 開始進行設計之前，先和導師一起討論對最終成品的預想。建議在紙上畫 prototype
[x] 請參照網站需求，開始想需要怎樣的資料結構
	[x] 需要哪些 model (table)？
	[x] table 會需要哪些欄位？
[x] 有想法之後，將 model 關係圖手繪出來
	- 完成後將關係圖拍照存檔，放進 repo 裡
	- 把 table schema 寫進 `README.md`（model 名稱、欄位名稱、資料形態）

※ 在這個階段，model 關係圖不需要是完全正確的。以現在所能預想的範圍來規劃就好（做到後面的步驟，發現需要修改時再來調整的概念）

### 步驟5: 資料庫連接等週邊設定

- 先建立新的 git topic branch
	- 之後都在 topic branch 上開發並 commit
[x] 安裝 bundler
[x] 在 `Gemfile` 安裝 `pg`（PostgreSQL 的 adapter）
[x] 設定 `database.yml`
[x] 以 `rails db:create` 建立資料庫
[x] 以 `rails db` 確認有正確連接資料庫
[] 在 GitHub 上建立 PR 並請人 review
	[] 必要時，請在 PR 上標柱 WIP（work in progress）
	[] 收到 comment 後就做必要的處置。收到兩個 LGTM（looks good to me） 後就可以 merge 回 master

### 步驟6: 建立任務 model

開始來做管理任務所需要的 CRUD。
一開始先簡單做，只要能記錄名字和任務內容即可。

[] 以 `rails generate` 指令建立 CRUD 所需的 model class
[] 撰寫 migration 並以此建立 table
	[] 非常重要：migration 要確定能安全回到上一步的狀態！請養成以 `redo` 確認的習慣
[] 以 `rails c` 指令，透過 model 確認有正確連接資料庫
	[] 順便試著以 ActiveRecord 建立資料
[] 在 GitHub 上發 PR 並請人 review

### 步驟7: 讓任務能夠被新增、修改、刪除

[] 製作任務的列表、新增、檢視、修改頁面
	[] 以 `rails generate` 指令產生 controller
		[] 請和導師討論要用哪一種 template engine
	[] 實做 controller 和 view 必要的部分
	[] 新增、修改、刪除後，需要顯示對應的 flash 訊息
[] 修改 `routes.rb`，讓 `http://localhost:3000/` 會顯示任務的列表頁面
[] 在 GitHub 上發 PR 並請人 review
	[] 之後的 PR，如果覺得過於龐大，就需要開始考慮分割成多個 PR

### 步驟8: 寫 E2E 測試

[] 寫 spec 的事前準備
	[] 準備 `spec/spec_helper.rb` 、`spec/rails_helper.rb`
[] 針對任務的功能來寫 feature spec
[] 導入 Travis CI 之類的 CI 工具，每次 Push 自動跑 Spec
	[] 太難的話可以請導師幫忙設定

### 步驟9: 將網站中的中文部分共用化

[] 利用 Rails 的 i18n 功能，將 View / Controller / Model 中的語言部份共用化

※ i18n 化的好處是，之後的步驟中，各種訊息的處理會輕鬆很多

### 步驟10: 設定 Rails 的時區

[] 將 Rails 的時區設為台灣（台北）

### 步驟11: 任務列表以建立時間排序

[] 現在是以 id 排序，請試著讓它以建立時間排序
[] 完成後，撰寫 feature spec

### 步驟12: 資料驗證

[] 開始設定資料驗證
	[] 請思考需要在哪個欄位上加入哪種驗證比較好
	[] 與之配合的 DB 限制，請寫成 migration
	[] 以 `rails generate` 指令產生 migration file
[] 在頁面上加入驗證的錯誤訊息
[] 撰寫對應的 model 測試
[] 在 GitHub 上發 PR 並請人 review

### 步驟13: 網站佈署

#### 一般版（非 DevOps 適用）

[] 來將 master branch 上的簡易任務管理系統推上線吧
[] 試著將網站 deploy 到 Heroku 上
	[] 沒有帳號的話，請建立帳號
[] 戳一下被推上 Heroku 的網站
  [] 接下來就會在這裡建立任務並繼續開發
  [] ※ 不過，推上 Heroku 後，就是在網路上公開了，請注意不要放敏感資料
    [] 現階段，或許可以考慮加入 basic 認證
  [] 今後，每個步驟完成後，就繼續將成品推上 Heroku
[] 將佈署的方法寫進 `README.md`
	[] 也將使用的 framework 版號等資料記下來

#### VPS 版（DevOps 適用）

[] 註冊服務商（Linode / DO / Vultr）帳號或登入
[] 開機器（1G Ram 機種，OS 用 CENTOS 7 x64）並加入自己的 SSH KEY
[] 用[普通的方式1](https://blog.frost.tw/posts/2018/03/20/Getting-started-deploy-your-Ruby-on-Rails-Part-1/)或[普通的方式2](https://ryudo.tw/blog/2017/01/24/install-ruby-rails-passenger-postgresql-into-rhel-2017/)安裝必要的套件和 CRuby
[] 安裝必要的其它套件
[] 請使用 Passenger + Nginx 做為 Application Server 和 Web Front-End Server

### 步驟14: 加入結束時間

[] 讓任務可以設定結束時間
[] 讓列表頁能夠以結束時間排序
[] 擴充 spec
[] PR/review 後佈署

### 步驟15: 加入狀態，並且能夠查詢

[] 在任務上加入狀態（待處理、進行中、完成）
	[] 【選項】不是初學者的話，可以使用管理 state 的 gem
[] 在列表頁面，要能夠以標題和狀態進行查詢
	[] 【選項】不是初學者的話，可以使用 ransack 等 gem
[] 在設定條件查詢時，請觀察 log 並確認 SQL 的變化
	[] 之後的步驟也需要這麼做，請養成習慣
[] 建立 search index
	[] 準備一定程度的測試資料後，觀察 log/development.log 以確認加入 index 後對速度的改善
	[] 【選項】使用 PostreSQL 的 explain 等功能，檢視資料庫端的 index 使用狀況
[] 針對查詢功能增加 model spec（feature spec 也要擴充）

### 步驟16: 設定優先順序（※有實做過類似功能的人可以跳過）

[] 在任務上加入優先順序（高中低）
[] 能夠以優先順序做排序
[] 擴充 feature spec
[] PR/review 後 佈署（以下同）

### 步驟17: 增加分頁功能

[] 使用 kaminari gem 在列表頁面加入分頁功能

### 步驟18: 加入設計

[] 導入 bootstrap，為目前為止的作品套入設計
	[] 【選項】自己寫 CSS 來設計

### 步驟19: 支援多人使用（導入使用者）

[] 建立使用者 model
[] 以 seed 建立第一個使用者
[] 建立使用者和任務的關聯
	[] 建立關聯所需的 index
	[] 設計上要注意避免 N+1 問題
	[] ※ 推上 Heroku 時，已經建立過的任務，要和使用者建立關係（資料維護）

### 步驟20: 實做登入/登出功能

[] 這裡不能使用 gem，請自己實做
	[] 不使用 devise 等 gem，是為了讓新人能更深入了解 Rails 中 HTTP cookie 和 session 的原理
	[] 以及加強對一般認證機制的理解（例如密碼的處理）
[] 實做登入的頁面
[] 未登入時，不能進入任務管理頁面
[] 請改成只能看到自己建立的任務
[] 實做登出功能

### 步驟21: 實做使用者管理頁面

[] 在頁面上新增管理選單
[] 管理頁面的網址一定要以 `/admin` 開頭
	[] 在修改 `routes.rb` 之前，請想一下 URL 以及 routing name（會變成 `*_path` 的部分）要怎麼設計
[] 實做使用者列表、新增、修改、刪除等功能
[] 刪除使用者後，也一併刪除該使用者的任務
[] 在使用者列表頁面，顯示使用者的任務數量
[] 能夠看到使用者所建立的任務列表

### 步驟22: 為使用者加入角色

[] 將使用者分為管理員和一般使用者
[] 請改成只有管理員可以存取使用者管理頁面
	[] 一般使用者存取管理頁面時，需要有專用的例外處理
	[] 補充來說，例如適當的錯誤頁面（也可以在步驟 24 再實做）
[] 能在使用者管理頁面選擇角色
[] 管理者只剩下一個人時，不能再被刪除
	[] 利用 model 的 callback 實做
[] ※ 可以自己決定是否要使用 gem

### 步驟23: 為任務加入標籤

[] 任務可以設定複數的標籤
[] 能夠以標籤進行搜尋

### 步驟24: 設定錯誤頁面

[] 將 Rails 的預設錯誤頁面換成自己的
[] 根據不同狀況，設定適合的錯誤頁面
	[] 至少需要做 404 和 500 這兩頁
