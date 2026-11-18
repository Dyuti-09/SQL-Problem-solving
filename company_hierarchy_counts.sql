-- Company hierarchy counts
-- Count distinct codes at each level to avoid over-counting caused by
-- joining multiple one-to-many hierarchy tables together.

CREATE TABLE Company (
    company_code VARCHAR(50),
    founder VARCHAR(50)
);

INSERT INTO Company (company_code, founder)
VALUES
    ('C1', 'A'),
    ('C3', 'C'),
    ('C2', 'B'),
    ('C4', 'D');

CREATE TABLE Lead_Manager (
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(50)
);

INSERT INTO Lead_Manager (lead_manager_code, company_code)
VALUES
    ('LM2', 'C1'),
    ('LM1', 'C10'),
    ('LM4', 'C2'),
    ('LM3', 'C4');

CREATE TABLE Senior_Manager (
    senior_manager_code VARCHAR(10),
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(50)
);

INSERT INTO Senior_Manager (senior_manager_code, lead_manager_code, company_code)
VALUES
    ('SM3', 'LM2', 'C1'),
    ('SM1', 'LM1', 'C10'),
    ('SM3', 'LM4', 'C2'),
    ('SM4', 'LM3', 'C4');

CREATE TABLE Manager (
    manager_code VARCHAR(10),
    senior_manager_code VARCHAR(10),
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(50)
);

INSERT INTO Manager (manager_code, senior_manager_code, lead_manager_code, company_code)
VALUES
    ('M3', 'SM3', 'LM2', 'C1'),
    ('M2', 'SM1', 'LM1', 'C10'),
    ('M1', 'SM3', 'LM4', 'C2'),
    ('M4', 'SM4', 'LM3', 'C4');

CREATE TABLE Employee (
    employee_code VARCHAR(10),
    manager_code VARCHAR(10),
    senior_manager_code VARCHAR(10),
    lead_manager_code VARCHAR(10),
    company_code VARCHAR(50)
);

INSERT INTO Employee (employee_code, manager_code, senior_manager_code, lead_manager_code, company_code)
VALUES
    ('E1', 'M3', 'SM3', 'LM2', 'C1'),
    ('E3', 'M2', 'SM1', 'LM1', 'C10'),
    ('E2', 'M1', 'SM3', 'LM4', 'C2'),
    ('E4', 'M4', 'SM4', 'LM3', 'C4');

SELECT
    c.company_code,
    c.founder,
    COUNT(DISTINCT lm.lead_manager_code) AS total_lead_managers,
    COUNT(DISTINCT sm.senior_manager_code) AS total_senior_managers,
    COUNT(DISTINCT m.manager_code) AS total_managers,
    COUNT(DISTINCT e.employee_code) AS total_employees
FROM Company AS c
LEFT JOIN Lead_Manager AS lm
    ON c.company_code = lm.company_code
LEFT JOIN Senior_Manager AS sm
    ON c.company_code = sm.company_code
LEFT JOIN Manager AS m
    ON c.company_code = m.company_code
LEFT JOIN Employee AS e
    ON c.company_code = e.company_code
GROUP BY
    c.company_code,
    c.founder
ORDER BY c.company_code ASC;

-- Result for the sample data:
-- C1 | A | 1 | 1 | 1 | 1
-- C2 | B | 1 | 1 | 1 | 1
-- C3 | C | 0 | 0 | 0 | 0
-- C4 | D | 1 | 1 | 1 | 1
