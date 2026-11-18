# SQL Problem Solving

## Binary Search Tree Node Classification

Given a table `BST` with a node `N` and its parent `P`, classify every node as:

- `Root` — `P` is `NULL`
- `Inner` — the node also appears as a parent in another row
- `Leaf` — the node does not appear as a parent in any other row

The following query creates a sample database and table, inserts the nodes, and prints each node and its type:

```sql
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
```

### How the method works

1. **Find the root:** A root has no parent, so `P IS NULL` identifies it. The sample root is `5`.
2. **Find inner nodes:** An inner node is the parent of at least one other node. Check whether `N` appears in the subquery `SELECT P FROM BST`.
3. **Find leaf nodes:** Nodes that are neither a root nor an inner node are leaves.
4. **Sort the result:** `ORDER BY N ASC` prints the nodes in ascending value order.

For the supplied data, the subquery finds parents `2`, `5`, and `8`, producing:

| N | P | node_type |
|---|---|---|
| 1 | 2 | 1 Leaf |
| 2 | 5 | 2 Inner |
| 3 | 2 | 3 Leaf |
| 5 | NULL | 5 Root |
| 6 | 8 | 6 Leaf |
| 8 | 5 | 8 Inner |
| 9 | 8 | 9 Leaf |

## Company Hierarchy Counts

Count the distinct lead managers, senior managers, managers, and employees for each company, while retaining companies with no matching hierarchy rows. `COUNT(DISTINCT ...)` handles duplicate records and prevents inflated counts from the multiplication of rows across the one-to-many joins. The final `ORDER BY` sorts the company codes lexicographically as strings.

The complete schema, sample data, and query are in [`company_hierarchy_counts.sql`](company_hierarchy_counts.sql). For this sample, company `C3` has zero counts, and the `C10` rows are excluded because `C10` is not present in `Company`.
