# Expense Tracker MVP Implementation Plan

This plan outlines the steps to build the Minimum Viable Product (MVP) for your Expense Tracker. Our goal is to create a functional app that helps you understand the core Flutter concepts (UI, State Management, Persistence) before tackling advanced features like SMS extraction or OCR.

## User Review Required
> [!IMPORTANT]
> **MVP Scope Definition**:
> To start, we will implement **manual data entry** instead of SMS/OCR. This allows you to learn how data flows through the app.
> - **Platform**: **Android, iOS, Web, Windows, Linux, macOS**
> - **Storage**: Local Database (SQLite) - data stays on your device.
> - **State Management**: `Provider` - beginner-friendly and industry standard.

## Proposed Architecture
We will use a clean, layered architecture to keep code organized:
1.  **Presentation Layer (UI)**: Screens and Widgets.
2.  **Business Logic Layer (State)**: Providers that handle data manipulation.
3.  **Data Layer (Repository)**: Database code.

### Directories
- `lib/models/`: Data structures (e.g., `Expense` class).
- `lib/screens/`: Full-page views (e.g., `HomeScreen`, `AddExpenseScreen`).
- `lib/widgets/`: Reusable UI parts (e.g., `Chart`, `ExpenseTile`).
- `lib/database/`: SQLite database helper.

## Step-by-Step Implementation

### 1. Project Initialization
- Create a new Flutter project: `finnovu_mvp_antigravity`.
- Add learning-friendly comments to the boilerplate code.

### 2. Git Integration
- Initialize local git repository: `git init`
- Update `README.md` with project documentation.
- Add remote origin: `git remote add origin https://github.com/mrinalkantinag/Finnovu_mvp_antigravity`
- Initial commit and push: `git add .`, `git commit -m "Initial commit"`, `git branch -M main`, `git push -u origin main`

### 3. Dependencies
We will add these packages to `pubspec.yaml`:
- `uuid`: For generating unique IDs for transactions.
- `intl`: For date formatting (e.g., "Dec 25, 2025").
- `sqflite`: For mobile storage.
- `sqflite_common_ffi`: **For Windows/Linux/MacOS/Web storage support.**
- `path`: For saving data locally on the phone.
- `provider`: To efficiently manage app state and rebuild UI when data changes.
- `fl_chart`: For the dashboard graphs.

### 3. Core Features Implementation
#### [NEW] `lib/models/transaction.dart`
- Create a simple class to hold: ID, Title, Amount, Date, Category.

#### [NEW] `lib/database/db_helper.dart`
- Write code to open a database file and insert/fetch rows.

#### [NEW] `lib/providers/transaction_provider.dart`
- Create the logic to "add transaction", "delete transaction", and "calculate total".

#### [NEW] `lib/screens/home_screen.dart`
- A list view showing recent expenses. Note: We will focus on smooth scrolling and nice card design.

#### [NEW] `lib/screens/add_transaction_screen.dart`
- A form with inputs for Title, Amount, and a Date Picker.
- **Refinement**: Default the transaction date to the current date.
- **Refinement**: Restrict the amount field to numeric input only using `inputFormatters`.

## Verification Plan
### Automated Tests
- We will run `flutter test` for simple unit tests on the model.

### Manual Verification
1.  **Launch App**: Ensure it opens without crashing.
2.  **Add Expense**: Tap "+", enter "Lunch", "15.00", select today. Save.
3.  **Verify List**: Check if "Lunch" appears on the Home Screen.
4.  **Restart App**: Close and reopen to ensure data persists (Database check).
5.  **Check Charts**: Ensure the bar chart reflects the new $15.00 expense.
