# OnlineShop_UAS

Aplikasi Manajemen Toko Online berbasis web menggunakan Java Servlet, JSP, JDBC, dan konsep Object-Oriented Programming (OOP).

## 📋 Deskripsi

Aplikasi ini adalah sistem manajemen toko online yang memungkinkan pengguna untuk:
- Menambah produk baru
- Melihat daftar produk
- Mencari dan memfilter produk
- Mengedit dan menghapus produk
- Mengurutkan produk berdasarkan berbagai kriteria

## 🚀 Fitur Utama

### A. Pemrograman Web dengan Java
- **Java Servlet**: Menangani request dan response HTTP
- **JSP (JavaServer Pages)**: Template engine untuk UI dinamis
- **JSTL**: Tag library untuk operasi data di JSP

### B. Integrasi Database dengan JDBC
- **MySQL Database**: Penyimpanan data produk
- **JDBC Connection**: Koneksi database yang efisien
- **Connection Pooling**: Manajemen koneksi database
- **Prepared Statements**: Mencegah SQL injection

### C. Desain Berorientasi Objek (OOP)
- **Model**: Kelas `Product` dengan encapsulation
- **DAO Pattern**: `ProductDAO` untuk data access
- **Service Layer**: `ProductService` untuk business logic
- **Inheritance & Polymorphism**: Struktur code yang maintainable

### D. Filtering dan Sorting
- **Search**: Pencarian berdasarkan nama dan kategori
- **Filter**: Filter berdasarkan kategori produk
- **Sort**: Sorting berdasarkan nama, harga, stok, tanggal
- **Combined Operations**: Filter dan sort bersamaan

### E. GUI dengan HTML & CSS
- **Responsive Design**: Mobile-first approach
- **Modern UI**: Clean dan intuitive interface
- **CSS Grid & Flexbox**: Layout yang fleksibel
- **Interactive Elements**: Hover effects dan transitions

## 🛠️ Teknologi yang Digunakan

- **Java**: JDK 11+
- **Jakarta EE**: Servlet 4.0, JSP 2.3
- **Database**: MySQL 8.0+
- **Build Tool**: Maven
- **IDE**: NetBeans (recommended)
- **Frontend**: HTML5, CSS3, JavaScript
- **Libraries**: 
  - MySQL Connector/J
  - JSTL 1.2
  - Gson (untuk JSON processing)

## 📁 Struktur Projekt

```
OnlineShop_UAS/
├── src/
│   └── main/
│       ├── java/
│       │   └── com/onlineshop/
│       │       ├── model/
│       │       │   └── Product.java
│       │       ├── dao/
│       │       │   ├── DatabaseConnection.java
│       │       │   └── ProductDAO.java
│       │       ├── service/
│       │       │   └── ProductService.java
│       │       └── servlet/
│       │           └── ProductServlet.java
│       └── webapp/
│           ├── WEB-INF/
│           │   ├── views/
│           │   │   ├── product-list.jsp
│           │   │   ├── product-form.jsp
│           │   │   └── product-detail.jsp
│           │   └── web.xml
│           ├── css/
│           │   └── style.css
│           ├── js/
│           │   └── script.js
│           └── index.jsp
├── database/
│   └── schema.sql
├── pom.xml
└── README.md
```

## 🗄️ Database Schema

### Tabel Products
```sql
CREATE TABLE products (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nama VARCHAR(255) NOT NULL,
    kategori VARCHAR(100) NOT NULL,
    harga DECIMAL(15,2) NOT NULL DEFAULT 0.00,
    stok INT NOT NULL DEFAULT 0,
    deskripsi TEXT,
    gambar VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## ⚙️ Setup dan Instalasi

### Prerequisites
- JDK 11 atau higher
- NetBeans IDE
- MySQL Server 8.0+
- Apache Tomcat 9.0+

### Langkah Instalasi

1. **Clone atau Download Project**
   ```bash
   # Atau download ZIP dan extract
   cd OnlineShop_UAS
   ```

2. **Setup Database**
   ```sql
   -- Buat database
   CREATE DATABASE onlineshop_db;
   
   -- Import schema
   mysql -u root -p onlineshop_db < database/schema.sql
   ```

3. **Konfigurasi Database Connection**
   
   Edit file `DatabaseConnection.java`:
   ```java
   private static final String URL = "jdbc:mysql://localhost:3306/onlineshop_db";
   private static final String USERNAME = "root";
   private static final String PASSWORD = "your_password";
   ```

4. **Import ke NetBeans**
   - Open NetBeans IDE
   - File → Open Project
   - Pilih folder OnlineShop_UAS
   - Klik "Open Project"

5. **Setup Server**
   - Right-click project → Properties
   - Run → Server → Apache Tomcat
   - Set context path: `/OnlineShop_UAS`

6. **Deploy dan Run**
   - Right-click project → Clean and Build
   - Right-click project → Run
   - Akses: `http://localhost:8080/OnlineShop_UAS`

## 🎯 Cara Penggunaan

### 1. Halaman Utama
- Akses aplikasi melalui browser
- Navigasi ke daftar produk atau tambah produk baru

### 2. Manajemen Produk
- **Tambah Produk**: Klik "Tambah Produk" → Isi form → Simpan
- **Lihat Produk**: Browse daftar produk di halaman utama
- **Edit Produk**: Klik icon edit pada kartu produk
- **Hapus Produk**: Klik icon hapus → Konfirmasi

### 3. Pencarian dan Filter
- **Search**: Ketik keyword di search box
- **Filter**: Pilih kategori dari dropdown
- **Sort**: Pilih kriteria sorting (nama, harga, stok)

## 🔧 Fitur Teknis

### Exception Handling
- Input validation dengan custom exceptions
- Database error handling
- User-friendly error messages
- Logging untuk debugging

### Security Features
- SQL injection prevention dengan PreparedStatement
- Input sanitization
- XSS protection di JSP

### Performance Optimization
- Database indexing
- Connection pooling
- Efficient queries dengan pagination ready

## 🧪 Testing

### Manual Testing
1. Test CRUD operations
2. Test search dan filter functionality
3. Test responsive behavior
4. Test error scenarios

### Sample Test Cases
- Tambah produk dengan data valid/invalid
- Search dengan keyword yang ada/tidak ada
- Filter berdasarkan kategori
- Sort berdasarkan berbagai kriteria

## 📱 Responsive Design

Aplikasi mendukung berbagai ukuran layar:
- **Desktop**: Layout grid 3-4 kolom
- **Tablet**: Layout grid 2 kolom
- **Mobile**: Layout single column

## 🎨 UI/UX Features

- **Clean Design**: Minimalist dan professional
- **Intuitive Navigation**: Easy to use interface
- **Visual Feedback**: Loading states, hover effects
- **Accessibility**: ARIA labels, keyboard navigation
- **Dark/Light Theme Ready**: CSS variables support

## 🚀 Future Enhancements

- [ ] User authentication dan authorization
- [ ] Shopping cart functionality
- [ ] Order management system
- [ ] Product reviews dan ratings
- [ ] Image upload functionality
- [ ] Export data to PDF/Excel
- [ ] Advanced reporting dashboard
- [ ] REST API endpoints
- [ ] Real-time notifications

## 📄 Lisensi

Project ini dibuat untuk keperluan akademik (UAS).

## 👨‍💻 Kontributor

- **Developer**: [Nama Anda]
- **Mata Kuliah**: Pemrograman Web dengan Java
- **Institusi**: [Nama Universitas]

## 📞 Support

Jika ada pertanyaan atau issues:
1. Buat issue di repository ini
2. Contact developer via email
3. Diskusi di forum kelas

---

**Happy Coding! 🎉**