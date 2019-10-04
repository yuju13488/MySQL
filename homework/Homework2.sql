INSERT INTO food VALUES ('CK001', '曲奇餅乾', '2021/01/10', 'TL', 250, '點心');
INSERT INTO food VALUES ('CK002', '蘇打餅乾', '2020/10/12', 'TW', 80, '點心');
INSERT INTO food VALUES ('DK001', '高山茶', '2021/05/23', 'TW', 780, '飲料');
INSERT INTO food VALUES ('DK002', '綠茶', '2020/06/11', 'JP', 530, '飲料');
INSERT INTO food VALUES ('OL001', '苦茶油', '2022/03/16', 'TW', 360, '調味品');
INSERT INTO food VALUES ('OL002', '橄欖油', '2021/07/25', 'TL', 420, '調味品');
INSERT INTO food VALUES ('CK003', '仙貝', '2020/11/01', 'JP', 270, '點心');
INSERT INTO food VALUES ('SG001', '醬油', '2022/05/05', 'JP', 260, '調味品');
INSERT INTO food VALUES ('OL003', '葡萄子油', '2022/05/05', 'JP', 550, '調味品');
INSERT INTO food VALUES ('CK004', '鳳梨酥', '2020/10/12', 'TW', 340, '點心');
INSERT INTO food VALUES ('CK005', '太陽餅', '2020/08/27', 'TW', 150, '點心');
INSERT INTO food VALUES ('DK003', '紅茶', '2022/11/12', 'TL', 260, '飲料');
INSERT INTO food VALUES ('SG002', '醋', '2021/09/18', 'TW', 60, '調味品');
INSERT INTO food VALUES ('SG003', '米酒', '2018/11/18', 'TW', 30, '調味品');

INSERT INTO place VALUES ('TW', '台灣');
INSERT INTO place VALUES ('JP', '日本');
INSERT INTO place VALUES ('TL', '泰國');
INSERT INTO place VALUES ('US', '美國');

SELECT * FROM food; #查詢所有食物表格中所有欄位的資料
SELECT `name`,expiredate,price FROM food; #查詢所有食物名稱、到期日和價格
SELECT `name` AS '名稱',expiredate AS '到期日',price AS '價格' FROM food; #查詢所有食物名稱、到期日和價格，並將表頭重新命為'名稱'、'到期日'和'價格'
SELECT DISTINCT catalog FROM food; #查詢所有食物的種類有哪些？(重覆的資料只顯示一次)
SELECT concat(`name`, ' ', catalog) AS 'Food name & catalog' FROM food; #查詢所有食物名稱和種類，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & catalog'

-- WHERE子句
SELECT `name`,price FROM food WHERE price>400; #查詢所有食物價格超過400的食物名稱和價格
SELECT `name`,price FROM food WHERE 250<price AND price<530; #查詢所有食物價格介於250~530之間的食物名稱和價格
SELECT `name`,price FROM food WHERE 250>price OR price>530; #查詢所有食物價格不介於250~530之間的食物名稱和價格
SELECT `name`,price FROM food WHERE catalog LIKE '點心'; #查詢所有食物種類為'點心'的食物名稱和價格
SELECT `name`,price,catalog 
	FROM food WHERE catalog LIKE '點心' OR catalog LIKE '飲料'; #查詢所有食物種類為'點心'和'飲料'的食物名稱、價格和種類
SELECT `name`,price 
	FROM food WHERE placeid LIKE 'TW' OR placeid LIKE 'JP'; #查詢所有食物產地為'TW'和'JP'的食物名稱和價格
SELECT `name`,expiredate,price
	FROM food WHERE `name` LIKE '%油%'; #查詢所有食物名稱有'油'字的食物名稱、到期日和價格
SELECT `name`,expiredate,price
	FROM food WHERE YEAR(expiredate)<2021; #查詢所有食物到期日在2020底以前到期的食物名稱和價格
SELECT `name`,expiredate,price
	FROM food WHERE expiredate<20210601; #查詢所有食物到期日在2021年6月底以前到期的食物名稱和價格
SELECT `name`,expiredate,price
	FROM food WHERE DATEDIFF(NOW(),expiredate)<1; #查詢所有食物1年內到期的食物名稱和價格

-- ORDER BY子句
SELECT `name`,expiredate,price
	FROM food ORDER BY price DESC; #查詢所有食物名稱、到期日和價格，並以價格做降冪排序
SELECT `name`,expiredate,price
	FROM food ORDER BY price DESC LIMIT 3; #查詢前三個價格最高的食物名稱、到期日和價格，並以價格做降冪排序
SELECT `name`,price,catalog
	FROM food WHERE price <= 250 AND catalog
    LIKE '點心' ORDER BY price; #查詢種類為'點心'且價格低於等於250的食物名稱和價格，並以價格做升冪排序
SELECT `name`,price,round(price*1.05) 'New Price' FROM food; #顯示所有食物名稱、價格和增加5%且四捨五入為整數後的價格，新價格並將表頭命名為'New Price'
SELECT `name`,price,round(price*1.05) 'New Price',round(price*0.05) 'Increase' FROM food; #接續上題，再增加一個表頭命名為'Increase'，顯示New price減去price的值
SELECT id,`name`,price,
	CASE
		WHEN price > 501 THEN FLOOR(price*1.03)
        WHEN price > 251 AND price <= 500 THEN FLOOR(price*1.05)
        WHEN price <= 250 THEN FLOOR(price*1.08)
		ELSE 'E'
    END 'New Price'
FROM food; #顯示所有食物名稱、價格和整數後的價格，新價格並將表頭命名為'New Price'；按價格分250以下、251~500和501以上三種分別增加8%,5%和3%且價格無條件捨去成整數
SELECT `name`,catalog,
	CASE
		WHEN DATEDIFF(expiredate,now()) > 0 THEN DATEDIFF(expiredate,now())
		ELSE DATEDIFF(expiredate,now())
    END AS 'Days Of Expired',
    CASE
		WHEN DATEDIFF(expiredate,now()) > 0 THEN '未過期'
        ELSE '已過期'
	END AS 'Expired Or Not'
FROM food; #查詢所有食物名稱、種類、距離今天尚有幾天到期(正數表示)或已過期幾天(負數表示)和註記(有'已過期'或'未過期'兩種)，並將後兩者表頭分別命名為'Days of expired'和'expired or not'
SELECT `name`,catalog,
	CASE
		WHEN DATEDIFF(expiredate,now()) > 0 THEN DATEDIFF(expiredate,now())
		ELSE DATEDIFF(expiredate,now())
    END AS 'Days Of Expired',
    CASE
		WHEN DATEDIFF(expiredate,now()) > 0 THEN '未過期'
        ELSE '已過期'
	END AS 'Expired Or Not'
FROM food ORDER BY DATEDIFF(expiredate,now()) asc; #接續上題，並以過期天數做升冪排序

-- GROUP BY & HAVING子句
SELECT round(AVG(price)) 'AVG',
	round(SUM(price)) 'SUM',
	round(MAX(price)) 'MAX',
    round(MIN(price)) 'MIN' FROM food; #查詢所有食物最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
SELECT catalog,round(AVG(price)) 'AVG',
	SUM(price) 'SUM',
	MAX(price) 'MAX',
    MIN(price) 'MIN' FROM food
    GROUP BY catalog; #接續上題，查詢每個種類
SELECT catalog,round(AVG(price)) 'AVG',
	SUM(price) 'SUM',
	MAX(price) 'MAX',
    MIN(price) 'MIN' FROM food
    GROUP BY catalog
    HAVING AVG(price) > 300
    ORDER BY AVG(price) DESC; #接續上題，查詢每個種類且平均價格超過300，並以平均價格做降冪排序
SELECT catalog,COUNT(`name`) AS 'COUNT'
	FROM food
    GROUP BY catalog; #顯示查詢每個種類的食物數量
SELECT catalog,placeid,COUNT(`name`) AS 'COUNT'
	FROM food
    GROUP BY catalog,placeid; #查詢不同產地和每個種類的食物數量