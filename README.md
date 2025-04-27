
# Account Creation Form - Intern Interview Task

## Objective
Build a full-stack application where users can create new Accounts by selecting:
- Entity (from existing `entities` table)
- Account Type (`AST`, `LIA`, `EQT`, `REV`, `EXP`)
- Subcategory (filtered by selected Account Type)
- Account Name
- Opening Balance

## Technology Stack
- **Frontend:** React.js
- **Backend:** Express.js (Node.js)
- **Database:** MySQL

## Database Schema

```sql
-- Entities Table
CREATE TABLE entities (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(250),
  NTN INT
);

-- Account Subcategories
CREATE TABLE account_subcategories (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Account_Type ENUM('AST', 'LIA', 'EQT', 'REV', 'EXP'),
  Subcategory VARCHAR(250)
);

-- Accounts
CREATE TABLE accounts (
  ID INT AUTO_INCREMENT PRIMARY KEY,
  Name VARCHAR(250) UNIQUE,
  Type ENUM('AST', 'LIA', 'EQT', 'REV', 'EXP'),
  Entity INT,
  Opening_Balance FLOAT DEFAULT 0,
  Opening_Date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  Balance FLOAT DEFAULT 0,
  Subcategory INT,
  FOREIGN KEY (Entity) REFERENCES entities(ID),
  FOREIGN KEY (Subcategory) REFERENCES account_subcategories(ID)
);
```
## Backend Requirements

Set up an Express.js server with a MySQL connection.

### API Endpoints

| Endpoint | Method | Description |
|:---------|:-------|:------------|
| `/api/entities` | `GET` | Fetch all entities |
| `/api/account-types` | `GET` | Return static account types (`AST`, `LIA`, `EQT`, `REV`, `EXP`) |
| `/api/subcategories/:type` | `GET` | Fetch subcategories by account type |
| `/api/accounts` | `POST` | Create a new account |
  
## Frontend Requirements

Build a React form with these fields:
- **Account Name** (text input)
- **Entity** (dropdown - `/api/entities`)
- **Account Type** (dropdown - `/api/account-types`)
- **Subcategory** (dropdown - depends on selected Account Type)
- **Opening Balance** (number input)

### Behavior
- Selecting an Account Type should dynamically fetch subcategories.
- Validate all fields before submission (Optional).
- Submit the form via `POST /api/accounts`.
- Show a success or error message based on the server's response.
- Use Axios or Fetch for API calls.
- Include loading indicators where necessary (Optional).

## API Convention
All endpoints must be under `/api/`, e.g., `/api/entities`, `/api/accounts`.

## Design Requirements
Keep the UI simple and intuitive with proper form validation and dynamic dropdowns.
