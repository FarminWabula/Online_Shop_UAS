<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${product.nama} - OnlineShop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <!-- Set locale untuk formatting -->
    <fmt:setLocale value="id_ID" />
    
    <!-- Header -->
    <header class="header">
        <div class="container">
            <div class="header-content">
                <div class="logo">
                    <h1><i class="fas fa-store"></i> OnlineShop</h1>
                </div>
                <nav class="navigation">
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

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Breadcrumb -->
            <div class="breadcrumb">
                <a href="${pageContext.request.contextPath}/products">
                    <i class="fas fa-box"></i> Produk
                </a>
                <span>/</span>
                <span>${product.nama}</span>
            </div>

            <!-- Product Detail -->
            <div class="product-detail">
                <div class="product-detail-grid">
                    <!-- Product Image -->
                    <div class="product-image-section">
                        <div class="product-image-main">
                            <c:choose>
                                <c:when test="${not empty product.gambar}">
                                    <img src="${product.gambar}" alt="${product.nama}" 
                                         onerror="this.parentElement.innerHTML='<div class=\\'no-image-large\\'><i class=\\'fas fa-image\\'></i><p>Gambar tidak tersedia</p></div>'">
                                </c:when>
                                <c:otherwise>
                                    <div class="no-image-large">
                                        <i class="fas fa-image"></i>
                                        <p>Gambar tidak tersedia</p>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <!-- Product Info -->
                    <div class="product-info-section">
                        <div class="product-header">
                            <div class="product-category-badge">${product.kategori}</div>
                            <h1 class="product-title">${product.nama}</h1>
                        </div>

                        <div class="product-price-section">
                            <div class="product-price-main">
                                <fmt:formatNumber value="${product.harga}" type="currency" 
                                                currencySymbol="Rp " groupingUsed="true"/>
                            </div>
                        </div>

                        <div class="product-stock-section">
                            <c:choose>
                                <c:when test="${product.stok > 0}">
                                    <div class="stock-info available">
                                        <i class="fas fa-check-circle"></i>
                                        <span>Tersedia</span>
                                        <div class="stock-quantity">Stok: <strong>${product.stok}</strong> unit</div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="stock-info unavailable">
                                        <i class="fas fa-times-circle"></i>
                                        <span>Stok Habis</span>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <c:if test="${not empty product.deskripsi}">
                            <div class="product-description-section">
                                <h3><i class="fas fa-info-circle"></i> Deskripsi Produk</h3>
                                <div class="product-description">
                                    ${product.deskripsi}
                                </div>
                            </div>
                        </c:if>

                        <!-- Product Meta Info -->
                        <div class="product-meta">
                            <div class="meta-item">
                                <i class="fas fa-calendar-plus"></i>
                                <div>
                                    <strong>Ditambahkan</strong>
                                    <div>
                                        <fmt:formatDate value="${product.createdAt}" 
                                                      pattern="dd MMMM yyyy, HH:mm"/>
                                    </div>
                                </div>
                            </div>
                            <c:if test="${product.updatedAt != null}">
                                <div class="meta-item">
                                    <i class="fas fa-calendar-edit"></i>
                                    <div>
                                        <strong>Terakhir diupdate</strong>
                                        <div>
                                            <fmt:formatDate value="${product.updatedAt}" 
                                                          pattern="dd MMMM yyyy, HH:mm"/>
                                        </div>
                                    </div>
                                </div>
                            </c:if>
                        </div>

                        <!-- Action Buttons -->
                        <div class="product-actions">
                            <a href="${pageContext.request.contextPath}/products?action=edit&id=${product.id}" 
                               class="btn btn-primary">
                                <i class="fas fa-edit"></i> Edit Produk
                            </a>
                            <button onclick="deleteProduct(${product.id}, '${product.nama}')" 
                                    class="btn btn-danger">
                                <i class="fas fa-trash"></i> Hapus Produk
                            </button>
                        </div>

                        <!-- Back Button -->
                        <div class="back-action">
                            <a href="${pageContext.request.contextPath}/products" class="btn btn-outline">
                                <i class="fas fa-arrow-left"></i> Kembali ke Daftar Produk
                            </a>
                        </div>
                    </div>
                </div>

                <!-- Additional Info Tabs -->
                <div class="product-tabs">
                    <div class="tab-headers">
                        <button class="tab-header active" onclick="switchTab('details')">
                            <i class="fas fa-info-circle"></i> Detail
                        </button>
                        <button class="tab-header" onclick="switchTab('specifications')">
                            <i class="fas fa-list"></i> Spesifikasi
                        </button>
                    </div>

                    <div class="tab-content">
                        <div id="details" class="tab-pane active">
                            <div class="detail-grid">
                                <div class="detail-item">
                                    <strong>ID Produk:</strong>
                                    <span>#${product.id}</span>
                                </div>
                                <div class="detail-item">
                                    <strong>Nama:</strong>
                                    <span>${product.nama}</span>
                                </div>
                                <div class="detail-item">
                                    <strong>Kategori:</strong>
                                    <span>${product.kategori}</span>
                                </div>
                                <div class="detail-item">
                                    <strong>Harga:</strong>
                                    <span>
                                        <fmt:formatNumber value="${product.harga}" type="currency" 
                                                        currencySymbol="Rp " groupingUsed="true"/>
                                    </span>
                                </div>
                                <div class="detail-item">
                                    <strong>Stok:</strong>
                                    <span>${product.stok} unit</span>
                                </div>
                                <div class="detail-item">
                                    <strong>Status:</strong>
                                    <span class="${product.stok > 0 ? 'status-available' : 'status-unavailable'}">
                                        ${product.stok > 0 ? 'Tersedia' : 'Stok Habis'}
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div id="specifications" class="tab-pane">
                            <div class="spec-grid">
                                <div class="spec-item">
                                    <strong>Ketersediaan Stok:</strong>
                                    <span>${product.available ? 'Ya' : 'Tidak'}</span>
                                </div>
                                <div class="spec-item">
                                    <strong>Gambar Produk:</strong>
                                    <span>${not empty product.gambar ? 'Ada' : 'Tidak ada'}</span>
                                </div>
                                <div class="spec-item">
                                    <strong>Deskripsi:</strong>
                                    <span>${not empty product.deskripsi ? 'Ada' : 'Tidak ada'}</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
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
    <script>
        function switchTab(tabName) {
            // Remove active class from all tabs
            document.querySelectorAll('.tab-header').forEach(header => {
                header.classList.remove('active');
            });
            document.querySelectorAll('.tab-pane').forEach(pane => {
                pane.classList.remove('active');
            });

            // Add active class to clicked tab
            event.target.classList.add('active');
            document.getElementById(tabName).classList.add('active');
        }
    </script>
</body>
</html>