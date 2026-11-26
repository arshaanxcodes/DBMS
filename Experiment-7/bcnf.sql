USE sales_norm_db;

DROP TABLE IF EXISTS city_salesperson_bcnf;
DROP TABLE IF EXISTS salesperson_category_bcnf;
DROP TABLE IF EXISTS territory_assignment_3nf;

CREATE TABLE territory_assignment_3nf (
    customer_city VARCHAR(50) NOT NULL,
    category_id VARCHAR(10) NOT NULL,
    salesperson_id INT NOT NULL,
    PRIMARY KEY (customer_city, category_id),
    UNIQUE KEY uq_city_salesperson (customer_city, salesperson_id),
    FOREIGN KEY (category_id) REFERENCES categories_3nf(category_id),
    FOREIGN KEY (salesperson_id) REFERENCES salespersons_3nf(salesperson_id)
) ENGINE=InnoDB;

INSERT INTO territory_assignment_3nf VALUES
('Mumbai', 'C01', 501),
('Mumbai', 'C02', 503),
('Ahmedabad', 'C03', 502),
('Lucknow', 'C01', 501),
('Chennai', 'C02', 504);

CREATE TABLE salesperson_category_bcnf (
    salesperson_id INT PRIMARY KEY,
    category_id VARCHAR(10) NOT NULL,
    FOREIGN KEY (salesperson_id) REFERENCES salespersons_3nf(salesperson_id),
    FOREIGN KEY (category_id) REFERENCES categories_3nf(category_id)
) ENGINE=InnoDB;

CREATE TABLE city_salesperson_bcnf (
    customer_city VARCHAR(50) NOT NULL,
    salesperson_id INT NOT NULL,
    PRIMARY KEY (customer_city, salesperson_id),
    FOREIGN KEY (salesperson_id) REFERENCES salesperson_category_bcnf(salesperson_id)
) ENGINE=InnoDB;

INSERT INTO salesperson_category_bcnf
SELECT DISTINCT salesperson_id, category_id
FROM territory_assignment_3nf;

INSERT INTO city_salesperson_bcnf
SELECT customer_city, salesperson_id
FROM territory_assignment_3nf;
