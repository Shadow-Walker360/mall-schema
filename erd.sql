erDiagram
    MALLS {
        INT mall_id PK
        VARCHAR name
        VARCHAR location
        DATE opening_date
    }
    SHOPS {
        INT shop_id PK
        INT mall_id FK
        VARCHAR name
        VARCHAR category
        DATE open_date
    }
    LEASES {
        INT lease_id PK
        INT shop_id FK
        DATE start_date
        DATE end_date
        DECIMAL rent_amount
    }
    ShopEmployees {
        INT employee_id PK
        INT shop_id FK
        VARCHAR first_name
        VARCHAR last_name
        DATE hire_date
        VARCHAR role
    }
    PRODUCTS {
        INT product_id PK
        INT shop_id FK
        VARCHAR name
        VARCHAR sku
        DECIMAL price
        INT stock
    }
    CUSTOMERS {
        INT customer_id PK
        VARCHAR first_name
        VARCHAR last_name
        VARCHAR email
        VARCHAR phone
        DATE join_date
    }
    SALES {
        INT sale_id PK
        INT customer_id FK
        DATETIME sale_date
        DECIMAL total_amount
    }
    SALEITEMS {
        INT sale_id PK, FK
        INT product_id PK, FK
        INT quantity
        DECIMAL unit_price
    }

    MALLS ||--o{ SHOPS : "has"
    SHOPS ||--|{ LEASES : "leases"
    SHOPS ||--o{ ShopEmployees : "employs"
    SHOPS ||--o{ PRODUCTS : "stocks"
    CUSTOMERS ||--o{ SALES : "makes"
    SALES ||--|{ SALEITEMS : "includes"
    PRODUCTS ||--o{ SALEITEMS : "sold_in"
