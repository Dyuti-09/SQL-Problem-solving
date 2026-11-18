CREATE DATABASE hackathon;

CREATE TABLE BST (
    N INT,
    P INT
);

INSERT INTO BST (N, P)
VALUES
    (1, 2),
    (3, 2),
    (6, 8),
    (9, 8),
    (2, 5),
    (8, 5),
    (5, NULL);

SELECT
    N,
    P,
    CASE
        WHEN P IS NULL THEN CONCAT(N, ' Root')
        WHEN N IN (SELECT P FROM BST) THEN CONCAT(N, ' Inner')
        ELSE CONCAT(N, ' Leaf')
    END AS node_type
FROM BST
ORDER BY N ASC;
