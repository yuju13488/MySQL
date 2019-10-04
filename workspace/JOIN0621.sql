-- JOIN（屬性必須相同）
-- CROSS JOIN
SELECT ename,dname FROM emp CROSS JOIN dept;

-- EQUAL JOIN
SELECT ename,emp.ename,dept.dname -- 須加表格名稱
	FROM emp,dept
    WHERE emp.deptno=dept.deptno; -- 欄位名稱不同仍能使用
    
-- ANSI JOIN
SELECT ename,emp.deptno,dept.dname -- 須加表格名稱
	FROM emp JOIN dept
    ON emp.deptno=dept.deptno; -- 欄位名稱不同仍能使用

-- USING JOIN
SELECT ename,emp.deptno,dname
	FROM emp JOIN dept
    USING (deptno); -- 條件：跨表格欄位必須有相同的
    
-- NATURAL JOIN
SELECT ename,emp.deptno,dname
	FROM emp NATURAL JOIN dept; -- 條件：跨表格欄位必須有相同的
    
-- AND
SELECT ename,emp.ename,dept.dname -- 須加表格名稱
	FROM emp,dept
    WHERE emp.deptno=dept.deptno
		AND title='manager';
SELECT ename,emp.deptno,dept.dname -- 須加表格名稱
	FROM emp JOIN dept
    ON emp.deptno=dept.deptno
    WHERE emp.deptno=dept.deptno
		AND title='manager';
        
-- 縮寫Alias（無法用單引號）
SELECT e.ename,e.ename,d.dname
	FROM emp e,dept d
    WHERE e.deptno=d.deptno; -- 必須使用縮寫
SELECT e.ename,e.deptno,d.dname
	FROM emp e JOIN dept d
    ON e.deptno=d.deptno;
    
-- N-1個JOIN
SELECT e.ename,d.dname,c.cname
	FROM emp e,dept d,city c
    WHERE e.deptno=d.deptno
    AND d.cityno=c.cityno;
SELECT e.ename,d.dname,c.cname
	FROM emp e JOIN dept d -- ANSI JOIN一次只能JOIN一表格並附加ON一條件
    ON e.deptno=d.deptno
    JOIN city c -- JOIN第三個表格
    ON d.cityno=c.cityno; -- 再附加條件
    
-- NON-EQUAL JOIN
SELECT e.ename,d.dname,e.salary,g.level
	FROM emp e,dept d,grade g
    WHERE e.deptno=d.deptno -- 加入EQUAL JOIN條件
    AND e.salary between g.lowest AND g.highest;
    
-- OUTER JOIN尋找有誤資料（若有foreign key可阻擋資料消失或不一致）
SELECT e.ename,e.deptno,d.dname
	FROM emp e
    LEFT JOIN dept d -- 省略OUTER
    ON e.deptno=d.deptno;
SELECT e.ename,d.deptno,d.dname -- 與下方例子相同結果，互換表格方向改變LIFT or RIGHT
	FROM dept d
    LEFT JOIN emp e
    ON e.deptno=d.deptno;
SELECT e.ename,d.deptno,d.dname -- 編號要改為dept的
	FROM emp e
    RIGHT JOIN dept d
    ON e.deptno=d.deptno;
SELECT e.ename,e.deptno,d.dname
	FROM emp e
    LEFT JOIN dept d
    ON e.deptno=d.deptno
UNION -- 結合LEFT OUTER JOIN和RIGHT OUTER JOIN
SELECT e.ename,d.deptno,d.dname
	FROM emp e
    RIGHT JOIN dept d
    ON e.deptno=d.deptno;
    
-- SELF JOIN
SELECT worker.ename '員工',manager.ename '主管'
	FROM emp worker,emp manager -- 同表格JOIN必須要有綽號
    WHERE worker.mgrno=manager.empno;