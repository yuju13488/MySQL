 -- SELECT
 -- FROM
 -- WHERE：篩選資料
 -- GROUP BY 分組
	-- HAVING 限制GROUP BY的條件
 -- ORDER BY 排序
 -- LIMIT 限制

 -- IF
SELECT empno,ename,salary,
	salary*IF(salary>=50000,2,1.5) 'bonus' -- IF(條件,成立,不成立)
FROM employee;

 -- CASE,WHEN,THEN,ELSE
SELECT empno,ename,salary,
	CASE
		WHEN salary > 100000 THEN 'A'
        WHEN salary > 70000 THEN 'B' -- =BETWEEN 70000 AND 100000（BETWEEN AND包含頭尾）
        WHEN salary > 50000 THEN 'C' -- =BETWEEN 50000 AND 69999
        WHEN salary > 30000 THEN 'D' -- =BETWEEN 30000 AND 49999
		ELSE 'E'
    END 'Grade'
FROM employee;

 -- DISTINCT
SELECT DISTINCT deptno FROM employee; -- 去除相同值的欄位
SELECT DISTINCT deptno,title FROM employee; -- 去除組合後相同值的欄位

-- WHRER IN, NOT
SELECT * FROM employee WHERE deptno=100; -- *代表全部
SELECT * FROM employee WHERE title='engineer'; -- 字串必須加單引號
SELECT * FROM employee WHERE hiredate='2007/07/06'; -- 日期必須加單引號
SELECT * FROM employee WHERE title IN('manager','engineer'); -- title為兩者之一的
SELECT * FROM employee WHERE title NOT IN('manager','engineer');
SELECT * FROM department WHERE mgrno IS NULL; -- 為NULL值的
SELECT * FROM department WHERE mgrno IS NOT NULL;

 -- WHERE LIKE
SELECT * FROM employee WHERE ename LIKE '林%'; -- 以林當關鍵字找姓林的，%為0~多字元
SELECT * FROM employee WHERE ename LIKE '%生'; -- 以生當關鍵字找名生的
SELECT * FROM employee WHERE ename LIKE '%麗%'; -- 以麗當關鍵字找名麗的
SELECT * FROM employee WHERE ename LIKE '_麗%'; -- 以麗當關鍵字找姓名第二字為麗的，_為1字元
SELECT * FROM employee WHERE title LIKE '%SA\_%'; -- \讓_失去功能，以SA_當關鍵字
SELECT * FROM employee WHERE title LIKE '%SA#_%' ESCAPE '#'; -- 將escape功能改為'#'
SELECT * FROM employee WHERE ename NOT LIKE '林%'; -- 不是姓林的

 -- WHERE AND,OR
SELECT * FROM employee WHERE salary >= 45000 AND ename LIKE '林%'; -- 交集
SELECT * FROM employee WHERE salary >= 45000 OR ename LIKE '林%'; -- 聯集
SELECT empno,ename,salary,
	CASE
		WHEN salary > 100000 THEN 'A'
        WHEN salary >= 70000 AND salary <= 100000 THEN 'B' -- =BETWEEN 70000 AND 100000（BETWEEN AND包含頭尾）
        WHEN salary >= 50000 AND salary < 70000 THEN 'C' -- =BETWEEN 50000 AND 69999
        WHEN salary >= 30000 AND salary < 50000 THEN 'D' -- =BETWEEN 30000 AND 49999
		ELSE 'E'
    END 'Grade'
FROM employee;

 -- ORER BY ASC,DESC
 SELECT * FROM employee ORDER BY salary; -- ASC由小到大（預設）
 SELECT * FROM employee ORDER BY salary DESC; -- 由大到小排序
 SELECT ename,deptno,salary FROM employee ORDER BY deptno, -- 預設的ASC先排
	salary DESC; -- 先排完第一欄相同的再排第二欄
 SELECT ename,salary*12 'Annual' FROM employee ORDER BY Annual; -- 依照別名排序
 SELECT ename,salary*12 'Annual' FROM employee ORDER BY salary*12; -- 依照欄位運算排序
 SELECT ename,deptno,salary FROM employee ORDER BY 3; -- 依照欄位編號排序
 SELECT * FROM employee ORDER BY 3;
 
  -- LIMIT（與其他資料庫寫法皆不同）
 SELECT * FROM employee LIMIT 3; -- 取前三筆資料
 SELECT * FROM employee LIMIT 4,3; -- 「跳過」前四筆資料開始取三筆資料（從第五筆開始取三筆）
 SELECT * FROM employee ORDER BY salary DESC LIMIT 3; -- 取排名前三
 
  -- 集合函數AVG,SUM,COUNT,MAX,MIN
 SELECT COUNT(*) FROM employee; -- 以*取代欄位可避開只取非null的錯誤
 SELECT COUNT(DISTINCT deptno) FROM employee; -- 去除相同值再計算數量
 SELECT AVG(salary) 'AVG',SUM(salary) 'SUM',MAX(salary) 'MAX',MIN(salary) 'MIN' FROM employee; -- 需別名方能放入算式
 SELECT COUNT(mgrno) 'Count' FROM department; -- 計算時不含NULLdepartmentdepartment
 
 -- GROUP BY
 SELECT deptno,COUNT(*) 'COUNT',AVG(salary) 'AVG',SUM(salary) 'SUM',MAX(salary) 'MAX',MIN(salary) 'MIN' FROM employee GROUP BY deptno ORDER BY AVG(salary); -- 以某一欄未為集合分組計算，並以AVG升冪排序
 SELECT deptno,title,SUM(salary) 'SUM' FROM employee GROUP BY deptno,title; -- 多欄位分組
 SELECT deptno,title,SUM(salary) 'SUM' FROM employee GROUP BY deptno,title WITH ROLLUP; -- 每一群組多一列小計
 SELECT deptno,AVG(salary) 'AVG'
	FROM employee
    GROUP BY deptno
    HAVING AVG(salary)>50000;
  -- 1
 SELECT SUM(salary) 'SUM'
	FROM employee
	GROUP BY title;
  -- 2
 SELECT title,SUM(salary) 'SUM'
	FROM employee
	GROUP BY title;
  -- 3
 SELECT title,SUM(salary) 'SUM'
	FROM employee
    WHERE title NOT LIKE '%SA%'
	GROUP BY title;
  -- 4
 SELECT title,SUM(salary) 'SUM'
	FROM employee
    WHERE title NOT LIKE '%SA%'
	GROUP BY title
		HAVING SUM(salary) > 100000
	ORDER BY SUM(salary);