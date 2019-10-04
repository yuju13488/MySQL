-- DML(INSERT, UPDATE, DELETE)
-- 預設auto-commit：立即UPDATE DB
-- DML需同步成敗，避免DB資料不一致（關閉auto-commit）
-- --------------------------------------------------

-- Explicit Transaction
START TRANSACTION; -- 須設定交易開始與結束
	INSERT INTO department VALUES(601,'RD',1001);
	INSERT INTO department VALUES(602,'IT',NULL);
	SELECT * FROM department;
ROLLBACK; -- 設定結束交易：駁回輸入
	SELECT * FROM department;

START TRANSACTION; -- 須設定交易開始與結束
	INSERT INTO department VALUES(601,'RD',1001);
	INSERT INTO department VALUES(602,'IT',NULL);
	SELECT * FROM department;
COMMIT; -- 設定結束交易：確認輸入
	SELECT * FROM department;

-- Implicit Transaction
SET AutoCommit=0; -- 啟動
	INSERT INTO department VALUES(603,'RD',1001);
	INSERT INTO department VALUES(604,'IT',NULL);
	SELECT * FROM department;
ROLLBACK; -- 設定結束交易：駁回輸入
	SELECT * FROM department;

	INSERT INTO department VALUES(605,'RD',1001);
	INSERT INTO department VALUES(606,'IT',NULL);
	SELECT * FROM department;
COMMIT; -- 設定結束交易：確認輸入
	SELECT * FROM department;
SET AutoCommit=1; -- 關閉

-- Savepoint
BEGIN;
	SELECT empno,ename,salary
		FROM employee
		WHERE empno IN (1001,1002,1003);
	UPDATE employee SET salary=60000 WHERE empno=1001;
SAVEPOINT A; -- 設定交易儲存點
	UPDATE employee SET salary=40000 WHERE empno=1002;
SAVEPOINT B; -- 設定交易儲存點
	UPDATE employee SET salary=80000 WHERE empno=1003;
ROLLBACK TO A; -- 回到指定儲存點，並將儲存點後產生的暫存遺棄；若省略A遺棄全部紀錄
-- RELEASE SAVEPOINT n; 移除交易儲存點
COMMIT; -- 將會移除交易儲存點，永久改變DB
	SELECT empno,ename,salary
		FROM employee
		WHERE empno IN (1001,1002,1003);
    
-- Lock另一個connect的交易在先開始的交易（下方）未完成（commit）前，無法進行更新
BEGIN;
	SELECT salary
		FROM employee
		WHERE empno=1001;
	UPDATE employee SET salary=60001 WHERE empno=1001;
COMMIT;