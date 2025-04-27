DROP TABLE IF EXISTS accounts, account_subcategories, entities;

CREATE TABLE entities(
ID int auto_increment not null,
Name varchar(250),
NTN int,
PRIMARY KEY(ID)
);

INSERT INTO entities (Name, NTN) VALUES 
('Business', 0000000),
('Imtiaz', 1234567),
('Al-Fatah', 2345678), 
('Metro Cash & Carry', 3456789), 
('Chase Up', 4567890), 
('Hyperstar', 5678901), 
('Carrefour', 6789012), 
('Shaheen Grocery', 7890123)
;

CREATE TABLE account_subcategories(
ID int auto_increment not null,
Account_Type enum('AST', 'LIA', 'EQT', 'REV', 'EXP'),
Subcategory varchar(250),
PRIMARY KEY(ID)
);

INSERT INTO account_subcategories (Account_Type, Subcategory) 
VALUES ('AST', 'Cash'),
('AST', 'Inventory'),
('LIA', 'Loans'),
('LIA', 'Payable'), 
('EXP', 'Fuel'), 
('EXP', 'Maintenance'), 
('AST', 'Receivable'), 
('AST', 'Bank'),
('AST', 'Overflow'), -- 9
('EXP', 'Bank Charges'), -- 10
('EQT', 'Investment'), -- 11
('REV', 'Online Sales') -- 12
;

CREATE TABLE accounts(
ID int auto_increment not null,
Name varchar(250), 
Type enum('AST', 'LIA', 'EQT', 'REV', 'EXP'),
Entity int,
Opening_Balance float DEFAULT 0,
Opening_Date TIMESTAMP DEFAULT current_timestamp,
Balance float DEFAULT 0,
Subcategory int,
PRIMARY KEY(ID),
FOREIGN KEY(Entity) REFERENCES entities(ID),
FOREIGN KEY(Subcategory) REFERENCES account_subcategories(ID),
UNIQUE(Name)
);
