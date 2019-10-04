SELECT * FROM department;
INSERT INTO department(deptno,dname,mgrno)
	VALUES (400,'Research',1001);
INSERT INTO department
	VALUES (500,'Personnel',1001);
INSERT INTO department(deptno,dname)
	VALUES (601,'IT');
INSERT INTO department
	VALUES (602,'IT',NULL);
INSERT INTO department(deptno,dname,mgrno)
	VALUES (603,'HRD',1003),(604,'STK',NULL);

SELECT * FROM employee;
INSERT INTO employee
	VALUES (1009,'孫悟空','2013/11/10',56000,100,'senior engineer');
INSERT INTO employee
	VALUES (1010,'李大文',CURDATE(),89000,200,'manager'); -- 當前日期

CREATE TABLE emp_copy LIKE employee;
INSERT INTO emp_copy SELECT * FROM employee;
SELECT * FROM emp_copy;

-- COPY
CREATE TABLE emp_copy1 LIKE employee;
ALTER TABLE emp_copy1 DROP title;
ALTER TABLE emp_copy1 CHANGE empno empid decimal(4);
INSERT INTO emp_copy1 (empid,ename,deptno,hiredate,salary)
	SELECT empno,ename,deptno,hiredate,salary
	FROM employee
	WHERE title NOT LIKE '%SA%';
SELECT * FROM emp_copy1;

-- 更新
UPDATE emp_copy
	SET salary=45000
	WHERE empno=1008;
UPDATE emp_copy
	SET hiredate=curdate(); -- 沒條件式會阻擋防呆
SET SQL_SAFE_UPDATES=0; -- 關閉安全狀態
SET SQL_SAFE_UPDATES=1; -- 開啟安全狀態
-- --------------------------------------------------------
UPDATE emp_copy
	SET salary = (SELECT salary FROM (SELECT * FROM emp_copy) e WHERE empno=1006)
	WHERE empno=1007; -- 不允許欲更新表格使用該表格內容更新，須將FROM子句以別名子句取代
-- --------------------------------------------------------
UPDATE emp_copy
	SET deptno = (SELECT deptno FROM employee WHERE empno=1003)
	WHERE salary = (SELECT salary FROM employee WHERE empno=1003);

-- DELETE
DELETE FROM emp_copy WHERE empno=1007;
DELETE FROM emp_copy1; -- 安全機制
DELETE FROM department
	WHERE deptno BETWEEN 601 AND 604;
DELETE FROM emp_copy
	WHERE deptno = (SELECT deptno FROM department WHERE dname='Accounting');
TRUNCATE  db01.emp_copy;
TRUNCATE  db01.emp_copy1;