-- INDEX索引：加速查詢、無法修改
SHOW INDEX FROM employee;
SHOW INDEX FROM emp1;

CREATE INDEX ename_idx ON employee(ename);
SHOW INDEX FROM employee;

DROP INDEX ename_idx ON employee;
SHOW INDEX FROM employee;