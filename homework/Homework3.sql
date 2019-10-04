SELECT f.`name`,f.placeid,p.`name`,f.price
	FROM food f,place p
    WHERE f.placeid=p.id; #查詢所有食物名稱、產地編號、產地名稱和價格
SELECT f.`name`,p.`name`,
	concat(f.`name`,' ',p.`name`) AS 'Food Name & Place'
	FROM food f,place p
    WHERE f.placeid=p.id; #查詢所有食物名稱和產地名稱，並串接成一個字串，中間以空白隔開，並將表頭重新命為'Food name & place'
SELECT f.`name`,p.`name`,f.price
	FROM food f,place p
    WHERE f.placeid=p.id
	AND p.`name` LIKE '台灣'; #查詢所有'台灣'生產的食物名稱和價格
SELECT f.`name`,p.`name`,f.price
	FROM food f,place p
    WHERE f.placeid=p.id
	AND p.`name` LIKE '台灣'
    OR p.`name` LIKE '日本'
    ORDER BY f.price DESC; #查詢所有'台灣'和'日本'生產的食物名稱和價格，並以價格做降冪排序
SELECT f.`name`,p.`name`,f.price
	FROM food f,place p
    WHERE f.placeid=p.id
	AND p.`name` LIKE '台灣'
    ORDER BY f.price DESC
    LIMIT 3; #查詢前三個價格最高且'台灣'生產的食物名稱、到期日和價格，並以價格做降冪排序
SELECT p.`name`,
	round(AVG(price)) 'AVG',
	round(SUM(price)) 'SUM',
	round(MAX(price)) 'MAX',
    round(MIN(price)) 'MIN'
    FROM food f,place p
    WHERE f.placeid=p.id
    GROUP BY p.`name`; #查詢每個產地(顯示產地名稱)最高、最低、加總和平均價格，表頭分別命名為'Max'、'Min'、'Sum'和'Avg'，結果皆以四捨五入的整數來顯示
SELECT p.`name`,f.catalog,
	COUNT(f.catalog) AS 'COUNT'
    FROM food f,place p
    WHERE f.placeid=p.id
    GROUP BY p.`name`,f.catalog; #查詢不同產地(顯示產地名稱)和每個種類的食物數量

