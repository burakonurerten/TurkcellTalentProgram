-- Yiğit Kalay
-- Burak Onur Erten
-- İbrahim Şengün

-- +1) müşteriler tablosundaki verileri getir

Select * from customers;

-- +2) ürünler tablosundan sadece ürün id, ürün ismi ve ürün fiyatı verilerini getir.

Select product_id,product_name,unit_price from products;

-- +3) ürünler tablosundan ürün fiyatları 25'den büyük olanları getir

Select * from products where unit_price > 25;

-- +4) ürünler tablosundan ürün fiyatları 25'den büyük olanları ve ürün adedi 10'dan küçük olanları getir.

Select * from products where unit_price > 25 and units_in_stock < 10;

-- +5) ürünler tablosundan ürün ismi 'An' ile başlayanları getir.

Select * from products where product_name LIKE 'An%';

-- +6) ürünler tablosunda ürün isimlerinde 'An' olan ürünleri getir.

Select * from products Where product_name LIKE '%An%';

-- +7) ürünler tablosunda ürün isimlerinde 'An' olan ve ürün ismi en az 4 karekter uzunluğundaki ürünleri getir.

Select * from products Where product_name LIKE '%An__%';

-- +8) ürünler tablosunda ürün isimlerinde 'an' olan büyük ve küçük karekterleri içeren tüm ürünleri getir

Select * from products Where LOWER(product_name) LIKE '%an%';

-- +9) ürünler tablosunda ürün fiyatı en düşük olan ürünü getir.

Select * from products where unit_price=(Select MIN(unit_price) from products);

-- +10) siparisler tablosunda siparişlerin ülkelere göre gruplandırarak sayılarıyla birlikte getir.

SELECT ship_country, COUNT(*) AS order_count FROM orders GROUP BY ship_country;

-- +11) product tablosundaki unit_price kolonundaki en çok tekrar eden değerleri bul.

select unit_price, count(*) AS counter from products group by unit_price order by count(*) desc;

-- +12) çalışanların yaşlarına göre büyükten küçüğe doğru sırala

Select * from employees order by birth_date asc;

-- +13) sipariş detayları tablosundaki ürün adet toplam sayısını getir.

Select SUM(quantity) from order_details;

-- +14) müşteriler tablosundaki benzersiz şehir isimlerini sırala.

Select DISTINCT city from customers;

-- +15) ürünler tablosunda ürün fiyatı en yüksek olan ilk 5 ürünü getir.

Select * from products order by unit_price desc limit 5 offset 0;

-- +16) ürünler tablosunda ürün isminde 'An' buluanan ve ürün fiyatı 23 den büyük olan 1 ürün getir.

Select * from products where unit_price>1 and product_name=(Select product_name from products Where product_name LIKE '%An%' limit 1);

-- +17) sipariş detayları tablosundaki ortalama ürün sayısını getir.

Select AVG(quantity) from order_details;

-- +18) ürünler tablosundaki ürünleri fiyatlarına göre büyükten küçüğe sıraladıktan sonra 15 ile 20 sıradaki ürünleri getir.

Select * from products order by unit_price desc limit 5 offset 15;

-- +19) Her bir kategorideki en yüksek fiyatlı ürünlerin ismini ve fiyatını getir.

SELECT category_id, product_name, unit_price FROM products p WHERE unit_price = (SELECT MAX(unit_price) FROM products WHERE category_id = p.category_id);

-- +20) ürünler tablosunda indirimli olan tüm ürünleri getir.

Select * from products where discontinued=1;

-- +21) ürün tablosundaki ürünlerin, ürün fiyatına baz alınarak ortalaması alındıktan sonra bu ortalama değerden büyük ürün fiyatına sahip olan ürünleri listele.

Select * from products where unit_price > (select Avg(unit_price) from products);

-- +22) ürün tablosundaki en çok tekrar sipariş edilen ürünleri küçükten büyüğe listele.

Select * from products order by reorder_level asc;

-- +23) ürün tablosundaki sepette en çok bulunan ürünleri büyükten küçüğe listele ilk 5 ürünü getir.

Select * from products order by units_on_order desc limit 5;

-- +24) sağlayıcılar tablosundaki fax numarası olmayan sağlayıcıları getirme.

select * from suppliers where fax is not null;

-- +25) kategori tablosunda ürün kategorisi "Condiments" olarak belirtilmiş ürünleri ürün tablosundan getir.

select * from products where category_id=(select category_id from categories where category_name = 'Condiments');