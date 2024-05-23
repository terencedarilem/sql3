-- 1. Afficher toutes les données des clients
SELECT * FROM Customers;

-- 2. Afficher le product_name et la category pour les produits dont le prix est compris entre 5000 et 10000
SELECT product_name, category
FROM Products
WHERE price BETWEEN 5000 AND 10000;

-- 3. Affichez toutes les données des produits triés par ordre décroissant de prix
SELECT * FROM Products
ORDER BY price DESC;

-- 4. Afficher le nombre total de commandes, le montant moyen, le montant total le plus élevé et le montant total le plus bas
-- 4a. Nombre total de commandes
SELECT COUNT(*) AS total_orders
FROM Orders;

-- 4b. Montant moyen des commandes
SELECT AVG(total_amount) AS average_amount
FROM Orders;

-- 4c. Montant total le plus élevé
SELECT MAX(total_amount) AS highest_amount
FROM Orders;

-- 4d. Montant total le plus bas
SELECT MIN(total_amount) AS lowest_amount
FROM Orders;

-- 4e. Pour chaque product_id, afficher le nombre de commandes
SELECT 
    product_id,
    COUNT(*) AS number_of_orders
FROM OrderDetails
GROUP BY product_id;

-- 5. Afficher le customer_id qui a plus de 2 commandes
SELECT customer_id
FROM Orders
GROUP BY customer_id
HAVING COUNT(order_id) > 2;

-- 6. Pour chaque mois de l'année 2020, affichez le nombre de commandes
SELECT 
    EXTRACT(YEAR FROM order_date) AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    COUNT(*) AS number_of_orders
FROM Orders
WHERE EXTRACT(YEAR FROM order_date) = 2020
GROUP BY year, month
ORDER BY month;

-- 7. Pour chaque commande, affichez le product_name, le customer_name et la order_date
SELECT 
    p.product_name,
    c.customer_name,
    o.order_date
FROM OrderDetails od
JOIN Orders o ON od.order_id = o.order_id
JOIN Products p ON od.product_id = p.product_id
JOIN Customers c ON o.customer_id = c.customer_id;

-- 8. Afficher toutes les commandes passées il y a trois mois
-- Utilisation d'une syntaxe générique pour la date
SELECT * 
FROM Orders
-- Afficher toutes les commandes passées il y a trois mois
SELECT * 
FROM Orders
WHERE order_date = DATE('now', '-3 months');


-- 9. Afficher les clients (customer_id) qui n'ont jamais commandé de produit
SELECT customer_id
FROM Customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM Orders);
