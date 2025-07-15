# :pushpin:Аналіз продажів велосипедів в Австралії 
###
## 📜URL`s:
:link:Посилання на Google Sheets: [google sheets](https://docs.google.com/spreadsheets/d/192K1SStzX3pPXUlqU6cPoZ3ul7pr-YdZVEo-Jw9PxlU/edit?usp=sharing)

:link:Дані взяв звідси: [GitHub](https://github.com/Youtube-NikitaTymoshenko/googleSheets-course/tree/main/%D0%94%D0%B0%D0%BD%D1%96%20%D0%B4%D0%BB%D1%8F%20%D1%80%D0%BE%D0%B1%D0%BE%D1%82%D0%B8)

📎 Для детальнішого перегляду роботи запрошую в папки tables, power BI (в розробці), SQL та 🔗[google sheets](https://docs.google.com/spreadsheets/d/192K1SStzX3pPXUlqU6cPoZ3ul7pr-YdZVEo-Jw9PxlU/edit?usp=sharing) з повними версіями таблиць, коду та візуалізацій!

## :green_book: Основні приклади моїх можливостей в межах цього проекту.
### 👁️‍🗨️Опрацювання даних в Google Sheets
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

### 📈 Візуалізація в Google Sheets (DashBoard) 📉

<img width="1919" height="856" alt="image" src="https://github.com/user-attachments/assets/1d72b802-9d44-4a3b-95d0-21390fd8d901" />
  DashBoard є навчальним, взятим з курсу Google Sheets Нікіти Тімошенка.


### :arrows_counterclockwise: трансформування наявних даних за допомогою запитів в PostgreSQL
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

### Power BI візуалізація (DashBoard) 
в процесі!😄
тест для подальшої праці
