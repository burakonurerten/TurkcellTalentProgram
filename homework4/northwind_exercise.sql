
--1. Product isimlerini (`ProductName`) ve birim başına miktar (`QuantityPerUnit`) değerlerini almak için sorgu yazın.

select product_name, quantity_per_unit from products;

--2. Ürün Numaralarını (`ProductID`) ve Product isimlerini (`ProductName`) değerlerini almak için sorgu yazın. Artık satılmayan ürünleri (`Discontinued`) filtreleyiniz.

select product_id, product_name,discontinued from products where discontinued=1;

--3. Durdurulan Ürün Listesini, Ürün kimliği ve ismi (`ProductID`, `ProductName`) değerleriyle almak için bir sorgu yazın.

select product_id, product_name,discontinued from products where discontinued=1;

--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.

select product_id, product_name, unit_price from products where unit_price < 20;

--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (`ProductID`, `ProductName`, `UnitPrice`) almak için bir sorgu yazın.

select product_id, product_name, unit_price from products where unit_price between 15 and 25;

--6. Ürün listesinin (`ProductName`, `UnitsOnOrder`, `UnitsInStock`) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.

select product_name,units_on_order,units_in_stock from products where units_in_stock < units_on_order;

--7. İsmi `a` ile başlayan ürünleri listeleyeniz.

select * from products where product_name like 'A%';

--8. İsmi `i` ile biten ürünleri listeleyeniz.

select * from products where product_name like '%i';

--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.

select product_name,unit_price,unit_price * 1.18 as unit_price_kdv from products;

--10. Fiyatı 30 dan büyük kaç ürün var?

select Count(*) from products where unit_price > 30;

--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele

select Lower(product_name) as product_name from products order by unit_price desc;

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır

select CONCAT(first_name, ' ', last_name) as full_name from employees;

--13. Region alanı NULL olan kaç tedarikçim var?

select Count(*) from suppliers where region is null;

-- 14. Region alanı NULL olmayan kaç tedarikçim var?

select Count(*) from suppliers where region is not null;

--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.

select Upper(CONCAT('TR', product_name)) from products;

--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle

select CONCAT('TR', product_name) as product_name, unit_price from products where unit_price < 20;

--17. En pahalı ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.

select product_name, unit_price from products order by unit_price DESC;

--18. En pahalı 10 ürünün Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.

select product_name, unit_price from products order by unit_price DESC LIMIT 10;

--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (`ProductName` , `UnitPrice`) almak için bir sorgu yazın.

SELECT product_name, unit_price FROM products where unit_price > (select AVG(unit_price) from products);

--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.

SELECT SUM(unit_price * units_in_stock) FROM products;

--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.

SELECT
    (SELECT Count(*) FROM products WHERE discontinued = 0) as "mevcut",
    (SELECT Count(*) FROM products WHERE discontinued = 1) as "durdurulan";

--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.

SELECT c.category_name, p.* FROM products as p JOIN categories as c ON c.category_id = p.category_id;

--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.

SELECT c.category_name, AVG(p.unit_price) FROM products as p
                                                   JOIN categories as c
                                                        ON c.category_id = p.category_id
GROUP by c.category_name;

--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?

SELECT p.product_name, p.unit_price, c.category_name FROM products as p
                                                              JOIN categories as c
                                                                   ON c.category_id = p.category_id
where unit_price= (SELECT max(unit_price) from products);

--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı

SELECT p.product_name, c.category_name, s.company_name FROM products as p
                                                                JOIN categories as c
                                                                     ON c.category_id = p.category_id
                                                                JOIN suppliers as s
                                                                     ON s.supplier_id = p.supplier_id
ORDER BY p.reorder_level DESC
    LIMIT 1;

--26. Stokta bulunmayan ürünlerin ürün listesiyle birlikte tedarikçilerin ismi ve iletişim numarasını (`ProductID`, `ProductName`, `CompanyName`, `Phone`) almak için bir sorgu yazın.

SELECT p.product_id, p.product_name, s.company_name, s.phone, p.units_in_stock FROM products as p
                                                                                        JOIN suppliers as s
                                                                                             ON p.supplier_id = s.supplier_id
WHERE p.units_in_stock = 0;

--27. 1998 yılı mart ayındaki siparişlerimin adresi, siparişi alan çalışanın adı, çalışanın soyadı

SELECT o.ship_address, e.first_name, e.last_name,o.order_date FROM orders as o
                                                                       JOIN employees as e
                                                                            ON o.employee_id = e.employee_id
WHERE o.order_date BETWEEN '1998-03-01' and '1998-03-31';

--28. 1997 yılı şubat ayında kaç siparişim var?

select Count(*) from orders where order_date BETWEEN '1997-02-01' and '1997-02-28';

--29. London şehrinden 1998 yılında kaç siparişim var?

select Count(*) from orders where order_date BETWEEN '1998-01-01' and '1998-12-31' and ship_city = 'London';

--30. 1997 yılında sipariş veren müşterilerimin contactname ve telefon numarası

SELECT c.contact_name, c.phone, o.order_date
FROM customers AS c
         JOIN orders AS o
              ON c.customer_id = o.customer_id
WHERE o.order_date BETWEEN '1997-01-01' AND '1997-12-31';

--31. Taşıma ücreti 40 üzeri olan siparişlerim

SELECT * from orders where freight > 40;

--32. Taşıma ücreti 40 ve üzeri olan siparişlerimin şehri, müşterisinin adı

SELECT o.ship_city, c.contact_name, o.freight FROM customers as c
                                                       JOIN orders as o
                                                            on c.customer_id = o.customer_id
where o.freight > 40;

--33. 1997 yılında verilen siparişlerin tarihi, şehri, çalışan adı -soyadı ( ad soyad birleşik olacak ve büyük harf),

SELECT o.order_date, o.ship_city, Upper(Concat(e.first_name,e.last_name)) as full_name from orders as o
                                                                                                JOIN employees as e
                                                                                                     ON o.employee_id = e.employee_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1997;

--34. 1997 yılında sipariş veren müşterilerin contactname i, ve telefon numaraları ( telefon formatı 2223322 gibi olmalı )

SELECT o.order_date, c.contact_name, TRANSLATE(phone, '() -.', '') as phone From orders as o
                                                                                     Join customers as c
                                                                                          on o.customer_id = c.customer_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1997;

--35. Sipariş tarihi, müşteri contact name, çalışan ad, çalışan soyad

SELECT o.order_date, c.contact_name, e.first_name,e.last_name From orders as o
                                                                       Join customers as c
                                                                            on o.customer_id = c.customer_id
                                                                       join employees as e
                                                                            on o.employee_id = e.employee_id;

--36. Geciken siparişlerim?

Select * from orders where shipped_date > required_date;

--37. Geciken siparişlerimin tarihi, müşterisinin adı

select o.order_date, c.contact_name from orders as o
                                             Join customers as c
                                                  on o.customer_id = c.customer_id
where shipped_date > required_date;

--38. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi

SELECT p.product_name, c.category_name, od.quantity
FROM order_details AS od
         JOIN products AS p
              ON p.product_id = od.product_id
         JOIN categories AS c
              ON c.category_id = p.category_id
WHERE od.order_id = 10248;

--39. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı

Select p.product_name, s.company_name, od.order_id FROM order_details as od
                                                            JOIN products as p ON p.product_id = od.product_id
                                                            join suppliers as s ON s.supplier_id = p.supplier_id
where od.order_id = 10248;

--40. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti

SELECT e.employee_id, p.product_name, o.order_date, od.quantity FROM employees AS e
                                                                         JOIN orders AS o
                                                                              ON e.employee_id = o.employee_id
                                                                         JOIN order_details AS od
                                                                              ON o.order_id = od.order_id
                                                                         JOIN products AS p
                                                                              ON p.product_id = od.product_id
WHERE e.employee_id = 3 AND EXTRACT(YEAR FROM o.order_date) = 1997;

--41. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad

SELECT e.employee_id, e.first_name, e.last_name, od.quantity FROM employees AS e
                                                                      JOIN orders AS o
                                                                           ON e.employee_id = o.employee_id
                                                                      JOIN order_details AS od
                                                                           ON o.order_id = od.order_id
                                                                      JOIN products AS p
                                                                           ON p.product_id = od.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1997 order by od.quantity desc limit 1;

--42. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****

SELECT e.employee_id, e.first_name, e.last_name, SUM(od.quantity) AS total_quantity
FROM employees AS e
         JOIN orders AS o ON e.employee_id = o.employee_id
         JOIN order_details AS od ON o.order_id = od.order_id
         JOIN products AS p ON p.product_id = od.product_id
WHERE EXTRACT(YEAR FROM o.order_date) = 1997
GROUP BY e.employee_id
ORDER BY total_quantity DESC limit 1;

--43. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?

Select c.category_name, p.product_name, p.unit_price from products as p
                                                              join categories as c
                                                                   on p.category_id = c.category_id
where unit_price=(select max(unit_price) from products);

--44. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre

SELECT o.order_id, e.first_name, e.last_name,  o.order_date from orders as o
                                                                     join employees as e
                                                                          on o.employee_id = e.employee_id
order by order_date;

--45. SON 5 siparişimin ortalama fiyatı ve orderid nedir?

Select AVG(od.unit_price * od.quantity) as total_price, od.order_id, o.order_date from order_details as od
                                                                                           join orders as o
                                                                                                on o.order_id = od.order_id
group by od.order_id,o.order_date
order by o.order_date desc LIMIT 5;

--46. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?

SELECT c.category_name, p.product_name, SUM(od.quantity) AS total_quantity
FROM orders AS o
         JOIN order_details AS od ON o.order_id = od.order_id
         JOIN products AS p ON od.product_id = p.product_id
         JOIN categories AS c ON p.category_id = c.category_id
WHERE EXTRACT(MONTH FROM o.order_date) = 1
GROUP BY c.category_name, p.product_name;

--47. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?

SELECT p.product_name, o.order_id
FROM order_details AS od
         JOIN products AS p
              ON p.product_id = od.product_id
         JOIN orders AS o
              ON o.order_id = od.order_id
WHERE (SELECT AVG(quantity) FROM order_details WHERE order_id = o.order_id) > od.quantity;

--48. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı

SELECT SUM(od.quantity) AS total_quantity, c.category_name, s.company_name
FROM order_details AS od
         JOIN products AS p ON p.product_id = od.product_id
         JOIN orders AS o ON o.order_id = od.order_id
         JOIN categories AS c ON c.category_id = p.category_id
         JOIN suppliers AS s ON p.supplier_id = s.supplier_id
GROUP BY s.company_name, c.category_name;

--49. Kaç ülkeden müşterim var

SELECT COUNT(DISTINCT country) FROM customers;

--50. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?

SELECT e.employee_id, SUM(od.quantity) AS total_quantity
FROM order_details AS od
         JOIN orders AS o ON o.order_id = od.order_id
         JOIN employees AS e ON e.employee_id = o.employee_id
WHERE EXTRACT(YEAR FROM o.order_date) < EXTRACT(YEAR FROM CURRENT_DATE) and e.employee_id = 3
GROUP BY e.employee_id;

--------------------------------------Sorular Aynı----------------------------------------

--51. 10248 nolu siparişte satılan ürünlerin adı, kategorisinin adı, adedi
--52. 10248 nolu siparişin ürünlerinin adı , tedarikçi adı
--53. 3 numaralı ID ye sahip çalışanın 1997 yılında sattığı ürünlerin adı ve adeti
--54. 1997 yılında bir defasinda en çok satış yapan çalışanımın ID,Ad soyad
--55. 1997 yılında en çok satış yapan çalışanımın ID,Ad soyad ****
--56. En pahalı ürünümün adı,fiyatı ve kategorisin adı nedir?
--57. Siparişi alan personelin adı,soyadı, sipariş tarihi, sipariş ID. Sıralama sipariş tarihine göre
--58. SON 5 siparişimin ortalama fiyatı ve orderid nedir?
--59. Ocak ayında satılan ürünlerimin adı ve kategorisinin adı ve toplam satış miktarı nedir?
--60. Ortalama satış miktarımın üzerindeki satışlarım nelerdir?
--61. En çok satılan ürünümün(adet bazında) adı, kategorisinin adı ve tedarikçisinin adı
--62. Kaç ülkeden müşterim var
--63. Hangi ülkeden kaç müşterimiz var
--64. 3 numaralı ID ye sahip çalışan (employee) son Ocak ayından BUGÜNE toplamda ne kadarlık ürün sattı?

--------------------------------------Sorular Aynı----------------------------------------

--65. 10 numaralı ID ye sahip ürünümden son 3 ayda ne kadarlık ciro sağladım?

SELECT p.product_id, sum(od.quantity * od.unit_price) from order_details as od
                                                               JOIN orders as o
                                                                    on o.order_id = od.order_id
                                                               join products as p
                                                                    on p.product_id = od.product_id
WHERE p.product_id = 10 AND o.order_date <= CURRENT_DATE - INTERVAL '3 months'
group by p.product_id;

--66. Hangi çalışan şimdiye kadar toplam kaç sipariş almış..?

select e.employee_id, sum(od.quantity) as total_quantity from order_details as od
                                                                  join orders as o
                                                                       on o.order_id = od.order_id
                                                                  join employees as e
                                                                       on e.employee_id = o.employee_id
group by e.employee_id;

--67. 91 müşterim var. Sadece 89’u sipariş vermiş. Sipariş vermeyen 2 kişiyi bulun

SELECT c.customer_id FROM customers AS c
                              LEFT JOIN orders AS o
                                        ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

--68. Brazil’de bulunan müşterilerin Şirket Adı, TemsilciAdi, Adres, Şehir, Ülke bilgileri

SELECT company_name, contact_name, address, country FROM customers where country = 'Brazil';

--69. Brezilya’da olmayan müşteriler

select * from customers where country != 'Brazil';

--70. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler

SELECT * FROM customers WHERE country IN ('Brazil', 'Spain', 'France', 'Germany');

--71. Faks numarasını bilmediğim müşteriler

SELECT * from customers where fax is null;

--72. Londra’da ya da Paris’de bulunan müşterilerim

SELECT * FROM customers WHERE city IN ('Londra', 'Paris');

--73. Hem Mexico D.F’da ikamet eden HEM DE ContactTitle bilgisi ‘owner’ olan müşteriler

SELECT * FROM customers WHERE city = 'México D.F.' AND contact_title = 'owner';

--74. C ile başlayan ürünlerimin isimleri ve fiyatları

select product_name, unit_price from products where product_name like 'C%';

--75. Adı (FirstName) ‘A’ harfiyle başlayan çalışanların (Employees); Ad, Soyad ve Doğum Tarihleri

select first_name, last_name, birth_date from employees where first_name like 'A%';

--76. İsminde ‘RESTAURANT’ geçen müşterilerimin şirket adları

select company_name from customers where company_name like '%RESTAURANT%';

--77. 50$ ile 100$ arasında bulunan tüm ürünlerin adları ve fiyatları

select product_name, unit_price from products where unit_price between 50 and 100;

--78. 1 temmuz 1996 ile 31 Aralık 1996 tarihleri arasındaki siparişlerin (Orders), SiparişID (OrderID) ve SiparişTarihi (OrderDate) bilgileri

select order_id, order_date from orders where order_date BETWEEN '1996-07-01' and '1996-12-31';

--79. Ülkesi (Country) YA Spain, Ya France, Ya da Germany olan müşteriler

SELECT * FROM customers WHERE country not in ('Brazil', 'Spain', 'France', 'Germany');

--80. Faks numarasını bilmediğim müşteriler

SELECT * from customers where fax is null;

--81. Müşterilerimi ülkeye göre sıralıyorum:

select * from customers order by country;

--82. Ürünlerimi en pahalıdan en ucuza doğru sıralama, sonuç olarak ürün adı ve fiyatını istiyoruz

select product_name, unit_price from products order by unit_price desc;

--83. Ürünlerimi en pahalıdan en ucuza doğru sıralasın, ama stoklarını küçükten-büyüğe doğru göstersin sonuç olarak ürün adı ve fiyatını istiyoruz

SELECT product_name, unit_price, units_in_stock FROM products ORDER BY unit_price DESC, units_in_stock ASC;

--84. 1 Numaralı kategoride kaç ürün vardır..?

SELECT COUNT(*)
FROM categories AS c
         JOIN products AS p ON
        p.category_id = c.category_id
WHERE c.category_id = 1;

--85. Kaç farklı ülkeye ihracat yapıyorum..?

select count(distinct country) from suppliers;

--86. a.Bu ülkeler hangileri..?

select distinct country from suppliers;

--87. En Pahalı 5 ürün

SELECT product_name, unit_price FROM products order by unit_price desc LIMIT 5;

--88. ALFKI CustomerID’sine sahip müşterimin sipariş sayısı..?

select count(*) from customers where customer_id = 'ALFKI';

--89. Ürünlerimin toplam maliyeti

select sum(unit_price) from products;

--90. Şirketim, şimdiye kadar ne kadar ciro yapmış..?

select s.company_name, sum(od.quantity * od.unit_price) from order_details as od
                                                                 join orders as o
                                                                      on o.order_id = od.order_id
                                                                 join products as p
                                                                      on p.product_id = od.product_id
                                                                 join suppliers as s
                                                                      on s.supplier_id = p.supplier_id
group by s.company_name;

--91. Ortalama Ürün Fiyatım

select AVG(unit_price) from products;

--92. En Pahalı Ürünün Adı

SELECT product_name FROM products WHERE unit_price = (SELECT MAX(unit_price) FROM products);

--93. En az kazandıran sipariş

select sum(od.quantity * od.unit_price) as total_price from order_details as od
                                                                join orders as o
                                                                     on o.order_id = od.order_id
                                                                join products as p
                                                                     on p.product_id = od.product_id
group by od.order_id
order by total_price limit 1;

--94. Müşterilerimin içinde en uzun isimli müşteri

select Length(company_name) as len from customers GROUP by customer_id order by len desc limit 1;

--95. Çalışanlarımın Ad, Soyad ve Yaşları

select first_name, last_name, EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date) AS age from employees;

--96. Hangi üründen toplam kaç adet alınmış..?

select product_name, sum(od.quantity) as total_quantity from order_details as od
                                                                 join orders as o
                                                                      on o.order_id = od.order_id
                                                                 join products as p
                                                                      on p.product_id = od.product_id
group by product_name;

--97. Hangi siparişte toplam ne kadar kazanmışım..?

select od.order_id, sum(od.quantity * od.unit_price) from order_details as od
                                                              join orders as o
                                                                   on o.order_id = od.order_id
                                                              join products as p
                                                                   on p.product_id = od.product_id
GROUP by od.order_id;

--98. Hangi kategoride toplam kaç adet ürün bulunuyor..?

SELECT c.category_id,COUNT(*) FROM categories AS c
                                       JOIN products AS p
                                            ON p.category_id = c.category_id
GROUP BY c.category_id;

--99. 1000 Adetten fazla satılan ürünler?

select product_name, sum(od.quantity) as total_quantity from order_details as od
                                                                 join orders as o
                                                                      on o.order_id = od.order_id
                                                                 join products as p
                                                                      on p.product_id = od.product_id
group by product_name
HAVING SUM(od.quantity) > 1000;

--100. Hangi Müşterilerim hiç sipariş vermemiş..?

SELECT c.customer_id FROM customers AS c
                              LEFT JOIN orders AS o
                                        ON c.customer_id = o.customer_id
WHERE o.customer_id IS NULL;

--101. Hangi tedarikçi hangi ürünü sağlıyor ?

SELECT s.company_name, p.product_name FROM products AS p
                                               JOIN suppliers AS s
                                                    ON s.supplier_id = p.supplier_id;

--102. Hangi sipariş hangi kargo şirketi ile ne zaman gönderilmiş..?

SELECT s.company_name, o.order_id from orders as o
                                           join shippers as s
                                                on s.shipper_id = o.ship_via;

--103. Hangi siparişi hangi müşteri verir..?

select c.company_name, o.order_id from orders as o
                                           join customers as c
                                                on c.customer_id = o.customer_id;

--104. Hangi çalışan, toplam kaç sipariş almış..?

select e.employee_id, sum(od.quantity) as total_quantity from order_details as od
                                                                  join orders as o
                                                                       on o.order_id = od.order_id
                                                                  join employees as e
                                                                       on e.employee_id = o.employee_id
group by e.employee_id;

--105. En fazla siparişi kim almış..?

select e.employee_id, sum(od.quantity) as total_quantity from order_details as od
                                                                  join orders as o
                                                                       on o.order_id = od.order_id
                                                                  join employees as e
                                                                       on e.employee_id = o.employee_id
group by e.employee_id
order by total_quantity DESC limit 1;

--106. Hangi siparişi, hangi çalışan, hangi müşteri vermiştir..?

select e.employee_id, od.order_id, o.customer_id from order_details as od
                                                          join orders as o
                                                               on o.order_id = od.order_id
                                                          join employees as e
                                                               on e.employee_id = o.employee_id;

--107. Hangi ürün, hangi kategoride bulunmaktadır..? Bu ürünü kim tedarik etmektedir..?

select p.product_name, c.category_name, s.company_name from products as p
                                                                join suppliers as s
                                                                     on s.supplier_id = p.supplier_id
                                                                join categories as c
                                                                     on c.category_id = p.category_id;

--108. Hangi siparişi hangi müşteri vermiş, hangi çalışan almış, hangi tarihte, hangi kargo şirketi tarafından gönderilmiş hangi üründen kaç adet alınmış, hangi fiyattan alınmış, ürün hangi kategorideymiş bu ürünü hangi tedarikçi sağlamış

select o.order_id, o.customer_id, o.employee_id, o.order_date, sh.company_name, od.quantity, od.unit_price, c.category_name, p.supplier_id from order_details as od
                                                                                                                                                    join orders as o
                                                                                                                                                         on o.order_id = od.order_id
                                                                                                                                                    join products as p
                                                                                                                                                         on p.product_id = od.product_id
                                                                                                                                                    join categories as c
                                                                                                                                                         on p.category_id = c.category_id
                                                                                                                                                    join shippers as sh
                                                                                                                                                         on sh.shipper_id = o.ship_via
                                                                                                                                                    join suppliers as s
                                                                                                                                                         on s.supplier_id = p.supplier_id;

--109. Altında ürün bulunmayan kategoriler

SELECT c.category_id
FROM categories AS c
         LEFT JOIN products AS p ON c.category_id = p.category_id
WHERE p.category_id IS NULL;

--110. Manager ünvanına sahip tüm müşterileri listeleyiniz.

select * from customers where contact_title like '%Manager%';

--111. FR ile başlayan 5 karekter olan tüm müşterileri listeleyiniz.

select * from customers where contact_name like 'FR___%';

--112. (171) alan kodlu telefon numarasına sahip müşterileri listeleyiniz.

select * from customers where phone like '(171)%';

--113. BirimdekiMiktar alanında boxes geçen tüm ürünleri listeleyiniz.

select * from products where quantity_per_unit like '%boxes%';

--114. Fransa ve Almanyadaki (France,Germany) Müdürlerin (Manager) Adını ve Telefonunu listeleyiniz.(MusteriAdi,Telefon)

select contact_name, phone from customers where contact_title like '%Manager%';

--115. En yüksek birim fiyata sahip 10 ürünü listeleyiniz.

select * from products order by unit_price desc limit 10;

--116. Müşterileri ülke ve şehir bilgisine göre sıralayıp listeleyiniz.

SELECT * FROM customers ORDER BY country, city;


--117. Personellerin ad,soyad ve yaş bilgilerini listeleyiniz.

select first_name, last_name, EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM birth_date) AS age from employees;

--118. 35 gün içinde sevk edilmeyen satışları listeleyiniz.

SELECT * FROM orders WHERE shipped_date > order_date + INTERVAL '35 days';

--119. Birim fiyatı en yüksek olan ürünün kategori adını listeleyiniz. (Alt Sorgu)

select c.category_name from products as p
                                join categories as c
                                     on c.category_id = p.category_id
where unit_price = (select max(unit_price) from products);

--120. Kategori adında 'on' geçen kategorilerin ürünlerini listeleyiniz. (Alt Sorgu)

select p.* from products as p
                    join categories as c
                         on c.category_id = p.category_id
where c.category_name like '%on%';

--121. Konbu adlı üründen kaç adet satılmıştır.

select count(*) from order_details as od
                         join orders as o
                              on o.order_id = od.order_id
                         join products as p
                              on p.product_id = od.product_id
where p.product_name='Konbu';

--122. Japonyadan kaç farklı ürün tedarik edilmektedir.

SELECT COUNT(DISTINCT p.product_id)
FROM products AS p
         JOIN suppliers AS s ON s.supplier_id = p.supplier_id
WHERE s.country = 'Japan';

--123. 1997 yılında yapılmış satışların en yüksek, en düşük ve ortalama nakliye ücretlisi ne kadardır?

SELECT MAX(freight) AS top, MIN(freight) AS low, AVG(freight) AS mean FROM orders WHERE EXTRACT(YEAR FROM order_date) = 1997;

--124. Faks numarası olan tüm müşterileri listeleyiniz.

select * from customers where fax is not null;

--125. 1996-07-16 ile 1996-07-30 arasında sevk edilen satışları listeleyiniz. 

select * from orders where order_date between '1996-07-16' and '1996-07-30';