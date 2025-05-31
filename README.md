# Expense Tracker Lite

A lightweight expense tracking app built with Flutter using Clean Architecture and BLoC.  
Tracks expenses with offline storage, currency conversion, pagination, and custom UI.

---

## 🧩 Features

- Add, view, and filter expenses
- Currency conversion to USD using [open.er-api.com](https://open.er-api.com)
- SQLite local storage
- Pagination (10 items per page)
- Filters: This Month, Last 7 Days, All
- Dashboard with total balance, income, and expenses
- Clean Architecture with BLoC pattern
- Custom UI inspired by [Dribbble design](https://dribbble.com/shots/24276232-Expense-Tracker-App)

---

## 📱 Screens

### Dashboard
- Welcome text
- Total Balance, Income, and Expenses cards
- Recent transactions list
- FAB to add a new expense

### Add Expense
- Input category, amount, date, and currency
- Currency converted to USD
- Data saved to SQLite


---

## 🧪 Testing

Basic logic can be tested for:
- Currency conversion
- Validation
- Pagination calculation

*(Tests not included but structure ready.)*

---

## 🛠️ How to Run

```bash
flutter pub get
flutter run
```

> Requires Flutter 3.10 or higher

---

## 📁 Project Structure

```
lib/
├── core/              # Theme, constants
├── data/              # Data layer (models, database, API)
├── domain/            # Entities and usecases (not needed for this small scope)
├── presentation/      # UI, Screens, BLoC, Widgets
└── main.dart
```

---

## 💡 Notes

- Income is mocked as \$1000 for summary calculation.
- All expenses are saved locally.
- API uses latest free currency rates to convert on submit.

---

## 👨‍💻 Developed For

**Inovola Mobile Technical Interview Project**

> Expense Tracker Lite – With Currency Conversion, Pagination & Custom UI
