-- VIEW存取指令的邏輯表格
-- 使用SELECT指令，方式如同TABLE（名稱需不同）
-- --------------------------------------------------
CREATE VIEW empvu100 -- 名稱不同於TABLE
	AS SELECT empno,ename,salary -- AS後接SELECR指令
		FROM employee
        WHERE deptno=100; -- VIEW沒有subquery
SELECT * FROM empvu100;

-- VIEW運算式需有別名
CREATE VIEW salvu100
	AS SELECT empno id,ename `name`,salary*12 'Annual'
    FROM employee
    WHERE deptno=100;
SELECT * FROM salvu100;
-- --------------------------------------------------
CREATE VIEW salvu100_1 (id,`name`,Annual) -- column list
	AS SELECT empno,ename,salary*12
	FROM employee
    WHERE deptno=100;
SELECT * FROM salvu100_1;
-- --------------------------------------------------
CREATE VIEW dept_sum_vw (`name` , `min` , `max` , `avg`)
    AS SELECT d.dname, MIN(e.salary), MAX(e.salary),AVG(e.salary)
    FROM employee e,department d
    WHERE e.deptno=d.deptno
    GROUP BY d.dname;
SELECT * FROM dept_sum_vw;

-- 資料維護（僅限最基本VIEW）
UPDATE empvu100
SET ename='沙悟淨' WHERE empno=1009; -- 修改base table資料
SELECT * FROM empvu100;
-- --------------------------------------------------
UPDATE empvu100
SET ename='孫大為' WHERE empno=1003; -- deptno!=100
SELECT * FROM empvu100;
-- --------------------------------------------------
UPDATE empvu100
SET title='SA' WHERE empno=1009; -- VIEW not incluld title
SELECT * FROM empvu100;
-- --------------------------------------------------
DELETE FROM empvu100 WHERE empno=1009;
SELECT * FROM empvu100;

-- WITH CHECK OPTION與WHERE衝突時無法新增、修改
CREATE VIEW emp_sal_vw
    AS SELECT empno,ename,salary
    FROM employee
    WHERE salary <= 40000
WITH CHECK OPTION;
SELECT * FROM emp_sal_vw;
-- --------------------------------------------------
UPDATE emp_sal_vw
SET salary=40001 WHERE empno=1002; -- 被WITH CHECK OPTION擋住，因上WHERE子句限制40000以下

ALTER VIEW emp_sal_vw
    AS SELECT empno,ename,salary
    FROM employee
    WHERE salary <= 50000;
DROP VIEW emp_sal_vw;