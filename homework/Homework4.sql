SELECT * FROM food ORDER BY placeid;

-- 1.查詢所有比'鳳梨酥'貴的食物名稱、到期日和價格
SELECT price FROM food WHERE `name`='鳳梨酥';
SELECT `name`,expiredate,price
FROM food
WHERE price > (SELECT price FROM food WHERE `name`='鳳梨酥');

-- 2.查詢所有比'曲奇餅乾'便宜且種類是'點心'的食物名稱、到期日和價格
SELECT price FROM food WHERE `name`='曲奇餅乾';
SELECT catalog FROM food WHERE catalog='點心';
SELECT `name`,expiredate,price
FROM food
WHERE price < ALL(SELECT price FROM food WHERE `name`='曲奇餅乾')
AND catalog = '點心';

-- 3.查詢所有和'鳳梨酥'同一年到期的食物名稱、到期日和價格
SELECT YEAR(expiredate) FROM food WHERE `name`='鳳梨酥';
SELECT `name`,expiredate,price
FROM food
WHERE YEAR(expiredate) = (SELECT YEAR(expiredate) FROM food WHERE `name`='鳳梨酥');

-- 4.查詢所有比平均價格高的食物名稱、到期日和價格
SELECT AVG(price) FROM food;
SELECT `name`,expiredate,price
FROM food
WHERE price > (SELECT AVG(price) FROM food);

-- 5.查詢所有比平均價格低的'台灣'食物名稱、到期日和價格
SELECT f.`name`,expiredate,price
FROM food f,place p
WHERE price < (SELECT AVG(price) FROM food)
AND p.`name`='台灣';

-- 6.查詢所有種類和'仙貝'相同且價格比'仙貝'便宜的食物名稱、到期日和價格
SELECT `name`,expiredate,price
FROM food
WHERE price < (SELECT price FROM food WHERE `name`='仙貝')
AND catalog = (SELECT catalog FROM food WHERE `name`='仙貝');

-- 7.查詢所有產地和'仙貝'相同且保存期限6個月以上的食物名稱、到期日和價格
SELECT `name`,expiredate,price
FROM food
WHERE 180 < DATEDIFF(expiredate,now())
AND placeid = (SELECT placeid FROM food WHERE `name`='仙貝');

-- 8.查詢每個產地價格最低的食物名稱、到期日和價格
SELECT MIN(price) AS 'MIN' FROM food GROUP BY placeid;
SELECT `name`,placeid,expiredate,price
FROM food f
WHERE price
IN (SELECT MIN(price) FROM food GROUP BY placeid HAVING placeid=f.placeid);
-- ------------------------------------------------------------------------------
SELECT `name`,placeid,expiredate,price
FROM food f
WHERE price = (SELECT MIN(price) FROM food WHERE placeid=f.placeid);

-- 9.查詢每個種類的食物價格最高者的食物名稱和價格
SELECT MAX(price) FROM food GROUP BY catalog;
SELECT `name`,catalog,expiredate,price
FROM food f
WHERE price
IN (SELECT MAX(price) FROM food GROUP BY catalog HAVING catalog=f.catalog);

-- 10.查詢所有種類不是'點心'但比種類是'點心'貴的食物名稱、種類和價格，並以價格做降冪排序
SELECT price FROM food WHERE catalog='點心';
SELECT `name`,catalog,price
FROM food
WHERE price > ALL(SELECT price FROM food WHERE catalog='點心')
AND catalog <> '點心'
ORDER BY price DESC;

-- 11.查詢每個產地(顯示產地名稱)的食物價格最高者的食物名稱和價格
SELECT `name`,MAX(price),placeid FROM food GROUP BY placeid;
SELECT `name`'食物名稱',price '價格',placeid '產地'
FROM food f
WHERE price
IN (SELECT MAX(price) FROM food GROUP BY placeid HAVING placeid=f.placeid);
-- -------------------------------------------------------------------
SELECT f.`name`'食物名稱',price '價格',p.`name` '產地'
FROM food f JOIN place p
ON f.placeid=p.id -- JINO使用ON
WHERE price
IN (SELECT MAX(price) FROM food GROUP BY placeid HAVING placeid=f.placeid);