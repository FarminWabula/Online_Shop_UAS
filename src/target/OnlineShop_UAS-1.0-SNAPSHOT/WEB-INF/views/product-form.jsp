<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${isEdit ? 'Edit' : 'Tambah'} Produk - OnlineShop</title>
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
                    <a href="${pageContext.request.contextPath}/products" class="nav-link">
                        <i class="fas fa-box"></i> Produk
                    </a>
                    <a href="${pageContext.request.contextPath}/products?action=add" class="nav-link ${!isEdit ? 'active' : ''}">
                        <i class="fas fa-plus"></i> Tambah Produk
                    </a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <h2>
                    <i class="fas fa-${isEdit ? 'edit' : 'plus'}"></i> 
                    ${isEdit ? 'Edit' : 'Tambah'} Produk
                </h2>
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/products">Produk</a> 
                    <span>/</span> 
                    <span>${isEdit ? 'Edit' : 'Tambah'}</span>
                </div>
            </div>

            <!-- Error Message -->
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>

            <!-- Product Form -->
            <div class="form-container">
                <form action="${pageContext.request.contextPath}/products" method="post" class="product-form" id="productForm">
                    <input type="hidden" name="action" value="${isEdit ? 'update' : 'add'}">
                    <c:if test="${isEdit}">
                        <input type="hidden" name="id" value="${product.id}">
                    </c:if>

                    <div class="form-grid">
                        <!-- Left Column -->
                        <div class="form-column">
                            <div class="form-section">
                                <h3><i class="fas fa-info-circle"></i> Informasi Dasar</h3>
                                
                                <div class="form-group">
                                    <label for="nama" class="form-label required">Nama Produk</label>
                                    <input type="text" 
                                           id="nama" 
                                           name="nama" 
                                           value="${product.nama}" 
                                           class="form-input"
                                           placeholder="Masukkan nama produk"
                                           required>
                                    <div class="form-help">Masukkan nama produk yang jelas dan deskriptif</div>
                                </div>

                                <div class="form-group">
                                    <label for="kategori" class="form-label required">Kategori</label>
                                    <div class="kategori-input-group">
                                        <select id="kategoriSelect" class="form-select" onchange="handleKategoriChange()">
                                            <option value="">Pilih kategori yang sudah ada</option>
                                            <c:forEach var="category" items="${categories}">
                                                <option value="${category}" 
                                                        <c:if test="${category == product.kategori}">selected</c:if>>
                                                    ${category}
                                                </option>
                                            </c:forEach>
                                            <option value="new">+ Tambah kategori baru</option>
                                        </select>
                                        <input type="text" 
                                               id="kategori" 
                                               name="kategori" 
                                               value="${product.kategori}" 
                                               class="form-input"
                                               placeholder="Atau ketik kategori baru"
                                               required>
                                    </div>
                                    <div class="form-help">Pilih dari kategori yang ada atau buat kategori baru</div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="harga" class="form-label required">Harga</label>
                                        <div class="input-group">
                                            <span class="input-prefix">Rp</span>
                                            <input type="number" 
                                                   id="harga" 
                                                   name="harga" 
                                                   value="${product.harga}" 
                                                   class="form-input"
                                                   placeholder="0"
                                                   min="0"
                                                   step="0.01"
                                                   required>
                                        </div>
                                    </div>

                                    <div class="form-group">
                                        <label for="stok" class="form-label required">Stok</label>
                                        <input type="number" 
                                               id="stok" 
                                               name="stok" 
                                               value="${product.stok}" 
                                               class="form-input"
                                               placeholder="0"
                                               min="0"
                                               required>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Right Column -->
                        <div class="form-column">
                            <div class="form-section">
                                <h3><i class="fas fa-image"></i> Media & Deskripsi</h3>
                                
                                <div class="form-group">
                                    <label for="gambar" class="form-label">URL Gambar</label>
                                    <input type="url" 
                                           id="gambar" 
                                           name="gambar" 
                                           value="${product.gambar}" 
                                           class="form-input"
                                           placeholder="https://example.com/image.jpg">
                                    <div class="form-help">Masukkan URL gambar produk (opsional)</div>
                                    
                                    <!-- Image Preview -->
                                    <div class="image-preview" id="imagePreview" style="display: none;">
                                        <img id="previewImg" src="" alt="Preview" style="max-width: 200px; max-height: 200px;">
                                    </div>
                                </div>

                                <div class="form-group">
                                    <label for="deskripsi" class="form-label">Deskripsi</label>
                                    <textarea id="deskripsi" 
                                              name="deskripsi" 
                                              class="form-textarea"
                                              rows="5"
                                              placeholder="Masukkan deskripsi produk (opsional)">${product.deskripsi}</textarea>
                                    <div class="form-help">Jelaskan detail produk, fitur, atau spesifikasi</div>
                                </div>
                            </div>

                            <!-- Product Preview -->
                            <div class="form-section">
                                <h3><i class="fas fa-eye"></i> Preview Produk</h3>
                                <div class="product-preview" id="productPreview">
                                    <div class="preview-image">
                                        <i class="fas fa-image"></i>
                                    </div>
                                    <div class="preview-content">
                                        <div class="preview-category">-</div>
                                        <div class="preview-name">Nama Produk</div>
                                        <div class="preview-price">Rp 0</div>
                                        <div class="preview-stock">Stok: 0</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Form Actions -->
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">
                            <i class="fas fa-times"></i> Batal
                        </a>
                        <button type="reset" class="btn btn-outline">
                            <i class="fas fa-undo"></i> Reset
                        </button>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> 
                            ${isEdit ? 'Update' : 'Simpan'} Produk
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="footer">
        <div class="container">
            <p>&copy; 2024 OnlineShop UAS. Dibuat dengan Java Servlet & JSP.</p>
        </div>
    </footer>

    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    <script>
        // Form validation and preview functionality
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('productForm');
            const namaInput = document.getElementById('nama');
            const kategoriInput = document.getElementById('kategori');
            const hargaInput = document.getElementById('harga');
            const stokInput = document.getElementById('stok');
            const gambarInput = document.getElementById('gambar');
            const deskripsiInput = document.getElementById('deskripsi');

            // Preview elements
            const previewName = document.querySelector('.preview-name');
            const previewCategory = document.querySelector('.preview-category');
            const previewPrice = document.querySelector('.preview-price');
            const previewStock = document.querySelector('.preview-stock');
            const previewImage = document.querySelector('.preview-image');

            // Update preview
            function updatePreview() {
                previewName.textContent = namaInput.value || 'Nama Produk';
                previewCategory.textContent = kategoriInput.value || '-';
                
                const harga = parseFloat(hargaInput.value) || 0;
                previewPrice.textContent = 'Rp ' + harga.toLocaleString('id-ID');
                
                const stok = parseInt(stokInput.value) || 0;
                previewStock.textContent = 'Stok: ' + stok;

                // Update image preview
                if (gambarInput.value) {
                    previewImage.innerHTML = `<img src="${gambarInput.value}" alt="Preview" onerror="this.parentElement.innerHTML='<i class=\\'fas fa-image\\'></i>'">`;
                } else {
                    previewImage.innerHTML = '<i class="fas fa-image"></i>';
                }
            }

            // Add event listeners
            [namaInput, kategoriInput, hargaInput, stokInput, gambarInput].forEach(input => {
                input.addEventListener('input', updatePreview);
            });

            // Initialize preview
            updatePreview();

            // Image URL preview
            gambarInput.addEventListener('input', function() {
                const imagePreview = document.getElementById('imagePreview');
                const previewImg = document.getElementById('previewImg');
                
                if (this.value) {
                    previewImg.src = this.value;
                    previewImg.onload = function() {
                        imagePreview.style.display = 'block';
                    };
                    previewImg.onerror = function() {
                        imagePreview.style.display = 'none';
                    };
                } else {
                    imagePreview.style.display = 'none';
                }
            });

            // Trigger initial image preview
            if (gambarInput.value) {
                gambarInput.dispatchEvent(new Event('input'));
            }
        });

        function handleKategoriChange() {
            const select = document.getElementById('kategoriSelect');
            const input = document.getElementById('kategori');
            
            if (select.value === 'new') {
                input.value = '';
                input.focus();
                input.placeholder = 'Masukkan kategori baru';
            } else if (select.value !== '') {
                input.value = select.value;
            }
        }
    </script>
</body>
</html>