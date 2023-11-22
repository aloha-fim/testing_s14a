/*Lesson 1: Creating Indexes
**********************************************************************
Verify record count and non-existance 
of book Title 'Personal Watercraft Safety'
**********************************************************************
View all titles*/

sp_help titles; --shows table structure

--primary key is a clustered index and is created when you create the primary key

#Batch 1

Create Index Titles_Price --non clustered index
	On Titles(bktitle, slprice);
go


--another example
Create Unique Index Titles_UniqueName
	On Titles(bktitle);
go




Select 
	* 
From 
	Titles
Order By 
	bktitle;

--View indexes or lack thereof in structure of Titles table

sp_help titles;

/**************************************************************************
Test Batch 1.
Create 2 sort indexes, 1 Unique index
and then display the records
***************************************************************************

Batch 1 */

Create Index Titles_Price
	On Titles(bktitle, slprice);
go

Create Unique Index Titles_UniqueName
	On Titles(bktitle);
go

Select 
	*
From 
	Titles
Order By 
	2;
go

/*****************************************************************
Execute sp_Help Titles and view new structure.
Run second batch: Enter new record, 
Verify existance of new record.
*****************************************************************/

sp_help titles;

--Batch 2

INSERT 
	Titles 
	(pubdate, partnum, bktitle, slprice, devcost)
VALUES
	('2008-08-01', '22222', 'Personal Watercraft Safety', 35, 15382.14);
go

Select 
	*
From 
	Titles
Order By 
	2;
go

/**************************************************************
Test UniqueName Index.
Insert new record with same name but different Partnum.
**************************************************************/

INSERT 
	Titles 
	(pubdate, partnum, bktitle, slprice, devcost)
VALUES
	('2008-08-01', '33333', 'Personal Watercraft Safety', 35, 15382.14)

--Insertion of record failed


/*Lesson 2: Managing Indexes with Batch Processing
**********************************************************************
Reset
Verify all non clustered indexes have 
been removed via code or GUI.

Batch 3 */

drop Index Titles.Titles_Price;
go

Drop Index Titles.Titles_UniqueName;
go

sp_help Titles
/***********************************************************************
Create indexes on the fly and remove them
after their need has been eliminated. Remember 
that a few indexes will speed up searches but
too many indexes slow down the entire process.
***********************************************************************/

exec sp_help titles

--Batch 3

Create Index Titles_Price
On Titles(bktitle, slprice);
go

Select 
	*
From 
	Titles
where 
	slprice > 20
Order By 
	4, 2;
go

drop Index Titles.Titles_Price;
go

/* Verify that the index that was created is now gone 
by runing 'sp_help titles' and records are being displayed*/

sp_help titles


/*Reset Codes ***********************************************************
Make sure each statement ends with a semi colon */

Create Index Titles_Price
On Titles(bktitle, slprice);

drop Index Titles.Titles_Price;
go

Create Unique Index Titles_UniqueName
On Titles(bktitle);
go

Drop Index Titles.Titles_UniqueName;
go 

sp_help titles