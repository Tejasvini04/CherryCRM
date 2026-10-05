CREATE DATABASE IF NOT EXISTS cherrycrm CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE cherrycrm;

CREATE TABLE IF NOT EXISTS customers (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  email VARCHAR(160) NOT NULL UNIQUE,
  phone VARCHAR(40),
  status ENUM('New','Active','VIP','Inactive') NOT NULL DEFAULT 'New',
  tags JSON NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS orders (
  id INT PRIMARY KEY,
  customer_id INT NOT NULL,
  product VARCHAR(160) NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  status ENUM('Pending','Processing','Confirmed','Shipped','Delivered','Cancelled') NOT NULL DEFAULT 'Pending',
  order_date DATE NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS customer_notes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  note TEXT NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (customer_id) REFERENCES customers(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS workflows (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  trigger_event VARCHAR(160) NOT NULL,
  action_text VARCHAR(200) NOT NULL,
  enabled BOOLEAN NOT NULL DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS message_templates (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(120) NOT NULL,
  subject VARCHAR(200) NOT NULL,
  body TEXT NOT NULL
);

CREATE TABLE IF NOT EXISTS sync_log (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customers_synced INT DEFAULT 0,
  orders_synced INT DEFAULT 0,
  products_synced INT DEFAULT 0,
  status ENUM('running','completed','failed') NOT NULL,
  synced_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT IGNORE INTO customers (id,name,email,phone,status,tags) VALUES
(1,'Rahul Sharma','rahul@gmail.com','+91 98220 41107','VIP','["VIP","Frequent Buyer","High Value"]'),
(2,'Priya Patil','priya@gmail.com','+91 98903 22458','Active','["Frequent Buyer"]'),
(3,'Amit Kumar','amit@gmail.com','+91 97650 11329','New','["New Customer"]'),
(4,'Sneha Naik','sneha.naik@gmail.com','+91 99230 76514','Active','[]'),
(5,'Vikram Desai','vikram.desai@outlook.com','+91 98500 33871','VIP','["VIP","High Value"]'),
(6,'Anjali Kamat','anjali.kamat@gmail.com','+91 98225 90462','Inactive','["Inactive"]'),
(7,'Rohan Fernandes','rohan.f@gmail.com','+91 98907 14230','Inactive','["Inactive"]'),
(8,'Meera Joshi','meera.joshi@gmail.com','+91 97300 55218','New','["New Customer"]');

INSERT IGNORE INTO orders (id,customer_id,product,amount,status,order_date) VALUES
(1051,1,'Nike Air Max',2999,'Shipped','2026-10-05'),
(1050,2,'Classic Cotton Shirt',1499,'Delivered','2026-10-05'),
(1049,3,'Smart Watch',3999,'Processing','2026-10-04'),
(1048,8,'Leather Wallet',899,'Pending','2026-10-04'),
(1047,5,'Smart Watch',4999,'Delivered','2026-10-01'),
(1046,1,'Leather Wallet',1299,'Delivered','2026-09-28'),
(1045,4,'Classic Cotton Shirt',1299,'Confirmed','2026-09-22'),
(1044,1,'Nike Air Max',3499,'Delivered','2026-09-14'),
(1043,2,'Leather Wallet',2701,'Delivered','2026-09-09'),
(1042,5,'Nike Air Max',3299,'Pending','2026-09-02'),
(1041,6,'Classic Cotton Shirt',999,'Cancelled','2026-07-03'),
(1040,7,'Leather Wallet',799,'Delivered','2026-06-06');

INSERT IGNORE INTO workflows (id,name,trigger_event,action_text,enabled) VALUES
(1,'Order confirmation','When an order is placed','Send confirmation message',1),
(2,'Shipping notification','When an order is shipped','Send shipping notification',1),
(3,'Delivery thank you','When an order is delivered','Send thank-you message',1);

INSERT IGNORE INTO message_templates (id,name,subject,body) VALUES
(1,'Order confirmation','Your order has been confirmed','Hi {{customer_name}},\n\nThank you for your order #{{order_id}}.\n\nYour order is now being processed.\n\nThank you,\nCommerce CRM'),
(2,'Shipping notification','Your order is on its way','Hi {{customer_name}},\n\nYour {{product_name}} (order #{{order_id}}) has been shipped.\n\nThank you,\nCommerce CRM');
