SELECT * FROM food;
SELECT * FROM place;
-- 1.以不列舉欄位的方式新增一筆食物資料
INSERT INTO food
	VALUES ('DK004', '檸檬紅茶', '2019/06/10', 'TW', 20, '飲料');

-- 2.以列舉欄位的方式新增一筆食物資料
INSERT INTO food (id,`name`,expiredate,placeid,price,catalog)
	VALUES ('SG004', '魚露', '2018/06/10', 'TL', 30, '調味品');

-- 3.以不列舉欄位的方式新增多產地資料
INSERT INTO place
	VALUES ('AU','澳洲'),('NZ','紐西蘭');

-- 4.修改一筆食物資料的價格
UPDATE food
	SET price=300
    WHERE id='SG004';

-- 5.按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
UPDATE food SET price = CASE
	WHEN price > 501 THEN FLOOR(price*1.03)
	WHEN price > 251 AND price <= 500 THEN FLOOR(price*1.05)
	WHEN price <= 250 THEN FLOOR(price*1.08)
    ELSE price
    END;
SET SQL_SAFE_UPDATES=0; -- 關閉安全狀態
SET SQL_SAFE_UPDATES=1; -- 開啟安全狀態
-- -----------------------------------------------------------------------------
SELECT `name`,price,
	CASE
		WHEN price > 501 THEN
			(UPDATE food SET price=FLOOR(price*1.03))
        WHEN price > 251 AND price <= 500 THEN
			(UPDATE food SET price=FLOOR(price*1.05))
        WHEN price <= 250 THEN
			(UPDATE food SET price=FLOOR(price*1.08))
		ELSE 'E'
    END 'New Price'
FROM food;

-- 6.刪除一筆食物資料
DELETE FROM food WHERE id='SG004';