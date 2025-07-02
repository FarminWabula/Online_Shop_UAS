<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>OnlineShop - Manajemen Toko Online Farmin Wabula</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .hero-section {
            background: linear-gradient(135deg, var(--primary-600), var(--primary-700));
            color: white;
            padding: var(--spacing-16) 0;
            text-align: center;
        }
        
        .hero-content h1 {
            font-size: var(--font-size-4xl);
            font-weight: 700;
            margin-bottom: var(--spacing-4);
        }
        
        .hero-content p {
            font-size: var(--font-size-xl);
            margin-bottom: var(--spacing-8);
            opacity: 0.9;
        }
        
        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: var(--spacing-6);
            margin: var(--spacing-12) 0;
        }
        
        .feature-card {
            background: white;
            padding: var(--spacing-6);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-sm);
            text-align: center;
            transition: var(--transition-base);
        }
        
        .feature-card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-lg);
        }
        
        .feature-icon {
            font-size: var(--font-size-4xl);
            color: var(--primary-500);
            margin-bottom: var(--spacing-4);
        }
        
        .feature-title {
            font-size: var(--font-size-xl);
            font-weight: 600;
            color: var(--neutral-800);
            margin-bottom: var(--spacing-3);
        }
        
        .feature-description {
            color: var(--neutral-600);
            line-height: 1.6;
        }
        
        .stats-section {
            background: var(--neutral-100);
            padding: var(--spacing-12) 0;
            margin: var(--spacing-12) 0;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: var(--spacing-6);
        }
        
        .stat-card {
            text-align: center;
            padding: var(--spacing-6);
        }
        
        .stat-number {
            font-size: var(--font-size-4xl);
            font-weight: 700;
            color: var(--primary-600);
            display: block;
        }
        
        .stat-label {
            color: var(--neutral-600);
            font-weight: 500;
            margin-top: var(--spacing-2);
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <h1><i class="fas fa-store"></i> OnlineShop</h1>
                </div>
                <nav class="navigation">
                    <a href="${pageContext.request.contextPath}/" class="nav-link active">
                        <i class="fas fa-home"></i> Beranda
                    </a>
                    <a href="${pageContext.request.contextPath}/products" class="nav-link">
                        <i class="fas fa-box"></i> Produk
                    </a>
                    <a href="${pageContext.request.contextPath}/products?action=add" class="nav-link">
                        <i class="fas fa-plus"></i> Tambah Produk
                    </a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Hero Section -->
    <section class="hero-section">
        <div class="container">
            <div class="hero-content">
                <h1><i class="fas fa-store"></i> OnlineShop UAS</h1>
                <p>Sistem Manajemen Toko Online karya Farmin Wabula, dibangun menggunakan Java Servlet, JSP, dan JDBC untuk mengelola produk, transaksi, dan data pelanggan secara efisien.</p>
                <div style="display: flex; gap: var(--spacing-4); justify-content: center; flex-wrap: wrap;">
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-primary" style="background: white; color: var(--primary-600);">
                        <i class="fas fa-box"></i> Lihat Produk
                    </a>
                    <a href="${pageContext.request.contextPath}/products?action=add" class="btn btn-outline" style="border-color: white; color: white;">
                        <i class="fas fa-plus"></i> Tambah Produk
                    </a>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <main class="main-content">
        <div class="container">
            <div class="page-header">
                <h2>Fitur Aplikasi</h2>
                <p class="page-subtitle">Saya Menghadirkan teknologi modern untuk manajemen toko online yang efisien</p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-database"></i>
                    </div>
                    <h3 class="feature-title">Database Integration</h3>
                    <p class="feature-description">
                        Integrasi database MySQL dengan JDBC untuk penyimpanan data produk yang aman dan reliable.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-code"></i>
                    </div>
                    <h3 class="feature-title">Java OOP</h3>
                    <p class="feature-description">
                        Implementasi konsep Object-Oriented Programming dengan kelas Product, DAO, dan Service Layer.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-globe"></i>
                    </div>
                    <h3 class="feature-title">Web Technology</h3>
                    <p class="feature-description">
                        Menggunakan Java Servlet dan JSP untuk menciptakan aplikasi web yang dinamis dan interaktif.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-search"></i>
                    </div>
                    <h3 class="feature-title">Search & Filter</h3>
                    <p class="feature-description">
                        Fitur pencarian dan filtering produk berdasarkan kategori, nama, dengan sorting by harga dan stok.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-mobile-alt"></i>
                    </div>
                    <h3 class="feature-title">Responsive Design</h3>
                    <p class="feature-description">
                        Interface yang responsif dengan HTML5, CSS3, dan JavaScript untuk pengalaman optimal di semua device.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <h3 class="feature-title">Exception Handling</h3>
                    <p class="feature-description">
                        Penanganan error yang komprehensif untuk input validation dan database operations.
                    </p>
                </div>
            </div>

            <!-- Technology Stack -->
            <div class="page-header" style="margin-top: var(--spacing-16);">
                <h2>Technology Stack</h2>
                <p class="page-subtitle">Teknologi yang digunakan dalam pengembangan aplikasi</p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon" style="color: var(--accent-500);">
                        <i class="fab fa-java"></i>
                    </div>
                    <h3 class="feature-title">Java</h3>
                    <p class="feature-description">
                        Backend logic dengan Java Servlet, JSP, dan implementasi konsep OOP untuk struktur code yang maintainable.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon" style="color: var(--secondary-500);">
                        <i class="fas fa-database"></i>
                    </div>
                    <h3 class="feature-title">MySQL + JDBC</h3>
                    <p class="feature-description">
                        Database relational MySQL dengan koneksi JDBC untuk operasi CRUD yang efisien dan secure.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon" style="color: var(--warning-500);">
                        <i class="fab fa-html5"></i>
                    </div>
                    <h3 class="feature-title">HTML5 & CSS3</h3>
                    <p class="feature-description">
                        Frontend modern dengan semantic HTML5, CSS3 Grid/Flexbox, dan responsive design principles.
                    </p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon" style="color: var(--success-500);">
                        <i class="fas fa-server"></i>
                    </div>
                    <h3 class="feature-title">NetBeans IDE</h3>
                    <p class="feature-description">
                        Dikembangkan dengan NetBeans IDE untuk Java EE development dengan Maven project structure.
                    </p>
                </div>
            </div>
        </div>
    </main>

    <!-- Stats Section -->
    <section class="stats-section">
        <div class="container">
            <div class="page-header">
                <h2>Spesifikasi Aplikasi</h2>
            </div>
            <div class="stats-grid">
                <div class="stat-card">
                    <span class="stat-number">5+</span>
                    <div class="stat-label">Fitur Utama</div>
                </div>
                <div class="stat-card">
                    <span class="stat-number">100%</span>
                    <div class="stat-label">Responsive</div>
                </div>
                <div class="stat-card">
                    <span class="stat-number">OOP</span>
                    <div class="stat-label">Architecture</div>
                </div>
                <div class="stat-card">
                    <span class="stat-number">MVC</span>
                    <div class="stat-label">Pattern</div>
                </div>
            </div>
        </div>
    </section>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 02/07/2025 OnlineShop UAS. Aplikasi Manajemen Toko Online dengan Java Servlet, JSP, JDBC & OOP.</p>
            <p style="margin-top: var(--spacing-2); font-size: var(--font-size-sm); opacity: 0.8;">
                Dibuat untuk memenuhi tugas UAS Pemrograman Web dengan Java Dari Farmin Wabula
            </p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>