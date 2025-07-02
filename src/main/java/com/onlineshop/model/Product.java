package com.onlineshop.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Kelas Product dengan konsep OOP
 * Merepresentasikan produk dalam toko online
 */
public class Product {
    private int id;
    private String nama;
    private String kategori;
    private BigDecimal harga;
    private int stok;
    private String deskripsi;
    private String gambar;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    
    // Default constructor
    public Product() {}
    
    // Constructor dengan parameter utama
    public Product(String nama, String kategori, BigDecimal harga, int stok) {
        this.nama = nama;
        this.kategori = kategori;
        this.harga = harga;
        this.stok = stok;
    }
    
    // Constructor lengkap
    public Product(int id, String nama, String kategori, BigDecimal harga, 
                   int stok, String deskripsi, String gambar) {
        this.id = id;
        this.nama = nama;
        this.kategori = kategori;
        this.harga = harga;
        this.stok = stok;
        this.deskripsi = deskripsi;
        this.gambar = gambar;
    }
    
    // Getter dan Setter methods
    public int getId() {
        return id;
    }
    
    public void setId(int id) {
        this.id = id;
    }
    
    public String getNama() {
        return nama;
    }
    
    public void setNama(String nama) {
        this.nama = nama;
    }
    
    public String getKategori() {
        return kategori;
    }
    
    public void setKategori(String kategori) {
        this.kategori = kategori;
    }
    
    public BigDecimal getHarga() {
        return harga;
    }
    
    public void setHarga(BigDecimal harga) {
        this.harga = harga;
    }
    
    public int getStok() {
        return stok;
    }
    
    public void setStok(int stok) {
        this.stok = stok;
    }
    
    public String getDeskripsi() {
        return deskripsi;
    }
    
    public void setDeskripsi(String deskripsi) {
        this.deskripsi = deskripsi;
    }
    
    public String getGambar() {
        return gambar;
    }
    
    public void setGambar(String gambar) {
        this.gambar = gambar;
    }
    
    public Timestamp getCreatedAt() {
        return createdAt;
    }
    
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
    
    public Timestamp getUpdatedAt() {
        return updatedAt;
    }
    
    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
    
    // Business methods
    public boolean isAvailable() {
        return stok > 0;
    }
    
    public void reduceStock(int quantity) throws IllegalArgumentException {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity harus lebih dari 0");
        }
        if (quantity > stok) {
            throw new IllegalArgumentException("Stok tidak mencukupi");
        }
        this.stok -= quantity;
    }
    
    public void addStock(int quantity) throws IllegalArgumentException {
        if (quantity <= 0) {
            throw new IllegalArgumentException("Quantity harus lebih dari 0");
        }
        this.stok += quantity;
    }
    
    @Override
    public String toString() {
        return "Product{" +
                "id=" + id +
                ", nama='" + nama + '\'' +
                ", kategori='" + kategori + '\'' +
                ", harga=" + harga +
                ", stok=" + stok +
                '}';
    }
    
    @Override
    public boolean equals(Object obj) {
        if (this == obj) return true;
        if (obj == null || getClass() != obj.getClass()) return false;
        Product product = (Product) obj;
        return id == product.id;
    }
    
    @Override
    public int hashCode() {
        return Integer.hashCode(id);
    }
}