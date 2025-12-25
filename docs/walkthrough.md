# Finnovu MVP Walkthrough

## Overview
We have built a foundational Expense Tracker MVP titled **Finnovu**.
It supports:
- **Cross-Platform**: Android, iOS, Windows, Linux, macOS.
- **Local Storage**: Data persists using SQLite.
- **State Management**: Uses `Provider` for clean architecture.
- **Visuals**: Dashboard with a Pie Chart.

## Features & Usages
### 1. Home Screen (Transactions)
- **View**: Lists all your expenses sorted by date.
- **Delete**: Swipe or click the delete icon to remove an expense.
- **Add**: Tap the floating "+" button to enter a new expense.

### 2. Add Transaction
- Enter **Title** (e.g., "Lunch").
- Enter **Amount** (e.g., "15.50").
- Pick a **Date**.
- Select **Category** (Food, Travel, etc.).
- Tap "Add Transaction" to save.

### 3. Dashboard
- Tap the **Dashboard** tab at the bottom.
- View a **Pie Chart** breaking down expenses by category.
- See total spending at the top.

### 4. Web Persistence & Debugging
> [!NOTE]
> **Important for Web Development**:
> When running `flutter run -d chrome`, Flutter launches a **temporary** Chrome profile. If you stop the app and restart it using the terminal, this profile (and your data) is wiped.
>
> **To Verify Persistence**:
> 1. Run `flutter run -d web-server --web-port=3000`.
> 2. Open `http://localhost:3000` in your **regular** Chrome browser.
> 3. Add a transaction.
> 4. Refresh the page. The data should remain!
>
> **Verification Screenshot**:
> ![Persistence Success](file:///C:/Users/Mrinal/.gemini/antigravity/brain/df3b42bf-56c6-4517-838d-bf61246b04e7/persistence_success_png_1766650594996.png)

## Code Structure (For Learning)
- **`lib/main.dart`**: Entry point. Sets up the Theme and Providers.
- **`lib/models/transaction.dart`**: Defines what a "Transaction" *is*.
- **`lib/database/db_helper.dart`**: Handles all "talk" with the SQLite database.
    - *Note*: Includes special logic for Windows/Linux/macOS using `sqflite_common_ffi`.
- **`lib/providers/transaction_provider.dart`**: The "brain". It fetches data from DB and tells the UI to update.
- **`lib/screens/`**: The UI pages (`HomeScreen`, `AddTransactionScreen`, `DashboardScreen`).

## Next Steps (Future Features)
As per your roadmap:
1.  **SMS/Email Parsing**: Will require platform channels to read messages.
2.  **Scan Receipt (OCR)**: Will need camera integration and an OCR package (like Google ML Kit).
3.  **Family Sync**: will require a backend (Firebase/AWS) instead of just local SQLite.
