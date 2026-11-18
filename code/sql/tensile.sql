-- Create a table, load data, and query it (SQLite dialect)
CREATE TABLE tensile (
    specimen    TEXT PRIMARY KEY,
    material    TEXT NOT NULL,
    diameter_mm REAL,
    yield_MPa   REAL
);

.import --csv --skip 1 ../data/tensile.csv tensile

-- How many specimens of each material, and their mean strength?
SELECT material,
       COUNT(*)                 AS n,
       ROUND(AVG(yield_MPa), 2) AS mean_MPa,
       MIN(yield_MPa)           AS min_MPa,
       MAX(yield_MPa)           AS max_MPa
FROM tensile
GROUP BY material
ORDER BY mean_MPa DESC;

-- The three strongest specimens, with their yield load in kN
SELECT specimen, material, yield_MPa,
       ROUND(yield_MPa * 3.14159265 * diameter_mm * diameter_mm / 4 / 1000, 2) AS load_kN
FROM tensile
ORDER BY load_kN DESC
LIMIT 3;
