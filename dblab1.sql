USE dblab1;

CREATE TABLE Customer (
    customer_id INT IDENTITY(1,1) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    password_hash VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    city VARCHAR(100),
    postal_code VARCHAR(20),
    country VARCHAR(100),

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Category (
    category_id INT IDENTITY(1,1) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL,
    description TEXT,
    parent_category_id INT,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (parent_category_id) REFERENCES Category(category_id)
);

CREATE TABLE Supplier (
    supplier_id INT IDENTITY(1,1) PRIMARY KEY,
    supplier_name VARCHAR(100) NOT NULL,
    contact_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    address VARCHAR(255),
    country VARCHAR(100),

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Product (
    product_id INT IDENTITY(1,1) PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    category_id INT,
    supplier_id INT,
    image_url VARCHAR(255),
    is_active BIT DEFAULT 1,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id) REFERENCES Category(category_id),
    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE Pet (
    pet_id INT IDENTITY(1,1) PRIMARY KEY,
    pet_name VARCHAR(100),
    species VARCHAR(50) NOT NULL,
    breed VARCHAR(100),
    age_months INT,
    gender VARCHAR(10) CHECK (gender in ('Male', 'Female', 'Unknown')),
    price DECIMAL(10,2) NOT NULL,
    health_status VARCHAR(100),
    is_available BIT DEFAULT 1,
    supplier_id INT,
    description TEXT,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id)
);

CREATE TABLE [Order] (
    order_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    total_amount DECIMAL(10,2) NOT NULL,
    status VARCHAR(20) DEFAULT 'Pending' CHECK(status IN ('Pending','Processing','Shipped','Delivered','Cancelled')),
    shipping_address VARCHAR(255),
    payment_method VARCHAR(50),

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id)
);

CREATE TABLE OrderItem (
    order_item_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT,
    pet_id INT,
    quantity INT DEFAULT 1,
    unit_price DECIMAL(10,2) NOT NULL,

    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (order_id) REFERENCES [Order](order_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (pet_id) REFERENCES Pet(pet_id)
);

CREATE TABLE Review (
    review_id INT IDENTITY(1,1) PRIMARY KEY,
    customer_id INT NOT NULL,
    product_id INT,
    pet_id INT,
    rating INT CHECK (rating BETWEEN 1 AND 5),
    comment TEXT,

    review_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id) REFERENCES Product(product_id),
    FOREIGN KEY (pet_id) REFERENCES Pet(pet_id)
);

CREATE TABLE Payment (
    payment_id INT IDENTITY(1,1) PRIMARY KEY,
    order_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method VARCHAR(25) CHECK (payment_method IN ('Credit Card','Debit Card','PayPal','Bank Transfer','Cash on Delivery')),
    payment_status VARCHAR(25) DEFAULT 'Pending' CHECK (payment_status IN ('Pending','Completed','Failed','Refunded')),
    transaction_reference VARCHAR(100),

    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (order_id) REFERENCES [Order](order_id)
);

CREATE TABLE ProductWishlist (
    customer_id INT NOT NULL,
    product_id  INT NOT NULL,
    added_date  DATETIME DEFAULT GETDATE(),

    PRIMARY KEY (customer_id, product_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (product_id)  REFERENCES Product(product_id)
);

CREATE TABLE PetWishlist (
    customer_id INT NOT NULL,
    pet_id      INT NOT NULL,
    added_date  DATETIME DEFAULT GETDATE(),

    PRIMARY KEY (customer_id, pet_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (pet_id)      REFERENCES Pet(pet_id)
);