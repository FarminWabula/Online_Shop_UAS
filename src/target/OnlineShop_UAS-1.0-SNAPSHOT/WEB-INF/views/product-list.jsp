<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Daftar Produk - OnlineShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                    <a href="${pageContext.request.contextPath}/products" class="nav-link active">
                        <i class="fas fa-box"></i> Produk
                    </a>
                    <a href="${pageContext.request.contextPath}/products?action=add" class="nav-link">
                        <i class="fas fa-plus"></i> Tambah Produk
                    </a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Page Title -->
            <div class="page-header">
                <h2>
                    <i class="fas fa-box"></i> 
                    Manajemen Produk
                </h2>
                <p class="page-subtitle">Kelola produk toko online Anda</p>
            </div>

            <!-- Success/Error Messages -->
            <c:if test="${param.success == 'add'}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    Produk berhasil ditambahkan!
                </div>
            </c:if>
            <c:if test="${param.success == 'update'}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    Produk berhasil diupdate!
                </div>
            </c:if>
            <c:if test="${param.success == 'delete'}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i>
                    Produk berhasil dihapus!
                </div>
            </c:if>
            <c:if test="${param.error == 'delete'}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    Gagal menghapus produk!
                </div>
            </c:if>

            <!-- Search and Filter Section -->
            <div class="search-filter-section">
                <!-- Search Form -->
                <form action="${pageContext.request.contextPath}/products" method="get" class="search-form">
                    <input type="hidden" name="action" value="search">
                    <div class="search-input-group">
                        <input type="text" 
                               name="keyword" 
                               value="${searchKeyword}" 
                               placeholder="Cari produk..."
                               class="search-input">
                        <button type="submit" class="search-btn">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </form>

                <!-- Filter and Sort Form -->
                <form action="${pageContext.request.contextPath}/products" method="get" class="filter-form">
                    <input type="hidden" name="action" value="filter">
                    
                    <div class="filter-group">
                        <select name="kategori" class="filter-select">
                            <option value="all">Semua Kategori</option>
                            <c:forEach var="category" items="${categories}">
                                <option value="${category}" 
                                        <c:if test="${category == currentKategori}">selected</c:if>>
                                    ${category}
                                </option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="filter-group">
                        <select name="sortBy" class="filter-select">
                            <option value="nama" <c:if test="${currentSortBy == 'nama'}">selected</c:if>>
                                Urutkan Nama
                            </option>
                            <option value="harga" <c:if test="${currentSortBy == 'harga'}">selected</c:if>>
                                Urutkan Harga
                            </option>
                            <option value="stok" <c:if test="${currentSortBy == 'stok'}">selected</c:if>>
                                Urutkan Stok
                            </option>
                            <option value="created_at" <c:if test="${currentSortBy == 'created_at'}">selected</c:if>>
                                Urutkan Tanggal
                            </option>
                        </select>
                    </div>

                    <div class="filter-group">
                        <select name="sortOrder" class="filter-select">
                            <option value="ASC" <c:if test="${currentSortOrder == 'ASC'}">selected</c:if>>
                                A-Z / Rendah-Tinggi
                            </option>
                            <option value="DESC" <c:if test="${currentSortOrder == 'DESC'}">selected</c:if>>
                                Z-A / Tinggi-Rendah
                            </option>
                        </select>
                    </div>

                    <button type="submit" class="filter-btn">
                        <i class="fas fa-filter"></i> Filter
                    </button>
                </form>
            </div>

            <!-- Add Product Button -->
            <div class="action-bar">
                <a href="${pageContext.request.contextPath}/products?action=add" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Tambah Produk Baru
                </a>
                <div class="product-count">
                    Total: <strong>${products.size()}</strong> produk
                </div>
            </div>

            <!-- Products Grid -->
            <div class="products-grid">
                <c:choose>
                    <c:when test="${empty products}">
                        <div class="empty-state">
                            <i class="fas fa-box-open"></i>
                            <h3>Tidak ada produk</h3>
                            <p>Belum ada produk yang ditambahkan atau tidak ditemukan hasil pencarian.</p>
                            <a href="${pageContext.request.contextPath}/products?action=add" class="btn btn-primary">
                                <i class="fas fa-plus"></i> Tambah Produk Pertama
                            </a>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="product" items="${products}">
                            <div class="product-card">
                                <div class="product-image">
                                    <c:choose>
                                        <c:when test="${not empty product.gambar}">
                                            <img src="${product.gambar}" alt="${product.nama}" 
                                                 onerror="this.src='${pageContext.request.contextPath}/images/no-image.png'">
                                        </c:when>
                                        <c:otherwise>
                                            <div class="no-image">
                                                <i class="fas fa-image"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                                
                                <div class="product-info">
                                    <div class="product-category">${product.kategori}</div>
                                    <h3 class="product-name">${product.nama}</h3>
                                    <div class="product-price">
                                        <fmt:formatNumber value="${product.harga}" type="currency" 
                                                        currencySymbol="Rp " groupingUsed="true"/>
                                    </div>
                                    <div class="product-stock">
                                        <c:choose>
                                            <c:when test="${product.stok > 0}">
                                                <span class="stock-available">
                                                    <i class="fas fa-check-circle"></i>
                                                    Stok: ${product.stok}
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="stock-empty">
                                                    <i class="fas fa-times-circle"></i>
                                                    Stok Habis
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    
                                    <c:if test="${not empty product.deskripsi}">
                                        <p class="product-description">
                                            <c:choose>
                                                <c:when test="${product.deskripsi.length() > 100}">
                                                    ${product.deskripsi.substring(0, 100)}...
                                                </c:when>
                                                <c:otherwise>
                                                    ${product.deskripsi}
                                                </c:otherwise>
                                            </c:choose>
                                        </p>
                                    </c:if>
                                </div>
                                
                                <div class="product-actions">
                                    <a href="${pageContext.request.contextPath}/products?action=view&id=${product.id}" 
                                       class="btn btn-outline" title="Lihat Detail">
                                        <i class="fas fa-eye"></i>
                                    </a>
                                    <a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}" 
                                       class="btn btn-secondary" title="Edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <button onclick="deleteProduct(${product.id}, '${product.nama}')" 
                                            class="btn btn-danger" title="Hapus">
                                        <i class="fas fa-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 OnlineShop UAS. Dibuat dengan Java Servlet & JSP.</p>
        </div>
    </footer>

    <!-- Delete Confirmation Modal -->
    <div id="deleteModal" class="modal">
        <div class="modal-content">
            <div class="modal-header">
                <h3><i class="fas fa-exclamation-triangle"></i> Konfirmasi Hapus</h3>
                <span class="close">&times;</span>
            </div>
            <div class="modal-body">
                <p>Apakah Anda yakin ingin menghapus produk <strong id="productName"></strong>?</p>
                <p class="text-warning">Tindakan ini tidak dapat dibatalkan.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" onclick="closeDeleteModal()">Batal</button>
                <form id="deleteForm" method="post" style="display: inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="id" id="deleteProductId">
                    <button type="submit" class="btn btn-danger">
                        <i class="fas fa-trash"></i> Hapus
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script src="${pageContext.request.contextPath}/js/script.js"></script>
</body>
</html>