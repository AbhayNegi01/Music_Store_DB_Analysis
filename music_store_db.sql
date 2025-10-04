DROP DATABASE IF EXISTS music_store_db;
CREATE DATABASE music_store_db;
USE music_store_db;

CREATE TABLE artist (
  id INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(150) NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE album (
  id INT AUTO_INCREMENT PRIMARY KEY,
  title VARCHAR(150),
  artist_id INT NOT NULL,
  FOREIGN KEY (artist_id) REFERENCES artist(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE media_type (
  id INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(30),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE genre (
  id INT PRIMARY KEY AUTO_INCREMENT,
  `name` VARCHAR(50),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE track (
  id INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  album_id INT NOT NULL,
  media_type_id INT NOT NULL,
  genre_id INT NOT NULL,
  composer VARCHAR(255),
  milliseconds INT,
  bytes INT,
  unit_price DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (album_id) REFERENCES album(id) ON DELETE CASCADE,
  FOREIGN KEY (media_type_id) REFERENCES media_type(id) ON DELETE CASCADE,
  FOREIGN KEY (genre_id) REFERENCES genre(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE playlist (
  id INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(255),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE playlist_track (
  playlist_id INT NOT NULL,
  track_id INT NOT NULL,
  PRIMARY KEY (playlist_id, track_id),
  FOREIGN KEY (playlist_id) REFERENCES playlist(id) ON DELETE CASCADE,
  FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE employee (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  title VARCHAR(255),
  reports_to INT,
  birth_date DATE,
  hire_date DATE,
  address VARCHAR(150),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  postal_code VARCHAR(30),
  phone VARCHAR(30),
  fax VARCHAR(30),
  email VARCHAR(50),
  FOREIGN KEY (reports_to) REFERENCES employee(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE customer (
  id INT AUTO_INCREMENT PRIMARY KEY,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  company VARCHAR(150),
  address VARCHAR(150),
  city VARCHAR(50),
  state VARCHAR(50),
  country VARCHAR(50),
  postal_code VARCHAR(30),
  phone VARCHAR(30),
  fax VARCHAR(30),
  email VARCHAR(50),
  support_rep_id INT,
  FOREIGN KEY (support_rep_id) REFERENCES employee(id) ON DELETE SET NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE invoice (
  id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT NOT NULL,
  invoice_date DATETIME,
  billing_address VARCHAR(120),
  billing_city VARCHAR(50),
  billing_state VARCHAR(50),
  billing_country VARCHAR(50),
  billing_postal_code VARCHAR(30),
  total DECIMAL(10,2) DEFAULT 0,
  FOREIGN KEY (customer_id) REFERENCES customer(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE invoice_line (
  id INT AUTO_INCREMENT PRIMARY KEY,
  invoice_id INT NOT NULL,
  track_id INT NOT NULL,
  unit_price DECIMAL(10,2) DEFAULT 0,
  quantity INT NOT NULL,
  FOREIGN KEY (invoice_id) REFERENCES invoice(id) ON DELETE CASCADE,
  FOREIGN KEY (track_id) REFERENCES track(id) ON DELETE CASCADE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
