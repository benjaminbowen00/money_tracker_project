DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS shops;
DROP TABLE IF EXISTS wallets;


CREATE TABLE wallets (
  id serial4 PRIMARY KEY,
  budget FLOAT(2),
  spend FLOAT(2)
);

CREATE TABLE shops (
  id serial4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE categories (
  id serial4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE transactions (
  id serial4 PRIMARY KEY,
  amount FLOAT(2),
  date_of_transaction DATE,
  comment VARCHAR(255),
  wallet_id int4 REFERENCES wallets(id),
  shop_id int4 REFERENCES shops(id) ON DELETE CASCADE,
  category_id int4 REFERENCES categories(id) ON DELETE CASCADE
);
