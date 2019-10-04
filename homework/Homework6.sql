-- 1.使用food和place資料表的食物編號、食物名稱、到期日、產地名稱和價格來建立一個View名為food_vw；並使用food_vw來查詢所有資料
CREATE VIEW food_vw (id,`name`,expiredate,place,price)
    AS SELECT f.id,f.`name`, f.expiredate, p.`name`,f.price
		FROM food f,place p
		WHERE f.placeid=p.id;
SELECT * FROM food_vw;

-- 2.新建一個View名為place_vw，欄位為每個產地最低價格、最高價格和平均價格
CREATE VIEW place_vw (`name` , `min` , `max` , `avg`)
    AS SELECT p.`name`, MIN(f.price), MAX(f.price),round(AVG(f.price))
		FROM food f,place p
		WHERE f.placeid=p.id
		GROUP BY p.`name`;
SELECT * FROM place_vw;

-- 3.新建一個View名為food_dessert_vw，有food資料表所有欄位，包含種類為'點心'的資料
CREATE VIEW food_dessert_vw
	AS SELECT *
		FROM food
		WHERE catalog='點心';
SELECT * FROM food_dessert_vw;

-- 4.使用food_dessert_vw去修改'太陽餅'的價格
UPDATE food_dessert_vw
	SET price=200 WHERE `name`='太陽餅';
SET SQL_SAFE_UPDATES=0; -- 關閉安全狀態
SET SQL_SAFE_UPDATES=1;
DROP VIEW food_dessert_vw;