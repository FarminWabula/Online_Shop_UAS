<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - OnlineShop</title>
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
                    <a href="${pageContext.request.contextPath}/" class="nav-link">
                        <i class="fas fa-home"></i> Beranda
                    </a>
                    <a href="${pageContext.request.contextPath}/products" class="nav-link">
                        <i class="fas fa-box"></i> Produk
                    </a>
                </nav>
            </div>
        </div>
    </header>

    <!-- Main Content -->
    <main class="main-content">
        <div class="container">
            <div class="error-container" style="text-align: center; padding: var(--spacing-12) var(--spacing-4);">
                <div class="error-icon" style="font-size: 4rem; color: var(--error-500); margin-bottom: var(--spacing-6);">
                    <i class="fas fa-exclamation-triangle"></i>
                </div>
                
                <h1 style="font-size: var(--font-size-3xl); color: var(--neutral-800); margin-bottom: var(--spacing-4);">
                    Oops! Terjadi Kesalahan
                </h1>
                
                <div class="error-message" style="background: var(--error-50); border: 1px solid var(--error-200); border-radius: var(--radius-lg); padding: var(--spacing-6); margin-bottom: var(--spacing-6); max-width: 600px; margin-left: auto; margin-right: auto;">
                    <c:choose>
                        <c:when test="${not empty error}">
                            <p style="color: var(--error-700); margin: 0; font-weight: 500;">
                                ${error}
                            </p>
                        </c:when>
                        <c:when test="${not empty exception}">
                            <p style="color: var(--error-700); margin: 0; font-weight: 500;">
                                ${exception.message}
                            </p>
                        </c:when>
                        <c:otherwise>
                            <p style="color: var(--error-700); margin: 0; font-weight: 500;">
                                Terjadi kesalahan yang tidak terduga. Silakan coba lagi nanti.
                            </p>
                        </c:otherwise>
                    </c:choose>
                </div>
                
                <div class="error-actions" style="display: flex; gap: var(--spacing-4); justify-content: center; flex-wrap: wrap;">
                    <a href="javascript:history.back()" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Kembali
                    </a>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary">
                        <i class="fas fa-home"></i> Ke Beranda
                    </a>
                    <a href="${pageContext.request.contextPath}/products" class="btn btn-outline">
                        <i class="fas fa-box"></i> Lihat Produk
                    </a>
                </div>
                
                <div style="margin-top: var(--spacing-8); color: var(--neutral-500); font-size: var(--font-size-sm);">
                    <p>Jika masalah berlanjut, silakan hubungi administrator sistem.</p>
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
</body>
</html>