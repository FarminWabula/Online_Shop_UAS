package com.onlineshop.servlet;

import com.google.gson.Gson;
import com.onlineshop.model.Product;
import com.onlineshop.service.ProductService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 * Servlet untuk menangani request produk
 * Mendukung operasi CRUD dan filtering/sorting
 */
@WebServlet(name = "ProductServlet", urlPatterns = {"/products", "/products/*"})
public class ProductServlet extends HttpServlet {
    private ProductService productService;
    private Gson gson;
    
    @Override
    public void init() throws ServletException {
        try {
            this.productService = new ProductService();
            this.gson = new Gson();
            System.out.println("ProductServlet initialized successfully");
        } catch (Exception e) {
            System.err.println("Error initializing ProductServlet: " + e.getMessage());
            e.printStackTrace();
            // Don't throw exception, just log it
            // throw new ServletException("Error inisialisasi ProductService", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if service is available
        if (productService == null) {
            try {
                this.productService = new ProductService();
            } catch (Exception e) {
                handleError(request, response, "Database connection error: " + e.getMessage());
                return;
            }
        }
        
        String action = request.getParameter("action");
        
        try {
            if (action == null) {
                action = "list";
            }
            
            switch (action) {
                case "list":
                    handleList(request, response);
                    break;
                case "view":
                    handleView(request, response);
                    break;
                case "add":
                    handleAddForm(request, response);
                    break;
                case "edit":
                    handleEditForm(request, response);
                    break;
                case "search":
                    handleSearch(request, response);
                    break;
                case "filter":
                    handleFilter(request, response);
                    break;
                case "api":
                    handleApiGet(request, response);
                    break;
                default:
                    handleList(request, response);
                    break;
            }
        } catch (SQLException e) {
            handleError(request, response, "Database error: " + e.getMessage());
        } catch (Exception e) {
            handleError(request, response, "Unexpected error: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if service is available
        if (productService == null) {
            try {
                this.productService = new ProductService();
            } catch (Exception e) {
                handleError(request, response, "Database connection error: " + e.getMessage());
                return;
            }
        }
        
        String action = request.getParameter("action");
        
        try {
            if (action == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Action parameter required");
                return;
            }
            
            switch (action) {
                case "add":
                    handleAdd(request, response);
                    break;
                case "update":
                    handleUpdate(request, response);
                    break;
                case "delete":
                    handleDelete(request, response);
                    break;
                default:
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action");
                    break;
            }
        } catch (SQLException e) {
            handleError(request, response, "Database error: " + e.getMessage());
        } catch (Exception e) {
            handleError(request, response, "Unexpected error: " + e.getMessage());
        }
    }
    
    // Handler untuk menampilkan daftar produk
    private void handleList(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        String kategori = request.getParameter("kategori");
        
        List<Product> products;
        
        if (kategori != null && !kategori.trim().isEmpty() && !"all".equalsIgnoreCase(kategori)) {
            products = productService.getProductsFiltered(kategori, sortBy, sortOrder);
        } else if (sortBy != null && !sortBy.trim().isEmpty()) {
            products = productService.getProductsSorted(sortBy, sortOrder);
        } else {
            products = productService.getAllProducts();
        }
        
        List<String> categories = productService.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("currentKategori", kategori);
        request.setAttribute("currentSortBy", sortBy);
        request.setAttribute("currentSortOrder", sortOrder);
        
        request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
    }
    
    // Handler untuk menampilkan detail produk
    private void handleView(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID required");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            Product product = productService.getProductById(id);
            
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }
            
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/views/product-detail.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }
    
    // Handler untuk form tambah produk
    private void handleAddForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        List<String> categories = productService.getAllCategories();
        request.setAttribute("categories", categories);
        request.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(request, response);
    }
    
    // Handler untuk form edit produk
    private void handleEditForm(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID required");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            Product product = productService.getProductById(id);
            
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }
            
            List<String> categories = productService.getAllCategories();
            request.setAttribute("product", product);
            request.setAttribute("categories", categories);
            request.setAttribute("isEdit", true);
            request.getRequestDispatcher("/WEB-INF/views/product-form.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }
    
    // Handler untuk pencarian produk
    private void handleSearch(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String keyword = request.getParameter("keyword");
        List<Product> products = productService.searchProducts(keyword);
        List<String> categories = productService.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("searchKeyword", keyword);
        request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
    }
    
    // Handler untuk filter produk
    private void handleFilter(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        String kategori = request.getParameter("kategori");
        String sortBy = request.getParameter("sortBy");
        String sortOrder = request.getParameter("sortOrder");
        
        List<Product> products = productService.getProductsFiltered(kategori, sortBy, sortOrder);
        List<String> categories = productService.getAllCategories();
        
        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("currentKategori", kategori);
        request.setAttribute("currentSortBy", sortBy);
        request.setAttribute("currentSortOrder", sortOrder);
        
        request.getRequestDispatcher("/WEB-INF/views/product-list.jsp").forward(request, response);
    }
    
    // Handler untuk API GET (JSON response)
    private void handleApiGet(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        List<Product> products = productService.getAllProducts();
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(gson.toJson(products));
    }
    
    // Handler untuk menambah produk
    private void handleAdd(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        try {
            Product product = createProductFromRequest(request);
            boolean success = productService.addProduct(product);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/products?success=add");
            } else {
                request.setAttribute("error", "Gagal menambahkan produk");
                handleAddForm(request, response);
            }
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            handleAddForm(request, response);
        }
    }
    
    // Handler untuk update produk
    private void handleUpdate(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, ServletException, IOException {
        
        try {
            String idStr = request.getParameter("id");
            if (idStr == null || idStr.trim().isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID required");
                return;
            }
            
            int id = Integer.parseInt(idStr);
            Product product = createProductFromRequest(request);
            product.setId(id);
            
            boolean success = productService.updateProduct(product);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/products?success=update");
            } else {
                request.setAttribute("error", "Gagal mengupdate produk");
                request.setAttribute("product", product);
                handleEditForm(request, response);
            }
            
        } catch (IllegalArgumentException e) {
            request.setAttribute("error", e.getMessage());
            handleEditForm(request, response);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }
    
    // Handler untuk menghapus produk
    private void handleDelete(HttpServletRequest request, HttpServletResponse response) 
            throws SQLException, IOException {
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product ID required");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            boolean success = productService.deleteProduct(id);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/products?success=delete");
            } else {
                response.sendRedirect(request.getContextPath() + "/products?error=delete");
            }
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }
    
    // Helper method untuk membuat object Product dari request
    private Product createProductFromRequest(HttpServletRequest request) throws IllegalArgumentException {
        try {
            String nama = request.getParameter("nama");
            String kategori = request.getParameter("kategori");
            String hargaStr = request.getParameter("harga");
            String stokStr = request.getParameter("stok");
            String deskripsi = request.getParameter("deskripsi");
            String gambar = request.getParameter("gambar");
            
            // Validasi input
            if (nama == null || nama.trim().isEmpty()) {
                throw new IllegalArgumentException("Nama produk wajib diisi");
            }
            if (kategori == null || kategori.trim().isEmpty()) {
                throw new IllegalArgumentException("Kategori wajib diisi");
            }
            if (hargaStr == null || hargaStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Harga wajib diisi");
            }
            if (stokStr == null || stokStr.trim().isEmpty()) {
                throw new IllegalArgumentException("Stok wajib diisi");
            }
            
            BigDecimal harga = new BigDecimal(hargaStr);
            int stok = Integer.parseInt(stokStr);
            
            Product product = new Product();
            product.setNama(nama.trim());
            product.setKategori(kategori.trim());
            product.setHarga(harga);
            product.setStok(stok);
            product.setDeskripsi(deskripsi != null ? deskripsi.trim() : "");
            product.setGambar(gambar != null ? gambar.trim() : "");
            
            return product;
            
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Format angka tidak valid");
        }
    }
    
    // Handler untuk error
    private void handleError(HttpServletRequest request, HttpServletResponse response, String errorMessage) 
            throws ServletException, IOException {
        
        request.setAttribute("error", errorMessage);
        request.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(request, response);
    }
}