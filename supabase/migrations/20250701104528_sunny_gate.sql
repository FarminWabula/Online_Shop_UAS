-- Database Schema untuk OnlineShop_UAS
-- MySQL Database Schema

-- Buat database jika belum ada
CREATE DATABASE IF NOT EXISTS onlineshop_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Gunakan database
USE onlineshop_db;

-- Hapus tabel jika sudah ada (untuk development/testing)
DROP TABLE IF EXISTS products;

-- Buat tabel products
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kategori VARCHAR(100) NOT NULL,
    harga DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    stok INT NOT NULL DEFAULT 0,
    deskripsi TEXT,
    gambar VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    -- Indexes untuk performa query
    INDEX idx_kategori (kategori),
    INDEX idx_nama (nama),
    INDEX idx_harga (harga),
    INDEX idx_stok (stok),
    INDEX idx_created_at (created_at),
    
    -- Constraints
    CONSTRAINT chk_harga CHECK (harga >= 0),
    CONSTRAINT chk_stok CHECK (stok >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insert sample data untuk testing
INSERT INTO products (nama, kategori, harga, stok, deskripsi, gambar) VALUES
('Laptop Gaming ASUS ROG', 'Elektronik', 15000000.00, 5, 
 'Laptop gaming high-performance dengan processor Intel Core i7, RAM 16GB, dan VGA NVIDIA GeForce RTX 3060. Cocok untuk gaming dan content creation.',
 'https://images.pexels.com/photos/18105/pexels-photo.jpg'),

('Smartphone Samsung Galaxy S23', 'Elektronik', 12000000.00, 10,
 'Smartphone flagship dengan kamera 50MP, layar AMOLED 6.1 inch, processor Snapdragon 8 Gen 2, dan storage 256GB.',
 'https://images.pexels.com/photos/607812/pexels-photo-607812.jpeg'),

('Sepatu Nike Air Force 1', 'Fashion', 1500000.00, 20,
 'Sepatu sneakers klasik Nike Air Force 1 dengan upper leather berkualitas tinggi. Tersedia dalam berbagai ukuran.',
 'https://images.pexels.com/photos/2529148/pexels-photo-2529148.jpeg'),

('Kaos Polo Lacoste', 'Fashion', 800000.00, 15,
 'Kaos polo premium dari Lacoste dengan bahan cotton berkualitas tinggi. Nyaman dipakai dan tahan lama.',
 'https://images.pexels.com/photos/996329/pexels-photo-996329.jpg'),

('Buku "Clean Code" by Robert Martin', 'Buku', 350000.00, 25,
 'Buku panduan best practices dalam menulis code yang clean, readable, dan maintainable. Wajib dibaca programmer.',
 'https://images.pexels.com/photos/159711/books-bookstore-book-reading-159711.jpeg'),

('Buku "Design Patterns"', 'Buku', 400000.00, 12,
 'Buku referensi tentang design patterns dalam software engineering. Cocok untuk intermediate dan advanced developer.',
 'https://images.pexels.com/photos/1370298/pexels-photo-1370298.jpeg'),

('Mouse Gaming Logitech G502', 'Elektronik', 750000.00, 30,
 'Mouse gaming dengan sensor HERO 25K, 11 programmable buttons, dan RGB lighting. Perfect untuk FPS dan MOBA games.',
 'https://images.pexels.com/photos/2115256/pexels-photo-2115256.jpeg'),

('Keyboard Mechanical Corsair K95', 'Elektronik', 2200000.00, 8,
 'Keyboard mechanical premium dengan Cherry MX switches, RGB per-key lighting, dan dedicated macro keys.',
 'https://images.pexels.com/photos/1194713/pexels-photo-1194713.jpeg'),

('Jam Tangan Seiko Automatic', 'Fashion', 3500000.00, 6,
 'Jam tangan automatic dengan movement Seiko 4R36, case stainless steel, dan water resistance 100m.',
 'https://images.pexels.com/photos/190819/pexels-photo-190819.jpeg'),

('Headphone Sony WH-1000XM4', 'Elektronik', 4500000.00, 12,
 'Headphone wireless dengan Active Noise Cancellation terbaik di kelasnya. Battery life hingga 30 jam.',
 'https://images.pexels.com/photos/3394650/pexels-photo-3394650.jpeg'),

('Tas Ransel Eiger', 'Fashion', 450000.00, 18,
 'Tas ransel outdoor berkualitas tinggi dengan material ripstop dan padding yang nyaman. Kapasitas 25L.',
 'https://images.pexels.com/photos/2905238/pexels-photo-2905238.jpeg'),

('Buku "Java: The Complete Reference"', 'Buku', 500000.00, 8,
 'Buku referensi lengkap untuk bahasa pemrograman Java. Cocok untuk pemula hingga advanced level.',
 'https://images.pexels.com/photos/1370295/pexels-photo-1370295.jpeg');

-- Buat view untuk statistik produk
CREATE OR REPLACE VIEW product_stats AS
SELECT 
    COUNT(*) as total_products,
    COUNT(DISTINCT kategori) as total_categories,
    AVG(harga) as avg_price,
    SUM(stok) as total_stock,
    COUNT(CASE WHEN stok > 0 THEN 1 END) as available_products,
    COUNT(CASE WHEN stok = 0 THEN 1 END) as out_of_stock_products
FROM products;

-- Buat stored procedure untuk mendapatkan produk low stock
DELIMITER //
CREATE PROCEDURE GetLowStockProducts(IN threshold_stock INT)
BEGIN
    SELECT id, nama, kategori, harga, stok
    FROM products 
    WHERE stok <= threshold_stock 
    ORDER BY stok ASC, nama ASC;
END //
DELIMITER ;

-- Buat stored procedure untuk update stok produk
DELIMITER //
CREATE PROCEDURE UpdateProductStock(
    IN product_id INT, 
    IN new_stock INT,
    OUT result_message VARCHAR(255)
)
BEGIN
    DECLARE current_stock INT DEFAULT 0;
    DECLARE product_exists INT DEFAULT 0;
    
    -- Check if product exists
    SELECT COUNT(*), COALESCE(stok, 0) 
    INTO product_exists, current_stock
    FROM products 
    WHERE id = product_id;
    
    IF product_exists = 0 THEN
        SET result_message = 'Product not found';
    ELSEIF new_stock < 0 THEN
        SET result_message = 'Stock cannot be negative';
    ELSE
        UPDATE products 
        SET stok = new_stock, updated_at = CURRENT_TIMESTAMP 
        WHERE id = product_id;
        
        SET result_message = CONCAT('Stock updated from ', current_stock, ' to ', new_stock);
    END IF;
END //
DELIMITER ;

-- Buat trigger untuk log perubahan harga
CREATE TABLE IF NOT EXISTS price_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    old_price DECIMAL(15,2),
    new_price DECIMAL(15,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER price_change_log 
AFTER UPDATE ON products
FOR EACH ROW
BEGIN
    IF OLD.harga != NEW.harga THEN
        INSERT INTO price_history (product_id, old_price, new_price) 
        VALUES (NEW.id, OLD.harga, NEW.harga);
    END IF;
END //
DELIMITER ;

-- Grant permissions (adjust username as needed)
-- GRANT ALL PRIVILEGES ON onlineshop_db.* TO 'root'@'localhost';
-- FLUSH PRIVILEGES;

-- Query untuk testing
-- SELECT * FROM products ORDER BY created_at DESC;
-- SELECT * FROM product_stats;
-- CALL GetLowStockProducts(10);