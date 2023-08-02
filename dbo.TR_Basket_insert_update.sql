
if object_id('dbo.TR_Basket_insert_update') is not null
	drop trigger dbo.TR_Basket_insert_update
go
create trigger dbo.TR_Basket_insert_update on dbo.Basket after insert
	as 
		update dbo.Basket
			set DiscountValue = Value * 0.05
			where ID_SKU in (select ID_SKU from inserted group by ID_SKU having count(*) > 1)
			and ID in (select ID from inserted)
		update dbo.Basket
			set DiscountValue = 0
			where ID_SKU in (select ID_SKU from inserted group by ID_SKU having count(*) < 2)
			and ID in (select ID from inserted)
go