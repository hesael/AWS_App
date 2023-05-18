 #!/bin/bash
    sudo apt-get update
    sudo apt-get install -y mysql-server

    # # Create the database
    # mysql -u root -e "CREATE DATABASE My-Items;"

    # # Connect to the database and create the table structure
    # mysql -u root -D My-Items 
    # CREATE TABLE IF NOT EXISTS product_data (
    #   id INT AUTO_INCREMENT PRIMARY KEY,
    #   code VARCHAR(255),
    #   codeType VARCHAR(255),
    #   productName VARCHAR(255),
    #   description TEXT,
    #   region VARCHAR(255),
    #   imageUrl VARCHAR(255),
    #   brand VARCHAR(255),
    #   category VARCHAR(255),
    #   upc BIGINT,
    #   ean BIGINT,
    #   barcodeUrl VARCHAR(255)
    # );
