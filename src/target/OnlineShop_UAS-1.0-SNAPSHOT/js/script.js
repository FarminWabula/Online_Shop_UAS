// Global JavaScript functionality for OnlineShop application

// DOM Content Loaded Event
document.addEventListener('DOMContentLoaded', function() {
    initializeApp();
});

// Initialize application
function initializeApp() {
    initializeModals();
    initializeFormValidation();
    initializeTooltips();
    initializeImageHandling();
    initializeSearchEnhancements();
}

// Modal Management
function initializeModals() {
    const modals = document.querySelectorAll('.modal');
    const closeButtons = document.querySelectorAll('.modal .close');
    
    // Close modal when clicking close button
    closeButtons.forEach(button => {
        button.addEventListener('click', function() {
            const modal = this.closest('.modal');
            closeModal(modal);
        });
    });
    
    // Close modal when clicking outside
    modals.forEach(modal => {
        modal.addEventListener('click', function(e) {
            if (e.target === this) {
                closeModal(this);
            }
        });
    });
    
    // Close modal with Escape key
    document.addEventListener('keydown', function(e) {
        if (e.key === 'Escape') {
            const openModal = document.querySelector('.modal.show');
            if (openModal) {
                closeModal(openModal);
            }
        }
    });
}

// Delete Product Modal
function deleteProduct(productId, productName) {
    const modal = document.getElementById('deleteModal');
    const productNameElement = document.getElementById('productName');
    const deleteForm = document.getElementById('deleteForm');
    const deleteProductIdInput = document.getElementById('deleteProductId');
    
    if (modal && productNameElement && deleteForm && deleteProductIdInput) {
        productNameElement.textContent = productName;
        deleteProductIdInput.value = productId;
        deleteForm.action = window.location.pathname;
        showModal(modal);
    }
}

// Close Delete Modal
function closeDeleteModal() {
    const modal = document.getElementById('deleteModal');
    if (modal) {
        closeModal(modal);
    }
}

// Show Modal
function showModal(modal) {
    modal.classList.add('show');
    modal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
    
    // Focus management
    const firstFocusable = modal.querySelector('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
    if (firstFocusable) {
        firstFocusable.focus();
    }
}

// Close Modal
function closeModal(modal) {
    modal.classList.remove('show');
    modal.style.display = 'none';
    document.body.style.overflow = '';
}

// Form Validation
function initializeFormValidation() {
    const forms = document.querySelectorAll('form');
    
    forms.forEach(form => {
        // Add real-time validation
        const inputs = form.querySelectorAll('input[required], select[required], textarea[required]');
        
        inputs.forEach(input => {
            input.addEventListener('blur', function() {
                validateField(this);
            });
            
            input.addEventListener('input', function() {
                clearFieldError(this);
            });
        });
        
        // Form submission validation
        form.addEventListener('submit', function(e) {
            if (!validateForm(this)) {
                e.preventDefault();
            }
        });
    });
}

// Validate individual field
function validateField(field) {
    const value = field.value.trim();
    const fieldName = field.name;
    let isValid = true;
    let errorMessage = '';
    
    // Remove existing error
    clearFieldError(field);
    
    // Required field validation
    if (field.hasAttribute('required') && !value) {
        isValid = false;
        errorMessage = 'Field ini wajib diisi';
    }
    
    // Specific field validations
    switch (fieldName) {
        case 'nama':
            if (value && value.length < 2) {
                isValid = false;
                errorMessage = 'Nama produk minimal 2 karakter';
            }
            break;
            
        case 'harga':
            if (value && (isNaN(value) || parseFloat(value) < 0)) {
                isValid = false;
                errorMessage = 'Harga harus berupa angka positif';
            }
            break;
            
        case 'stok':
            if (value && (isNaN(value) || parseInt(value) < 0)) {
                isValid = false;
                errorMessage = 'Stok harus berupa angka positif';
            }
            break;
            
        case 'gambar':
            if (value && !isValidUrl(value)) {
                isValid = false;
                errorMessage = 'URL gambar tidak valid';
            }
            break;
    }
    
    if (!isValid) {
        showFieldError(field, errorMessage);
    }
    
    return isValid;
}

// Validate entire form
function validateForm(form) {
    const requiredFields = form.querySelectorAll('input[required], select[required], textarea[required]');
    let isValid = true;
    
    requiredFields.forEach(field => {
        if (!validateField(field)) {
            isValid = false;
        }
    });
    
    return isValid;
}

// Show field error
function showFieldError(field, message) {
    field.classList.add('error');
    
    // Remove existing error message
    const existingError = field.parentNode.querySelector('.field-error');
    if (existingError) {
        existingError.remove();
    }
    
    // Add new error message
    const errorElement = document.createElement('div');
    errorElement.className = 'field-error';
    errorElement.textContent = message;
    errorElement.style.color = 'var(--error-600)';
    errorElement.style.fontSize = 'var(--font-size-xs)';
    errorElement.style.marginTop = 'var(--spacing-1)';
    
    field.parentNode.appendChild(errorElement);
}

// Clear field error
function clearFieldError(field) {
    field.classList.remove('error');
    const errorElement = field.parentNode.querySelector('.field-error');
    if (errorElement) {
        errorElement.remove();
    }
}

// URL validation helper
function isValidUrl(string) {
    try {
        new URL(string);
        return true;
    } catch (_) {
        return false;
    }
}

// Initialize tooltips
function initializeTooltips() {
    const elementsWithTooltips = document.querySelectorAll('[title]');
    
    elementsWithTooltips.forEach(element => {
        const title = element.getAttribute('title');
        if (title) {
            element.addEventListener('mouseenter', function(e) {
                showTooltip(e, title);
            });
            
            element.addEventListener('mouseleave', function() {
                hideTooltip();
            });
            
            // Remove title attribute to prevent browser tooltip
            element.removeAttribute('title');
            element.setAttribute('data-tooltip', title);
        }
    });
}

// Show tooltip
function showTooltip(event, text) {
    const tooltip = document.createElement('div');
    tooltip.className = 'custom-tooltip';
    tooltip.textContent = text;
    tooltip.style.cssText = `
        position: fixed;
        background: var(--neutral-800);
        color: white;
        padding: var(--spacing-2) var(--spacing-3);
        border-radius: var(--radius-md);
        font-size: var(--font-size-xs);
        z-index: 1000;
        pointer-events: none;
        white-space: nowrap;
        box-shadow: var(--shadow-lg);
    `;
    
    document.body.appendChild(tooltip);
    
    // Position tooltip
    const rect = tooltip.getBoundingClientRect();
    tooltip.style.left = (event.clientX - rect.width / 2) + 'px';
    tooltip.style.top = (event.clientY - rect.height - 10) + 'px';
    
    // Ensure tooltip stays within viewport
    const viewportWidth = window.innerWidth;
    const viewportHeight = window.innerHeight;
    
    if (parseInt(tooltip.style.left) < 0) {
        tooltip.style.left = '10px';
    }
    if (parseInt(tooltip.style.left) + rect.width > viewportWidth) {
        tooltip.style.left = (viewportWidth - rect.width - 10) + 'px';
    }
    if (parseInt(tooltip.style.top) < 0) {
        tooltip.style.top = (event.clientY + 10) + 'px';
    }
}

// Hide tooltip
function hideTooltip() {
    const tooltip = document.querySelector('.custom-tooltip');
    if (tooltip) {
        tooltip.remove();
    }
}

// Image handling
function initializeImageHandling() {
    const imageInputs = document.querySelectorAll('input[type="url"][name="gambar"]');
    
    imageInputs.forEach(input => {
        input.addEventListener('input', function() {
            debounce(validateImageUrl, 500)(this);
        });
    });
}

// Validate image URL
function validateImageUrl(input) {
    const url = input.value.trim();
    const previewContainer = input.parentNode.querySelector('.image-preview') || 
                            document.getElementById('imagePreview');
    
    if (!url) {
        if (previewContainer) {
            previewContainer.style.display = 'none';
        }
        return;
    }
    
    if (!isValidUrl(url)) {
        showFieldError(input, 'URL tidak valid');
        return;
    }
    
    // Test if image loads
    const img = new Image();
    img.onload = function() {
        clearFieldError(input);
        if (previewContainer) {
            const previewImg = previewContainer.querySelector('img') || 
                              document.getElementById('previewImg');
            if (previewImg) {
                previewImg.src = url;
                previewContainer.style.display = 'block';
            }
        }
    };
    
    img.onerror = function() {
        showFieldError(input, 'Gambar tidak dapat dimuat');
        if (previewContainer) {
            previewContainer.style.display = 'none';
        }
    };
    
    img.src = url;
}

// Debounce function
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// Search enhancements
function initializeSearchEnhancements() {
    const searchInput = document.querySelector('input[name="keyword"]');
    if (searchInput) {
        // Add search suggestions or auto-complete here if needed
        searchInput.addEventListener('input', function() {
            // Could implement live search suggestions
        });
    }
    
    // Auto-submit filter form on change
    const filterSelects = document.querySelectorAll('.filter-form select');
    filterSelects.forEach(select => {
        select.addEventListener('change', function() {
            const autoSubmit = this.getAttribute('data-auto-submit');
            if (autoSubmit !== 'false') {
                // Small delay to prevent rapid submissions
                setTimeout(() => {
                    this.form.submit();
                }, 100);
            }
        });
    });
}

// Utility function to format currency
function formatCurrency(amount) {
    return new Intl.NumberFormat('id-ID', {
        style: 'currency',
        currency: 'IDR',
        minimumFractionDigits: 0,
        maximumFractionDigits: 0
    }).format(amount);
}

// Utility function to format number
function formatNumber(number) {
    return new Intl.NumberFormat('id-ID').format(number);
}

// Show success message
function showSuccessMessage(message) {
    showAlert(message, 'success');
}

// Show error message
function showErrorMessage(message) {
    showAlert(message, 'error');
}

// Show alert
function showAlert(message, type = 'info') {
    const alertContainer = document.createElement('div');
    alertContainer.className = `alert alert-${type}`;
    alertContainer.innerHTML = `
        <i class="fas fa-${type === 'success' ? 'check-circle' : 
                         type === 'error' ? 'exclamation-circle' : 
                         'info-circle'}"></i>
        ${message}
    `;
    
    // Insert at the top of main content
    const mainContent = document.querySelector('.main-content .container');
    if (mainContent) {
        mainContent.insertBefore(alertContainer, mainContent.firstChild);
        
        // Auto-hide after 5 seconds
        setTimeout(() => {
            alertContainer.style.opacity = '0';
            alertContainer.style.transform = 'translateY(-20px)';
            setTimeout(() => {
                alertContainer.remove();
            }, 300);
        }, 5000);
    }
}

// Loading state management
function showLoading(element) {
    if (element) {
        element.disabled = true;
        const originalText = element.textContent;
        element.setAttribute('data-original-text', originalText);
        element.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Loading...';
    }
}

function hideLoading(element) {
    if (element) {
        element.disabled = false;
        const originalText = element.getAttribute('data-original-text');
        if (originalText) {
            element.textContent = originalText;
            element.removeAttribute('data-original-text');
        }
    }
}

// Export functions for use in other scripts
window.OnlineShop = {
    deleteProduct,
    closeDeleteModal,
    showModal,
    closeModal,
    showSuccessMessage,
    showErrorMessage,
    formatCurrency,
    formatNumber,
    showLoading,
    hideLoading
};