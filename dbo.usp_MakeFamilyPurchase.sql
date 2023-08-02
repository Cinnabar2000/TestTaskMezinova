USE MYTEST;
go
if object_id('dbo.usp_MakeFamilyPurchase') is not null
drop proc dbo.usp_MakeFamilyPurchase
go

create proc dbo.usp_MakeFamilyPurchase
	@FamilySurName as varchar(255)
as 
	if @FamilySurName not in(select SurName FROM dbo.Family)
		print N'Ошибка входных данных. Такой семьи нет';
	else 
		begin
		update F
		set 
			F.BudgetValue = B2.result 
		from dbo.Family AS F
			inner join (select sum(value) as result, ID_Family from dbo.Basket where ID_Family = (select ID from Family where SurName = @FamilySurName) group by ID_Family) AS B2
				on F.ID = B2.ID_Family
		where F.SurName = @FamilySurName;
		end
go
