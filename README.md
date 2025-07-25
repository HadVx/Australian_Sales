# :pushpin:Аналіз продажів велосипедів в Австралії 
###
## 📜URL`s:
:link:Посилання на Google Sheets: [google sheets](https://docs.google.com/spreadsheets/d/192K1SStzX3pPXUlqU6cPoZ3ul7pr-YdZVEo-Jw9PxlU/edit?usp=sharing)

:link:Дані взяв звідси: [GitHub](https://github.com/Youtube-NikitaTymoshenko/googleSheets-course/tree/main/%D0%94%D0%B0%D0%BD%D1%96%20%D0%B4%D0%BB%D1%8F%20%D1%80%D0%BE%D0%B1%D0%BE%D1%82%D0%B8)

📎 Для детальнішого перегляду роботи запрошую в папки tables, power BI (в розробці), SQL та 🔗[google sheets](https://docs.google.com/spreadsheets/d/192K1SStzX3pPXUlqU6cPoZ3ul7pr-YdZVEo-Jw9PxlU/edit?usp=sharing) з повними версіями таблиць, коду та візуалізацій!

### :green_book: Нижче розміщені фото-звіти роботи з метою демонстрації моїх можливостей, в межах цього проекту.
## 👁️‍🗨️Опрацювання даних в Google Sheets
приклади сторінок з книги Google Sheets у форматі ДО/ПІСЛЯ

  Декілька слів: Перевірка даних у таблицях відбувалася після їх збору (в моєму випадку, запозичення готового паку сирих даних) та включає перевірку на релевантність, доречність, достовірність, актуальність і унікальність (відсутність дублювання) для їх подальшої підготовки. Далі підгототував дані у реляційний формат для їх подальшого трансформування. Трансформував дані (в основному, таблиця Transactions, створив зведені таблиці) та за допомогою набору зведених таблиць створив інтерактивний Dash Board в Google Sheets. 

### :shit:Transactions
<img width="1918" height="796" alt="image" src="https://github.com/user-attachments/assets/971f6cdf-9a79-408d-9a5d-750eaef446de" />

### :fire:Transactions_clean 
Видалено дублікати та аномальні дані (на кшталт DOB: 1900-01-01), відформатовано дані та додано декілька стовпців з інших таблиць! Зведено до нормованого формату
<img width="1919" height="775" alt="image" src="https://github.com/user-attachments/assets/102a9100-4952-422d-afe8-bf8219c68028" />

### :shit:Customers
Видалено декілька невалідних стовпців, вилучені дублікати та аномальні дані (на кшталт DOB: 1900-01-01), відформатовано дані та додано декілька стовпців з інших таблиць! Зведено до нормованого формату

<img width="1919" height="848" alt="image" src="https://github.com/user-attachments/assets/10cd5628-52ac-4094-a269-08e58e3d73ab" />

### :fire:Customers_clean 

<img width="1919" height="857" alt="image" src="https://github.com/user-attachments/assets/a5c3c90b-7b60-48fc-b4ff-4bb8074c5648" />

## 📈 Візуалізація в Google Sheets (DashBoard) 📉

<img width="1919" height="856" alt="image" src="https://github.com/user-attachments/assets/1d72b802-9d44-4a3b-95d0-21390fd8d901" />
  DashBoard є навчальним, взятим з курсу Google Sheets Нікіти Тімошенка, відтворений мною. Усі інші етапи роботи - самостійні! 


## :arrows_counterclockwise: трансформування наявних даних за допомогою запитів в PostgreSQL
Декілька слів: Нормовані дані з попереднього етапу переніс в SQL-середовище та, за допомогою запитів, зробив декілька Power BI-friendly таблиць з різними інсайдами.
Написання коду відбувалось виключно мною, проте завдання були запропоновані штучним інтелектом!
Весь код можна глянути в директорії SQL, приклади написання з кожного файлу закріплю нижче!

### :fire:Recency_Frequency_Monetary(RFM)+
<img width="1726" height="928" alt="image" src="https://github.com/user-attachments/assets/5f419fd2-96b9-4a7e-a264-48574ae7c4ef" />

### :fire:Brand-Product_Perfomance(BPP)
<img width="1708" height="892" alt="image" src="https://github.com/user-attachments/assets/98435951-747d-4b03-a047-b455def8a3b5" />

### :fire:Customer_Lifetime_Value(CLV)
<img width="1719" height="926" alt="image" src="https://github.com/user-attachments/assets/a5b2135f-6b56-4790-ad65-e44604a31c73" />

### :fire:Regional_Sales_Insights(RSI)
<img width="1699" height="978" alt="image" src="https://github.com/user-attachments/assets/e2c2f399-2685-4850-b1cc-914471b1eb79" />
Маю досвід написання великих кодів з десятком CTE блоків (RFM+.sql)

## 📈Power BI візуалізація (DashBoard) 📉
  Створені в SQL таблиці імпортував в Power BI, на кожну таблицю виділив один аркуш (+1 аркуш в виді Tooltip-у до кожної сторінки, всього - 8 сторінок). Детальніше переглянути можна скачавши дані з SQL-директорії та саму візуалізацію в Power BI, нижче прикріплені скріншоти роботи! 
### 1️⃣Загальна інформація по Продажам

<img width="1280" height="773" alt="image" src="https://github.com/user-attachments/assets/6b9bd75e-54e7-476e-9062-f86dcb7a5d0a" />

### 2️⃣Продажі по Брендам і Класам 

<img width="1280" height="779" alt="image" src="https://github.com/user-attachments/assets/5365d585-d6ab-46b2-95b8-ec9cbc11df9d" />

<img width="1280" height="779" alt="image" src="https://github.com/user-attachments/assets/32a49895-e0ba-4041-b117-d73b958abc3d" />

<img width="1280" height="782" alt="image" src="https://github.com/user-attachments/assets/a3bcc8d3-3c0b-4c57-b77d-2debf3b9b69f" />

<img width="1280" height="780" alt="image" src="https://github.com/user-attachments/assets/d0f71a64-2604-4e03-acbe-ed4743c05505" />

### 3️⃣Інформація про прибутковість клієнтів 

<img width="1280" height="782" alt="image" src="https://github.com/user-attachments/assets/97298c9f-443f-4239-bd9d-c6f5fdbcab4a" />

### 4️⃣Загальна інформація по клієнтам 

<img width="1280" height="782" alt="image" src="https://github.com/user-attachments/assets/b648d496-5471-4118-85a4-2a8f5800dc2f" />

### 🗒️Tooltip-и та їх застосування

  До кожної таблиці створив Tooltip з корисною інформацією, нижче приклади та використання, допомагає краще зрозуміти метрики та розкриває більше деталей щодо діаграм.

### 1️⃣Загальна інформація по Продажам

<img width="422" height="214" alt="image" src="https://github.com/user-attachments/assets/c839bbba-44b9-4f4b-8d69-f3022f4ff6f4" />

### Використання :bar_chart:

<img width="755" height="672" alt="image" src="https://github.com/user-attachments/assets/50ca87c2-f140-4876-bd5d-7d3e1968c323" />

### 2️⃣Продажі по Брендам і Класам 

<img width="424" height="315" alt="image" src="https://github.com/user-attachments/assets/46612582-3540-4859-827e-962913bd9160" />

### Використання :bar_chart:

<img width="874" height="672" alt="image" src="https://github.com/user-attachments/assets/ee8b1499-1ab8-43ea-9354-1a3d531d3a18" />

### 3️⃣Інформація про прибутковість клієнтів

<img width="427" height="616" alt="image" src="https://github.com/user-attachments/assets/0fc11c50-8355-4670-9752-d120ab8c2493" />

### Використання 📊

<img width="883" height="740" alt="image" src="https://github.com/user-attachments/assets/be41a23e-0ac1-47c5-aee9-645c63e6b12c" />

### 4️⃣Загальна інформація по клієнтам 

<img width="316" height="105" alt="image" src="https://github.com/user-attachments/assets/424a656e-8a31-48e6-8cd3-e2f90bca89a1" />

### Використання 📊

<img width="594" height="363" alt="image" src="https://github.com/user-attachments/assets/aceaa07a-dfb2-4de4-a5a2-9b992680c3ce" />

## Вирази DAX для метрики в виді зірочок та profit_margin: 

### :blue_book: profit_margin

    profit_margin = 
    VAR profit = AVERAGE(BPP[avg_profit])
    VAR price = AVERAGE(BPP[avg_price])
    RETURN 
        IF(
            ISBLANK(price) || price = 0,
            BLANK(),
            DIVIDE(profit, price)
        )
    
### ⭐stars_total

    stars_total = 
    VAR AvgR = AVERAGE('RFM+'[r])
    VAR AvgF = AVERAGE('RFM+'[f])
    VAR AvgM = AVERAGE('RFM+'[m])
    VAR AvgScore = ROUND((AvgR + AvgF + AvgM) / 3, 0)
    VAR full_stars = REPT("★", AvgScore)
    VAR null_stars = REPT("☆", 5 - AvgScore)
    RETURN
    full_stars & null_stars
