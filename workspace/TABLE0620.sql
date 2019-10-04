CREATE TABLE employee(
	empmo		decimal(4)		PRIMARY KEY,
    ename		varchar(30)		NOT NULL,
    hiredate	date			NOT NULL,
    salary		int				NOT NULL,
    deptno		decimal			NOT NULL,
    title		varchar(20)		NOT NULL
    ); -- column-level
    
CREATE TABLE `db01`.`department` (
  `deptno` DECIMAL(3) NOT NULL,
  `dname` VARCHAR(30) NOT NULL,
  `mgrno` DECIMAL(4) NULL,
  PRIMARY KEY (`deptno`)); -- table-level
  
  SHOW TABLE STATUS IN db01; -- 查看表格狀態
  SHOW TABLES; -- 僅查詢有哪些表格
  DESC employee; -- 查看表格設計
  
   -- ADD,MOFIFY,CHANGE,DROP,RENAME
  DESC t1;
  create table t1(a int not null,b float not null,c char(5) not null);
  ALTER TABLE t1 add (d char(4)); -- 新增欄位在最後面
  ALTER TABLE t1 add e varchar(6) FIRST; -- 新增欄位在最前面
  ALTER TABLE t1 add g varchar(6) AFTER b; -- 插入欄位
  ALTER TABLE t1 modify d char(8); -- 修改欄位屬性
  ALTER TABLE t1 modify g char(4) FIRST; -- 修改欄位屬性並移到第一欄
  ALTER TABLE t1 modify g int AFTER c; -- 修改欄位屬性並插入
  ALTER TABLE t1 change g j int; -- 修改欄位名稱
  ALTER TABLE t1 DROP b; -- 刪除欄位
  ALTER TABLE t1 RENAME t2; -- 更改表格名稱
  DROP TABLE t2; -- 刪除表格
  
  -- AS,SUBSTRING
  SELECT * FROM employee; -- 查詢所有欄位
  SELECT empmo, salary,title FROM employee; -- 查詢所選欄位
  SELECT ename AS '員工姓名', salary*12 AS '年薪' FROM employee; -- 修改別名
  SELECT ename 'employee name', salary*12 'annual salary'; -- 有空白鍵就必須有單引號
  SELECT SUBSTRING(ename,1,1) AS '姓' FROM employee; -- 抓取姓名欄第一個字開始的第一個字
  SELECT SUBSTRING(ename,2) AS '名' FROM employee; -- 抓取姓名欄第二個字開始到最後一個字
  SELECT SUBSTRING('YuJu Hsu',1,4) AS 'yoyo'; -- 從第一個字開始抓到第四個
  SELECT SUBSTRING('YuJu Hsu',6) AS yoyo; -- 從第六個字開始抓到最後一個
  SELECT SUBSTRING('YuJu Hsu',-3) AS yoyo;-- 從倒數第三個字開始抓到最後一個
  
   -- ADDDATE,SUBDATE,YEAR,MONTH,NOW
  SELECT concat(ename, 'is a', title) AS '員工' FROM employee; -- 串接欄位
  select length('我是一隻pig'); -- 中文字1~3bytes
  select char_length('我是一隻pig'); -- 計算字元數
  SELECT hiredate, hiredate + interval 3 month '試用期' FROM employee; -- 增加日期（interval必須）
  SELECT sysdate(); -- 系統時間
  SELECT ADDDATE(sysdate(),interval 5 year); -- 系統時間加五年
  SELECT SUBDATE(sysdate(),interval 3 month); -- 系統時間減三個月
  SELECT hiredate, YEAR(hiredate) AS '年', MONTH(hiredate) AS '月', DAY(hiredate)AS '日' FROM employee; -- AS可省略
  SELECT empmo,ename,DATEDIFF(NOW(),hiredate) div 365 'year' FROM employee; -- 計算年資：先算與現在時間差再除以365取整數
  
   -- DATEDIFF,ROUND
  SELECT ename,ename,
	DATEDIFF(NOW(),hiredate) div 365 'year',
    round(DATEDIFF(NOW(),hiredate) / 365) 'year', -- 四捨五入
    round(DATEDIFF(NOW(),hiredate) / 365,1) 'year' FROM employee;
  SELECT hiredate,
		DATEDIFF(NOW(),hiredate) div 365 '年',
		round((DATEDIFF(NOW(),hiredate) % 365)/30,1) '月'
	FROM employee;
    
    