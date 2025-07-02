package com.onlineshop.service;

import com.onlineshop.dao.ProductDAO;
import com.onlineshop.model.Product;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 * Service layer untuk Product
 * Mengimplementasikan business logic
 */
public class ProductService {
    private ProductDAO productDAO;
    
    public ProductService() throws SQLException {
        this.productDAO = new ProductDAO();
    }
    
    // Validasi dan menambah produk baru
    public boolean addProduct(Product product) throws SQLException, IllegalArgumentException {
        validateProduct(product);
        return productDAO.addProduct(product);
    }
    
    // Mendapatkan semua produk
    public List<Product> getAllProducts() throws SQLException {
        return productDAO.getAllProducts();
    }
    
    // Mendapatkan produk berdasarkan ID
    public Product getProductById(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("ID produk harus lebih dari 0");
        }
        return productDAO.getProductById(id);
    }
    
    // Validasi dan update produk
    public boolean updateProduct(Product product) throws SQLException, IllegalArgumentException {
        validateProduct(product);
        if (product.getId() <= 0) {
            throw new IllegalArgumentException("ID produk tidak valid");
        }
        return productDAO.updateProduct(product);
    }
    
    // Menghapus produk
    public boolean deleteProduct(int id) throws SQLException {
        if (id <= 0) {
            throw new IllegalArgumentException("ID produk harus lebih dari 0");
        }
        return productDAO.deleteProduct(id);
    }
    
    // Mencari produk
    public List<Product> searchProducts(String keyword) throws SQLException {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllProducts();
        }
        return productDAO.searchProducts(keyword.trim());
    }
    
    // Filter produk berdasarkan kategori
    public List<Product> getProductsByCategory(String kategori) throws SQLException {
        if (kategori == null || kategori.trim().isEmpty()) {
            return getAllProducts();
        }
        return productDAO.getProductsByCategory(kategori.trim());
    }
    
    // Mendapatkan produk dengan sorting
    public List<Product> getProductsSorted(String sortBy, String sortOrder) throws SQLException {
        return productDAO.getProductsSorted(sortBy, sortOrder);
    }
    
    // Mendapatkan semua kategori
    public List<String> getAllCategories() throws SQLException {
        return productDAO.getAllCategories();
    }
    
    // Filter dan sort bersamaan
    public List<Product> getProductsFiltered(String kategori, String sortBy, String sortOrder) throws SQLException {
        // Implementasi filter dan sort bersamaan
        if (kategori != null && !kategori.trim().isEmpty() && !"all".equalsIgnoreCase(kategori)) {
            List<Product> filteredProducts = getProductsByCategory(kategori);
            // Manual sorting jika perlu
            return sortProductsList(filteredProducts, sortBy, sortOrder);
        } else {
            return getProductsSorted(sortBy, sortOrder);
        }
    }
    
    // Helper method untuk validasi produk
    private void validateProduct(Product product) throws IllegalArgumentException {
        if (product == null) {
            throw new IllegalArgumentException("Produk tidak boleh null");
        }
        
        if (product.getNama() == null || product.getNama().trim().isEmpty()) {
            throw new IllegalArgumentException("Nama produk wajib diisi");
        }
        
        if (product.getKategori() == null || product.getKategori().trim().isEmpty()) {
            throw new IllegalArgumentException("Kategori produk wajib diisi");
        }
        
        if (product.getHarga() == null || product.getHarga().compareTo(BigDecimal.ZERO) < 0) {
            throw new IllegalArgumentException("Harga produk harus lebih dari atau sama dengan 0");
        }
        
        if (product.getStok() < 0) {
            throw new IllegalArgumentException("Stok produk tidak boleh negatif");
        }
        
        // Validasi panjang string
        if (product.getNama().length() > 255) {
            throw new IllegalArgumentException("Nama produk terlalu panjang (maksimal 255 karakter)");
        }
        
        if (product.getKategori().length() > 100) {
            throw new IllegalArgumentException("Kategori terlalu panjang (maksimal 100 karakter)");
        }
    }
    
    // Helper method untuk manual sorting
    private List<Product> sortProductsList(List<Product> products, String sortBy, String sortOrder) {
        if (products == null || products.isEmpty()) {
            return products;
        }
        
        boolean ascending = !"DESC".equalsIgnoreCase(sortOrder);
        
        products.sort((p1, p2) -> {
            int result = 0;
            
            switch (sortBy != null ? sortBy.toLowerCase() : "nama") {
                case "harga":
                    result = p1.getHarga().compareTo(p2.getHarga());
                    break;
                case "stok":
                    result = Integer.compare(p1.getStok(), p2.getStok());
                    break;
                case "kategori":
                    result = p1.getKategori().compareToIgnoreCase(p2.getKategori());
                    break;
                default:
                    result = p1.getNama().compareToIgnoreCase(p2.getNama());
                    break;
            }
            
            return ascending ? result : -result;
        });
        
        return products;
    }
}