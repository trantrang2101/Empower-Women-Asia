GO
Use master
GO
drop database EWA
create DATABASE EWA
GO
Use EWA
GO
CREATE TABLE "Categories" (
	"CategoryID" "int" IDENTITY (1, 1) NOT NULL ,
	"CategoryName" nvarchar (255) NOT NULL ,
	"Description" "ntext" NULL ,
	createAt datetime default getDate(),
	updateAt datetime default null,
	CONSTRAINT "PK_Categories" PRIMARY KEY  CLUSTERED 
	(
		"CategoryID"
	)
)
CREATE TABLE "Users"(
	[userID] [nvarchar](50) NOT NULL,
	[password] [nvarchar](50) NULL,
	[roleID] [nvarchar](50) NULL,
	[status] [bit] NULL,
	createAt datetime default getDate(),
	updateAt datetime default null,
	CONSTRAINT "PK_User" PRIMARY KEY  CLUSTERED 
	(
		[userID]
	)
)
CREATE TABLE "Customers" (
	"CustomerID" [nvarchar](50) NOT NULL ,
	"fullName" nvarchar (40) NULL ,
	"gender" [bit] NULL,
	"Address" nvarchar (60) NULL ,
	"Image" nvarchar(255) null,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"Phone" nvarchar (24) NULL ,
	CONSTRAINT "PK_Customers" PRIMARY KEY  CLUSTERED 
	(
		"CustomerID"
	),
	CONSTRAINT "FK_Users_Customers" FOREIGN KEY 
	(
		"CustomerID"
	) REFERENCES "dbo"."Users" (
		[userID]
	)
)
CREATE TABLE "Orders" (
	"OrderID" "int" IDENTITY (1, 1) NOT NULL ,
	"CustomerID" [nvarchar] (50) NULL ,
	"fullName" nvarchar (40) NOT NULL ,
	"OrderDate" "datetime" NULL default getDate(),
	"Address" nvarchar (60) NULL ,
	"Region" nvarchar (15) NULL ,
	"PostalCode" nvarchar (10) NULL ,
	"Country" nvarchar (15) NULL ,
	"Phone" nvarchar (24) NULL ,
	note ntext null,
	"prepayment" [bit] NULL default 1,
	"checkPay" [bit] NULL default 0,
	"done" int NULL default 1,
	updateAt datetime default null,
	CONSTRAINT "PK_Orders" PRIMARY KEY  CLUSTERED 
	(
		"OrderID"
	),
	CONSTRAINT "FK_Orders_Customers" FOREIGN KEY 
	(
		"CustomerID"
	) REFERENCES "dbo"."Customers" (
		"CustomerID"
	) on delete set null
)
/*CREATE TABLE "Discount" (
	"DiscountID" nvarchar(10) default null,
	"DiscountName" nvarchar (40) NOT NULL ,
	"DiscountDes" nvarchar (450) NULL ,
	"DiscountPrice" int null CONSTRAINT "DF_Discount_Price" DEFAULT (0),
	[status] [bit] NULL,
	CONSTRAINT "PK_Discount" PRIMARY KEY  CLUSTERED 
	(
		"DiscountID"
	),
	CONSTRAINT "CK_Discount_Price" CHECK ("DiscountPrice" >= 0)
)
*/

CREATE TABLE "Products" (
	"ProductID" "int" IDENTITY (1, 1) NOT NULL ,
	"ProductName" nvarchar (200) NOT NULL ,
	"Description" "ntext" NULL ,
	"ProductInfo"ntext NULL ,
	"CategoryID" "int" NULL ,
	"QuantityPerUnit" nvarchar (20) NULL ,
	"UnitPrice" "money" NULL CONSTRAINT "DF_Products_UnitPrice" DEFAULT (0),
--	"DiscountID" nvarchar(10) default null,
	 [status] [bit] NULL default(1),
	createAt datetime default getDate(),
	updateAt datetime default null,
	CONSTRAINT "PK_Products" PRIMARY KEY  CLUSTERED 
	(
		"ProductID"
	),
--	CONSTRAINT "FK_Products_Categories" FOREIGN KEY 
--	(
	--	"DiscountID"
--	) REFERENCES "dbo"."Discount" (
--		"DiscountID"
--	) ,
	CONSTRAINT "FK_Products_Discount" FOREIGN KEY 
	(
		"CategoryID"
	) REFERENCES "dbo"."Categories" (
		"CategoryID"
	)on delete set null,
	CONSTRAINT "CK_Products_UnitPrice" CHECK (UnitPrice >= 0)
)
CREATE TABLE Cart(
	"CustomerID" [nvarchar] (50) NULL ,
	"ProductID" "int" NOT NULL ,
	"Quantity" int default 0 ,
	CONSTRAINT "FK_Cart_Customer" FOREIGN KEY 
	(
		"CustomerID"
	) REFERENCES "dbo"."Customers" (
		"CustomerID"
	),
	CONSTRAINT "FK_Cart_Product" FOREIGN KEY 
	(
		"ProductID"
	) REFERENCES "dbo"."Products" (
		"ProductID"
	),
);
CREATE TABLE "ImageProduct"(
	"ProductID" "int" NOT NULL ,
	"Image" nvarchar(255) NOT NULL,
	CONSTRAINT "FK_Image_Product" FOREIGN KEY 
	(
		"ProductID"
	) REFERENCES "dbo"."Products" (
		"ProductID"
	),
);
CREATE TABLE "OrderDetails" (
	"OrderID" "int" NOT NULL ,
	"ProductID" "int" NOT NULL ,
	"Quantity" "smallint" NOT NULL CONSTRAINT "DF_Order_Details_Quantity" DEFAULT (1),
	"UnitPrice" "money" NULL DEFAULT (0),
--	"DiscountID" nvarchar(10) NOT NULL CONSTRAINT "DF_Order_Details_Discount" DEFAULT null,
	CONSTRAINT "PK_Order_Details" PRIMARY KEY  CLUSTERED 
	(
		"OrderID",
		"ProductID"
	),
	CONSTRAINT "FK_Order_Details_Orders" FOREIGN KEY 
	(
		"OrderID"
	) REFERENCES "dbo"."Orders" (
		"OrderID"
	),
	CONSTRAINT "FK_Order_Details_Products" FOREIGN KEY 
	(
		"ProductID"
	) REFERENCES "dbo"."Products" (
		"ProductID"
	),
	CONSTRAINT "CK_Quantity" CHECK (Quantity > 0),
	CONSTRAINT "DF_Order_Details_UnitPrice" CHECK (UnitPrice >= 0)
)
CREATE TABLE Blogs (
      blogID "int" IDENTITY (1, 1) NOT NULL ,
      AuthorID [nvarchar] (50) NULL ,
      AuthorName nvarchar (40) NOT NULL ,
      Title nvarchar(255) not null,
      Summary text null,
      content text null,
      "Image" nvarchar(255) null,
      CreatedAt "datetime" NULL default getDate(),
      UpdatedAt DATETIME NULL DEFAULT NULL,
      PublishedAt DATETIME NULL DEFAULT getDate(),
      CONSTRAINT "PK_Blogs" PRIMARY KEY  CLUSTERED 
      (
            blogID
      ),
      CONSTRAINT "FK_Blogs_Users" FOREIGN KEY 
      (
            AuthorID
      ) REFERENCES "dbo".Users (
            UserID
      ) 
  ON DELETE NO ACTION
  ON UPDATE NO ACTION
)
INSERT [dbo].Users ([userID], [password], [roleID], [status]) VALUES (N'admin', N'1', N'AD', 1),('hahata','27072002','US',1)
Insert Customers values ('hahata','Ta Ha Hoang Anh'	,1	,'Yen Nguu, Tam Hiep, Thanh Tri','hahata.png'	,'Ha Noi','100000', 'Vietnam'	,'0858290551')
insert into Categories (CategoryName,[Description]) values ('Products of Hoa Ban','Especially, Hoa Ban was chosen by the Swiss NGO KIBV as one of the addresses to invest, preserve and develop the traditional browsing profession combined with local tourism.')
insert into Categories (CategoryName,[Description]) values('La Pham Collection','La Pham and EWA are collaborating in a program to create simple decorations from brocade, and raise funds to support women and girls in brocade weaving and embroidery villages in Mai Chau, Hoa Binh.')
insert into Products (ProductName,[Description],CategoryID,UnitPrice,QuantityPerUnit,"ProductInfo") values
('Reversible Velvet Scarf','	Scarves and the cold season are a perfect combination. Understanding that, La Pham introduced to customers the reversible scarf made of velvet which ensures the satisfaction of its users from the outer appearance to the inner side. The velvet material creates senses of ease and lightness for the wearers. Moreover, the designer delicately incorporated different cold and warm colors of each side to boost wearers feminity and elegance and plus to adjust with different outfits. Currently, the product is available in different colors which diversifies the range of options for customers. For monocolour scarfs (green, white), they have tassels fixed to them at the tail - a cultural feature of women in mountainous regions. This design definitely brings the novelty and uniqueness to the wardrobe of its wearer.',	2,	160,	10000,'	Velvet materials Reversible and multiple style Sustainable and ethnical fashion accesories product'),
('Christmas ornaments small size','	In the world of integration, Christmas and customs like decorating the pine tree have become the norm in Vietnamese families. Christmas ornaments, therefore, are indispensable in this special festival. There are many charming and amiable designs such as the pine trees, snowmen, reindeers, golden stars, Christmas socks; besides, there are colourful patterns which are mainly green, red, yellow - the colours of Christmas - and made of simple brocade fabric. This is also the Zero Waste product line of La Pham who wishes to make use of excess cloths to create meaningful products. Therefore, if given the option of hanging and beholding the vivid, beautiful, and meaningful ornaments, will you choose them? About products of Empower Women Asia Each product that EWA brings is not just a mere product, but hidden behind each delicate and ingenious needlepoint is a story, the thoughts, the feelings and valuable experiences that were obtained through years of hard work on the loom. Therefore, when holding the products of ethnic minority women in our hands, we are also cherishing the nations long-standing traditional culture. A typical example of the art of telling stories through handmade products is the brocade weaving village of Mai Chau (Hoa Binh) or Sa Pa (Lao Cai). It is no coincidence that people treasure and appreciate hand-woven handicrafts because these products are made from environmentally friendly natural materials such as velvet, silk, brocade, denim hemp, linen, beeswax,... which do not cause skin irritation. With the idea of ​​zero waste, these costumes will not only stop at beautifying its wearer, but also contribute to the community greatly in minimizing waste and preserving the green of the environment. In order to create traditional textile products, it has to go through many stages, requiring the meticulousness and ingenuity of ethnic womens hands. Typically, the brocade pattern on the jacket is made from the bib of the Hmong girls. To make a costume, the women in Sa Pa weaving village will take more than a year to complete. First of all, the preparation of raw materials must be done extremely carefully such as the process of making raw yarn, weaving, dyeing with natural materials,... Next, coming up with ideas for costumes and process is also elaborated to every little detail. Finally, the process ends with the artisan checking each part carefully, ensuring the flawless perfection of the product. All steps in the process are completely handmade, not only to ensure quality but also to bring uniqueness to the product. In other words, the stories behind hand-woven products make them more unique and meaningful in the eyes of consumers. With the heart and hard work put into each product, these will definitely be great gifts for yourself, as well as your loved ones.',	2,	5,	10000,'	Hand weaving Brocade materials 100% sustainable and ethical fashion product'),
('Christmas ornaments big size','	In the world of integration, Christmas and customs like decorating the pine tree have become the norm in Vietnamese families. Christmas ornaments, therefore, are indispensable in this special festival. There are many charming and amiable designs such as the pine trees, snowmen, reindeers, golden stars, Christmas socks; besides, there are colourful patterns which are mainly green, red, yellow - the colours of Christmas - and made of simple brocade fabric. This is also the Zero Waste product line of La Pham who wishes to make use of excess cloths to create meaningful products. Therefore, if given the option of hanging and beholding the vivid, beautiful, and meaningful ornaments, will you choose them? About products of Empower Women Asia Each product that EWA brings is not just a mere product, but hidden behind each delicate and ingenious needlepoint is a story, the thoughts, the feelings and valuable experiences that were obtained through years of hard work on the loom. Therefore, when holding the products of ethnic minority women in our hands, we are also cherishing the nations long-standing traditional culture. A typical example of the art of telling stories through handmade products is the brocade weaving village of Mai Chau (Hoa Binh) or Sa Pa (Lao Cai). It is no coincidence that people treasure and appreciate hand-woven handicrafts because these products are made from environmentally friendly natural materials such as velvet, silk, brocade, denim hemp, linen, beeswax,... which do not cause skin irritation. With the idea of ​​zero waste, these costumes will not only stop at beautifying its wearer, but also contribute to the community greatly in minimizing waste and preserving the green of the environment. In order to create traditional textile products, it has to go through many stages, requiring the meticulousness and ingenuity of ethnic womens hands. Typically, the brocade pattern on the jacket is made from the bib of the Hmong girls. To make a costume, the women in Sa Pa weaving village will take more than a year to complete. First of all, the preparation of raw materials must be done extremely carefully such as the process of making raw yarn, weaving, dyeing with natural materials,... Next, coming up with ideas for costumes and process is also elaborated to every little detail. Finally, the process ends with the artisan checking each part carefully, ensuring the flawless perfection of the product. All steps in the process are completely handmade, not only to ensure quality but also to bring uniqueness to the product. In other words, the stories behind hand-woven products make them more unique and meaningful in the eyes of consumers. With the heart and hard work put into each product, these will definitely be great gifts for yourself, as well as your loved ones.',	2,	10,	10000,'	Hand weaving Brocade materials 100% sustainable and ethical fashion product'),
('Accessory bag','	In terms of materials, this bag is out of the safe zone compared to similar products on the market because it is produced with traditional brocade patterns. With the unique design of the stylized rectangle, even the strings are made of brocade, giving the consumers a feeling of uniformity and enjoyment. Moreover, with such a design, instead of buttoning or attaching directly to the product, users will easily open and close as well as bring the bag. The product has 3 main colors: green, red and black with different patterns, suitable for each persons preferences, promising to satisfy the most demanding customers. A small revelation is that these accessory bags are all made from redundant fabric or from costumes that have been preserved and cherished by Hmong girls. They also reflect La Phams Zero Waste fashion concept with the desire to bring fashion into a sustainable, environmentally friendly lifestyle.',	2,	29,	10000,'	Hand weaving Brocade materials 100% sustainable and ethical fashion product'),
('Pillowcase','	Probably with the products related to sleep, everyone will select carefully because of the importance of sleep. Only having decent sleep, we are more excited to get down to work. Penetrating the truth, in this event, EWA and designer La Pham published a pillowcase made of linen with brocade patterns, following the modern and traditional style. Each pillowcase with different patterns is unique in design, it shows cultural beauty of mountainous ethnic minority groups. Each person is based on own hobbies of shapes, colors to suitably choosing favorite one. Especially, a pillowcase made from linen - material that friendly protects the environment and does not irritate the skin, is easy to clean, helps users wake up to regenerate energy after a tiring working day. ',	2,	49,	10000,'	Hand weaving Brocade materials 100% sustainable and ethical fashion product'),
('Reversible Scarf','	Thinking of winter accessories, the first thing that everyone thinks of is scarf. Understanding this mentality of everyone, designer La Pham has designed a scarf printed with brocade patterns - produced entirely by hand from artisans of Mai Chau weaving village. The scarf is representative of the harmony between modern and classic features. Impressive brocade pattern with the symbolism of bird motifs representing joy and abundance of crops stands out on the red background of the scarf combined with pom-pom and small hooks. The shape of the scarf has transformed traditional hand-woven fabrics into a trendy product that still carries the folklore soul.',	2,	165,	10000,'	Hand weaving Brocade materials 100% sustainable and ethical fashion product'),
('Reversible Silk and Velvet Scarf','	Scarves and the cold season are a perfect combination. Understanding that, La Pham introduced to customers the scarf made of velvet and silk which ensures the satisfaction of its users from the outer appearance to the inner side. The velvet material creates senses of ease and lightness for the wearers. Moreover, the designer delicately incorporated different cold colors to boost wearers feminity and elegance. Currently, the product is available in dark blue - yellow, black - red, brown - turquoise, green - pink, which diversifies the range of options for customers. For monocolour scarfs (green, white), they have tassels fixed to them at the tail - a cultural feature of women in mountainous regions. This design definitely brings the novelty and uniqueness to the wardrobe of its wearer.',	2,	120,	10000,'	Velvet and silk Silk materials Reversible and multiple style Sustainable and ethnical fashion accesories product'),
('Beewax on Ramie Jacket','	The jacket is made of denim hemp and has a kimono-style lapel. The broad sleeves are a light blue color that contrasts with the dark blue of the shirt, and they include eye-catching sun-shaped beeswax patterns that add embellishments to the goods. The origin and procedure through which this shirt was manufactured are the unique features buried within it. Thai ethnic women from Hang Kia - Pa Co hamlet in Mai Chau district, Hoa Binh province, hand-paint beeswax designs. After painting with beeswax on canvas, you must pay close attention and be thorough because the beeswax will no longer be able to draw when it dries and cools. As a result, the coat represents the affection and devotion of Highland women. The designer took the risk of combining natural denim dyed hemp material representing modernity, with beeswax folk motifs reflecting tradition. The two combine to create a shirt that is both youthful and vibrant while remaining elegant.',	2,	250,	10000,'	Denim hemp materials and 100% handmade Beeswax designs Sustainable and ethnical fashion product'),
('Jacket','	Being inspired by the traditional Kimonos, this jacket was made from velvet fabric with a stylized bodice that brings a fresh, unique vibe. On the soft velvet background, brocade patterns with national identity are meticulously made, creating an accent on the sleeves and back. The brocade patterns are all handmade by Hmong girls. Therefore, this is not just an ordinary jacket, but also carrying the sentiments of women from highlands, the crystalization of hard work and time. Velvet and brocade seemed strange together but make a surprisingly harmonious combination, which made the shirt special. With two colors black and dark red, buyers can easily choose the suitable shirt for themselves and still ensure elegance and nobility. ',	2,	320,	10000,'	Velvet and handmade brocade materials Free Size Sustainable and ethical fashion product'),
('Water bottle bag','	',	1,	6,	10000,'	'),
('Eye patch','	',	1,	4,	10000,'	'),
('Key Chain','	',	1,	2,	10000,'	'),
('Baby Bib with Patterns','	Baby Bib made specially for baby with a careful, selective materials which are 100% cotton, natural dyed, hand weaving. ',	1,	29,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Baby sleeping bag','	Baby Sleeping Bag Size 0-6 Months with strings to be easy to close or open. Lining: 100% Cotton, natural dyed.Option of colors: Solid or with PatternsHandweaving. ',	1,	79,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Ipad Cover','	Ipad cover is made with 100% handweaving materials. It is convinient and stylish yet protect the Ipad',	1,	49,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Laptop case','	Laptop case with buttons to open and close it easly.Litting: 100% Cotton, natural dyed.Option of colors: Purple, Blue, White, Red, Grey.Handweaving. ',	1,	49,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Pillow cover','	Handmade pillow covers in 4 versions: 1. Black with white patterns.2. White with black patterns.3. Dark red and white patterns. 4. Dark red, white patterns on the black bacground. Size: 45x45 cm100% cotton, natural dyed.Handweaving. ',	1,	39,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Pot Holder','	Pot holder in different weaving patterned designs and colors Size: 13x13 cmLining: 100% Cotton, natural dyed.Handweaving by artisans in Mai Chau Villages.',	1,	19,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Running Table','	Running table with patterns made by hand weaving loom. Lining: 100% Cotton, natural dyedOption of colors: Dark redHandweaving. ',	1,	109,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Dish Mat','	Dish mat in two different options: red with blue and red with yellow. Lining: 100% Cotton, natural dyed.Handweaving.',	1,	8,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Glass mat','	Glass mat avaiable in 4 versions: 1. White, red, blue, green.2. White, red, orange, green. 3. White, red, orange. 4. White, red, green. 100% cotton, natural dyed.Handweaving. ',	1,	12,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Bib','	Bob for 6-12 month old baby. Avaiable in 3 options: 1. Pink with horizontal white lines.2. Pink with vertical white lines.3. Grey with white lines. 100% cotton, natural dyed.Handweaving. ',	1,	29,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Apron','	Apron with strings in 3 versions: 1. White patterns mixed with black fabric. Dark pocket with white squares. 2. Grey color with white patterns. Pocket with a pattern of small circles.3. Darker grey color. Pocet with a square pattern. 100% cotton, natural dyed.Handweaving.',	1,	39,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Cooking Glove','	Cooking gloves in 3 versions: 1. Dark red with colorful lines.2. Pink with white lines.3. Black with white lines. Lining: 100% Cotton, natural dyed.Handweaving. ',	1,	19,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Goat','	White, grey and dark blue goat. Lining: 100% cottonNatural dyed, handweaving.',	1,	39,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Big Elephant','	White big elephant with purple and yellow pattern. Lining: 100% CottonNatural dyed, handweaving.',	1,	49,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Dinosaur','	Dinosaur in two versions: 1. White with patterns in dark colors.2. White with colorful lines. Lining: 100% CottonNatural dyed, handweaving.',	1,	49,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Giraffe','	Giraffes in two colors:1. Dark blue with pink and white patterns.2. White with light blue lines. Lining: 100% CottonNatural dyed, handweaving.',	1,	49,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Blue Rabbit','	White rabbit with blue indigo clothes. 100% cotton, natural dyed,Handweaving. ',	1,	39,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Red Rabbit','	White rabbit avaiable in two versions:1. Red clothing in colorful lines.2. Red clothing with colorful patterns. 100% cotton, natural dyed,Handweaving. ',	1,	39,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Wether','	Wether in 2 versions:1. White with red and pink lines.2. White with blue ingido. 3. White with blue, red and grey large lines. 100% Cotton,Natural dyed, Handweaving.',	1,	39,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Deer','	White deer with orange, purple, red and white patterns. Lining: 100% CottonNatural dyed, Handweaving.',	1,	39,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Hairband Weaving Patterned','	Hand Weaving Patterned Hairbandproduced by Hoa Ban 100% Handmade27x26cmPurple/more colors This hairband is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to wear.',	1,	12,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Coaster/Glass Matte Weaving Patterned ','	Hand Weaving Patterned Coasterproduced by Hoa Ban 100% Handmade10x10cmBlue/more colors This coaster is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	10,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Wallet Weaving Patterned Stripe Bag ','	Hand Weaving Patterned Wallet Bagproduced by Hoa Ban 100% Handmade19x11cmYellow/more colors This wallet bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	20,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Little Hand Weaving Patterned Bag ','	Little Hand Weaving Patterned Bag - V16produced by Hoa Ban 100% Handmade18x9cmRed/more colors',	1,	20,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('String Pen Case Weaving Patterned ','	String Pen Case Weaving Patterned - HB01produced by Hoa Ban 100% Handmade26x21cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	20,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Large Weaving Patterned Wallet Bag ','	Hand Weaving Patterned Wallet Bagproduced by Hoa Ban 100% Handmade16x13cmBlue/more colors This wallet bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	25,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Grid Shopping Bag ','	Grid Shopping Bag - T08produced by Hoa Ban 100% Handmade40x30cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	12.5,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('Diamond Weaving Patterned Shopping Bag','	Diamond Weaving Patterned Shopping Bag- T11produced by Hoa Ban 100% Handmade33x30cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	12.5,	10000,'	Our products are natrually deyed, 100% hand weaving by local, minority women in minority villages in Vietnam. Each product is designed and developed by our team then being transfered to the atlier where our artisans will further work on them. Each product will therefore be selected and controlled carefully from fabrics to sewing threads. We designed and made these products with our most considered thought to our cilents who will use the item with an appreciation for the hardwork of our team.'),
('TwoTone Weaving Patterned Shopping Bag ','	TwoTone Weaving Patterned Shopping Bag - T15produced by Hoa Ban 100% Handmade31x22cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	35,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Magic Saddle Weaving Patterned Bag ','	Magic Saddle Weaving Patterned Bag - T43produced by Hoa Ban 100% Handmade21x22cmTeal/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Medium Hand Weaving Patterned Bag ','	Medium Hand Weaving Patterned Bag - V10produced by Hoa Ban 100% Handmade11x22,5cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	20,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Magic Weaving Patterned Messenger Bag','	Magic Weaving Patterned Messenger Bag - T02produced by Hoa Ban 100% Handmade19x24cmTeal/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Stand Pen Case','	Stand Pen Case - HB02produced by Hoa Ban 100% Handmade18x9,5cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry. ',	1,	20,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Hand Weaving Patterned Purse Bag','	Hand Weaving Patterned Purse Bagproduced by Hoa Ban 100% Handmade14x20cmRed/more colors This purse bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry. There are more space to put a variety things.',	1,	20,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Frame of Weaving Patterned Crossbody Bag','	Hand Weaving Patterned Crossbody/Frame Bagproduced by Hoa Ban 100% Handmade15x23cmNavy/more colors This crossbody/frame bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to wear.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Medium Weaving Patterned Wallet Bag','	Hand Weaving Patterned Wallet Bagproduced by Hoa Ban 100% Handmade12x21cmBlue/more colors This wallet bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	20,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Magic Weaving Patterned Crossbody Bag','	Hand Weaving Patterned Crossbody Bagproduced by Hoa Ban 100% Handmade19x25cmTeal/more colors This crossbody bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry. There are mor speace to put a variety things.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Messenger Weaving Patterned Bag','	Messenger Weaving Patterned Bag - T01produced by Hoa Ban 100% Handmade18x21cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	30,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('L Saddle Bag Weaving Patterned Bag','	M Saddle Bag Weaving Patterned Bag - T12produced by Hoa Ban 100% Handmade24x24cmNavy/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('M Shoulder bag Weaving Patterned Bag','	M Shoulder bag Weaving Patterned Bag - T44produced by Hoa Ban 100% Handmade23x20cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Diamond Messenger Weaving Patterned Bag','	Diamond Messenger Weaving Patterned Bag - T29produced by Hoa Ban 100% Handmade21x25cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('L Tote Bag Weaving Patterned','	L Tote Bag Weaving Patterned - T45produced by Hoa Ban 100% Handmade34x37cmNavy/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Flower Messenger Weaving Patterned Bag','	Flower Messenger Weaving Patterned Bag - T41produced by Hoa Ban 100% Handmade14x18cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Baguette Weaving Patterned','	aguette Weaving Patternedproduced by Hoa Ban 100% Handmade12x21cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	20,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Bachpack Weaving Patterned','	Bachpack Weaving Patterned - Balo04produced by Hoa Ban 100% Handmade36x42cmBlue/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	35,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Hand Weaving Patterned Cross Body/Shoulder Bag','	Hand Weaving Patterned Cross Body/Shoulder Bagproduced by Hoa Ban 100% Cotton19x25cmRed/more colors This cross body/shoulder bag is made with 100% cotton yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to wear.',	1,	25,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('A Letter Envelope Bag','	Hand Weaving Patterned Envelope Bagproduced by Hoa Ban 100% Handmade12x21cmRed/more colors This envelope bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	15,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('School With Weaving Patterned Bag','	Hand Weaving Patterned Purseproduced by Hoa Ban100% Handmade18x10cmTeal/more colors This purse bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable. Also can put a variety of things, pens, pencils or cosmetics.',	1,	15,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Kids Weaving Patterned Crossbody','	Hand Weaving Patterned Crossbody Bagproduced by Hoa Ban 100% Handmade10x16cmYellow/more colors This crossbody bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to wear.',	1,	20,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Cosmetics Weaving Patterned Bag','	Hand Weaving Patterned Purse Bagproduced by Hoa Ban100% Handmade16x24cmTeal/more colors This purse bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry. There are more speace to put a variety things such as cosmetics. ',	1,	15,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Requirement Weaving Patterned Clutch Bag','	Hand Weaving Patterned Clutch Bagproduced by Hoa Ban100% Handmade24x16cmRed/more colors This clutch bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	20,	10000,'	100% Handmade Ecofriendly Ethnical Products'),
('Heavy Patterned Wallet Bag','	Hand Weaving Patterned Wallet Bagproduced by Hoa Ban 100% Handmade8.5x12.5cmBlue/more colors This wallet bag is made with 100% handmade yarns and hand weaving fabric with its beautiful color and soft touch that makes it comfortable to carry.',	1,	15,	10000,'	100% Handmade Ecofriendly Ethnical Products')
insert into ImageProduct values
(1,'DSC05213.png'),(1,'DSC05218.png'), (1,'DSC05223.png'), (1,'DSC05227.png'), (1,'DSC05247.png'), (1,'DSC05268.png'), (1,'LP1-3.png'), (1,'LP1-4.jpg'), (1,'LP2-2.png'), (1,'LP2-3.png'), (1,'LP2-4.png'), (1,'LP3-1.png'), (1,'LP4-3.png'), (1,'LP5-1.png'), (1,'LP5-2.png'), (1,'LP5-4.jpg'), (1,'LP6-1.png'), (1,'LP6-3.png'), (1,'LP6-4.jpg'),
(2,'IMG_3762.JPG.jpg'),(2,'IMG_3763.JPG.jpg'),(2,'IMG_3764.JPG.jpg'),(2,'IMG_3765.JPG.jpg'),(2,'IMG_3769.JPG.jpg'),(2,'IMG_3771.JPG.jpg'),(2,'IMG_3772.JPG.jpg'),(2,'IMG_3780.JPG.jpg'),(2,'IMG_3781.JPG.jpg'),(2,'IMG_3782.JPG.jpg'),(2,'IMG_3783.JPG.jpg'),(2,'IMG_3792.JPG.jpg'),(2,'IMG_3809.JPG.jpg'),
(3,'IMG_3762.JPG.jpg'),(3,'IMG_3763.JPG.jpg'),(3,'IMG_3764.JPG.jpg'),(3,'IMG_3765.JPG.jpg'),(3,'IMG_3769.JPG.jpg'),(3,'IMG_3771.JPG.jpg'),(3,'IMG_3772.JPG.jpg'),(3,'IMG_3780.JPG.jpg'),(3,'IMG_3781.JPG.jpg'),(3,'IMG_3782.JPG.jpg'),(3,'IMG_3783.JPG.jpg'),(3,'IMG_3792.JPG.jpg'),(3,'IMG_3809.JPG.jpg'),
(4,'HDH_3409.jpg'),(4,'HDH_3413.jpg'),(4,'HDH_3418.jpg'),(4,'HDH_3420.jpg'),(4,'HDH_3423.jpg'),
(5,'DSC05288.png'),(5,'DSC05295.png'),(5,'DSC05301.png'),(5,'DSC05308.jpg'),(5,'DSC05326.png'),(5,'DSC05331.png'),(5,'DSC05338.jpg'),(5,'DSC05340.png'),(5,'HDH_3429.jpg'),(5,'HDH_3438.jpg'),(5,'HDH_3443.jpg'),(5,'HDH_3449.jpg'),
(6,'253502069_2201180803380123_4651375655379646979_n.jpg'),(6,'253613708_2201180816713455_6240897319290500626_n (1).jpg'),(6,'253685990_2201180793380124_4162638306916141093_n.jpg'),
(7,'LP1-1.png'),(7,'LP2-1.png'),(7,'LP3-1.png'),(7,'LP4-1.png'),(7,'LP5-2.png'),(7,'LP6-2 (1).png'),
(8,'DSC01478.jpg'),(8,'DSC030281.png'),(8,'DSC030351.png'),(8,'DSC030411.png'),(8,'DSC030463.png'),
(9,'3ddđ.png'),(9,'DSC01333.jpg'),(9,'DSC01374.jpg'),(9,'DSC01388.jpg'),(9,'DSC030171.png'),
(10,'Artboard 3@4x-88100-finaslfdff.jpg'),
(11,'Artboard 10@4x-88100-finaslfdff.jpg'),(11,'Artboard 11@4x-88100-finaslfdff.jpg'),(11,'Artboard 12@4x-88100-finaslfdff.jpg'),
(12,'Artboard 16@4x-88100-finaslfdff.jpg'),(12,'Artboard 19@4x-88100-finaslfdff.jpg'),
(13,'IMG_7047 (1).jpg'),(13,'IMG_7047 (1)_edited.png'),(13,'IMG_7048_edited.png'),(13,'IMG_7061.jpg'),
(14,'66.png'),(14,'67.png'),(14,'68.png'),(14,'69.png'),(14,'70.png'),(14,'71.png'),(14,'72.png'),(14,'73.png'),(14,'74.png'),(14,'75.png'),(14,'76.png'),
(15,'54.png'),(15,'55.png'),(15,'59.png'),(15,'60.png'),(15,'61.png'),(15,'62.png'),(15,'63.png'),(15,'64.png'),(15,'65.png'),
(16,'50.png'),(16,'51.png'),(16,'52.png'),(16,'53.png'),(16,'57.png'),(16,'58.png'),
(17,'43.png'),(17,'44.png'),(17,'45.png'),(17,'46.png'),(17,'47.png'),(17,'48.png'),(17,'49.png'),
(18,'26.png'),
(19,'41.png'),(19,'42.png'),
(20,'38.png'),(20,'39.png'),
(21,'33.png'),(21,'34.png'),(21,'35.png'),(21,'36.png'),(21,'37.png'),
(22,'18.png'),(22,'19.png'),(22,'20.png'),(22,'21.png'),
(23,'22.png'),(23,'24.png'),(23,'25.png'),(23,'30.png'),(23,'31.png'),(23,'40.png'),
(24,'27.png'),(24,'28.png'),
(25,'10.png'),
(26,'12.png'),(26,'7.png'),(26,'8.png'),
(27,'5.png'),
(28,'6.png'),
(29,'3.png'),
(30,'4.png'),
(31,'2.png'),
(32,'1.png'),(32,'1_edited.png'),
(33,'BD_a.png'),(33,'BD_b.png'),(33,'BD_c.png'),(33,'BD_d.png'),
(34,'LC-4.png'),(34,'LC-B.png'),(34,'LC-F.png'),
(35,'V19-B.png'),(35,'V19-Bin.png'),(35,'V19-F.png'),(35,'V19-Fin.png'),
(36,'UNS.png'),(36,'UNS3.png'),(36,'V16-B.png'),(36,'V16-F.png'),
(37,'HB01-F.png'),(37,'HB01-in.png'),(37,'HB01.png'),
(38,'V05C.png'),(38,'V05F.png'),(38,'V10-B.png'),(38,'V10-F.png'),(38,'V10-S.png'),
(39,'T08-B.png'),(39,'T08-F.png'),
(40,'T11-B.png'),(40,'T11-F.png'),
(41,'T15-3.png'),(41,'T15-F.png'),
(42,'T43-B.png'),(42,'T43-F.png'),
(43,'V10-B.png'),(43,'V10-F.png'),(43,'V10-S.png'),
(44,'T02-B.png'),(44,'T02-F.png'),(44,'t02-gf.png'),(44,'t02-gfc.png'),(44,'t02-gfvc.png'),(44,'t02-sd.png'),(44,'T02_blue.png'),(44,'T02_purple.png'),
(45,'HB02-F.png'),(45,'HB02-R.png'),
(46,'v11-blue.png'),(46,'v11-green.png'),(46,'v11-sky.png'),
(47,'V09B.png'),(47,'V09F.png'),(47,'V09S.png'),
(48,'v06-bb.png'),(48,'v06-ff.png'),(48,'v06-rb.png'),(48,'v06-vc.png'),
(49,'t04 170.jpg'),
(50,'T01-B.png'),(50,'T01-Bin.png'),(50,'T01-F.png'),(50,'T01_a.png'),(50,'T01_b.png'),(50,'T01_c.png'),(50,'T01_d.png'),(50,'T01_e.png'),(50,'T01_f.png'),(50,'T01_g.png'),
(51,'T12-B.png'),(51,'T12-Bin.png'),(51,'T12-F.png'),(51,'T12-Fin.png'),
(52,'T44-B.png'),(52,'T44-F.png'),(52,'T44-In.png'),(52,'T44.png'),
(53,'T29-2.png'),(53,'T29-B.png'),(53,'T29-F.png'),(53,'T29-Fin.png'),
(54,'T45-B.png'),(54,'T45-F.png'),
(55,'T41-B.png'),(55,'T41-Bin.png'),(55,'T41-F.png'),(55,'T41-Fin.png'),
(56,'v25-ff.png'),(56,'v25-ffd.png'),(56,'v25-jh.png'),
(57,'Balo04-B.png'),(57,'Balo04-F.png'),(57,'Balo04-In.png'),(57,'balo04-pof.png'),(57,'balo04-sf.png'),(57,'balo04-sfkk.png'),
(58,'1D7A0371.jpg'),
(59,'v25-ff.png'),(59,'v25-ffd.png'),(59,'v25-jh.png'),
(60,'v04-bb.png'),(60,'v04-cc.png'),(60,'v04-yy.png'),
(61,'v01 60.jpg'),(61,'v01-gb.png'),(61,'v01-green.png'),(61,'v01-navy.png'),(61,'v01-orange.png'),(61,'v01-pink.png'),(61,'v01-red.png'),(61,'V01-SKY.png'),(61,'v01-white.png'),(61,'v01-yellow.png'),
(62,'v14-58.png'),(62,'v14-hg.png'),(62,'v14-hgh.png'),
(63,'v24-lk.png'),(63,'v24-lo.png'),(63,'v24-poi.png'),
(64,'v08-rr.png')
insert into Blogs (AuthorID,AuthorName,Title,Summary,Content) values
('admin','Hoang Thi Thuy Duong','thai ethnique mai chau-hoa binh','Four villages in the Mai Chau valley have formed a coalition, manufacturing brocade cloth with the productive force of more than 300 loin looms, in order to develop handicraft tourism in their regions. The people of the Lac, Nhot, Van and Pom Coong brocade villagers sell unique handbags, clothes, wallets and pieu handkerchiefs made of brocade as the mean of living.','"<p>Mai Chau district has a total population of 55.663 people whilst 50% are women. There are 5 majoritty ethnic in Mai Chau including 73,3% Thai Ethnic, 17,33% Muong Ethnic, 11,96 Kinh Ethnic, 9,83 % Mong Ethnic, 3.58 % Giao Ethnic. Mai Chau is divided into 22 villages with the percent of poor households take 21,14%( households with income of average 30$ per month). Average population of Mai Chau is 35 years old.</p>

<p>&nbsp;</p>

<p>Four villages in the Mai Chau valley have formed a coalition, manufacturing brocade cloth with the productive force of more than 300 loin looms, in order to develop handicraft tourism in their regions. The people of the Lac, Nhot, Van and Pom Coong brocade villagers sell unique handbags, clothes, wallets and pieu handkerchiefs made of brocade as the mean of living.</p>

<p>&nbsp;</p>

<p>Weaving with the use of the traditional loin loom is a skill and occupation that is passed down generations among women in these villages. Even as women are engaged in cultivation, weaving is a secondary occupation, with every household owning a traditional loom. Though women or girls may not necessarily undergo training in weaving, the skills are learnt through lived experiences and by participating in the activity from an early age while assisting their mothers or elders.</p>

<p>&nbsp;</p>

<p>Traditionally, the loin loom has an economic significance as well and forms an important part of the socio-culture of tribal societies. But unfortunately, over the years, loin looms have been slowly disappearing and so is the weaving skill. As the result, younger generation no longer has the skill nor the knowledge as weaving is not done in their homes.</p>

<p>The massive invasion of cheap materials and products from china has quickly taken the market. The traditional weaving village slowly disappear. Many young people had to leave their village to be workers in the cities to secure some stable income for the family and themselves. The whole traditional weaving village of Mai Chau face the challenge of being disappear since the young generation will no longer how to work on the loom as they see no future of it and the old generation will also slowly pass away without having a chance to let their children to inherit from their skillful weaving skill.</p>

<p>&nbsp;</p>

<p>Nowadays, income of most people in the villages is based on cultivation and tourism by providing accommodation, food, organizing tours and selling souvenirs to tourists. The weaving village has been therefore becoming more and more commercial and lost its root to the cultural and traditional values.</p>'),
('admin','Hoang Thi Thuy Duong','weaving villages in vietnam','Nowadays, Vietnam weaving villages are slowly becoming major tourist attractions, primarily because of their expert weavers and artisans, who do not shy away from selling their handcrafted creations in tourist-oriented souvenir shops and markets. Hand-woven cotton, silk and brocade with unique motifs, designs and colors are used to make clothing, bags, purses, handkerchiefs and other items, but their textiles can also be sold in bulk. They are the perfect souvenirs, since they are unique to the people who made them, and the place they are bought from.','"<p>There are approximately 2000 craft villages in Vietnam, some of which are traditional, while others are modern. About 30% of the country&rsquo;s households take part in some for of craft activity. Craft villages are important to the nation, because they help counter rural poverty, and reduce the rural-urban income gap. To the people, crafting villages offer the opportunity to be independent by providing jobs and income during off-crop seasons, while improving their quality of life and helping to preserve their culture.</p>

<p>Nowadays, Vietnam weaving villages are slowly becoming major tourist attractions, primarily because of their expert weavers and artisans, who don&rsquo;t shy away from selling their handcrafted creations in tourist-oriented souvenir shops and markets. Hand-woven cotton, silk and brocade with unique motifs, designs and colors are used to make clothing, bags, purses, handkerchiefs and other items, but their textiles can also be sold in bulk. They are the perfect souvenirs, since they are unique to the people who made them, and the place they are bought from.</p>

<p>Vietnamese Brocade is a type of woven fabric made from raw cotton, flax or hemp. It is rich in texture, and is usually dyed in many colors, using natural dyes made from plants, seeds and other resources that the artisans collect from their surroundings.</p>

<p>The weaving patterns and designs are distinctly unique, and are primarily derived from the traditional weaving techniques of three ethnic minorities: the Mong people, the Ta Oi people, and the Cham people. Their weaving traditions and techniques are passed down from one generation to the next, through the women in the family.</p'),
('admin','Hoang Thi Thuy Duong','the orginal of fabric','The art of weaving has evolved over the course of thousands of years, through discovery and experimentation. It involves the production of fabric or cloth by interlacing two distinct sets of yarns or threads in a right angle. The (usually pulled taut) vertical strings are called the warp, and the horizontal thread that is intertwined over and under them is called the weft. The way these two strings are interwoven affects the characteristics of the cloth that will be produced.','"<p>The art of weaving has evolved over the course of thousands of years, through discovery and experimentation. It involves the production of fabric or cloth by interlacing two distinct sets of yarns or threads in a right angle. The (usually pulled taut) vertical strings are called the warp, and the horizontal thread that is intertwined over and under them is called the weft. The way these two strings are interwoven affects the characteristics of the cloth that will be produced.</p>

<p>Early civilization called for temporary shelters to be built, so knowing how to twine, plait, knot and weave materials such as grass, twigs, string and twine together, in order to build walls, roofs, bedding, baskets and doors, was imperative. The idea of interlacing materials together to create a weave was probably inspired by nature; by observing birds&rsquo; nests, spider webs and various animal constructions, the early civilization artisans discovered they could manipulate bendable materials and create objects that would make their life easier.</p>

<p>It is believed that man first learned how to create string 20 to 30 thousand years ago, by twisting plant fibres together. This technique evolved through time, and man was eventually able to stretch and dry fibres, in order to produce finer threads.</p>

<p>A distinct fabric impression in an archeological find (<a href=""http://en.wikipedia.org/wiki/Doln%C3%AD_V%C4%9Bstonice_%28archaeology%29"" rel=""noopener noreferrer noopener"" target=""_top"">Dolni Vestonice</a>), has lead scientists to the conclusion that the discovery of weaving actually took place as early as the Paleolithic era.</p>'),
('admin','Hoang Thi Thuy Duong','weaving techniques || the plain weave',' A plain weave is the process of pulling the weft thread (horizontal thread) over the first warp thread (vertical thread), then under the second, over the third, and so on until you get to the end of the warp threads. I always start left to right and start my weave going over the first warp thread. This is because I can later weave in my loose end of thread easily. Starting by going under the first warp thread would cause the weave to look not as seamless. ','"<p>On the second pass back, you are now starting opposite of where you ended. So if my weft thread ended over the warp thread, my next pass back would be going right to left and passing under the warp thread, then going over, then under, and so on until the first warp thread is met again. The basic weave continues on in this way over as many warp threads as you wish.</p>

<p>. Weave the shed stick all the way across your warp threads. Now when you are weaving with the shed stick turn the stick so it is vertical and creates a gap between the lower and upper warp threads. This gap is also known as the shed, hence the shed stick name</p>

<p>,&nbsp;through the shed. Once you are finished with this pass, lay your shed stick flat or horizontal again and push it up away from your weft threads. Now take your stick shuttle and use the corner to pick up the warp threads in the opposite way from before, working your weft thread across your piece. For the next pass bring your shed stick down by your weft again and turn it vertical to continue your weave in the same shed stick, then weave back pattern. You get the drift.</p>

<p>&nbsp;</p>'),
('admin','Hoang Thi Thuy Duong','how our products are made?','Every product has its own history is what truly applied with our products, those you have been seeing or looking at right now. ','"<p>Every product has its own history is what truly applied with our products, those you have been seeing or looking at right now. In order to give you a better understanding about what is standing behind them,we would like to proudly walk you through this exciting journey to learn about how our products are made and hopefully after having a closer look, you will grow more appreciation, love and care for each little item you consider to bring home.</p>

<p>&nbsp;</p>

<p>All our products are belonging to the project &ldquo;Restore, promote traditional weaving villages toward sustainable production and empower minority women&rdquo;, they therefore appear not as just a regular product but also hold a beautiful story behind. With our mission and goals to support these minority villages and women to reach out farther to the world so you would know, in a small corner of the world, there are these dedicated, hardworking women who commit themselves into each tune of the shuttle going back and forth on the looms to deliver the highest quality of handmade products.</p>

<p>&nbsp;</p>

<p>First is the mulberry farming process that made beautiful raw silk threads. These yarns come directly from locals in the villages who live just by the farm and taking care of the silkworms since they are just as tiny as a small ant until they grow up turn into a moth and fly away, leaving behind the cocoon that would later to be processed into raw yarns.</p>

<p>&nbsp;</p>

<p><img height=""1024"" src=""https://static.wixstatic.com/media/e69a3e_5b16b250a36943d3aa63d4ac1c9836f5~mv2.jpg/v1/fill/w_740,h_555,al_c,q_90/e69a3e_5b16b250a36943d3aa63d4ac1c9836f5~mv2.webp"" width=""1365"" /></p>

<p>Mulberry farm on the mountains of Mai Chau- Hoa Binh</p>

<p>&nbsp;</p>

<p><img height=""960"" src=""https://static.wixstatic.com/media/e69a3e_b2ce172da3a840e0b3832f4b509c5dc8~mv2.jpg/v1/fill/w_720,h_960,al_c,q_90/e69a3e_b2ce172da3a840e0b3832f4b509c5dc8~mv2.webp"" width=""720"" /></p>

<p>Feeding the silkworm with fresh chopped mulberry leave</p>

<p>&nbsp;</p>

<p>When the raw fibers are ready and processed, they will be brought to the factory nearby so the workers could start the dyeing process using 100% natural ingredients from surrounding forest, farms such as Yam roots, Turmeric, Herbal leaves etc.&hellip; These raw yarns will be soaked deeply in either boiling water of the Yam roots or the juice from smashing the Turmeric to absorb all colors and later to become those beautiful, colorful yarns.</p>

<p>&nbsp;</p>

<p><img height=""1512"" src=""https://static.wixstatic.com/media/e69a3e_22521c77bd0640ac980e6379db182de5~mv2_d_2016_1512_s_2.jpg/v1/fill/w_740,h_555,al_c,q_90/e69a3e_22521c77bd0640ac980e6379db182de5~mv2_d_2016_1512_s_2.webp"" width=""2016"" /></p>

<p>Smashing Turmeric to get the juice for dyeing</p>

<p>&nbsp;</p>

<p><img height=""1512"" src=""https://static.wixstatic.com/media/e69a3e_63d2ecb894ee4e828be92951cf6ff202~mv2_d_2016_1512_s_2.jpg/v1/fill/w_740,h_555,al_c,q_90/e69a3e_63d2ecb894ee4e828be92951cf6ff202~mv2_d_2016_1512_s_2.webp"" width=""2016"" /></p>

<p>Dyeing raw yarns by soaking them into Turmeric juice</p>

<p>&nbsp;</p>

<p><img height=""3024"" src=""https://static.wixstatic.com/media/e69a3e_e7fc961000e049879b3385ec9b821e64~mv2_d_4032_3024_s_4_2.jpg/v1/fill/w_740,h_555,al_c,q_90/e69a3e_e7fc961000e049879b3385ec9b821e64~mv2_d_4032_3024_s_4_2.webp"" width=""4032"" /></p>

<p>hanging up raw yarns and fabrics after being dyed</p>

<p>&nbsp;</p>

<p>Before being used as the threads for weaving, the workers need to go through one of the most complicated processes is to spin the thread by the wheel and set up the wanted designs for the looms. This traditional technique has been passed through generations of minority people so they would know exactly how to arrange the warp(vertical threads) to later insert the weft threads from weaving to make different designs.</p>

<p>&nbsp;</p>

<p><img height=""3024"" src=""https://static.wixstatic.com/media/e69a3e_64759e7d099341778427a2f690e8e699~mv2_d_4032_3024_s_4_2.jpg/v1/fill/w_740,h_555,al_c,q_90/e69a3e_64759e7d099341778427a2f690e8e699~mv2_d_4032_3024_s_4_2.webp"" width=""4032"" /></p>

<p>Spinning the threads by the most traditional hand method</p>

<p>&nbsp;</p>

<p><img height=""1512"" src=""https://static.wixstatic.com/media/e69a3e_69eb61d2e0e447a99b6c9089b179c5db~mv2_d_2016_1512_s_2.jpg/v1/fill/w_740,h_555,al_c,q_90/e69a3e_69eb61d2e0e447a99b6c9089b179c5db~mv2_d_2016_1512_s_2.webp"" width=""2016"" /></p>

<p>Setting up the warp threads for the looms</p>

<p>&nbsp;</p>

<p>Those beautiful yarns will be continued the journey to be transferred into something even more beautiful under the skillful hands of the artisans who could not mind sitting for hours by the looms, patiently focus on each tune of the shuttle going back and forth to create those amazing patterned fabrics. They work with passion, dreams and hope to bring these beautiful handcrafts to people who find the values and truly appreciated it.</p>

<p>&nbsp;</p>

<p><img height=""3024"" src=""https://static.wixstatic.com/media/e69a3e_a5042e87575c4c51839703cc16ff9664~mv2_d_4032_3024_s_4_2.jpg/v1/fill/w_740,h_555,al_c,q_90/e69a3e_a5042e87575c4c51839703cc16ff9664~mv2_d_4032_3024_s_4_2.webp"" width=""4032"" /></p>

<p>Working on the loom as a joy and daily work of these minority women</p>

<p>&nbsp;</p>

<p><img height=""1512"" src=""https://static.wixstatic.com/media/e69a3e_f0077c7b141344b0a0dfc082f0b39b08~mv2_d_2016_1512_s_2.jpg/v1/fill/w_740,h_555,al_c,q_90/e69a3e_f0077c7b141344b0a0dfc082f0b39b08~mv2_d_2016_1512_s_2.webp"" width=""2016"" /></p>

<p>Hardworking, dedicated, passionate women working on the looms</p>

<p>&nbsp;</p>

<p>And now in the end of the journey when you are getting closer, many beautiful weavings patterned were just created like that to later to be continued to become different products. What made them the most unique is because they are produced in the most sustainable, slow process with 100% hand labor involved. Our design, product development, cutting, sewing departments coordinate to find the most suitable ideas of products to be able deliver to your ones with timeless and high values. We strike to improve everyday to create more artworks and it is our mission to be here, to present our items in some small parts of your daily, enjoyable living.</p>

<p>&nbsp;</p>

<p><img height=""2300"" src=""https://static.wixstatic.com/media/7ab687_2a7a0ec9f8e94388b500ad3dc20c9bfd~mv2_d_2300_2300_s_2.png/v1/fill/w_740,h_740,al_c,q_95/7ab687_2a7a0ec9f8e94388b500ad3dc20c9bfd~mv2_d_2300_2300_s_2.webp"" width=""2300"" /></p>

<p><em>Handbag made from 100% hand weaving fabric</em></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img height=""3840"" src=""https://static.wixstatic.com/media/7ab687_8e3870e6eb164bb6904091aff221d8eb~mv2.jpg/v1/fill/w_740,h_493,al_c,q_90/7ab687_8e3870e6eb164bb6904091aff221d8eb~mv2.webp"" width=""5760"" /></p>

<p><em>Kitchen Gloves made from 100% hand weaving fabric</em></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img height=""4032"" src=""https://static.wixstatic.com/media/7ab687_e456e369c82b4d2094719b0c7e96f5a0~mv2.jpg/v1/fill/w_740,h_987,al_c,q_90/7ab687_e456e369c82b4d2094719b0c7e96f5a0~mv2.webp"" width=""3024"" /></p>

<p><em>Baby bibs made from 100% natural dyed and had weaving fabric</em></p>'),
('admin','Hoang Thi Thuy Duong','embroidery villages in vietnam','There are many embroidery villages in Vietnam, but Quat Dong village in Hanoi is well known for its high quality embroidery products. Located next to a national highway, the Quat Dong embroidery village is one of the most well-known traditional handicraft villages in Vietnam.','"<p>There are many embroidery villages in Vietnam, but Quat Dong village in Hanoi is well known for its high quality embroidery products. Located next to a national highway, the Quat Dong embroidery village is one of the most well-known traditional handicraft villages in Vietnam.</p>

<p>&nbsp;</p>

<p><img height=""426"" src=""https://static.wixstatic.com/media/7ab687_b634bbdec5f749df9e66410532b40f96~mv2.jpg/v1/fit/w_640,h_426,al_c,q_20,enc_auto/file.jpg"" width=""640"" /></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>Embroidery has been developing around here since the 17th century, local skilled artisans were chosen to make sophisticated embroidered costumes for the Vietnamese King, Queen and other Royal family members before Vietnam&nbsp;became a socialist republic country.</p>

<p>The first man who taught the local people how to embroider was Dr. Le Cong Hanh, who lived during the Le dynasty. He learned how to embroider while on a trip to China as an envoy, and taught the villagers of Quat Dong&nbsp;upon his return. Although these skills eventually spread across the country, the Quat Dong&rsquo;s embroidery creations are still highly appreciated.</p>

<p>&nbsp;</p>

<p><img height=""1000"" src=""https://static.wixstatic.com/media/7ab687_92f7e1e0045940b6b95f5806d63f28bd~mv2.jpg/v1/fit/w_750,h_931,al_c,q_20,enc_auto/file.jpg"" width=""3688"" /></p>


<p>&nbsp;</p>

<p>In order to create beautiful embroideries, an artisan must be patient, meticulous and have an eye for design, along with &quot;clever&quot; hands. Nowadays, Quat Dong&#39;s products may range from clothes, bags, pillowcases, to paintings and decorations, which are exported to many countries all over the world. An opportunity to meet in person with artisans in Quat Dong would indeed interesting and eyes- opening to watch these true, hardworking artisans who seem to put all their heart in each work they produce.</p>

<p>&nbsp;</p>

<p><img height=""404"" src=""https://static.wixstatic.com/media/7ab687_941dc3dac2f14920a975270801aa31ed~mv2.jpg/v1/fit/w_640,h_404,al_c,q_20,enc_auto/file.jpg"" width=""640"" /></p>

<p>These beautiful works that hold traditional values of Vietnam would slowly disappear without a relentless effort of artisans who strive to pass their passion and skill to the next generations. This is also one of the main reasons that urges Empower Women Asia to work closer with different groups of artisans, especially the women and girls in the villages, so their works could be widely understood, noticed and appreciated both domestic and internationally.</p>'),
('admin','Hoang Thi Thuy Duong','BAMBOOO AND RATTAN HANDICRAFT VILLAGE OF VIETNAM','Phu Vinh is known as one of the most famous bamboo and rattan handicraft villages of Vietnam with its more than 400 years existence. The skill to weave and turn bamboo and  rattan into beautifully hand-crafted products by the subtle and skillful hands of the artisans here is considered as one of the highest levels.','"<p>However, bamboo and rattan products of Phu Vinh have been recently produced massively with poor quality due to a lack of an investment into proper steps such as: design, technique, production. The traditional bamboo and rattan hand weaving skill has therefore slowly disappeared. Being aware of this threats and in an effort to maintain this long-existing traditional values, artisan Nguyen Van Son from Phu Vinh has been trying to bring the modern designs applied bamboo and rattan materials along with using the traditional weaving technique into his products.</p>

<p>&nbsp;</p>

<p><img height=""402"" src=""https://static.wixstatic.com/media/7ab687_d59e7fb9ab3e449ebdf69632796bfcc4~mv2.jpg/v1/fit/w_720,h_402,al_c,q_20,enc_auto/file.jpg"" width=""720"" /></p>

<p><em>Bamboo and rattan handicraft works produced by local artisans </em></p>

<p>&nbsp;</p>

<p>Bamboo and rattan products are on the list of customers&rsquo; favorites recently due to its environmental, high quality and applicable advantages. Especially, in fashion industry, many women tend to look for the modern fashion designs inspired by traditional values, which is also a trend to go back to the 90s styles or even older, known as a circle of fashion. Understanding this crucial demand, the artisan has been trying to produce products from bamboo and rattan that hold the traditional values yet having more stylist designs in favor of the consumers&#39; taste.</p>

<p>&nbsp;</p>

<p><img height=""1000"" src=""https://static.wixstatic.com/media/7ab687_ce1811442b194d8a832496b6d384a24a~mv2.jpg/v1/fit/w_750,h_1119,al_c,q_20,enc_auto/file.jpg"" width=""1413"" /></p>

<p><em>Modern and high-end style fashion designed bag made of bamboo and rattan materials </em></p>

<p>&nbsp;</p>

<p>Light and luminous as the silk, the products produced from bamboo and rattan are known as the lightest yet most durable materials. Moreover, the traditional weaving technique has been studied and applied into the products to make sure they are the most sophisticated and at highest quality.</p>

<p>&nbsp;</p>

<p><img height=""750"" src=""https://static.wixstatic.com/media/7ab687_5f1af1303f874771b412c0549aef0a78~mv2.jpg/v1/fit/w_498,h_750,al_c,q_20,enc_auto/file.jpg"" width=""498"" /></p>

<p><em>A close up into bamboo and rattan weaving technique </em></p>

<p>&nbsp;</p>

<p>These materials are also produced and well proved under chemical free process that are 100% environmentally friendly and the guarantees for durability would go from 10 to 15 years of use. It has given the artisans of the Phu Vinh a hope to be able to bring their traditional products to a higher level, so they would be more appreciated and acceptable in the market.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img height=""1000"" src=""https://static.wixstatic.com/media/7ab687_05df7bfe750e405393d7be16d73b971f~mv2.jpg/v1/fit/w_750,h_930,al_c,q_20,enc_auto/file.jpg"" width=""2607"" /></p>

<p><em>Bamboo and rattan handbag designed and produced by artisan Son Nguyen </em></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img height=""607"" src=""https://static.wixstatic.com/media/7ab687_010bacb9ab334bae8cd1f00056a279bd~mv2.png/v1/fit/w_300,h_300,al_c,q_5,enc_auto/file.png"" width=""585"" /></p>

<p><em>Bamboo and rattan handbag designed and produced by artisan Son Nguyen</em></p>

<p>&nbsp;</p>'),
('admin','Hoang Thi Thuy Duong','traditional works of vietnam represented on modern fashion products','In the mission to support the Vietnamese women artisans from minority villages to improve their competitive advantages and secure a stable income, by applying traditional hand-crafted materials along with long existed inherited techniques on modern products, Empower Women Asia has been successfully in bringing together a Vietnamese embroidery artisan with Ananda Zurich- a vegan designer handbag brand from Switzerland.','"<p>With a philosophy to sustain the environmental and social values, the Swiss handbag brand has chosen pineapple leaves material for their designs and was even being able to transfer the traditional embroidery works of Vietnamese artisan into high-end fashion products as a proof for the compatibility between traditional and modern characters.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img height=""3619"" src=""https://static.wixstatic.com/media/7ab687_1992eb0e582247ffae454f744b13da3c~mv2.jpg/v1/fit/w_750,h_599,al_c,q_20,enc_auto/file.jpg"" width=""4532"" /><img height=""3619"" src=""https://static.wixstatic.com/media/7ab687_1992eb0e582247ffae454f744b13da3c~mv2.jpg/v1/fill/w_740,h_591,al_c,q_90/7ab687_1992eb0e582247ffae454f744b13da3c~mv2.webp"" width=""4532"" /></p>

<p><em>Customized embroidery design on Ananda&#39;s bag handmade by artisan Hoang Khuong </em></p>

<p>&nbsp;</p>

<p><img height=""2327"" src=""https://static.wixstatic.com/media/a27d24_7bbda40d06a14d059c0dfa5571b135be~mv2.jpg/v1/fill/w_740,h_574,al_c,q_90/a27d24_7bbda40d06a14d059c0dfa5571b135be~mv2.webp"" width=""3000"" /></p>

<p><em>Customized embroidery design on Ananda&#39;s bag handmade by artisan Hoang Khuong </em></p>

<p>&nbsp;</p>

<p>Artisan Hoang Khuong has also proved her skill that would meet the high and strict requirements from a swiss fashion brand which also showed a great potential of her works being applied for other fashion brands in international markets. We also understand that the sustainable values will only be fulfilled when there are compromises from both sides, it is the brands who certainly put sustainable criteria on priority of the business mentality and its also the suppliers, workers, artisans... who commit to deliver highest quality of products.</p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><iframe frameborder=""0"" height=""100%"" id=""widget2"" src=""https://www.youtube.com/embed/e4ZABlycHsQ?autoplay=0&amp;mute=0&amp;controls=1&amp;origin=https%3A%2F%2Fwww.empowerwomenasia.org&amp;playsinline=1&amp;showinfo=0&amp;rel=0&amp;iv_load_policy=3&amp;modestbranding=1&amp;enablejsapi=1&amp;widgetid=1"" title=""YouTube video player"" width=""100%""></iframe></p>

<p><em>Artisan Hoang Khuong is working on embroidery designs from Ananda Zurich</em></p>

<p>&nbsp;</p>

<p>&nbsp;</p>

<p><img height=""3265"" src=""https://static.wixstatic.com/media/7ab687_db3cc041dac44a258ced6adc13965524~mv2.jpg/v1/fill/w_740,h_493,al_c,q_90/7ab687_db3cc041dac44a258ced6adc13965524~mv2.webp"" width=""4898"" /></p>

<p><em>Artisan Hoang Khuong received the highest prize in a competition co-organized by KIBV</em></p>'),
('admin','Hoang Thi Thuy Duong','youngsters make videos to honour beauty of vietnamese women and traditional craft villages','NDO - Youngsters have displayed their creativeness in making videos to outline the Vietnamese cultural values and the beauty of Vietnamese women in traditional craft villages across the nation.','"<p>They participated in a video making contest themed &quot;Vietnamese women and craft villages&quot;, which was launched by the Empower Women Asia (EWA) project under the NGO Keep It Beautiful Vietnam (KIBV), to honour the women in traditional craft villages together with their efforts to preserve the national cultural values in the modern society. The contest was held from May to July 2021 through the creation of photos/videos with a duration of 3-5 minutes, carrying the message of promoting and preserving traditional craft villages, while honouring the beauty of the simple, rustic labour of Vietnamese women in general and ethnic minority women in particular in such traditional craft villages. Taking place mainly on the Facebook channel of the EWA, the contest has attracted many young people at home and abroad, bringing unique and new perspectives on traditional craft villages to the masses nationally and internationally. After only two months, the organisers received hundreds of entries with diverse and unique content. Through their creative products, young people have reflected the true image of sincere and rustic women in traditional craft villages, evoking their love for their homeland and national pride, while showing their respect and desire to promote the core and long-standing cultural values of the nation. Among 11 outstanding entries to the final round, a jury of famous journalists, editors, travel bloggers and photographers selected four best works for awards, in which the first prize came to the video &quot;My Nghiep Cham Brocade Village (Ninh Thuan)&quot; by Champasix; the &quot;Crab noodle making village (Hai Phong)&quot; by Nguyen Thanh Loan won the second prize; and two third prizes went to videos &quot;Chang Son Fan Village (Hanoi)&quot; by GEN and &ldquo;Chuong Hat Village (Hanoi)&quot; by Jelly Potatoes. In addition, the most favoured video award went to &quot;Thach Xa Bamboo Dragonfly Village (Hanoi)&quot; by Le.Morq. The contest also received the companionship of famous speakers, designers, art activists and influential faces in the public to jointly spread the nation&rsquo;s traditional cultural features to the community. It is expected to raise the community&#39;s understanding and respect for traditional craft villages, thereby spreading the message of preserving the quintessence and traditions of the nation, as well as respecting and promoting the nation&rsquo;s cultural values through the skilful hands of village women in simple, rustic daily labour. <em>Let&#39;s admire the beauty of the labour of women in traditional villages through the excellent works that won the contest&rsquo;s top prizes:</em></p>

<p><img height=""750"" src=""https://static.wixstatic.com/media/ed4bb5_6854a8ba8c9a4e5a8cc93b6b13ce2c30~mv2.png/v1/fill/w_740,h_463,al_c,q_95/ed4bb5_6854a8ba8c9a4e5a8cc93b6b13ce2c30~mv2.webp"" width=""1200"" /></p>

<p><img height=""541"" src=""https://static.wixstatic.com/media/ed4bb5_4cdc062405ff46b5b14f07514c4de712~mv2.png/v1/fill/w_740,h_334,al_c,q_95/ed4bb5_4cdc062405ff46b5b14f07514c4de712~mv2.webp"" width=""1200"" /></p>

<p><img height=""748"" src=""https://static.wixstatic.com/media/ed4bb5_ca0c10674e0a4a3db2cfe1360dea3981~mv2.png/v1/fill/w_740,h_461,al_c,q_95/ed4bb5_ca0c10674e0a4a3db2cfe1360dea3981~mv2.webp"" width=""1200"" /></p>

<p><img height=""697"" src=""https://static.wixstatic.com/media/ed4bb5_ce12f1a5bb6d428ebc6c924e2527a4f8~mv2.png/v1/fill/w_740,h_430,al_c,q_95/ed4bb5_ce12f1a5bb6d428ebc6c924e2527a4f8~mv2.webp"" width=""1200"" /></p>

<p><strong>Empower Women Asia (EWA) aims to foster the ethnic minority women and girls in the weaving villages of Vietnam to improve their skills, knowledge, and competitive advantages in producing sustainable textile products, creating opportunities to enhance the living standard and secure stable income. This year, EWA is coming back with the theme &ldquo;Weaving dreams by the handlooms&rdquo;, which carries hopes and high aspirations toward spreading the beautiful image of mothers and sisters sitting by the looms, weaving their colourful dreams.</strong></p>');
update Blogs set "Image" = cast('blog'+CONVERT(varchar(2),blogID) as nvarchar(255))
update Blogs set PublishedAt = CreatedAt