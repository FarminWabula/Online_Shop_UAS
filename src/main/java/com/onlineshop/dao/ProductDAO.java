package com.onlineshop.dao;

import com.onlineshop.model.Product;
import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object untuk Product
 * Implementasi CRUD operations dengan JDBC
 */
public class ProductDAO {
    private Connection connection;
    
    public ProductDAO() throws SQLException {
        this.connection = DatabaseConnection.getInstance().getConnection();
    }
    
    // Create - Menambah produk baru
    public boolean addProduct(Product product) throws SQLException {
        String sql = "INSERT INTO products (nama, kategori, harga, stok, deskripsi, gambar) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, product.getNama());
            stmt.setString(2, product.getKategori());
            stmt.setBigDecimal(3, product.getHarga());
            stmt.setInt(4, product.getStok());
            stmt.setString(5, product.getDeskripsi());
            stmt.setString(6, product.getGambar());
            
            int rowsAffected = stmt.executeUpdate();
            
            if (rowsAffected > 0) {
                ResultSet generatedKeys = stmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    product.setId(generatedKeys.getInt(1));
                }
                return true;
            }
            return false;
        } catch (SQLException e) {
            throw new SQLException("Error saat menambah produk: " + e.getMessage(), e);
        }
    }
    
    // Read - Mendapatkan semua produk
    public List<Product> getAllProducts() throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products ORDER BY created_at DESC";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                products.add(product);
            }
        } catch (SQLException e) {
            throw new SQLException("Error saat mengambil data produk: " + e.getMessage(), e);
        }
        
        return products;
    }
    
    // Read - Mendapatkan produk berdasarkan ID
    public Product getProductById(int id) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToProduct(rs);
            }
            return null;
        } catch (SQLException e) {
            throw new SQLException("Error saat mengambil produk dengan ID " + id + ": " + e.getMessage(), e);
        }
    }
    
    // Update - Mengupdate produk
    public boolean updateProduct(Product product) throws SQLException {
        String sql = "UPDATE products SET nama = ?, kategori = ?, harga = ?, stok = ?, deskripsi = ?, gambar = ?, updated_at = CURRENT_TIMESTAMP WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, product.getNama());
            stmt.setString(2, product.getKategori());
            stmt.setBigDecimal(3, product.getHarga());
            stmt.setInt(4, product.getStok());
            stmt.setString(5, product.getDeskripsi());
            stmt.setString(6, product.getGambar());
            stmt.setInt(7, product.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new SQLException("Error saat mengupdate produk: " + e.getMessage(), e);
        }
    }
    
    // Delete - Menghapus produk
    public boolean deleteProduct(int id) throws SQLException {
        String sql = "DELETE FROM products WHERE id = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new SQLException("Error saat menghapus produk: " + e.getMessage(), e);
        }
    }
    
    // Search - Mencari produk berdasarkan nama atau kategori
    public List<Product> searchProducts(String keyword) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE nama LIKE ? OR kategori LIKE ? ORDER BY nama";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            String searchPattern = "%" + keyword + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            throw new SQLException("Error saat mencari produk: " + e.getMessage(), e);
        }
        
        return products;
    }
    
    // Filter - Mendapatkan produk berdasarkan kategori
    public List<Product> getProductsByCategory(String kategori) throws SQLException {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM products WHERE kategori = ? ORDER BY nama";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, kategori);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            throw new SQLException("Error saat filter berdasarkan kategori: " + e.getMessage(), e);
        }
        
        return products;
    }
    
    // Sort - Mendapatkan produk dengan sorting
    public List<Product> getProductsSorted(String sortBy, String sortOrder) throws SQLException {
        List<Product> products = new ArrayList<>();
        
        // Validasi parameter sorting
        if (!isValidSortColumn(sortBy)) {
            sortBy = "nama";
        }
        if (!"ASC".equalsIgnoreCase(sortOrder) && !"DESC".equalsIgnoreCase(sortOrder)) {
            sortOrder = "ASC";
        }
        
        String sql = "SELECT * FROM products ORDER BY " + sortBy + " " + sortOrder;
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                products.add(mapResultSetToProduct(rs));
            }
        } catch (SQLException e) {
            throw new SQLException("Error saat sorting produk: " + e.getMessage(), e);
        }
        
        return products;
    }
    
    // Mendapatkan semua kategori unik
    public List<String> getAllCategories() throws SQLException {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT DISTINCT kategori FROM products ORDER BY kategori";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                categories.add(rs.getString("kategori"));
            }
        } catch (SQLException e) {
            throw new SQLException("Error saat mengambil kategori: " + e.getMessage(), e);
        }
        
        return categories;
    }
    
    // Helper method untuk mapping ResultSet ke Product object
    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setNama(rs.getString("nama"));
        product.setKategori(rs.getString("kategori"));
        product.setHarga(rs.getBigDecimal("harga"));
        product.setStok(rs.getInt("stok"));
        product.setDeskripsi(rs.getString("deskripsi"));
        product.setGambar(rs.getString("gambar"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        product.setUpdatedAt(rs.getTimestamp("updated_at"));
        return product;
    }
    
    // Validasi kolom untuk sorting
    private boolean isValidSortColumn(String column) {
        String[] validColumns = {"id", "nama", "kategori", "harga", "stok", "created_at"};
        for (String validColumn : validColumns) {
            if (validColumn.equals(column)) {
                return true;
            }
        }
        return false;
    }
}