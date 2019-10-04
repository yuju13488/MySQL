CREATE TABLE emp1(
	-- column-level
	empno		decimal(4)		PRIMARY KEY,
    ename		varchar(30)		NOT NULL,
    hiredate	date			NOT NULL,
    email		varchar(30)		UNIQUE, -- UNIQUE可為NULL
    salary		int				NOT NULL,
    deptno		decimal			NOT NULL,
    title		varchar(20)		NOT NULL DEFAULT 'engineer',
    -- table-level
    CONSTRAINT emp_deptno_fk FOREIGN KEY(deptno) -- FOREIGN KEY只在table-level
		REFERENCES department(deptno)
    ); -- FK與對應PK欄位數量、資料型態與大小「完全」相同，但名稱可不相同
SELECT * FROM emp1;
SELECT * FROM dept;
DROP TABLE emp1;
    
INSERT INTO dept
	VALUES (600,'Public Relations',DEFAULT);
UPDATE dept
	SET cityno=DEFAULT -- DEFAULT在設計表格時已給101
	WHERE deptno=500;
SELECT * FROM dept;

-- foreign key error
INSERT INTO emp1
VALUES (1001,'孫悟空','2013/11/10','shiyoo123@hotmail.com','56000',100,'senior engineer');
-- Cannot add or update a child row: a foreign key constraint fails (`db01`.`emp1`, CONSTRAINT `emp_deptno_fk` FOREIGN KEY (`deptno`) REFERENCES `department` (`deptno`))

-- 修改表格設計：右鍵Alter Table
ALTER TABLE `db01`.`emp1` 
DROP FOREIGN KEY `emp_deptno_fk`;
ALTER TABLE `db01`.`emp1` 
ADD CONSTRAINT `emp_deptno_fk`
  FOREIGN KEY (`deptno`)
  REFERENCES `db01`.`department` (`deptno`)
  ON DELETE CASCADE
  ON UPDATE CASCADE;

ALTER TABLE `db01`.`emp1` 
DROP FOREIGN KEY `emp_deptno_fk`;
ALTER TABLE `db01`.`emp1` 
;
ALTER TABLE `db01`.`emp1` RENAME INDEX `emp_deptno_fk` TO `emp_deptno_fk_idx`;
ALTER TABLE `db01`.`emp1` ALTER INDEX `emp_deptno_fk_idx` VISIBLE;
ALTER TABLE `db01`.`emp1` 
ADD CONSTRAINT `emp_deptno_fk` -- 設置在child table
  FOREIGN KEY (`deptno`)
  REFERENCES `db01`.`department` (`deptno`)
  ON UPDATE CASCADE; -- 只能修改parent table影響child table
  
DELETE FROM department WHERE deptno=200;

-- AUTO_INCREMENT（屬性）
CREATE TABLE mem(
	memno	INT				PRIMARY KEY AUTO_INCREMENT,
    mname	VARCHAR(30)		NOT NULL); -- 初始值1
INSERT INTO mem(mname)
VALUES ('David Ho'),('Maria Wang'),('Pam Pan'),('Tina Lee'),('Jean Tsao');
SELECT LAST_INSERT_ID;
INSERT INTO mem(mname) VALUES ('David Ho');
SELECT * FROM mem;
DROP TABLE mem;

CREATE TABLE mem(
	memno	INT				PRIMARY KEY AUTO_INCREMENT,
    mname	VARCHAR(30)		NOT NULL)
    AUTO_INCREMENT = 100; -- 初始值
INSERT INTO mem(mname)
VALUES ('David Ho'),('Maria Wang'),('Pam Pan'),('Tina Lee'),('Jean Tsao');
INSERT INTO mem(mname) VALUES ('David Ho');
SELECT * FROM mem;
DROP TABLE mem;