-- subquery：SELECT、FROM、WHERE、HAVING
-- subquery->main query

-- subquery WHERE
SELECT salary FROM employee WHERE ename='潘麗珍';
SELECT ename,salary
FROM employee
WHERE salary > (SELECT salary FROM employee WHERE ename='潘麗珍');

SELECT title FROM employee WHERE empno=1002; -- 找出員工編號1002的職稱
SELECT salary FROM employee WHERE empno=1005; -- 找出員工編號1005的薪資
SELECT ename,title,salary
FROM employee
WHERE title = (SELECT title FROM employee WHERE empno=1002) -- 與員工編號1002相同的職稱
AND salary > (SELECT salary FROM employee WHERE empno=1005); -- > 員工編號1005的薪資

-- subquery GROUP BY HAVING
SELECT MIN(salary) FROM employee WHERE deptno=200; -- 先找出部門200中「最低」薪資（單筆）
SELECT deptno,MIN(salary) AS 'MIN salary'
FROM employee
GROUP BY deptno -- 找出各部門中最低薪資
HAVING MIN(salary) > (SELECT MIN(salary) FROM employee WHERE deptno=200); -- 找出各個部門最低薪資比部門代號200最低薪資高的alter

SELECT SUM(salary) FROM employee WHERE deptno=100; -- 計算部門100的薪資總和
SELECT ename,title,salary,
	round(salary*100 / (SELECT SUM(salary) FROM employee WHERE deptno=100),1) AS '%' -- 每人薪資佔總薪資比例*100
FROM employee
WHERE deptno=100;

-- subquery FROM
SELECT SUM(salary) 'total' FROM employee WHERE deptno=100; -- 計算部門100的薪資總和
SELECT ename,title,salary,
	round(salary*100/t.total,1) '%' -- JOIN
FROM employee,(SELECT SUM(salary) 'total' FROM employee WHERE deptno=100) AS t -- 製造薪資總和表格
WHERE deptno=100;

-- round
SELECT round(123456.789,1);
SELECT round(123456.789,-2); -- 從小數點往前省略2位
SELECT round(123456.789,-3);

-- subquery error
SELECT empno,ename
FROM employee
WHERE salary = 
(SELECT MIN(salary) FROM employee GROUP BY deptno); -- GROUP BY後超過1個值無法使用運算比較alter

-- 多筆資料IN（判斷or的狀況不可有NULL值，or NULL=NULL-.false）
SELECT DISTINCT mgrno FROM emp; -- 消除相同的主管編號
SELECT ename
FROM emp
WHERE empno
IN (SELECT DISTINCT mgrno FROM emp);

-- 多筆資料NOT IN
SELECT DISTINCT mgrno FROM emp WHERE mgrno IS NOT NULL; -- 篩選非NULL主管編號
SELECT ename
FROM emp
WHERE empno
NOT IN (SELECT DISTINCT mgrno FROM emp WHERE mgrno IS NOT NULL); -- 非主管員工

-- 多筆資料x<ANY小於最大（至少有一比x大，x<a or x<b or x<c......）、x>ANY大於最小（至少有一比x小，x>a or x>b or x>c......）、=ANY
SELECT salary FROM employee WHERE title='senior engineer'; -- senior engineer薪資
SELECT ename,title,salary
FROM employee
WHERE salary < ANY(SELECT salary FROM employee WHERE title='senior engineer') -- ANY()=(MAX)；薪資低於任意senior engineer
AND title <> 'senior engineer'; -- 不是senior engineer

-- 多筆資料x<ALL小於最小（x<a and x<b and x<c......）、x>ALL大於最大（x>a and x>b and x>c......）
SELECT ename,title,salary
FROM employee
WHERE salary < ALL(SELECT salary FROM employee WHERE title='senior engineer') -- ALL()=(MIN)；薪資低於所有senior engineer
AND title <> 'senior engineer'; -- 不是senior engineer

-- 關聯子查詢，需表格別名（不加單引號）
SELECT SUM(salary) FROM employee WHERE deptno=100;
SELECT e.ename,e.title,e.salary,
round(salary*100/(SELECT SUM(salary) FROM employee WHERE e.deptno=deptno),1) AS '%'
FROM employee e
WHERE e.deptno=100;

SELECT MIN(salary) AS 'MIN' FROM employee GROUP BY deptno; -- 找出各部門最低薪資
SELECT e.ename,e.salary,e.deptno
FROM employee e
WHERE e.salary
IN (SELECT MIN(salary) FROM employee GROUP BY deptno HAVING deptno=e.deptno); -- HAVEING用來限制不同部門
-- 同上
SELECT MIN(salary) FROM employee WHERE deptno;
SELECT e.ename,e.salary,e.deptno
FROM employee e
WHERE e.salary = (SELECT MIN(salary) FROM employee WHERE deptno=e.deptno);

-- 新表格
CREATE TABLE emp100 AS
SELECT empno,ename,salary*12 AS 'AnnualSalary',hiredate -- 必須有別名
FROM employee
WHERE deptno=100;
SELECT * FROM emp100;
