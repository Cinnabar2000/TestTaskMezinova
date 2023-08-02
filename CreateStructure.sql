if object_id('dbo.Basket', 'U') is not null
  drop table dbo.Basket;

if object_id('dbo.SKU', 'U') is not null
  drop table dbo.SKU;

if object_id('dbo.Family', 'U') is not null
  drop table dbo.Family;
go  

create table dbo.SKU(
	ID                int                   not null identity,
	Code AS 's' + cast(ID AS varchar(30))  UNIQUE,
	Name              varchar(30)          not null,
	constraint PKS_ID primary key(ID),
);
create table dbo.Family(
	ID          int           not null identity,
	SurName     varchar(255)  not null,
	BudgetValue decimal(18, 2)           not null
	constraint PKF_ID primary key(ID)
);
create table dbo.Basket(
	ID            int            not null identity,
	ID_SKU        int            not null,
	ID_Family     int            not null,
	Ouantity      decimal(18, 2) not null,
	Value         decimal(18, 2) not null,
	PurchaseDate  DATE           not null DEFAULT(GETDATE()),
	DiscountValue decimal(18, 2) not null,
	constraint PKB_ID primary key(ID),
	constraint FK_Basket_SKU foreign key(ID_SKU)
	references dbo.SKU(ID),
	constraint FK_Basket_Family foreign key(ID_Family)
	references dbo.Family(ID),
	constraint CHK_Ouantity check(Ouantity >= 0),
	constraint CHK_Value check(Value >= 0)
);
