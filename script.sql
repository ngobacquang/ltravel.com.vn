USE [ltravelcomvndb]
GO
/****** Object:  StoredProcedure [dbo].[GetDuplicateLink]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[GetDuplicateLink]
(
@link nvarchar(300),
@web nvarchar(300)
)
as
begin
with groups_items as
(
select 'Items' as RowType, items.viapp, items.IID,items.VITITLE,items.VISEOLINKSEARCH
from ITEMS where VISEOLINKSEARCH <> '' and web=@web and VISEOLINKSEARCH like N''+@link+''
union
select 'Groups' as RowType, groups.vgapp, GROUPS.IGID,GROUPS.VGNAME,GROUPS.VGSEOLINKSEARCH
from GROUPS where VGSEOLINKSEARCH <> '' and web=@web and VGSEOLINKSEARCH like N''+@link+''
)
select groups_items.*
from groups_items
join
(
select viseolinksearch
from groups_items
group by viseolinksearch
HAVING (COUNT(viseolinksearch) > 1 )) groups_items_2 on groups_items_2.VISEOLINKSEARCH=groups_items.VISEOLINKSEARCH
order by VISEOLINKSEARCH
end

--exec GetDuplicateLink 'van-hoa-cong-dong',''


GO
/****** Object:  StoredProcedure [dbo].[GetGroupsOrItemByTitle]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create PROCEDURE [dbo].[GetGroupsOrItemByTitle]	
	@title varchar(500)
	,@condition nvarchar(500)
	,@orderby nvarchar(300)
	,@web nvarchar(300)
AS
declare @sql nvarchar(1000)

set @sql= 'select * from groups,items where (Groups.VGSEOLINKSEARCH='+QUOTENAME(@title,'''') +' or Items.VISEOLINKSEARCH='+QUOTENAME(@title,'''')+') and (groups.web like '+QUOTENAME(@web,'''')+' or items.web like '+QUOTENAME(@web,'''')+')'
if(LEN(@condition)>0)
	set @sql=@sql+' and '+@condition

EXEC sp_executesql @sql



GO
/****** Object:  StoredProcedure [dbo].[Groups_DeleteGroupAndGroupItemByIgid]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Groups_DeleteGroupAndGroupItemByIgid]
@IGID INT,
@web nvarchar(300)
AS	
DELETE FROM dbo.GROUPS_ITEMS WHERE IGID = @IGID and GROUPS_ITEMS.web like @web
DELETE FROM dbo.GROUPS WHERE IGID = @IGID and GROUPS.web like @web



GO
/****** Object:  StoredProcedure [dbo].[Groups_DeleteGroupByIgid]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Groups_DeleteGroupByIgid] @IGID INT
,@web nvarchar(300)
AS 
    DECLARE @NEW_IGPARENTS NVARCHAR(200)
    SELECT  @NEW_IGPARENTS = IGPARENTSID
    FROM    dbo.GROUPS
    WHERE   IGID = @IGID  and groups.web like @web
    IF ( SELECT COUNT(*)
         FROM   dbo.GROUPS_ITEMS
         WHERE  LEFT(VPARAMS, LEN(@NEW_IGPARENTS)) = @NEW_IGPARENTS
       ) = 0 
        BEGIN
            DELETE  FROM dbo.GROUPS
            WHERE   LEFT(IGPARENTSID, LEN(@NEW_IGPARENTS)) = @NEW_IGPARENTS
            
            SELECT  @@ROWCOUNT AS RowAffected
        END
        ELSE
		SELECT  @@ROWCOUNT AS RowAffected



GO
/****** Object:  StoredProcedure [dbo].[Groups_GetGroupPagging]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Groups_GetGroupPagging]
    (
      @pageNumbers INT ,
      @returnRows INT ,
      @whereClause NVARCHAR(2000) ,
      @orderBy NVARCHAR(2000)
      ,@web nvarchar(300)
    )
AS 
    BEGIN
        SET NOCOUNT ON
    
        IF @pageNumbers < 1 
            SET @pageNumbers = 1
	
        IF @returnRows < 1 
            SET @returnRows = 0
    
        DECLARE @fromRows INT
        DECLARE @toRows INT
			
        SET @fromRows = ( ( @pageNumbers - 1 ) * @returnRows ) + 1
        IF @pageNumbers = 1 
            SET @fromRows = 1
        
        SET @toRows = @fromRows + @returnRows - 1
        	
        DECLARE @OrderClause AS NVARCHAR(200)
        IF LEN(@orderBy) > 0 
            SET @OrderClause = ' ORDER BY ' + @orderBy            
        ELSE 
            SET @OrderClause = ' ORDER BY [Groups].[igid] '            
			
        DECLARE @sql AS NVARCHAR(4000)
        SET @sql = ' 
				WITH [RankedList] AS 
				( 
					SELECT '
        IF @fromRows > 0 
            SET @sql = @sql + ' TOP (' + CONVERT(NVARCHAR, @toRows) + ') '
        
        SET @sql = @sql
            + ' 
					[Groups].*,			
					ROW_NUMBER() OVER ( ' + @OrderClause
            + ' ) AS [Rank] 
					FROM [Groups] where Groups.web like '+QUOTENAME(@web,'''')+'
					 '
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause            
        SET @sql = @sql + ' 
				) 
				SELECT
				[RankedList].*
				FROM
				[RankedList]
				WHERE
				[RankedList].[Rank] >= ' + CONVERT(NVARCHAR, @fromRows)
            + '
				ORDER BY
				[RankedList].[Rank] '
				
				
        EXEC sp_executesql @sql
	
	--== Count Items ==--
        SET @sql = ' 
				SELECT Count(*) AS TotalRows
				FROM [dbo].[Groups] where Groups.web like '+QUOTENAME(@web,'''')+'			
				'
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause  
					
        EXEC sp_executesql @sql    
    END

--EXEC GROUPS_ITEMS_GetItems_Condition 1,3," LEFT([GROUPS].IGPARENTSID, LEN('0,52,58')) = '0,52,58' ","[ITEMS].[IID] DESC"



GO
/****** Object:  StoredProcedure [dbo].[Groups_GetGroupsByTitle]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Groups_GetGroupsByTitle]	
	@title varchar(500),
	@condition nvarchar(500)	
	,@web nvarchar(300)
AS

declare @sql nvarchar(1000)

set @sql= 'select * from Groups where Groups.web like '+QUOTENAME(@web,'''')+' and VGSEOLINKSEARCH= '+QUOTENAME(@title,'''')
if(LEN(@condition)>0)
	set @sql=@sql+' and '+@condition

EXEC sp_executesql @sql



GO
/****** Object:  StoredProcedure [dbo].[Groups_InsertGroup]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Groups_InsertGroup]
    @VGLANG VARCHAR(50) ,
    @VGAPP VARCHAR(50) ,
    @IGPARENTID NVARCHAR(100) ,
    @VGNAME NVARCHAR(500) ,
    @VGDESC NVARCHAR(1000) ,
    @VGCONTENT NTEXT ,
    @VGSEOTITLE NVARCHAR(500) ,
    @VGSEOLINK NVARCHAR(500) ,
    @VGSEOLINKSEARCH NVARCHAR(500) ,
    @VGSEOMETAKEY NVARCHAR(500) ,
    @VGSEOMETADESC NVARCHAR(MAX) ,
    @VGSEOMETACANONICAL NVARCHAR(500) ,
    @VGSEOMETALANG NVARCHAR(100) ,
    @VGSEOMETAPARAMS NVARCHAR(MAX) ,
    @VGIMAGE NVARCHAR(300) ,
    @VGPARAMS NVARCHAR(MAX) ,
    @IGTOTALITEMS INT ,
    @IGORDER INT ,
    @DGCREATEDATE DATETIME ,
    @DGUPDATE DATETIME ,
    @DGENDDATE DATETIME ,
    @IGENABLE INT
    ,@web nvarchar(300)
AS 
    INSERT  INTO dbo.GROUPS
            ( VGLANG ,
              VGAPP ,
              IGLEVEL ,
              IGPARENTID ,
              IGPARENTSID ,
              VGNAME ,
              VGDESC ,
              VGCONTENT ,
              VGSEOTITLE ,
              VGSEOLINK,
			  VGSEOLINKSEARCH ,
			  VGSEOMETAKEY  ,
			  VGSEOMETADESC ,
			  VGSEOMETACANONICAL ,
			  VGSEOMETALANG ,
			  VGSEOMETAPARAMS ,
              VGIMAGE ,
              VGPARAMS ,
              IGTOTALITEMS ,
              IGORDER ,
              DGCREATEDATE ,
              DGUPDATE ,
              DGENDDATE ,
              IGENABLE,
              web
            )
    VALUES  ( @VGLANG , -- VGLANG - varchar(50)
              @VGAPP , -- VGAPP - varchar(50)
              1 , -- IGLEVEL - int
              @IGPARENTID , -- IGPARENTID - int
              '' , -- IGPARENTSID - nvarchar(100)
              @VGNAME , -- VGNAME - nvarchar(500)
              @VGDESC , -- VGDESC - nvarchar(1000)
              @VGCONTENT , -- VGCONTENT - ntext
              @VGSEOTITLE ,
              @VGSEOLINK,
			  @VGSEOLINKSEARCH ,
			  @VGSEOMETAKEY  ,
			  @VGSEOMETADESC ,
			  @VGSEOMETACANONICAL ,
			  @VGSEOMETALANG ,
			  @VGSEOMETAPARAMS ,
              @VGIMAGE , -- VGIMAGE - nvarchar(300)
              @VGPARAMS , -- VGPARAMS - nvarchar(max)
              @IGTOTALITEMS , -- IGTOTALITEMS - int
              @IGORDER , -- IGORDER - int
              @DGCREATEDATE , -- DGCREATEDATE - datetime
              @DGUPDATE , -- DGUPDAT - datetime
              @DGENDDATE , -- DGENDDATE - datetime
              @IGENABLE,  -- IGENABLE - int
              @web
            )
    DECLARE @TOP_IGID INT
    SELECT  @TOP_IGID = MAX(IGID)
    FROM    dbo.GROUPS where GROUPS.web like @web
    IF @IGPARENTID = 0 
        BEGIN    
            UPDATE  dbo.GROUPS
            SET     IGPARENTSID = '0,' + CONVERT(NVARCHAR(MAX), @TOP_IGID)
                    + ','
            WHERE   IGID = @TOP_IGID
        END

    ELSE 
        BEGIN
            DECLARE @NEW_IGPARENTSID_OF_IGPARENTID NVARCHAR(100) 
            DECLARE @NEW_IGLEVEL INT
            DECLARE @IGPARENTSID_WILL_INSERT NVARCHAR(100) 
            
            SELECT  @NEW_IGLEVEL = IGLEVEL ,
                    @NEW_IGPARENTSID_OF_IGPARENTID = IGPARENTSID
            FROM    dbo.GROUPS
            WHERE   IGID = @IGPARENTID and GROUPS.web like @web
            SET @IGPARENTSID_WILL_INSERT = ''
                + CONVERT(NVARCHAR(MAX), @NEW_IGPARENTSID_OF_IGPARENTID)
                + CONVERT(NVARCHAR(MAX), @TOP_IGID) + ','
                
            SET @NEW_IGLEVEL = @NEW_IGLEVEL + 1
                
            UPDATE  dbo.GROUPS
            SET     IGPARENTSID = @IGPARENTSID_WILL_INSERT ,
                    IGLEVEL = @NEW_IGLEVEL
            WHERE   IGID = @TOP_IGID and GROUPS.web like @web
        END



GO
/****** Object:  StoredProcedure [dbo].[Groups_InsertGroupCondition]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Groups_InsertGroupCondition]
	@values  nvarchar(3000),
	@fields nvarchar(3000)
	,@web nvarchar(300)
AS

SET NOCOUNT ON

DECLARE @sqlInsertGroup AS NVARCHAR(4000)

SET @sqlInsertGroup = 
'
	insert into GROUPS ( ' + @fields + ',web) values(' + @values +','+@web +') 
'
EXEC sp_executesql @sqlInsertGroup



GO
/****** Object:  StoredProcedure [dbo].[Groups_InsertGroupContent]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Groups_InsertGroupContent]
    @VGLANG VARCHAR(50) ,
    @VGAPP VARCHAR(50) ,
    @IGPARENTID NVARCHAR(100) ,
    @VGNAME NVARCHAR(500) ,
    @VGDESC NVARCHAR(1000) ,
    @VGCONTENT NTEXT ,
    @VGSEOTITLE NVARCHAR(500) ,
    @VGSEOLINK NVARCHAR(500) ,
    @VGSEOLINKSEARCH NVARCHAR(500) ,
    @VGSEOMETAKEY NVARCHAR(500) ,
    @VGSEOMETADESC NVARCHAR(MAX) ,
    @VGSEOMETACANONICAL NVARCHAR(500) ,
    @VGSEOMETALANG NVARCHAR(100) ,
    @VGSEOMETAPARAMS NVARCHAR(MAX) ,
    @VGIMAGE NVARCHAR(300) ,
    @VGPARAMS NVARCHAR(MAX) ,
    @IGTOTALITEMS INT ,
    @IGORDER INT ,
    @DGCREATEDATE DATETIME ,
    @DGUPDATE DATETIME ,
    @DGENDDATE DATETIME ,
    @IGENABLE INT
    ,@web nvarchar(300)
AS 
    INSERT  INTO dbo.GROUPS
            ( VGLANG ,
              VGAPP ,
              IGLEVEL ,
              IGPARENTID ,
              IGPARENTSID ,
              VGNAME ,
              VGDESC ,
              VGCONTENT ,
              VGSEOTITLE ,
			  VGSEOLINK,
			  VGSEOLINKSEARCH ,
			  VGSEOMETAKEY  ,
			  VGSEOMETADESC ,
			  VGSEOMETACANONICAL ,
			  VGSEOMETALANG ,
			  VGSEOMETAPARAMS ,
              VGIMAGE ,
              VGPARAMS ,
              IGTOTALITEMS ,
              IGORDER ,
              DGCREATEDATE ,
              DGUPDATE ,
              DGENDDATE ,
              IGENABLE,
              web
            )
    VALUES  ( @VGLANG , -- VGLANG - varchar(50)
              @VGAPP , -- VGAPP - varchar(50)
              1 , -- IGLEVEL - int
              @IGPARENTID , -- IGPARENTID - int
              '' , -- IGPARENTSID - nvarchar(100)
              @VGNAME , -- VGNAME - nvarchar(500)
              @VGDESC , -- VGDESC - nvarchar(1000)
              @VGCONTENT , -- VGCONTENT - ntext
              @VGSEOTITLE ,
			  @VGSEOLINK,
			  @VGSEOLINKSEARCH ,
			  @VGSEOMETAKEY  ,
			  @VGSEOMETADESC ,
			  @VGSEOMETACANONICAL ,
			  @VGSEOMETALANG ,
			  @VGSEOMETAPARAMS ,
              @VGIMAGE , -- VGIMAGE - nvarchar(300)
              @VGPARAMS , -- VGPARAMS - nvarchar(max)
              @IGTOTALITEMS , -- IGTOTALITEMS - int
              @IGORDER , -- IGORDER - int
              @DGCREATEDATE , -- DGCREATEDATE - datetime
              @DGUPDATE , -- DGUPDAT - datetime
              @DGENDDATE , -- DGENDDATE - datetime
              @IGENABLE,  -- IGENABLE - int
              @web
            )
    DECLARE @TOP_IGID INT
    SELECT  @TOP_IGID = MAX(IGID)
    FROM    dbo.GROUPS  where groups.web like @web
    IF @IGPARENTID = 0 
        BEGIN    
            UPDATE  dbo.GROUPS
            SET     IGPARENTSID = '0,' + CONVERT(NVARCHAR(MAX), @TOP_IGID)
                    + ',' ,
                    VGDESC = @VGDESC + '&igid=' + CONVERT(NVARCHAR(MAX),@TOP_IGID)
            WHERE   IGID = @TOP_IGID  and groups.web like @web
        END

    ELSE 
        BEGIN
            DECLARE @NEW_IGPARENTSID_OF_IGPARENTID NVARCHAR(100) 
            DECLARE @NEW_IGLEVEL INT
            DECLARE @IGPARENTSID_WILL_INSERT NVARCHAR(100) 
            
            SELECT  @NEW_IGLEVEL = IGLEVEL ,
                    @NEW_IGPARENTSID_OF_IGPARENTID = IGPARENTSID
            FROM    dbo.GROUPS
            WHERE   IGID = @IGPARENTID  and groups.web like @web
            SET @IGPARENTSID_WILL_INSERT = ''
                + CONVERT(NVARCHAR(MAX), @NEW_IGPARENTSID_OF_IGPARENTID)
                + CONVERT(NVARCHAR(MAX), @TOP_IGID) + ','
                
            SET @NEW_IGLEVEL = @NEW_IGLEVEL + 1
                
            UPDATE  dbo.GROUPS
            SET     IGPARENTSID = @IGPARENTSID_WILL_INSERT ,
                    IGLEVEL = @NEW_IGLEVEL,
                    VGDESC = @VGDESC + '&igid=' + CONVERT(NVARCHAR(MAX),@TOP_IGID)
            WHERE   IGID = @TOP_IGID  and groups.web like @web
        END



GO
/****** Object:  StoredProcedure [dbo].[Groups_UpdateGroupParent]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Groups_UpdateGroupParent]
	@IGID int,
	@NewIGPARENTID int
	,@web nvarchar(300)
AS

	DECLARE @IgparentsIDofParent NVARCHAR(100)
	DECLARE @OldIgparentID NVARCHAR(100)
	DECLARE @IgLevelOfIgid INT
	DECLARE @IgLevelOf@NewIGPARENTID INT
	IF(@NewIGPARENTID>0)
		BEGIN
			SELECT @IgparentsIDofParent=IGPARENTSID FROM dbo.GROUPS WHERE IGID=@NewIGPARENTID  and groups.web like @web
			SELECT @IgLevelOf@NewIGPARENTID=IGLEVEL FROM dbo.GROUPS WHERE IGID=@NewIGPARENTID  and groups.web like @web
		END
	ELSE
	BEGIN
		SET @IgparentsIDofParent='0,'
		SELECT @IgLevelOf@NewIGPARENTID=0
	END

IF(CHARINDEX(','+CAST(@IGID AS VARCHAR(10)) +',',@IgparentsIDofParent)<1)/*Không cho cập nhật vào nó và con của nó*/
BEGIN
	SELECT @OldIgparentID=IGPARENTSID FROM dbo.GROUPS WHERE IGID=@IGID  and groups.web like @web
	SELECT @IgLevelOfIgid=IGLEVEL FROM dbo.GROUPS WHERE IGID=@IGID  and groups.web like @web

	UPDATE dbo.GROUPS SET IGPARENTID=@NewIGPARENTID WHERE IGID=@IGID  and groups.web like @web

	UPDATE dbo.GROUPS SET IGPARENTSID=REPLACE(IGPARENTSID,@OldIgparentID ,@IgparentsIDofParent+ CONVERT(NVARCHAR(100),@IGID) +','),IGLEVEL=IGLEVEL+(@IgLevelOf@NewIGPARENTID-@IgLevelOfIgid+1)
	WHERE CHARINDEX(@OldIgparentID,IGPARENTSID)=1  and groups.web like @web

	UPDATE dbo.GROUPS_ITEMS SET VPARAMS=REPLACE(VPARAMS,@OldIgparentID ,@IgparentsIDofParent+ CONVERT(NVARCHAR(100),@IGID)+',')
	WHERE CHARINDEX(@OldIgparentID,VPARAMS)=1  and GROUPS_ITEMS.web like @web
END



GO
/****** Object:  StoredProcedure [dbo].[GroupsGroupsItemsItems_GetAllData]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GroupsGroupsItemsItems_GetAllData]
		@top nvarchar(20),
		@fields nvarchar(2000),
		@condition nvarchar(4000),
		@order nvarchar(2000)
		,@web nvarchar(300)
	AS
	DECLARE @sqlGetGroupsGroupsItemsItems AS NVARCHAR(Max)
	if (LEN(@top) > 0)
        Set @top = ' top ' + @top;
    
    if (LEN(@fields) > 0)
		Set @fields =  @fields;
	else
		Set @fields = ' * ';
		
    if (LEN(@condition) > 0)
        Set @condition = ' and ' + @condition;
        
    if (LEN(@order) > 0)
        Set  @order = ' ORDER BY ' + @order;
        
    
	SET @sqlGetGroupsGroupsItemsItems = 
	'
		select ' + @top + @fields + ' from GROUPS_ITEMS left join ITEMS on GROUPS_ITEMS.IID = ITEMS.IID left join GROUPS on GROUPS_ITEMS.IGID = GROUPS.IGID where groups.web like '+QUOTENAME(@web,'''')+' ' + @condition + @order + ' 
	'
	EXEC sp_executesql @sqlGetGroupsGroupsItemsItems



GO
/****** Object:  StoredProcedure [dbo].[GroupsGroupsItemsItems_GetAllDataPagging]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GroupsGroupsItemsItems_GetAllDataPagging]
    (
      @pageNumbers INT ,
      @returnRows INT ,
      @whereClause NVARCHAR(2000) ,
      @orderBy NVARCHAR(2000)
      ,@web nvarchar(300)
    )
AS 
    BEGIN
        SET NOCOUNT ON
    
        IF @pageNumbers < 1 
            SET @pageNumbers = 1
	
        IF @returnRows < 1 
            SET @returnRows = 0
    
        DECLARE @fromRows INT
        DECLARE @toRows INT
			
        SET @fromRows = ( ( @pageNumbers - 1 ) * @returnRows ) + 1
        IF @pageNumbers = 1 
            SET @fromRows = 1
        
        SET @toRows = @fromRows + @returnRows - 1
        	
        DECLARE @OrderClause AS NVARCHAR(200)
        IF LEN(@orderBy) > 0 
            SET @OrderClause = ' ORDER BY ' + @orderBy            
        ELSE 
            SET @OrderClause = ' ORDER BY [ITEMS].[IID] '            
			
        DECLARE @sql AS NVARCHAR(4000)
        SET @sql = ' 
				WITH [RankedList] AS 
				( 
					SELECT '
        IF @fromRows > 0 
            SET @sql = @sql + ' TOP (' + CONVERT(NVARCHAR, @toRows) + ') '
        
        SET @sql = @sql
            + ' 
					[GROUPS_ITEMS].*,
					[GROUPS].VGNAME,[GROUPS].VGAPP,[GROUPS].IGPARENTSID,[GROUPS].VGDESC,[GROUPS].VGCONTENT,[GROUPS].DGCREATEDATE,[GROUPS].IGTOTALITEMS,[GROUPS].VGSEOLINKSEARCH,
					[ITEMS].VIAPP,[ITEMS].VIKEY,[ITEMS].VITITLE,[ITEMS].VIDESC,[ITEMS].VICONTENT,[ITEMS].VIIMAGE,[ITEMS].VIURL,[ITEMS].VIAUTHOR,[ITEMS].VISEOTITLE,[ITEMS].VISEOLINK,[ITEMS].VISEOLINKSEARCH,[ITEMS].VISEOMETAKEY,[ITEMS].VISEOMETADESC,[ITEMS].VISEOMETACANONICAL,[ITEMS].VISEOMETALANG,[ITEMS].VISEOMETAPARAMS,[ITEMS].VIPARAMS,[ITEMS].FIPRICE,[ITEMS].FISALEPRICE,[ITEMS].IITOTALSUBITEMS,[ITEMS].IITOTALVIEW,[ITEMS].IIORDER,[ITEMS].DILASTVIEW,[ITEMS].DICREATEDATE,[ITEMS].DIUPDATE,[ITEMS].DIENDDATE,[ITEMS].IIENABLE,
					ROW_NUMBER() OVER ( ' + @OrderClause
            + ' ) AS [Rank] 
					FROM [dbo].[GROUPS_ITEMS]
					LEFT JOIN [GROUPS]
					ON [GROUPS_ITEMS].[IGID] = [GROUPS].[IGID]
					LEFT JOIN [ITEMS]
					ON [GROUPS_ITEMS].[IID] = [ITEMS].[IID] where groups.web like '+QUOTENAME(@web,'''')+'
					 '
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause            
        SET @sql = @sql + ' 
				) 
				SELECT
				[RankedList].*
				FROM
				[RankedList]
				WHERE
				[RankedList].[Rank] >= ' + CONVERT(NVARCHAR, @fromRows)
            + '
				ORDER BY
				[RankedList].[Rank] '
				
				
        EXEC sp_executesql @sql
	
	--== Count Items ==--
        SET @sql = ' 
				SELECT Count(*) AS TotalRows
				FROM [dbo].[GROUPS_ITEMS]
				LEFT JOIN [GROUPS]
				ON [GROUPS_ITEMS].[IGID] = [GROUPS].[IGID]
				LEFT JOIN [ITEMS]
				ON [GROUPS_ITEMS].[IID] = [ITEMS].[IID] where groups.web like '+QUOTENAME(@web,'''')+'
				'
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause  
					
        EXEC sp_executesql @sql    
    END



GO
/****** Object:  StoredProcedure [dbo].[GroupsGroupsItemsItemsDeal_GetAllDataPagging]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GroupsGroupsItemsItemsDeal_GetAllDataPagging]
    (
      @pageNumbers INT ,
      @returnRows INT ,
      @whereClause NVARCHAR(2000) ,
      @orderBy NVARCHAR(2000)
      ,@web nvarchar(300)
    )
AS 
    BEGIN
        SET NOCOUNT ON
    
        IF @pageNumbers < 1 
            SET @pageNumbers = 1
	
        IF @returnRows < 1 
            SET @returnRows = 0
    
        DECLARE @fromRows INT
        DECLARE @toRows INT
			
        SET @fromRows = ( ( @pageNumbers - 1 ) * @returnRows ) + 1
        IF @pageNumbers = 1 
            SET @fromRows = 1
        
        SET @toRows = @fromRows + @returnRows - 1
        	
        DECLARE @OrderClause AS NVARCHAR(200)
        IF LEN(@orderBy) > 0 
            SET @OrderClause = ' ORDER BY ' + @orderBy            
        ELSE 
            SET @OrderClause = ' ORDER BY [ITEMS].[IID] '            
			
        DECLARE @sql AS NVARCHAR(4000)
        SET @sql = ' 
				WITH [RankedList] AS 
				( 
					SELECT '
        IF @fromRows > 0 
            SET @sql = @sql + ' TOP (' + CONVERT(NVARCHAR, @toRows) + ') '
        
        SET @sql = @sql
            + ' 
					[GROUPS_ITEMS].*,
					[GROUPS].VGNAME,[GROUPS].IGPARENTSID,
					[ITEMS].VIAPP,[ITEMS].VIKEY,[ITEMS].VITITLE,[ITEMS].VIDESC,[ITEMS].VICONTENT,[ITEMS].VIIMAGE,[ITEMS].VIURL,[ITEMS].VIAUTHOR,[ITEMS].VISEOTITLE,[ITEMS].VISEOLINK,[ITEMS].VISEOLINKSEARCH,[ITEMS].VISEOMETAKEY,[ITEMS].VISEOMETADESC,[ITEMS].VISEOMETACANONICAL,[ITEMS].VISEOMETALANG,[ITEMS].VISEOMETAPARAMS,[ITEMS].VIPARAMS,[ITEMS].FIPRICE,[ITEMS].FISALEPRICE,[ITEMS].IITOTALSUBITEMS,[ITEMS].IITOTALVIEW,[ITEMS].IIORDER,[ITEMS].DILASTVIEW,[ITEMS].DICREATEDATE,[ITEMS].DIUPDATE,[ITEMS].DIENDDATE,[ITEMS].IIENABLE,
					(select COUNT(isid) from SUBITEMS where SUBITEMS.IID=ITEMS.IID and SUBITEMS.VSLANG=''DealCart'') as TotalBuy,
					ROW_NUMBER() OVER ( ' + @OrderClause
            + ' ) AS [Rank] 
					FROM [dbo].[GROUPS_ITEMS]
					LEFT JOIN [GROUPS]
					ON [GROUPS_ITEMS].[IGID] = [GROUPS].[IGID]
					LEFT JOIN [ITEMS]
					ON [GROUPS_ITEMS].[IID] = [ITEMS].[IID]  where groups.web like '+QUOTENAME(@web,'''')+'
					 '
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause            
        SET @sql = @sql + ' 
				) 
				SELECT
				[RankedList].*
				FROM
				[RankedList]
				WHERE
				[RankedList].[Rank] >= ' + CONVERT(NVARCHAR, @fromRows)
            + '
				ORDER BY
				[RankedList].[Rank] '
				
				
        EXEC sp_executesql @sql
	
	--== Count Items ==--
        SET @sql = ' 
				SELECT Count(*) AS TotalRows
				FROM [dbo].[GROUPS_ITEMS]
				LEFT JOIN [GROUPS]
				ON [GROUPS_ITEMS].[IGID] = [GROUPS].[IGID]
				LEFT JOIN [ITEMS]
				ON [GROUPS_ITEMS].[IID] = [ITEMS].[IID] where groups.web like '+QUOTENAME(@web,'''')+'
				'
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause  
					
        EXEC sp_executesql @sql    
    END



GO
/****** Object:  StoredProcedure [dbo].[GroupsItems_DeleteGroupsItems]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GroupsItems_DeleteGroupsItems]
	@condition nvarchar(3000)
	,@web nvarchar(300)
AS

SET NOCOUNT ON

DECLARE @sqlDeleteGroupsItems AS NVARCHAR(4000)
if(LEN(@condition) > 0)
	set @condition = ' and ' + @condition

SET @sqlDeleteGroupsItems = 
'
	Delete from GROUPS_ITEMS where GROUPS_ITEMS.web like '+QUOTENAME(@web,'''') +' '+ @condition + ' 
'
EXEC sp_executesql @sqlDeleteGroupsItems



GO
/****** Object:  StoredProcedure [dbo].[GroupsItems_GetGroupsItems]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GroupsItems_GetGroupsItems]
		@top nvarchar(20),
		@fields nvarchar(2000),
		@condition nvarchar(4000),
		@order nvarchar(2000)
		,@web nvarchar(300)
	AS
	DECLARE @sqlGetGroupsItems AS NVARCHAR(Max)
	if (LEN(@top) > 0)
        Set @top = ' top ' + @top;
    
    if (LEN(@fields) > 0)
		Set @fields =  @fields;
	else
		Set @fields = ' * ';
		
    if (LEN(@condition) > 0)
        Set @condition = ' and ' + @condition;
        
    if (LEN(@order) > 0)
        Set  @order = ' ORDER BY ' + @order;
        
    
	SET @sqlGetGroupsItems = 
	'
		select ' + @top + @fields + ' from Groups_Items where Groups_Items.web like '+QUOTENAME(@web,'''')+' ' + @condition + @order + '
	'
	EXEC sp_executesql @sqlGetGroupsItems



GO
/****** Object:  StoredProcedure [dbo].[GroupsItems_InsertGroupsItems]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GroupsItems_InsertGroupsItems]
    @IGID INT ,
    @IID INT ,
    @VPARAMS nvarchar(200),
    @DCREATEDATE DATETIME ,
    @DUPDATE DATETIME ,
    @DENDDATE DATETIME ,
    @IORDER INT
    ,@web nvarchar(300)
AS 
    INSERT  INTO dbo.GROUPS_ITEMS
            ( IGID ,
              IID ,
              VPARAMS ,
              DCREATEDATE ,
              DUPDATE ,
              DENDDATE ,
              IORDER,
              web
            )
    VALUES  ( @IGID , -- IGID - int
              @IID , -- IID - int
              @VPARAMS , -- VPARAMS - nvarchar(150)
              @DCREATEDATE , -- DCREATEDATE - datetime
              @DUPDATE , -- DUPDATE - datetime
              @DENDDATE , -- DENDDATE - datetime
              @IORDER,  -- IORDER - int
              @web
            )



GO
/****** Object:  StoredProcedure [dbo].[GroupsItems_UpdateGroupsItemsCondition]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GroupsItems_UpdateGroupsItemsCondition]
	@values  nvarchar(3000),
	@condition nvarchar(3000)
	,@web nvarchar(300)
AS

SET NOCOUNT ON

DECLARE @sqlUpdateGroupsItems AS NVARCHAR(4000)

if (Len(@values) > 0)
Begin
	if(LEN(@condition) > 0)
		set @condition = ' and ' + @condition

	SET @sqlUpdateGroupsItems = 
	'
		UPDATE [dbo].[GROUPS_ITEMS] SET ' + @values + ' where GROUPS_ITEMS.web like '+QUOTENAME(@web,'''')+ ' ' + @condition +' 
	'
end
EXEC sp_executesql @sqlUpdateGroupsItems



GO
/****** Object:  StoredProcedure [dbo].[ImagesBackup_Insert]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ImagesBackup_Insert]
    @path nvarchar(200) ,
    @base64code ntext,
    @createdate datetime,
    @enable int 
    ,@web nvarchar(300)
AS 
    INSERT  INTO dbo.ImagesBackup
            ( path ,
              base64code,
               createdate,
               enable      ,
               web
            )
    VALUES  ( @path ,
              @base64code,
              @createdate,
              @enable,
              @web
            )



GO
/****** Object:  StoredProcedure [dbo].[ImagesBackup_Update]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ImagesBackup_Update]
    @path nvarchar(200) ,
    @base64code ntext,
        @createdate datetime,
    @enable int ,
    @imid int
    ,@web nvarchar(300)
AS 
    update ImagesBackup set path=@path,base64code=@base64code,createdate=@createdate,enable=@enable where imid=@imid and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Items_DeleteItem]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_DeleteItem]
	@condition nvarchar(3000)
	 ,@web nvarchar(300)
AS

SET NOCOUNT ON

DECLARE @sqlDeleteItem AS NVARCHAR(4000)

if(LEN(@condition) > 0)
	set @condition = ' and ' + @condition

SET @sqlDeleteItem = 
'
	Delete from ITEMS where items.web like'+QUOTENAME(@web,'''')+' ' + @condition + ' 
'
EXEC sp_executesql @sqlDeleteItem



GO
/****** Object:  StoredProcedure [dbo].[Items_GetItem]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_GetItem]
		@top nvarchar(20),
		@fields nvarchar(2000),
		@condition nvarchar(4000),
		@order nvarchar(2000)
		,@web nvarchar(300)
	AS
	DECLARE @sqlGetItems AS NVARCHAR(Max)
	if (LEN(@top) > 0)
        Set @top = ' top ' + @top;
    
    if (LEN(@fields) > 0)
		Set @fields =  @fields;
	else
		Set @fields = ' * ';
		
    if (LEN(@condition) > 0)
        Set @condition = ' and ' + @condition;
        
    if (LEN(@order) > 0)
        Set  @order = ' ORDER BY ' + @order;
        
    DECLARE @sqlUpdateItem AS NVARCHAR(4000)
    
	SET @sqlGetItems = 
	'
		select ' + @top + @fields + ' from ITEMS where items.web like '+QUOTENAME(@web,'''')+' ' + @condition + @order + '
	'
	EXEC sp_executesql @sqlGetItems



GO
/****** Object:  StoredProcedure [dbo].[Items_GetItemCondition]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_GetItemCondition]
    @PageIndex INT ,
    @PageSize INT ,
    @whereClause NVARCHAR(1500) ,
    @orderBy NVARCHAR(150)
    ,@web nvarchar(300)
AS 
    BEGIN
        SET NOCOUNT ON
        DECLARE @OrderClause AS NVARCHAR(200)
        IF LEN(@orderBy) > 0 
            SET @OrderClause = ' ORDER BY ' + @orderBy            
        ELSE 
            SET @OrderClause = ' ORDER BY IID '            
			
        DECLARE @topagging AS NVARCHAR(2000)
        SET @topagging = ( @PageIndex - 1 ) * @PageSize + 1
        DECLARE @frompagging AS NVARCHAR(2000)
        SET @frompagging = @PageIndex * @PageSize
			
        DECLARE @sql AS NVARCHAR(4000)
        SET @sql = ' 
        WITH    ProductRecords
                  AS ( SELECT   ROW_NUMBER() OVER (' + @OrderClause
            + ' ) AS RowIndex ,
                                IID ,
                                VIAPP,
                                VIKEY ,                                
                                VITITLE ,
                                VIDESC ,
                                VICONTENT ,
                                VIIMAGE ,
                                VIURL ,
                                VIAUTHOR ,
                                VISEOTITLE ,
								VISEOLINK ,
								VISEOLINKSEARCH ,
								VISEOMETAKEY ,
								VISEOMETADESC ,
								VISEOMETACANONICAL ,
								VISEOMETALANG ,
								VISEOMETAPARAMS ,
                                VIPARAMS ,
                                FIPRICE ,
                                FISALEPRICE ,
                                IITOTALSUBITEMS ,
                                IITOTALVIEW ,
                                IIORDER ,
                                DILASTVIEW ,
                                DICREATEDATE ,
                                DIUPDATE ,
                                DIENDDATE ,
                                IIENABLE
                       FROM     [dbo].[ITEMS] where items.web like '+QUOTENAME(@web,'''')+'
                       '
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause            
            
        SET @sql = @sql + ' 
                     )
            SELECT  IID ,
					VIAPP,
                    VIKEY ,
                    VITITLE ,
                    VIDESC ,
                    VICONTENT ,
                    VIIMAGE ,
                    VIURL ,
                    VIAUTHOR ,
                    VISEOTITLE ,
                    VISEOLINK ,
                    VISEOLINKSEARCH ,
                    VISEOMETAKEY ,
                    VISEOMETADESC ,
                    VISEOMETACANONICAL ,
                    VISEOMETALANG ,
                    VISEOMETAPARAMS ,
                    VIPARAMS ,
                    FIPRICE ,
                    FISALEPRICE ,
                    IITOTALSUBITEMS ,
                    IITOTALVIEW ,
                    IIORDER ,
                    DILASTVIEW ,
                    DICREATEDATE ,
                    DIUPDATE ,
                    DIENDDATE ,
                    IIENABLE
            FROM    ProductRecords 
            WHERE   ( RowIndex BETWEEN ' + @topagging + '
                               AND     ' + @frompagging + ' )'
     
		EXEC sp_executesql @sql
		
     --== Count Items ==--
        SET @sql = ' 
				SELECT Count(*) AS TotalRows
				FROM [dbo].[ITEMS]  where items.web like '+QUOTENAME(@web,'''')+''
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause  
        EXEC sp_executesql @sql    
        
        
    END
     
    --EXECUTE ITEMS_GETITEMS_CONDITION 1,3,  " VIAPP = 'PRA' ", ''



GO
/****** Object:  StoredProcedure [dbo].[Items_GetItemsByTitle]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_GetItemsByTitle]	
	@title varchar(500),
	@condition nvarchar(500)
	,@web nvarchar(300)
AS
declare @sql nvarchar(1000)

set @sql= 'select * from items where items.web like '+QUOTENAME(@web,'''')+' and VISEOLINKSEARCH='+QUOTENAME(@title,'''')
if(LEN(@condition)>0)
	set @sql=@sql+' and '+@condition

EXEC sp_executesql @sql



GO
/****** Object:  StoredProcedure [dbo].[Items_InsertItem]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_InsertItem]
    @VILANG VARCHAR(50) ,
    @VIAPP VARCHAR(50) ,
    @VIKEY varchar(200) ,
    @VITITLE NVARCHAR(500) ,
    @VIDESC NVARCHAR(1000) ,
    @VICONTENT NTEXT ,
    @VIIMAGE nvarchar(300) ,
    @VIURL NVARCHAR(300) ,
    @VIAUTHOR NVARCHAR(300) ,
    @VISEOTITLE nvarchar(500),
    @VISEOLINK nvarchar(500),
    @VISEOLINKSEARCH nvarchar(500),
    @VISEOMETAKEY nvarchar(500),
    @VISEOMETADESC nvarchar(Max),
    @VISEOMETACANONICAL nvarchar(500),
    @VISEOMETALANG nvarchar(100),
    @VISEOMETAPARAMS nvarchar(Max),
    @VIPARAMS nvarchar(Max),
    @FIPRICE float,
    @FISALEPRICE float,
    @IITOTALSUBITEMS int,
    @IITOTALVIEW int,
    @IIORDER int,
    @DILASTVIEW datetime,
    @DICREATEDATE datetime,
    @DIUPDATE datetime,
    @DIENDDATE datetime,
    @IIENABLE INT
    ,@web nvarchar(300)
AS 
    INSERT INTO dbo.ITEMS
            ( VILANG ,
              VIAPP ,
              VIKEY ,
              VITITLE ,
              VIDESC ,
              VICONTENT ,
              VIIMAGE ,
              VIURL ,
              VIAUTHOR ,
              VISEOTITLE ,
              VISEOLINK,
			  VISEOLINKSEARCH,
              VISEOMETAKEY ,
              VISEOMETADESC ,
              VISEOMETACANONICAL ,
              VISEOMETALANG ,
              VISEOMETAPARAMS ,
              VIPARAMS ,
              FIPRICE ,
              FISALEPRICE ,
              IITOTALSUBITEMS ,
              IITOTALVIEW ,
              IIORDER ,
              DILASTVIEW ,
              DICREATEDATE ,
              DIUPDATE ,
              DIENDDATE ,
              IIENABLE,
              web
            )
    VALUES  ( 
				@VILANG , --VARCHAR(50)-- 
				@VIAPP , --VARCHAR(50) --
				@VIKEY , --varchar(200) --
				@VITITLE , --NVARCHAR(500) --
				@VIDESC, --NVARCHAR(1000) --
				@VICONTENT, --NTEXT --
				@VIIMAGE, --nvarchar(300) --
				@VIURL, --NVARCHAR(300) --
				@VIAUTHOR, --NVARCHAR(300) --
				@VISEOTITLE, --nvarchar(500)--
				@VISEOLINK,
				@VISEOLINKSEARCH, --nvarchar(500)--
				@VISEOMETAKEY, --nvarchar(500)--
				@VISEOMETADESC, --nvarchar(Max)--
				@VISEOMETACANONICAL, --nvarchar(500)--
				@VISEOMETALANG, --nvarchar(100)--
				@VISEOMETAPARAMS, --nvarchar(Max)--
				@VIPARAMS, --nvarchar(Max)--
				@FIPRICE, --float--
				@FISALEPRICE, --float--
				@IITOTALSUBITEMS, --int--
				@IITOTALVIEW, --int--
				@IIORDER, --int--
				@DILASTVIEW,  --datetime--
				@DICREATEDATE, --datetime--
				@DIENDDATE, --datetime--
				@DIENDDATE, --datetime--
				@IIENABLE, --INT--
				@web
            )



GO
/****** Object:  StoredProcedure [dbo].[Items_InsertItemCondition]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_InsertItemCondition]
	@values  nvarchar(3000),
	@fields nvarchar(3000)
	,@web nvarchar(300)
AS

SET NOCOUNT ON

DECLARE @sqlInsertItem AS NVARCHAR(4000)

SET @sqlInsertItem = 
'
	insert into ITEMS ( ' + @fields + ',web) values(' + @values+','+@web +') 
'
EXEC sp_executesql @sqlInsertItem



GO
/****** Object:  StoredProcedure [dbo].[Items_UpdateItem]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_UpdateItem]
	@VILANG VARCHAR(50) ,
    @VIAPP VARCHAR(50) ,
    @VIKEY varchar(200) ,
    @VITITLE NVARCHAR(500) ,
    @VIDESC NVARCHAR(1000) ,
    @VICONTENT NTEXT ,
    @VIIMAGE nvarchar(300) ,
    @VIURL NVARCHAR(300) ,
    @VIAUTHOR NVARCHAR(300) ,
    @VISEOTITLE nvarchar(500),
    @VISEOLINK nvarchar(500),
    @VISEOLINKSEARCH nvarchar(500),
    @VISEOMETAKEY nvarchar(500),
    @VISEOMETADESC nvarchar(Max),
    @VISEOMETACANONICAL nvarchar(500),
    @VISEOMETALANG nvarchar(100),
    @VISEOMETAPARAMS nvarchar(Max),
    @VIPARAMS nvarchar(Max),
    @FIPRICE float,
    @FISALEPRICE float,
    @IITOTALSUBITEMS int,
    @IITOTALVIEW int,
    @IIORDER int,
    @DICREATEDATE datetime,
    @DIENDDATE datetime,
    @IIENABLE INT,
    @IID INT
    ,@web nvarchar(300),
    @vsearchkey nvarchar(1000)
    
AS
update ITEMS set 
		VILANG=@VILANG,
		VIAPP = @VIAPP,
		VIKEY = @VIKEY,
		VITITLE = @VITITLE,
		VIDESC = @VIDESC,
		VICONTENT = @VICONTENT ,
		VIIMAGE = @VIIMAGE,
		VIURL = @VIURL,
		VIAUTHOR = @VIAUTHOR,
		VISEOTITLE = @VISEOTITLE,
		VISEOLINK = @VISEOLINK,
		VISEOLINKSEARCH = @VISEOLINKSEARCH,
		VISEOMETAKEY = @VISEOMETAKEY,
		VISEOMETADESC = @VISEOMETADESC,
		VISEOMETACANONICAL = @VISEOMETACANONICAL,
		VISEOMETALANG = @VISEOMETALANG,
		VISEOMETAPARAMS = @VISEOMETAPARAMS,
		VIPARAMS = @VIPARAMS,
		FIPRICE = @FIPRICE,
		FISALEPRICE = @FISALEPRICE,
		IITOTALSUBITEMS = @IITOTALSUBITEMS,
		IITOTALVIEW = @IITOTALVIEW,
		IIORDER = @IIORDER,
		DILASTVIEW = getdate(),
		DICREATEDATE = @DICREATEDATE,
		DIUPDATE = getdate(),
		DIENDDATE = @DIENDDATE,
		IIENABLE = @IIENABLE,
		vsearchkey = ''
		where IID = @IID and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Items_UpdateItemCondition]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Items_UpdateItemCondition]
	@values  nvarchar(3000),
	@condition nvarchar(3000)
	,@web nvarchar(300)
AS

SET NOCOUNT ON

DECLARE @sqlUpdateItem AS NVARCHAR(4000)

if (Len(@values) > 0)
Begin
	if(LEN(@condition) > 0)
		set @condition = ' and ' + @condition

	SET @sqlUpdateItem = 
	'
		UPDATE [dbo].[ITEMS] SET ' + @values + ' where items.web like '+QUOTENAME(@web,'''')+' ' + @condition +' 
	'
end
EXEC sp_executesql @sqlUpdateItem



GO
/****** Object:  StoredProcedure [dbo].[ItemsGroupsItems_DeleteByIid]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ItemsGroupsItems_DeleteByIid]
@IID int 
,@web nvarchar(300)
as
delete from GROUPS_ITEMS where IID=@IID and web like @web
delete from ITEMS where IID=@IID and web like @web



GO
/****** Object:  StoredProcedure [dbo].[ItemsGroupsItems_DeleteCondition]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ItemsGroupsItems_DeleteCondition]
    @whereclause VARCHAR(100)
    ,@web nvarchar(300)
AS 
    BEGIN
        SET NOCOUNT ON
        DECLARE @sql AS NVARCHAR(4000)
        SET @sql = ' 
		DELETE FROM dbo.GROUPS_ITEMS where GROUPS_ITEMS.web like '+QUOTENAME(@web,'''')+' '
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause
        SET @sql = @sql + 'DELETE FROM dbo.ITEMS where ITEMS.web like '+QUOTENAME(@web,'''')+' '
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause      
            
        EXEC sp_executesql @sql
    END



GO
/****** Object:  StoredProcedure [dbo].[ItemsGroupsItems_Insert]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ItemsGroupsItems_Insert]
    @VILANG VARCHAR(50) ,
    @VIAPP VARCHAR(50) ,
    @VIKEY VARCHAR(200) ,
    @VITITLE NVARCHAR(500) ,
    @VIDESC NVARCHAR(1000) ,
    @VICONTENT NTEXT ,
    @VIIMAGE NVARCHAR(300) ,
    @VIURL NVARCHAR(300) ,
    @VIAUTHOR NVARCHAR(300) ,
    @VISEOTITLE nvarchar(500),
    @VISEOLINK nvarchar(500),
    @VISEOLINKSEARCH nvarchar(500),
    @VISEOMETAKEY nvarchar(500),
    @VISEOMETADESC nvarchar(Max),
    @VISEOMETACANONICAL nvarchar(500),
    @VISEOMETALANG nvarchar(100),
    @VISEOMETAPARAMS nvarchar(Max),
    @VIPARAMS NVARCHAR(MAX) ,
    @FIPRICE FLOAT ,
    @FISALEPRICE FLOAT ,
    @IITOTALSUBITEMS INT ,
    @IITOTALVIEW INT ,
    @DICREATEDATE DATETIME ,
    @DIUPDATE DATETIME ,
    @DIENDDATE DATETIME ,
    @IIORDER INT ,
    @IGID INT ,
    @DCREATEDATE DATETIME ,
    @DUPDATE DATETIME ,
    @DENDDATE DATETIME ,
    @IORDER INT ,
    @IIENABLE INT
    ,@web nvarchar(300)
AS 
    INSERT  INTO ITEMS
    VALUES  ( @VILANG, @VIAPP, @VIKEY, @VITITLE, @VIDESC, @VICONTENT, @VIIMAGE,
              @VIURL, @VIAUTHOR, @VISEOTITLE, --nvarchar(500)--
				@VISEOLINK,
				@VISEOLINKSEARCH, --nvarchar(500)--
				@VISEOMETAKEY, --nvarchar(500)--
				@VISEOMETADESC, --nvarchar(Max)--
				@VISEOMETACANONICAL, --nvarchar(500)--
				@VISEOMETALANG, --nvarchar(100)--
				@VISEOMETAPARAMS, --nvarchar(Max)--
				@VIPARAMS, @FIPRICE, @FISALEPRICE,
              @IITOTALSUBITEMS, @IITOTALVIEW, @IIORDER, GETDATE(),
              @DICREATEDATE, @DIUPDATE, @DIENDDATE, @IIENABLE,@web,'' )

--KHAI BAO BIEN
    DECLARE @NewID INT
-- LAY BIEN SET ID MOI NHAT VUA THEM VAO
    SELECT  @NewID = ( SELECT TOP 1
                                IID
                       FROM     dbo.ITEMS where web like @web
                       ORDER BY IID DESC
                     )
-- Lay IGPARENTS theo IGID
	DECLARE @NEW_IGPARENTSID NVARCHAR(200)
	SELECT @NEW_IGPARENTSID = IGPARENTSID FROM dbo.GROUPS WHERE IGID = @IGID  and GROUPS.web like @web                      
                      
-- INSERT GROUPS_ITEMS
	INSERT INTO dbo.GROUPS_ITEMS
	        ( IGID ,
	          IID ,
	          VPARAMS ,
	          DCREATEDATE ,
	          DUPDATE ,
	          DENDDATE ,
	          IORDER,
	          web
	        )
	VALUES  ( @IGID , -- IGID - int
	          @NewID , -- IID - int
	          @NEW_IGPARENTSID , -- VPARAMS - nvarchar(150)
	          @DCREATEDATE , -- DCREATEDATE - datetime
	          @DUPDATE , -- DUPDATE - datetime
	          @DENDDATE , -- DENDDATE - datetime
	          @IORDER,  -- IORDER - int
	          @web
	        )
    SELECT  @@ROWCOUNT AS RowAffected



GO
/****** Object:  StoredProcedure [dbo].[ItemsGroupsItems_Update]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[ItemsGroupsItems_Update]
    @VILANG VARCHAR(50) ,
    @VIAPP VARCHAR(50) ,
    @VIKEY VARCHAR(200) ,
    @VITITLE NVARCHAR(500) ,
    @VIDESC NVARCHAR(1000) ,
    @VICONTENT NTEXT ,
    @VIIMAGE NVARCHAR(300) ,
    @VIURL NVARCHAR(300) ,
    @VIAUTHOR NVARCHAR(300) ,
    @VISEOTITLE nvarchar(500),
    @VISEOLINK nvarchar(500),
    @VISEOLINKSEARCH nvarchar(500),
    @VISEOMETAKEY nvarchar(500),
    @VISEOMETADESC nvarchar(Max),
    @VISEOMETACANONICAL nvarchar(500),
    @VISEOMETALANG nvarchar(100),
    @VISEOMETAPARAMS nvarchar(Max),
    @VIPARAMS NVARCHAR(MAX) ,
    @FIPRICE FLOAT ,
    @FISALEPRICE FLOAT ,
    @IITOTALSUBITEMS INT ,
    @IITOTALVIEW INT ,
    @DICREATEDATE DATETIME ,
    @DIUPDATE DATETIME ,
    @DIENDDATE DATETIME ,
    @IIORDER INT ,
    @IGID INT ,
    @DCREATEDATE DATETIME ,
    @DUPDATE DATETIME ,
    @DENDDATE DATETIME ,
    @IORDER INT ,
    @IIENABLE INT ,
    @IID INT
    ,@web nvarchar(300)
AS 
    UPDATE  ITEMS
    SET     VILANG = @VILANG ,
            VIAPP = @VIAPP ,
            VIKEY = @VIKEY ,
            VITITLE = @VITITLE ,
            VIDESC = @VIDESC ,
            VICONTENT = @VICONTENT ,
            VIIMAGE = @VIIMAGE ,
            VIURL = @VIURL ,
            VIAUTHOR = @VIAUTHOR ,
            VISEOTITLE = @VISEOTITLE ,
            VISEOLINK = @VISEOLINK ,
			VISEOLINKSEARCH = @VISEOLINKSEARCH ,
			VISEOMETAKEY = @VISEOMETAKEY, --nvarchar(500)--
			VISEOMETADESC = @VISEOMETADESC, --nvarchar(Max)--
			VISEOMETACANONICAL = @VISEOMETACANONICAL, --nvarchar(500)--
			VISEOMETALANG = @VISEOMETALANG, --nvarchar(100)--
			VISEOMETAPARAMS = @VISEOMETAPARAMS, --nvarchar(Max)--
            VIPARAMS = @VIPARAMS ,
            FIPRICE = @FIPRICE ,
            FISALEPRICE = @FISALEPRICE ,
            IITOTALSUBITEMS = @IITOTALSUBITEMS ,
            IITOTALVIEW = @IITOTALVIEW ,
            DICREATEDATE = @DICREATEDATE ,
            DIUPDATE = @DIUPDATE ,
            DIENDDATE = @DIENDDATE ,
            DILASTVIEW = GETDATE(),
            IIORDER = @IIORDER ,
            IIENABLE = @IIENABLE,
            vsearchkey =''           
    WHERE   IID = @IID  and items.web like @web

    DELETE  FROM GROUPS_ITEMS
    WHERE   IID = @IID
            AND IGID IN ( SELECT IGID
                         FROM   dbo.GROUPS
                         WHERE  IGID IN ( SELECT    IGID
                                          FROM      dbo.GROUPS_ITEMS
                                          WHERE     IID = @IID and web like @web)
                                AND VGAPP = @VIAPP
                       ) 
                 
                 
-- Nhap ban ghi
	DECLARE @NEW_IGPARENTSID NVARCHAR(200)
	SELECT @NEW_IGPARENTSID = IGPARENTSID FROM dbo.GROUPS WHERE IGID = @IGID  and web like @web
    INSERT INTO dbo.GROUPS_ITEMS
	        ( IGID ,
	          IID ,
	          VPARAMS ,
	          DCREATEDATE ,
	          DUPDATE ,
	          DENDDATE ,
	          IORDER,
	          web
	        )
	VALUES  ( @IGID , -- IGID - int
	          @IID , -- IID - int
	          @NEW_IGPARENTSID , -- VPARAMS - nvarchar(150)
	          @DCREATEDATE , -- DCREATEDATE - datetime
	          @DUPDATE , -- DUPDATE - datetime
	          @DENDDATE , -- DENDDATE - datetime
	          @IORDER,  -- IORDER - int
	          @web
	        )


   

---- Dem so ban ghi



GO
/****** Object:  StoredProcedure [dbo].[LanguageItem_Insert]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageItem_Insert]
    @iLanguageNationalId int ,
	@iLanguageKeyId int ,
	@nLanguageItemTitle ntext ,
	@nLanguageItemDesc nvarchar(MAX) ,
    @nLanguageItemParams nvarchar(MAX)
    ,@web nvarchar(300)
AS 
    INSERT  INTO dbo.LanguageItem
            ( iLanguageNationalId ,
			  iLanguageKeyId ,
			  nLanguageItemTitle ,
			  nLanguageItemDesc ,
              nLanguageItemParams,
              web
            )
    VALUES  ( @iLanguageNationalId ,
			  @iLanguageKeyId ,
			  @nLanguageItemTitle ,
			  @nLanguageItemDesc ,
              @nLanguageItemParams,
              @web
            )



GO
/****** Object:  StoredProcedure [dbo].[LanguageItemLanguageKey_DeleteByiLanguageKeyId]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageItemLanguageKey_DeleteByiLanguageKeyId]
@iLanguageKeyId INT
,@web nvarchar(300)
AS	
DELETE FROM dbo.LanguageItem WHERE iLanguageKeyId = @iLanguageKeyId and web like @web
DELETE FROM dbo.LanguageKey WHERE iLanguageKeyId = @iLanguageKeyId and web like @web



GO
/****** Object:  StoredProcedure [dbo].[LanguageItemLanguageNational_DeleteByiLanguageNationalId]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageItemLanguageNational_DeleteByiLanguageNationalId]
@iLanguageNationalId INT
,@web nvarchar(300)
AS	
DELETE FROM dbo.LanguageItem WHERE iLanguageNationalId = @iLanguageNationalId and web like @web
DELETE FROM dbo.LanguageNational WHERE iLanguageNationalId = @iLanguageNationalId and web like @web



GO
/****** Object:  StoredProcedure [dbo].[LanguageKey_Insert]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageKey_Insert]
    @nLanguageKeyTitle nvarchar(1000) ,
    @nLanguageKeyDesc nvarchar(250)
    ,@web nvarchar(300)
AS 
    INSERT  INTO dbo.LanguageKey
            ( nLanguageKeyTitle ,
			  nLanguageKeyDesc,
			  web
            )
    VALUES  ( @nLanguageKeyTitle , -- nLanguageNationalName - nvarchar(100)
              @nLanguageKeyDesc,
              @web
            )



GO
/****** Object:  StoredProcedure [dbo].[LanguageKey_Update]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageKey_Update]
	@iLanguageKeyId int,
	@nLanguageKeyTitle nvarchar(1000),
	@nLanguageKeyDesc nvarchar(250)
	,@web nvarchar(300)
AS

SET NOCOUNT ON

UPDATE [dbo].[LanguageKey] SET
	[nLanguageKeyTitle] = @nLanguageKeyTitle,	
	[nLanguageKeyDesc] = @nLanguageKeyDesc 
WHERE
	[iLanguageKeyId] = @iLanguageKeyId and web like @web



GO
/****** Object:  StoredProcedure [dbo].[LanguageNational_Insert]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageNational_Insert]
    @nLanguageNationalName nvarchar(100) ,
    @nLanguageNationalFlag nvarchar(250) ,
    @nLanguageNationalDesc nvarchar(250) ,
	@iLanguageNationalEnable tinyint 
	,@web nvarchar(300)
AS 
    INSERT  INTO dbo.LanguageNational
            ( nLanguageNationalName ,
              nLanguageNationalFlag ,
              nLanguageNationalDesc ,
			  iLanguageNationalEnable,
			  web
            )
    VALUES  ( @nLanguageNationalName , -- nLanguageNationalName - nvarchar(100)
              @nLanguageNationalFlag , -- nLanguageNationalFlag - nvarchar(250)
              @nLanguageNationalDesc , -- nLanguageNationalDesc - nvarchar(250) 
			  @iLanguageNationalEnable, -- nLanguageNationalDesc - tinyint 
			  @web
            )



GO
/****** Object:  StoredProcedure [dbo].[LanguageNational_Update]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LanguageNational_Update]
	@iLanguageNationalId int,
	@nLanguageNationalName nvarchar(1000),
	@nLanguageNationalFlag nvarchar(250),
	@nLanguageNationalDesc nvarchar(250),
	@iLanguageNationalEnable tinyint
	,@web nvarchar(300)
AS

SET NOCOUNT ON

UPDATE [dbo].[LanguageNational] SET
	[nLanguageNationalName] = @nLanguageNationalName,	
	[nLanguageNationalFlag] = @nLanguageNationalFlag,
	[nLanguageNationalDesc] = @nLanguageNationalDesc,
	[iLanguageNationalEnable] = @iLanguageNationalEnable
WHERE
	[iLanguageNationalId] = @iLanguageNationalId and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Logs_DeleteLogs]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Logs_DeleteLogs]
	@condition nvarchar(3000)
	,@web nvarchar(300)
AS

SET NOCOUNT ON

DECLARE @sqlDeleteItem AS NVARCHAR(4000)

if(LEN(@condition) > 0)
	set @condition = ' and ' + @condition

SET @sqlDeleteItem = 
'
	Delete from Logs where logs.web like '+QUOTENAME(@web,'''')+' ' + @condition + ' 
'
EXEC sp_executesql @sqlDeleteItem



GO
/****** Object:  StoredProcedure [dbo].[Logs_GetLogs]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Logs_GetLogs]
		@top nvarchar(20),
		@fields nvarchar(2000),
		@condition nvarchar(4000),
		@order nvarchar(2000)
		,@web nvarchar(300)
	AS
	DECLARE @sqlGetItems AS NVARCHAR(Max)
	if (LEN(@top) > 0)
        Set @top = ' top ' + @top;
    
    if (LEN(@fields) > 0)
		Set @fields =  @fields;
	else
		Set @fields = ' * ';
		
    if (LEN(@condition) > 0)
        Set @condition = ' and ' + @condition;
        
    if (LEN(@order) > 0)
        Set  @order = ' ORDER BY ' + @order;
        
    DECLARE @sqlUpdateItem AS NVARCHAR(4000)
    
	SET @sqlGetItems = 
	'
		select ' + @top + @fields + ' from Logs where logs.web like '+QUOTENAME(@web,'''')+' ' + @condition + @order + '
	'
	EXEC sp_executesql @sqlGetItems



GO
/****** Object:  StoredProcedure [dbo].[Logs_GetLogsPagging]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Logs_GetLogsPagging]
    (
      @pageNumbers INT ,
      @returnRows INT ,
      @whereClause NVARCHAR(2000) ,
      @orderBy NVARCHAR(2000)
      ,@web nvarchar(300)
    )
AS 
    BEGIN
        SET NOCOUNT ON
    
        IF @pageNumbers < 1 
            SET @pageNumbers = 1
	
        IF @returnRows < 1 
            SET @returnRows = 0
    
        DECLARE @fromRows INT
        DECLARE @toRows INT
			
        SET @fromRows = ( ( @pageNumbers - 1 ) * @returnRows ) + 1
        IF @pageNumbers = 1 
            SET @fromRows = 1
        
        SET @toRows = @fromRows + @returnRows - 1
        	
        DECLARE @OrderClause AS NVARCHAR(200)
        IF LEN(@orderBy) > 0 
            SET @OrderClause = ' ORDER BY ' + @orderBy            
        ELSE 
            SET @OrderClause = ' ORDER BY [Logs].[ilid] '            
			
        DECLARE @sql AS NVARCHAR(4000)
        SET @sql = ' 
				WITH [RankedList] AS 
				( 
					SELECT '
        IF @fromRows > 0 
            SET @sql = @sql + ' TOP (' + CONVERT(NVARCHAR, @toRows) + ') '
        
        SET @sql = @sql
            + ' 
					[Logs].*,			
					ROW_NUMBER() OVER ( ' + @OrderClause
            + ' ) AS [Rank] 
					FROM [Logs] where logs.web like '+QUOTENAME(@web,'''')+'
					 '
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause            
        SET @sql = @sql + ' 
				) 
				SELECT
				[RankedList].*
				FROM
				[RankedList]
				WHERE
				[RankedList].[Rank] >= ' + CONVERT(NVARCHAR, @fromRows)
            + '
				ORDER BY
				[RankedList].[Rank] '
				
				
        EXEC sp_executesql @sql
	
	--== Count Items ==--
        SET @sql = ' 
				SELECT Count(*) AS TotalRows
				FROM [dbo].[Logs] where logs.web like '+QUOTENAME(@web,'''')+'		
				'
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause  
					
        EXEC sp_executesql @sql    
    END



GO
/****** Object:  StoredProcedure [dbo].[Logs_InsertLogs]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Logs_InsertLogs]
    @dlCreateDate datetime ,
    @vlUrl nvarchar(300) ,
    @vlIP nvarchar(100) ,
    @vlInfo nvarchar(300) ,
    @vlAuthor nvarchar(100) ,
    @vlType nvarchar(100),
    @vlDesc nvarchar(100)   
    ,@web nvarchar(300) 
AS 
    INSERT INTO dbo.Logs
            ( dlCreateDate ,
              vlUrl ,
              vlIP ,
              vlInfo ,
              vlAuthor ,
              vlType ,
              vlDesc     ,
              web                    
            )
    VALUES  ( 
				 @dlCreateDate ,
    @vlUrl ,
    @vlIP ,
    @vlInfo ,
    @vlAuthor ,
    @vlType,
    @vlDesc    ,
    @web
            )



GO
/****** Object:  StoredProcedure [dbo].[Members_DeleteMemberByImid]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Members_DeleteMemberByImid]
@IMID int
,@web nvarchar(300)
AS
DELETE dbo.Members
WHERE dbo.Members.IMID=@IMID and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Members_DeleteMemberByvMemberAccount]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Members_DeleteMemberByvMemberAccount]
@vMemberAccount int
,@web nvarchar(300)
AS
DELETE dbo.Members
WHERE dbo.Members.vMemberAccount=@vMemberAccount and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Members_GetDataPagging]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Members_GetDataPagging]
    (
      @pageNumbers INT ,
      @returnRows INT ,
      @whereClause NVARCHAR(2000) ,
      @orderBy NVARCHAR(2000)
      ,@web nvarchar(300)
    )
AS 
    BEGIN
        SET NOCOUNT ON
    
        IF @pageNumbers < 1 
            SET @pageNumbers = 1
	
        IF @returnRows < 1 
            SET @returnRows = 0
    
        DECLARE @fromRows INT
        DECLARE @toRows INT
			
        SET @fromRows = ( ( @pageNumbers - 1 ) * @returnRows ) + 1
        IF @pageNumbers = 1 
            SET @fromRows = 1
        
        SET @toRows = @fromRows + @returnRows - 1
        	
        DECLARE @OrderClause AS NVARCHAR(200)
        IF LEN(@orderBy) > 0 
            SET @OrderClause = ' ORDER BY ' + @orderBy            
        ELSE 
            SET @OrderClause = ' ORDER BY [Members].[imid] '            
			
        DECLARE @sql AS NVARCHAR(4000)
        SET @sql = ' 
				WITH [RankedList] AS 
				( 
					SELECT '
        IF @fromRows > 0 
            SET @sql = @sql + ' TOP (' + CONVERT(NVARCHAR, @toRows) + ') '
        
        SET @sql = @sql
            + ' 
					[Members].*,			
					ROW_NUMBER() OVER ( ' + @OrderClause
            + ' ) AS [Rank] 
					FROM [Members] where web like '+QUOTENAME(@web,'''')
					
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause            
        SET @sql = @sql + ' 
				) 
				SELECT
				[RankedList].*
				FROM
				[RankedList]
				WHERE
				[RankedList].[Rank] >= ' + CONVERT(NVARCHAR, @fromRows)
            + '
				ORDER BY
				[RankedList].[Rank] '
				
				
        EXEC sp_executesql @sql
	
	--== Count Items ==--
        SET @sql = ' 
				SELECT Count(*) AS TotalRows
				FROM [dbo].[Members] where web like '+QUOTENAME(@web,'''')+'	
				'
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause  
					
        EXEC sp_executesql @sql    
    END

--EXEC GROUPS_ITEMS_GetItems_Condition 1,3," LEFT([GROUPS].IGPARENTSID, LEN('0,52,58')) = '0,52,58' ","[ITEMS].[IID] DESC"



GO
/****** Object:  StoredProcedure [dbo].[Members_InsertMember]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Members_InsertMember]
@vProperty nvarchar(max),
@vMemberAccount nvarchar(30),
@vMemberPassword nvarchar(150),
@vMemberName nvarchar(80),
@vMemberAddress nvarchar(250),
@vMemberPhone nvarchar(25),
@vMemberEmail nvarchar(100),
@dMemberBirthday datetime,
@vMemberIdentityCard nvarchar(100),
@vMemberRelationship nvarchar(250),
@vMemberEdu nvarchar(250),
@vMemberJob nvarchar(250),
@vMemberYahooNick nvarchar(250),
@vMemberImage nvarchar(250),
@vMemberPasswordQuestion nvarchar(250),
@vMemberPasswordAnswer nvarchar(250),
@iMemberIsApproved int,
@iMemberIsLockedOut int,
@dMemberCreatedate datetime,
@dMemberLastLoginDate datetime,
@dMemberLastChangePasswordDate datetime,
@dMemberLastLogOutDate datetime,
@vMemberComment nvarchar(max),
@iMemberTotalLogin int, 
@iMemberTotalview int, 
@vMemberWeight nvarchar(250), 
@vMemberHeight nvarchar(250), 
@vMemberBlast nvarchar(250)
,@web nvarchar(300)
as
insert into members(vProperty,vMemberAccount,vMemberPassword,vMemberName,vMemberAddress,vMemberPhone,vMemberEmail,dMemberBirthday,vMemberIdentityCard,vMemberRelationship,vMemberEdu,vMemberJob,vMemberYahooNick,vMemberImage,vMemberPasswordQuestion,vMemberPasswordAnswer,iMemberIsApproved,iMemberIsLockedOut,dMemberCreatedate,dMemberLastLoginDate,dMemberLastChangePasswordDate,dMemberLastLogOutDate,vMemberComment,iMemberTotalLogin,iMemberTotalview,vMemberWeight,vMemberHeight,vMemberBlast,web)
values(@vProperty,@vMemberAccount,@vMemberPassword,@vMemberName,@vMemberAddress,@vMemberPhone,@vMemberEmail,@dMemberBirthday,@vMemberIdentityCard,@vMemberRelationship,@vMemberEdu,@vMemberJob,@vMemberYahooNick,@vMemberImage,@vMemberPasswordQuestion,@vMemberPasswordAnswer,@iMemberIsApproved,@iMemberIsLockedOut,@dMemberCreatedate,@dMemberLastLoginDate,@dMemberLastChangePasswordDate,@dMemberLastLogOutDate,@vMemberComment,@iMemberTotalLogin,@iMemberTotalview,@vMemberWeight,@vMemberHeight,@vMemberBlast,@web)



GO
/****** Object:  StoredProcedure [dbo].[Members_UpdateMember]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Members_UpdateMember]
	@IMID int,
	@vProperty nvarchar(max),
	@vMemberAccount nvarchar(30),	
	@vMemberName nvarchar(80),
	@vMemberAddress nvarchar(250),
	@vMemberPhone nvarchar(25),
	@vMemberEmail nvarchar(100),
	@dMemberBirthday datetime,
	@vMemberIdentityCard nvarchar(100),
	@vMemberRelationship nvarchar(250),
	@vMemberEdu nvarchar(250),
	@vMemberJob nvarchar(250),
	@vMemberYahooNick nvarchar(250),
	@vMemberImage nvarchar(250),
	@vMemberPasswordQuestion nvarchar(250),
	@vMemberPasswordAnswer nvarchar(250),
	@iMemberIsApproved int,
	@iMemberIsLockedOut int,
	@dMemberCreatedate datetime,
	@dMemberLastLoginDate datetime,
	@dMemberLastChangePasswordDate datetime,
	@dMemberLastLogOutDate datetime,
	@vMemberComment nvarchar(max),
	@iMemberTotalLogin int, 
	@iMemberTotalview int, 
	@vMemberWeight nvarchar(250), 
	@vMemberHeight nvarchar(250), 
	@vMemberBlast nvarchar(250)
	,@web nvarchar(300)
AS

SET NOCOUNT ON

UPDATE [dbo].[Members] SET
	[vProperty] = @vProperty,
	[vMemberAccount] = @vMemberAccount,	
	[vMemberName] = @vMemberName,
	[vMemberAddress] = @vMemberAddress,
	[vMemberPhone] = @vMemberPhone,
	[vMemberEmail] = @vMemberEmail,
	[dMemberBirthday] = @dMemberBirthday,
	[vMemberIdentityCard] = @vMemberIdentityCard,
	[vMemberRelationship] = @vMemberRelationship,
	[vMemberEdu] = @vMemberEdu,
	[vMemberJob] = @vMemberJob,
	[vMemberYahooNick] = @vMemberYahooNick,
	[vMemberImage] = @vMemberImage,
	[vMemberPasswordQuestion] = @vMemberPasswordQuestion,
	[vMemberPasswordAnswer] = @vMemberPasswordAnswer,
	[iMemberIsApproved] = @iMemberIsApproved,
	[iMemberIsLockedOut] = @iMemberIsLockedOut,
	[dMemberCreatedate] = @dMemberCreatedate,
	[dMemberLastLoginDate] = @dMemberLastLoginDate,
	[dMemberLastChangePasswordDate] = @dMemberLastChangePasswordDate,
	[dMemberLastLogOutDate] = @dMemberLastLogOutDate,
	[vMemberComment] = @vMemberComment,
	[iMemberTotalLogin]=@iMemberTotalLogin, 
	[iMemberTotalview]=@iMemberTotalview, 
	[vMemberWeight]=@vMemberWeight, 
	[vMemberHeight]=@vMemberHeight, 
	[vMemberBlast]=@vMemberBlast
WHERE
	[IMID] = @IMID and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Members_UpdateMemberPassword]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Members_UpdateMemberPassword]
@IMID INT,
@vMemberPassword nvarchar(300)
,@web nvarchar(300)
AS
UPDATE dbo.Members
SET vMemberPassword=@vMemberPassword
WHERE IMID=@IMID and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Members_UpdateMemberPasswordByAccount]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Members_UpdateMemberPasswordByAccount]
@vMemberAccount nvarchar(300),
@vMemberPassword nvarchar(300)
,@web nvarchar(300)
AS
UPDATE dbo.Members
SET vMemberPassword=@vMemberPassword
WHERE vMemberAccount=@vMemberAccount and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Roles_GetRolesByRoleId]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Roles_GetRolesByRoleId]
	@RoleId INT
	,@web nvarchar(300)
AS
SELECT * FROM Roles WHERE RoleId = @RoleId and web like @web



GO
/****** Object:  StoredProcedure [dbo].[SearchItems]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create proc [dbo].[SearchItems]
(
@top varchar(50),
@field varchar(300),
@viapp varchar(50),
@iienable int,
@search nvarchar(500),
@orderby varchar(50)
)
as
begin

if(LEN(@orderby)>0)
set @orderby = ' order by '+@orderby

if(LEN(@top)>0)
set @top = ' top '+@top

if(LEN(@field)<1)
set @field = 'items.*'


declare @sql nvarchar(2000)
set @sql='with Table1 as
(
select IID as iid_,VIKEY as vikey_, vsearchkey as vsearchkey_ from items where viapp='''+@viapp+''' and iienable='+cast(@iienable as varchar(10))+'
),
table2 as
(
select '+@top+' * from table1 where vsearchkey_+VIKEY_ like N''%'+@search+'%''
)
select '+@field+' from table2,ITEMS where table2.IID_=items.iid '+@orderby

EXEC sp_executesql @sql

end

--exec SearchItems '','vititle','p','1','a','vititle'


GO
/****** Object:  StoredProcedure [dbo].[SubItems_GetSubItemsPagging]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SubItems_GetSubItemsPagging]
    (
      @pageNumbers INT ,
      @returnRows INT ,
      @whereClause NVARCHAR(2000) ,
      @orderBy NVARCHAR(2000)
      ,@web nvarchar(300)
    )
AS 
    BEGIN
        SET NOCOUNT ON
    
        IF @pageNumbers < 1 
            SET @pageNumbers = 1
	
        IF @returnRows < 1 
            SET @returnRows = 0
    
        DECLARE @fromRows INT
        DECLARE @toRows INT
			
        SET @fromRows = ( ( @pageNumbers - 1 ) * @returnRows ) + 1
        IF @pageNumbers = 1 
            SET @fromRows = 1
        
        SET @toRows = @fromRows + @returnRows - 1
        	
        DECLARE @OrderClause AS NVARCHAR(200)
        IF LEN(@orderBy) > 0 
            SET @OrderClause = ' ORDER BY ' + @orderBy            
        ELSE 
            SET @OrderClause = ' ORDER BY [SUBITEMS].[isid] '            
			
        DECLARE @sql AS NVARCHAR(4000)
        SET @sql = ' 
				WITH [RankedList] AS 
				( 
					SELECT '
        IF @fromRows > 0 
            SET @sql = @sql + ' TOP (' + CONVERT(NVARCHAR, @toRows) + ') '
        
        SET @sql = @sql
            + ' 
					[SUBITEMS].*,			
					ROW_NUMBER() OVER ( ' + @OrderClause
            + ' ) AS [Rank] 
					FROM [SUBITEMS] where subitems.web like '+QUOTENAME(@web,'''')+'
					 '
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause            
        SET @sql = @sql + ' 
				) 
				SELECT
				[RankedList].*
				FROM
				[RankedList]
				WHERE
				[RankedList].[Rank] >= ' + CONVERT(NVARCHAR, @fromRows)
            + '
				ORDER BY
				[RankedList].[Rank] '
				
				
        EXEC sp_executesql @sql
	
	--== Count Items ==--
        SET @sql = ' 
				SELECT Count(*) AS TotalRows
				FROM [dbo].[SUBITEMS] where subitems.web like '+QUOTENAME(@web,'''')+'		
				'
        IF LEN(@whereClause) > 0 
            SET @sql = @sql + ' and ' + @whereClause  
					
        EXEC sp_executesql @sql    
    END

--EXEC GROUPS_ITEMS_GetItems_Condition 1,3," LEFT([GROUPS].IGPARENTSID, LEN('0,52,58')) = '0,52,58' ","[ITEMS].[IID] DESC"



GO
/****** Object:  StoredProcedure [dbo].[Subitems_Insert]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Subitems_Insert]
(
@IID int,
@VSLANG varchar(50),
@VSKEY varchar(200),
@VSTITLE nvarchar(500),
@VSCONTENT ntext,
@VSIMAGE nvarchar(300),
@VSEMAIL nvarchar(300),
@VSATUTHOR nvarchar(300),
@VSURL nvarchar(300),
@DSCREATEDATE datetime,
@DSUPDATE datetime,
@DSENDDATE datetime,
@ISENABLE int,
@web nvarchar(300)
)
as
begin
INSERT INTO [SUBITEMS]
           ([IID]
           ,[VSLANG]
           ,[VSKEY]
           ,[VSTITLE]
           ,[VSCONTENT]
           ,[VSIMAGE]
           ,[VSEMAIL]
           ,[VSATUTHOR]
           ,[VSURL]
           ,[DSCREATEDATE]
           ,[DSUPDATE]
           ,[DSENDDATE]
           ,[ISENABLE]
           ,[web])
     VALUES
           (@IID,
@VSLANG,
@VSKEY,
@VSTITLE,
@VSCONTENT,
@VSIMAGE,
@VSEMAIL,
@VSATUTHOR,
@VSURL,
@DSCREATEDATE,
@DSUPDATE,
@DSENDDATE,
@ISENABLE,
@web
)
end





GO
/****** Object:  StoredProcedure [dbo].[Subitems_InsertFull]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Subitems_InsertFull]
(
@IID int
,@VSLANG varchar(50)
,@VSKEY varchar(200)
,@VSTITLE nvarchar(500)
,@VSCONTENT ntext
,@VSIMAGE nvarchar(300)
,@VSEMAIL nvarchar(300)
,@VSATUTHOR nvarchar(300)
,@VSURL nvarchar(300)
,@DSCREATEDATE datetime
,@DSUPDATE datetime
,@DSENDDATE datetime
,@ISENABLE int
,@web nvarchar(300)
,@fsPrice float
,@fsSalePrice float
,@vsDesc nvarchar(1000)
,@vsParams nvarchar(max)
,@isTotalView int
,@isTotalSubitem int
,@isOrder int
,@isParam1 int
,@isParam2 int
,@vsParam1 nvarchar(1000)
,@vsParam2 nvarchar(1000)
,@dsParam1 datetime
,@dsParam2 datetime
)
as
begin
INSERT INTO [SUBITEMS]
           ([IID]
           ,[VSLANG]
           ,[VSKEY]
           ,[VSTITLE]
           ,[VSCONTENT]
           ,[VSIMAGE]
           ,[VSEMAIL]
           ,[VSATUTHOR]
           ,[VSURL]
           ,[DSCREATEDATE]
           ,[DSUPDATE]
           ,[DSENDDATE]
           ,[ISENABLE]
           ,[web]
           ,[fsPrice]
           ,[fsSalePrice]
           ,[vsDesc]
           ,[vsParams]
           ,[isTotalView]
           ,[isTotalSubitem]
		   ,[isOrder]
           ,[isParam1]
           ,[isParam2]
           ,[vsParam1]
           ,[vsParam2]           
           ,[dsParam1]
           ,[dsParam2])
     VALUES
           (
           @IID
,@VSLANG
,@VSKEY
,@VSTITLE
,@VSCONTENT
,@VSIMAGE
,@VSEMAIL
,@VSATUTHOR
,@VSURL
,@DSCREATEDATE
,@DSUPDATE
,@DSENDDATE
,@ISENABLE
,@web
,@fsPrice
,@fsSalePrice
,@vsDesc
,@vsParams
,@isTotalView
,@isTotalSubitem
,@isOrder
,@isParam1
,@isParam2
,@vsParam1
,@vsParam2
,@dsParam1
,@dsParam2
           )
end





GO
/****** Object:  StoredProcedure [dbo].[Subitems_Update]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[Subitems_Update]
(
@IID int,
@VSLANG varchar(50),
@VSKEY varchar(200),
@VSTITLE nvarchar(500),
@VSCONTENT ntext,
@VSIMAGE nvarchar(300),
@VSEMAIL nvarchar(300),
@VSATUTHOR nvarchar(300),
@VSURL nvarchar(300),
@DSCREATEDATE datetime,
@DSUPDATE datetime,
@DSENDDATE datetime,
@ISENABLE int,
@isid int,
@web nvarchar(300)
)
as
begin

update [SUBITEMS] set
           [IID]=@IID
           ,[VSLANG]=@VSLANG
           ,[VSKEY]=@VSKEY
           ,[VSTITLE]=@VSTITLE
           ,[VSCONTENT]=@VSCONTENT
           ,[VSIMAGE]=@VSIMAGE
           ,[VSEMAIL]=@VSEMAIL
           ,[VSATUTHOR]=@VSATUTHOR
           ,[VSURL]=@VSURL
           ,[DSCREATEDATE]=@DSCREATEDATE
           ,[DSUPDATE]=@DSUPDATE
           ,[DSENDDATE]=@DSENDDATE
           ,[ISENABLE]=@ISENABLE
          where ISID=@isid and web like @web
end





GO
/****** Object:  StoredProcedure [dbo].[Subitems_UpdateFull]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE proc [dbo].[Subitems_UpdateFull]
(
@IID int,
@VSLANG varchar(50),
@VSKEY varchar(200),
@VSTITLE nvarchar(500),
@VSCONTENT ntext,
@VSIMAGE nvarchar(300),
@VSEMAIL nvarchar(300),
@VSATUTHOR nvarchar(300),
@VSURL nvarchar(300),
@DSCREATEDATE datetime,
@DSUPDATE datetime,
@DSENDDATE datetime,
@ISENABLE int,
@isid int,
@web nvarchar(300)

,@fsPrice float
,@fsSalePrice float
,@vsDesc nvarchar(1000)
,@vsParams nvarchar(max)
,@isTotalView int
,@isTotalSubitem int
,@isOrder int
,@isParam1 int
,@isParam2 int
,@vsParam1 nvarchar(1000)
,@vsParam2 nvarchar(1000)
,@dsParam1 datetime
,@dsParam2 datetime
)
as
begin

update [SUBITEMS] set
           [IID]=@IID
           ,[VSLANG]=@VSLANG
           ,[VSKEY]=@VSKEY
           ,[VSTITLE]=@VSTITLE
           ,[VSCONTENT]=@VSCONTENT
           ,[VSIMAGE]=@VSIMAGE
           ,[VSEMAIL]=@VSEMAIL
           ,[VSATUTHOR]=@VSATUTHOR
           ,[VSURL]=@VSURL
           ,[DSCREATEDATE]=@DSCREATEDATE
           ,[DSUPDATE]=@DSUPDATE
           ,[DSENDDATE]=@DSENDDATE
           ,[ISENABLE]=@ISENABLE
           
           ,[fsPrice]=@fsPrice
           ,[fsSalePrice]=@fsSalePrice
           ,[vsDesc]=@vsDesc
           ,[vsParams]=@vsParam1
           ,[isTotalView]=@isTotalView
           ,[isTotalSubitem]=@isTotalSubitem
		   ,[isOrder]=@isOrder
           ,[isParam1]=@isParam1
           ,[isParam2]=@isParam2
           ,[vsParam1]=@vsParam1
           ,[vsParam2]=@vsParam2
           
           ,[dsParam1]=@dsParam1
           ,[dsParam2]=@dsParam2
          where ISID=@isid and web like @web
end





GO
/****** Object:  StoredProcedure [dbo].[UpdateGroupsOfItems]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateGroupsOfItems]    
	@IID INT,
	@IGID_Old INT ,
    @IGID_New INT 
    ,@web nvarchar(300)
AS                                           
	DECLARE @NEW_IGPARENTSID NVARCHAR(200)
	SELECT @NEW_IGPARENTSID = IGPARENTSID FROM dbo.GROUPS WHERE IGID = @IGID_New  and web like @web
	
	UPDATE GROUPS_ITEMS SET VPARAMS=@NEW_IGPARENTSID,IGID=@IGID_New
	WHERE IID=@IID AND IGID=@IGID_Old	  and web like @web



GO
/****** Object:  StoredProcedure [dbo].[Users_ChangePassword]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Users_ChangePassword]
	@UserId INT,
	@UserPassword nvarchar(100),
	@UserNewPassword nvarchar(100)
	,@web nvarchar(300)
AS
IF((SELECT COUNT(*) FROM Users where UserId = @UserId AND UserPassword = @UserPassword  and web like @web) > 0)
	BEGIN
	UPDATE Users SET UserPassword = @UserNewPassword WHERE UserId = @UserId
	END
ELSE 
	RETURN



GO
/****** Object:  StoredProcedure [dbo].[UsersRoles_Delete]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsersRoles_Delete]
	@UserId int
	,@web nvarchar(300)
as
Declare @NewRoleId INT
select @NewRoleId = (select RoleId from Users where UserId = @UserId and web like @web)
delete from Users where UserId = @UserId and web like @web
delete from Roles where RoleId = @NewRoleId and web like @web



GO
/****** Object:  StoredProcedure [dbo].[UsersRoles_Insert]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsersRoles_Insert]
	@RoleName nvarchar(100),
	@RoleDescription nvarchar(300),
	@RoleLevel int,
	@UserName nvarchar(100),
	@UserPassword nvarchar(100),
	@UserPasswordSalt nvarchar(100),
	@UserFirstName nvarchar(80),
	@UserLastName nvarchar(80),
	@UserAddress nvarchar(80),
	@UserPhoneNumber nvarchar(300),
	@UserEmail nvarchar(120),
	@UserIdentityCard nvarchar(50),
	@UserPasswordQuestion nvarchar(500),
	@UserPasswordAnswer nvarchar(500),
	@UserIsApproved tinyint,
	@UserIsLockedout tinyint,
	@UserCreateDate datetime,
	@UserLastLogindate datetime,
	@UserLastPasswordChangedDate datetime,
	@UserLastLockoutDate datetime,
	@UserComment nvarchar(500)
	,@web nvarchar(300)
AS
	INSERT INTO Roles VALUES(@RoleName,@RoleDescription,@RoleLevel,@web)
	
	DECLARE @NewRoleId int

	SELECT @NewRoleId = (SELECT TOP 1 RoleId FROM Roles where web like @web ORDER BY RoleId DESC)

	INSERT INTO Users values(
		@NewRoleId,
		@UserName,
		@UserPassword,
		@UserPasswordSalt,
		@UserFirstName,
		@UserLastName,
		@UserAddress,
		@UserPhoneNumber,
		@UserEmail,
		@UserIdentityCard,
		@UserPasswordQuestion,
		@UserPasswordAnswer,
		@UserIsApproved,
		@UserIsLockedout,
		@UserCreateDate,
		@UserLastLogindate,
		@UserLastPasswordChangedDate,
		@UserLastLockoutDate,
		@UserComment,
		@web
	)



GO
/****** Object:  StoredProcedure [dbo].[UsersRoles_Update]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UsersRoles_Update]
	@UserId int,
	@RoleId int,
	@RoleName nvarchar(100),
	@RoleDescription nvarchar(300),
	@RoleLevel int,
	@UserName nvarchar(100),
	@UserFirstName nvarchar(80),
	@UserLastName nvarchar(80),
	@UserAddress nvarchar(80),
	@UserPhoneNumber nvarchar(300),
	@UserEmail nvarchar(120),
	@UserIdentityCard nvarchar(50),
	@UserPasswordQuestion nvarchar(500),
	@UserPasswordAnswer nvarchar(500),
	@UserIsApproved tinyint,
	@UserIsLockedout tinyint,
	@UserCreateDate datetime,
	@UserLastLogindate datetime,
	@UserLastPasswordChangedDate datetime,
	@UserLastLockoutDate datetime,
	@UserComment nvarchar(500)
	,@web nvarchar(300)
AS
	UPDATE Users set 
		UserName = @UserName,
		UserFirstName = @UserFirstName,
		UserLastName = @UserLastName,
		UserAddress = @UserAddress,
		UserPhoneNumber = @UserPhoneNumber,
		UserEmail = @UserEmail,
		UserIdentityCard = @UserIdentityCard,
		UserPasswordQuestion = @UserPasswordQuestion,
		UserPasswordAnswer = @UserPasswordAnswer,
		UserIsApproved = @UserIsApproved,
		UserIsLockedout = @UserIsLockedout,
		UserCreateDate = @UserCreateDate,
		UserLastLogindate = @UserLastLogindate,
		UserLastPasswordChangedDate = @UserLastPasswordChangedDate,
		UserLastLockoutDate = @UserLastLockoutDate,
		UserComment = @UserComment
		where UserId = @UserId and web like @web
	

	UPDATE Roles set 
		RoleName=@RoleName,
		RoleDescription=@RoleDescription,
		RoleLevel=@RoleLevel 
		where RoleId=@RoleId and web like @web



GO
/****** Object:  UserDefinedFunction [dbo].[CastParamToOrder]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CastParamToOrder](
@param nvarchar(300)
)
returns float
as
begin
declare @kq float
if ISNUMERIC(@param)=1 set @kq=@param
else set @kq=9999
return @kq
end

--select dbo.CastParamToOrder('123.1')



GO
/****** Object:  UserDefinedFunction [dbo].[ContainsSharedTerm]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create FUNCTION [dbo].[ContainsSharedTerm]
( @SearchString1 varchar(255), @SearchString2 varchar(255) )
RETURNS BIT
AS
BEGIN
    DECLARE @MatchFound BIT
    SET @MatchFound = 0
    DECLARE @TempString VARCHAR(255)
	
	set @SearchString1=','+@SearchString1+','
	set @SearchString2=','+@SearchString2+','
	
    WHILE LEN(@SearchString1) > 0 AND @MatchFound = 0
    BEGIN
        IF CHARINDEX(',',@SearchString1) = 0
        BEGIN
            SET @TempString = @SearchString1
            SET @SearchString1 = ''
        END
        ELSE
        BEGIN
            SET @TempString = LEFT(@SearchString1,CHARINDEX(',',@SearchString1)-1)
            SET @SearchString1 = RIGHT(@SearchString1,LEN(@SearchString1)-CHARINDEX(',',@SearchString1))
        END

		if(@TempString<>',' and @TempString<>'' and CHARINDEX(','+@TempString+',',@SearchString2) > 0)
        BEGIN
            SET @MatchFound = 1
        END
    END
    RETURN @MatchFound
END


GO
/****** Object:  UserDefinedFunction [dbo].[LayChuoi]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[LayChuoi]
(
	@chuoinguon NVARCHAR(max),
	@chuoiphancach NVARCHAR(100),
	@vitricanlay INT
)
RETURNS NVARCHAR(1000)
AS
BEGIN	
	DECLARE @vitrihientai INT
	DECLARE @chuoihientai NVARCHAR(1000)
	DECLARE @sochuoidacat int

	SET @vitrihientai = CHARINDEX(@chuoiphancach,@chuoinguon)
	SET @sochuoidacat =0

	WHILE(@vitrihientai>0 AND @sochuoidacat <= @vitricanlay)
		BEGIN
			IF(@sochuoidacat=@vitricanlay)
				SET @chuoihientai=SUBSTRING(@chuoinguon,0,@vitrihientai)
			SET @chuoinguon=SUBSTRING(@chuoinguon,@vitrihientai+LEN(@chuoiphancach),LEN(@chuoinguon)-@vitrihientai-LEN(@chuoiphancach)+1)
			SET @vitrihientai = CHARINDEX(@chuoiphancach,@chuoinguon)
			SET @sochuoidacat=@sochuoidacat+1
		END

	RETURN @chuoihientai
END

--SELECT dbo.LayChuoi('*!<=*ParamsSpilitItems*=>*!Nguyễn Văn Hoà*!<=*ParamsSpilitItems*=>*!hello*!<=*ParamsSpilitItems*=>*!','*!<=*ParamsSpilitItems*=>*!',1)


GO
/****** Object:  UserDefinedFunction [dbo].[RemoveTextIfNotIsFloat]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[RemoveTextIfNotIsFloat](
@source nvarchar(10)
)
returns float
as
begin
declare @result float

if isnumeric(@source)=1
set @result=cast(@source as float)
else
set @result=999

return @result
end


GO
/****** Object:  UserDefinedFunction [dbo].[ReplaceTitle]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[ReplaceTitle](@sourceString NVARCHAR(max))
	RETURNS NVARCHAR(max)
AS
BEGIN
	--Khai báo biến lưu kết quả
	DECLARE @result NVARCHAR(max)
		
	--Chuyển chuỗi vào thành chữ thường
	SET @result=LOWER(@sourceString)
	
	
	--Bắt đầu chuyển đổi chuỗi:
		
	--Cắt bỏ các kí tự trắng bên trái và bên phải
	SET @result=LTRIM(@result)
	SET @result=RTRIM(@result)
	
	--Chuyển các chữ a có dấu về không dấu
	set @result=REPLACE(@result,N'ä','a')
	set @result=REPLACE(@result,N'à','a')
	set @result=REPLACE(@result,N'á','a')
	set @result=REPLACE(@result,N'ạ','a')
	set @result=REPLACE(@result,N'ả','a')
	set @result=REPLACE(@result,N'ã','a')
	set @result=REPLACE(@result,N'â','a')
	set @result=REPLACE(@result,N'ầ','a')
	set @result=REPLACE(@result,N'ấ','a')
	set @result=REPLACE(@result,N'ậ','a')
	set @result=REPLACE(@result,N'ẩ','a')
	set @result=REPLACE(@result,N'ẫ','a')
	set @result=REPLACE(@result,N'ă','a')
	set @result=REPLACE(@result,N'ằ','a')
	set @result=REPLACE(@result,N'ắ','a')
	set @result=REPLACE(@result,N'ặ','a')
	set @result=REPLACE(@result,N'ẳ','a')
	set @result=REPLACE(@result,N'ẵ','a')
	
	--Chuyển các chữ c có dấu về không dấu	
	set @result=REPLACE(@result,N'ç','c')
	
	--Chuyển các chữ e có dấu về không dấu
	set @result=REPLACE(@result,N'è','e')
	set @result=REPLACE(@result,N'é','e')
	set @result=REPLACE(@result,N'ẹ','e')
	set @result=REPLACE(@result,N'ẻ','e')
	set @result=REPLACE(@result,N'ẽ','e')
	set @result=REPLACE(@result,N'ê','e')
	set @result=REPLACE(@result,N'ề','e')
	set @result=REPLACE(@result,N'ế','e')
	set @result=REPLACE(@result,N'ệ','e')
	set @result=REPLACE(@result,N'ể','e')
	set @result=REPLACE(@result,N'ễ','e')
	
	--Chuyển các chữ i có dấu về không dấu
	set @result=REPLACE(@result,N'ì','i')
	set @result=REPLACE(@result,N'í','i')
	set @result=REPLACE(@result,N'î','i')
	set @result=REPLACE(@result,N'ị','i')
	set @result=REPLACE(@result,N'ỉ','i')
	set @result=REPLACE(@result,N'ĩ','i')
	
	--Chuyển các chữ o có dấu về không dấu
	set @result=REPLACE(@result,N'ö','o')
	set @result=REPLACE(@result,N'ò','o')
	set @result=REPLACE(@result,N'ó','o')
	set @result=REPLACE(@result,N'ọ','o')
	set @result=REPLACE(@result,N'ỏ','o')
	set @result=REPLACE(@result,N'õ','o')
	set @result=REPLACE(@result,N'ô','o')
	set @result=REPLACE(@result,N'ồ','o')
	set @result=REPLACE(@result,N'ố','o')
	set @result=REPLACE(@result,N'ộ','o')
	set @result=REPLACE(@result,N'ổ','o')
	set @result=REPLACE(@result,N'ỗ','o')
	set @result=REPLACE(@result,N'ơ','o')
	set @result=REPLACE(@result,N'ờ','o')
	set @result=REPLACE(@result,N'ớ','o')
	set @result=REPLACE(@result,N'ợ','o')
	set @result=REPLACE(@result,N'ở','o')
	set @result=REPLACE(@result,N'ỡ','o')
	
	--Chuyển các chữ u có dấu về không dấu
	set @result=REPLACE(@result,N'ü','u')
	set @result=REPLACE(@result,N'ù','u')
	set @result=REPLACE(@result,N'ú','u')
	set @result=REPLACE(@result,N'ụ','u')
	set @result=REPLACE(@result,N'ủ','u')
	set @result=REPLACE(@result,N'ũ','u')
	set @result=REPLACE(@result,N'ư','u')
	set @result=REPLACE(@result,N'ừ','u')
	set @result=REPLACE(@result,N'ứ','u')
	set @result=REPLACE(@result,N'ự','u')
	set @result=REPLACE(@result,N'ử','u')
	set @result=REPLACE(@result,N'ữ','u')
	
	--Chuyển các chữ y có dấu về không dấu
	set @result=REPLACE(@result,N'ỳ','y')
	set @result=REPLACE(@result,N'ý','y')
	set @result=REPLACE(@result,N'ỵ','y')
	set @result=REPLACE(@result,N'ỷ','y')
	set @result=REPLACE(@result,N'ỹ','y')
	
	--Chuyển các chữ d có dấu về không dấu
	set @result=REPLACE(@result,N'đ','d')		
	
	--Chỉ dữ lại các kí tự a-z, các số 0-9, các kí tự khác đổi thành dấu -
	DECLARE @count INT
	DECLARE @currentChar NVARCHAR(1)
	SET @count=1
	WHILE (@count <= LEN(@result))
		BEGIN	
			SET @currentChar=SUBSTRING(@result,@count,1) --Lấy kí tự hiện tại
			--Nếu kí tự hiện tại không thuộc 0-9 hoặc a-z -> thay kí tự đó bởi dấu -	
			IF(ASCII(@currentChar) < ASCII('0') OR ASCII(@currentChar) > ASCII('z') OR (ASCII(@currentChar) > ASCII('9') AND ASCII(@currentChar) < ASCII('a')))
				SET @result=REPLACE(@result,@currentChar,'-')
			SET @count=@count+1
		END
	
	--Đổi nhiều dấu - liền nhau thành 1 dấu -
	DECLARE @nextChar NVARCHAR(1) --Kí tự liền sau kí tự đang xét
	DECLARE @found INT --Số dấu - liền nhau được phát hiện
	DECLARE @foundStartIndex INT	--Vị trí đầu tiên của dấu - trong dãy các dấu - liền nhau
	SET @found=0
	SET @foundStartIndex=0
	SET @count=1
	WHILE (@count <= LEN(@result))
		BEGIN	
			SET @currentChar=SUBSTRING(@result,@count,1) --Lấy kí tự hiện tại
			SET @nextChar=SUBSTRING(@result,@count+1,1) --Lấy kí tự kế tiếp
			IF(@currentChar='-' AND @nextChar='-') --Nếu có hai dấu - liền nhau -> đánh dấu vị trí phát hiện, tăng số lượng kí tự thừa phát hiện
				BEGIN
					SET @foundStartIndex=@count
					SET @found=@found+1
				END
			IF(@found>0)--Nếu có kí tự thừa được phát hiện -> đổi nhiều kí tự - thành 1 kí tự -, lùi biến đếm 1 đơn vị và tiếp tục duyệt
				BEGIN
					SET @result=STUFF(@result,@foundStartIndex,@found+1,'-')
					SET @found=0
					SET @foundStartIndex=0
					SET @count=@count-1
				END
			SET @count=@count+1
		END
	
	--Xoá dấu - đầu tiên và cuối cùng
	SET @currentChar=SUBSTRING(@result,1,1) --Lấy kí tự đầu tiên
	IF(@currentChar='-')
		SET @result=STUFF(@result,1,1,'')
	SET @currentChar=SUBSTRING(@result,LEN(@result),1) --Lấy kí tự cuối cùng
	IF(@currentChar='-')
		SET @result=STUFF(@result,LEN(@result),1,'')
	
	
	--Trả về kết quả
	RETURN @result
END


GO
/****** Object:  UserDefinedFunction [dbo].[SearchMatched]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--So khớp chuỗi tìm kiếm với chuỗi đã có
CREATE FUNCTION [dbo].[SearchMatched](@searchString NVARCHAR(max),@sourceString NVARCHAR(max))
	RETURNS int
AS
BEGIN
	DECLARE @result INT
	SET @result =0
	
	SET @searchString=dbo.ReplaceTitle(@searchString) --Loại bỏ dấu, các kí tự đặc biệt và chuyển về chữ thường
	SET @sourceString=dbo.ReplaceTitle(@sourceString) --Loại bỏ dấu, các kí tự đặc biệt và chuyển về chữ thường
	
	IF(CHARINDEX(@searchString,@sourceString)>0)
		SET @result=1
	
	RETURN @result
END


GO
/****** Object:  Table [dbo].[GROUPS]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GROUPS](
	[IGID] [int] IDENTITY(1,1) NOT NULL,
	[VGLANG] [varchar](50) NULL,
	[VGAPP] [varchar](50) NULL,
	[IGLEVEL] [int] NULL,
	[IGPARENTID] [int] NULL,
	[IGPARENTSID] [nvarchar](100) NULL,
	[VGNAME] [nvarchar](500) NULL,
	[VGDESC] [nvarchar](1000) NULL,
	[VGCONTENT] [ntext] NULL,
	[VGSEOTITLE] [nvarchar](500) NULL,
	[VGSEOLINK] [nvarchar](500) NULL,
	[VGSEOLINKSEARCH] [nvarchar](500) NULL,
	[VGSEOMETAKEY] [nvarchar](500) NULL,
	[VGSEOMETADESC] [nvarchar](max) NULL,
	[VGSEOMETACANONICAL] [nvarchar](500) NULL,
	[VGSEOMETALANG] [nvarchar](100) NULL,
	[VGSEOMETAPARAMS] [nvarchar](max) NULL,
	[VGIMAGE] [nvarchar](300) NULL,
	[VGPARAMS] [nvarchar](max) NULL,
	[IGTOTALITEMS] [int] NULL,
	[IGORDER] [int] NULL,
	[DGCREATEDATE] [datetime] NULL,
	[DGUPDATE] [datetime] NULL,
	[DGENDDATE] [datetime] NULL,
	[IGENABLE] [int] NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_GROUPS] PRIMARY KEY CLUSTERED 
(
	[IGID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GROUPS_ITEMS]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GROUPS_ITEMS](
	[IGIID] [int] IDENTITY(1,1) NOT NULL,
	[IGID] [int] NULL,
	[IID] [int] NULL,
	[VPARAMS] [nvarchar](150) NULL,
	[DCREATEDATE] [datetime] NULL,
	[DUPDATE] [datetime] NULL,
	[DENDDATE] [datetime] NULL,
	[IORDER] [int] NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_GROUPS_ITEMS] PRIMARY KEY CLUSTERED 
(
	[IGIID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ITEMS]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ITEMS](
	[IID] [int] IDENTITY(1,1) NOT NULL,
	[VILANG] [varchar](50) NULL,
	[VIAPP] [varchar](50) NULL,
	[VIKEY] [varchar](200) NULL,
	[VITITLE] [nvarchar](500) NULL,
	[VIDESC] [nvarchar](1000) NULL,
	[VICONTENT] [ntext] NULL,
	[VIIMAGE] [nvarchar](300) NULL,
	[VIURL] [nvarchar](300) NULL,
	[VIAUTHOR] [nvarchar](300) NULL,
	[VISEOTITLE] [nvarchar](500) NULL,
	[VISEOLINK] [nvarchar](500) NULL,
	[VISEOLINKSEARCH] [nvarchar](500) NULL,
	[VISEOMETAKEY] [nvarchar](500) NULL,
	[VISEOMETADESC] [nvarchar](max) NULL,
	[VISEOMETACANONICAL] [nvarchar](500) NULL,
	[VISEOMETALANG] [nvarchar](100) NULL,
	[VISEOMETAPARAMS] [nvarchar](max) NULL,
	[VIPARAMS] [nvarchar](max) NULL,
	[FIPRICE] [float] NULL,
	[FISALEPRICE] [float] NULL,
	[IITOTALSUBITEMS] [int] NULL,
	[IITOTALVIEW] [int] NULL,
	[IIORDER] [int] NULL,
	[DILASTVIEW] [datetime] NULL,
	[DICREATEDATE] [datetime] NULL,
	[DIUPDATE] [datetime] NULL,
	[DIENDDATE] [datetime] NULL,
	[IIENABLE] [int] NULL,
	[web] [nvarchar](300) NULL,
	[vsearchkey] [nvarchar](1000) NULL,
 CONSTRAINT [PK_ITEMS] PRIMARY KEY CLUSTERED 
(
	[IID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[LanguageItem]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageItem](
	[iLanguageItemId] [int] IDENTITY(1,1) NOT NULL,
	[iLanguageNationalId] [int] NULL,
	[iLanguageKeyId] [int] NULL,
	[nLanguageItemTitle] [ntext] NULL,
	[nLanguageItemDesc] [nvarchar](max) NULL,
	[nLanguageItemParams] [nvarchar](max) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_LanguageItem] PRIMARY KEY CLUSTERED 
(
	[iLanguageItemId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LanguageKey]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageKey](
	[iLanguageKeyId] [int] IDENTITY(1,1) NOT NULL,
	[nLanguageKeyTitle] [nvarchar](1000) NULL,
	[nLanguageKeyDesc] [nvarchar](250) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED 
(
	[iLanguageKeyId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[LanguageNational]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LanguageNational](
	[iLanguageNationalId] [int] IDENTITY(1,1) NOT NULL,
	[nLanguageNationalName] [nvarchar](100) NULL,
	[nLanguageNationalFlag] [nvarchar](250) NULL,
	[nLanguageNationalDesc] [nvarchar](250) NULL,
	[iLanguageNationalEnable] [tinyint] NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_LanguageNational] PRIMARY KEY CLUSTERED 
(
	[iLanguageNationalId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Logs]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Logs](
	[ilId] [int] IDENTITY(1,1) NOT NULL,
	[dlCreateDate] [datetime] NOT NULL,
	[vlUrl] [nvarchar](300) NOT NULL,
	[vlIP] [nchar](100) NULL,
	[vlInfo] [nchar](300) NULL,
	[vlAuthor] [nchar](100) NULL,
	[vlType] [nchar](100) NULL,
	[vlDesc] [nchar](300) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED 
(
	[ilId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Members]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Members](
	[IMID] [int] IDENTITY(1,1) NOT NULL,
	[vProperty] [nvarchar](max) NULL,
	[vMemberAccount] [nvarchar](30) NULL,
	[vMemberPassword] [nvarchar](150) NULL,
	[vMemberName] [nvarchar](80) NULL,
	[vMemberAddress] [nvarchar](250) NULL,
	[vMemberPhone] [nvarchar](25) NULL,
	[vMemberEmail] [nvarchar](100) NULL,
	[dMemberBirthday] [datetime] NULL,
	[vMemberIdentityCard] [nvarchar](100) NULL,
	[vMemberRelationship] [nvarchar](250) NULL,
	[vMemberEdu] [nvarchar](250) NULL,
	[vMemberJob] [nvarchar](250) NULL,
	[vMemberYahooNick] [nvarchar](250) NULL,
	[vMemberImage] [nvarchar](250) NULL,
	[vMemberPasswordQuestion] [nvarchar](250) NULL,
	[vMemberPasswordAnswer] [nvarchar](250) NULL,
	[iMemberIsApproved] [int] NULL,
	[iMemberIsLockedOut] [int] NULL,
	[dMemberCreatedate] [datetime] NULL,
	[dMemberLastLoginDate] [datetime] NULL,
	[dMemberLastChangePasswordDate] [datetime] NULL,
	[dMemberLastLogOutDate] [datetime] NULL,
	[vMemberComment] [nvarchar](max) NULL,
	[iMemberTotalLogin] [int] NULL,
	[iMemberTotalview] [int] NULL,
	[vMemberWeight] [nvarchar](250) NULL,
	[vMemberHeight] [nvarchar](250) NULL,
	[vMemberBlast] [nvarchar](250) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_Members] PRIMARY KEY CLUSTERED 
(
	[IMID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Reports]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Reports](
	[iReportsId] [int] IDENTITY(1,1) NOT NULL,
	[dRTotal] [datetime] NULL,
	[vRTotalView] [nvarchar](max) NULL,
	[vRTotalClick] [nvarchar](max) NULL,
	[vRTotalTime] [nvarchar](50) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_Reports] PRIMARY KEY CLUSTERED 
(
	[iReportsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReportsBrowser]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportsBrowser](
	[iReportBrowserId] [int] IDENTITY(1,1) NOT NULL,
	[vBType] [nvarchar](20) NULL,
	[vBName] [nvarchar](30) NULL,
	[vBVersion] [nvarchar](30) NULL,
	[vPlatform] [nvarchar](20) NULL,
	[iBIsBeta] [tinyint] NULL,
	[iBIsCrawler] [tinyint] NULL,
	[iBIsAOL] [tinyint] NULL,
	[vBWin] [nvarchar](15) NULL,
	[iBSupportFrames] [tinyint] NULL,
	[iBSupportTable] [tinyint] NULL,
	[iBSupportCookies] [tinyint] NULL,
	[iBSupportVBScript] [tinyint] NULL,
	[vBSupportJavaScript] [nvarchar](15) NULL,
	[iBSupportJavaApplets] [tinyint] NULL,
	[iBSupportActiveXControls] [tinyint] NULL,
	[vBScreenresolution] [nvarchar](50) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_ReportBrowser] PRIMARY KEY CLUSTERED 
(
	[iReportBrowserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReportsDetail]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportsDetail](
	[iReportDetailId] [int] IDENTITY(1,1) NOT NULL,
	[iLanguageNationalId] [int] NULL,
	[iReportBrowserId] [int] NULL,
	[iReportsLocationId] [int] NULL,
	[vReportDetailIP] [nvarchar](30) NULL,
	[vReportDetailNAME] [nvarchar](100) NULL,
	[dReportDetailStartView] [datetime] NULL,
	[dReportDetailEndView] [datetime] NULL,
	[vReportDetailVparams] [nvarchar](max) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_ReportsDetail] PRIMARY KEY CLUSTERED 
(
	[iReportDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReportsLink]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportsLink](
	[iReportsLinkId] [int] IDENTITY(1,1) NOT NULL,
	[iReportDetailId] [int] NULL,
	[vReportsLinkView] [nvarchar](200) NULL,
	[dReportsLinkStart] [datetime] NULL,
	[dReportsLinkEnd] [datetime] NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_ReportsLink] PRIMARY KEY CLUSTERED 
(
	[iReportsLinkId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReportsLocation]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportsLocation](
	[iReportsLocationId] [int] IDENTITY(1,1) NOT NULL,
	[nReportsLocationCountry] [nvarchar](150) NULL,
	[nReportsLocationCity] [nvarchar](500) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_ReportsLocation] PRIMARY KEY CLUSTERED 
(
	[iReportsLocationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ReportsSetting]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ReportsSetting](
	[iReportsSettingId] [int] IDENTITY(1,1) NOT NULL,
	[vReportsSettingLanguage] [nvarchar](50) NULL,
	[vReportsSettingTitle] [nvarchar](100) NULL,
	[vReportsSettingDesc] [nvarchar](250) NULL,
	[vReportsSettingValue] [nvarchar](100) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_ReportsSetting] PRIMARY KEY CLUSTERED 
(
	[iReportsSettingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Roles]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NULL,
	[RoleDescription] [nvarchar](300) NULL,
	[RoleLevel] [int] NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SETTINGS]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SETTINGS](
	[VSKEY] [nvarchar](200) NOT NULL,
	[VSDESC] [nvarchar](1500) NULL,
	[VSVALUE] [nvarchar](max) NULL,
	[VSLANG] [nvarchar](50) NOT NULL,
	[web] [nvarchar](300) NOT NULL DEFAULT (''),
 CONSTRAINT [PK_SETTINGS] PRIMARY KEY CLUSTERED 
(
	[VSKEY] ASC,
	[VSLANG] ASC,
	[web] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[SUBITEMS]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SUBITEMS](
	[ISID] [int] IDENTITY(1,1) NOT NULL,
	[IID] [int] NULL,
	[VSLANG] [varchar](50) NULL,
	[VSKEY] [varchar](200) NULL,
	[VSTITLE] [nvarchar](500) NULL,
	[VSCONTENT] [ntext] NULL,
	[VSIMAGE] [nvarchar](300) NULL,
	[VSEMAIL] [nvarchar](300) NULL,
	[VSATUTHOR] [nvarchar](300) NULL,
	[VSURL] [nvarchar](300) NULL,
	[DSCREATEDATE] [datetime] NULL,
	[DSUPDATE] [datetime] NULL,
	[DSENDDATE] [datetime] NULL,
	[ISENABLE] [int] NULL,
	[web] [nvarchar](300) NULL,
	[fsPrice] [float] NULL,
	[fsSalePrice] [float] NULL,
	[vsDesc] [nvarchar](1000) NULL,
	[vsParams] [nvarchar](max) NULL,
	[isTotalView] [int] NULL,
	[isTotalSubitem] [int] NULL,
	[isOrder] [int] NULL,
	[isParam1] [int] NULL,
	[isParam2] [int] NULL,
	[vsParam1] [nvarchar](1000) NULL,
	[vsParam2] [nvarchar](1000) NULL,
	[dsParam1] [datetime] NULL,
	[dsParam2] [datetime] NULL,
 CONSTRAINT [PK_SUBITEMS] PRIMARY KEY CLUSTERED 
(
	[ISID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Users]    Script Date: 10/10/2019 3:21:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [int] NULL,
	[UserName] [nvarchar](100) NULL,
	[UserPassword] [nvarchar](100) NULL,
	[UserPasswordSalt] [nvarchar](100) NULL,
	[UserFirstName] [nvarchar](80) NULL,
	[UserLastName] [nvarchar](80) NULL,
	[UserAddress] [nvarchar](300) NULL,
	[UserPhoneNumber] [nvarchar](50) NULL,
	[UserEmail] [nvarchar](120) NULL,
	[UserIdentityCard] [nvarchar](50) NULL,
	[UserPasswordQuestion] [nvarchar](500) NULL,
	[UserPasswordAnswer] [nvarchar](500) NULL,
	[UserIsApproved] [tinyint] NULL,
	[UserIsLockedout] [tinyint] NULL,
	[UserCreateDate] [datetime] NULL,
	[UserLastLogindate] [datetime] NULL,
	[UserLastPasswordChangedDate] [datetime] NULL,
	[UserLastLockoutDate] [datetime] NULL,
	[UserComment] [nvarchar](500) NULL,
	[web] [nvarchar](300) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[GROUPS] ON 

INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1, N'2', N'CUP', 1, 0, N'0,1,', N'Cat Ba Freedom tour', N'<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59706.88745779679!2d107.02417297106759!3d20.723196187382115!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a444a4adb83f1%3A0xe7902d18f44a272a!2zQ2F0IEJhLCBDw6F0IEjhuqNpLCBIYWkgUGhvbmcsIFZpZXRuYW0!5e0!3m2!1sen!2s!4v1570550432920!5m2!1sen!2s" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>', N'*!<=*ParamsSpilitItems*=>*!Cat ba town, Cat Hai district, Hai Phong city, Viet Nam.*!<=*ParamsSpilitItems*=>*!0966 500 109*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!captainjacktour@gmail.com, cathaitourist@gmail.com*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!http://catbafreedom.com*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'Cat Ba Freedom tour', N'Cat Ba Freedom tour', N'Cat-Ba-Freedom-tour', N'Cat Ba Freedom tour', N'<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d59706.88745779679!2d107.02417297106759!3d20.723196187382115!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a444a4adb83f1%3A0xe7902d18f44a272a!2zQ2F0IEJhLCBDw6F0IEjhuqNpLCBIYWkgUGhvbmcsIFZpZXRuYW0!5e0!3m2!1sen!2s!4v1570550432920!5m2!1sen!2s" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 08:14:35.000' AS DateTime), CAST(N'2019-10-09 08:14:35.000' AS DateTime), CAST(N'2019-10-09 08:14:35.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (2, N'2', N'AboutUs', 1, 0, N'0,2,', N'About us', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'About us', N'About us', N'About-us', N'About us', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-08 23:20:04.000' AS DateTime), CAST(N'2019-10-08 23:20:04.000' AS DateTime), CAST(N'2019-10-08 23:20:04.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (3, N'2', N'Tour', 1, 0, N'0,3,', N'Cat Ba Island, Ha Long Bay Tours', N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book', N'', N'Cat Ba Island, Ha Long Bay Tours', N'Cat Ba Island, Ha Long Bay Tours', N'Cat-Ba-Island-Ha-Long-Bay-Tours', N'Cat Ba Island, Ha Long Bay Tours', N'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry''s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book', N'', N'', N'', N'bg-banner_637062581222132516.jpg', N'', 0, 1, CAST(N'2019-10-09 22:48:42.000' AS DateTime), CAST(N'2019-10-09 22:48:42.000' AS DateTime), CAST(N'2019-10-09 22:48:42.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (4, N'2', N'Tour', 1, 0, N'0,4,', N'Viet nam tours', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'Viet nam tours', N'Viet nam tours', N'Viet-nam-tours', N'Viet nam tours', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'', N'', N'banne_637062581390143338.jpg', N'', 0, 1, CAST(N'2019-10-09 22:48:59.000' AS DateTime), CAST(N'2019-10-09 22:48:59.000' AS DateTime), CAST(N'2019-10-09 22:48:59.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (6, N'2', N'Hotel', 1, 0, N'0,6,', N'Accomodation', N'', N'', N'Accomodation', N'Accomodation', N'Accomodation', N'Accomodation', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-08 23:42:25.000' AS DateTime), CAST(N'2019-10-09 08:23:02.000' AS DateTime), CAST(N'2019-10-08 23:42:25.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (7, N'2', N'MNM', 1, 0, N'0,7,', N'Home', N'/', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 1, CAST(N'2019-10-08 23:42:54.000' AS DateTime), CAST(N'2019-10-08 23:42:54.000' AS DateTime), CAST(N'2019-10-08 23:42:54.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (8, N'2', N'MNM', 1, 0, N'0,8,', N'About us', N'?go=gioi-thieu', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 2, CAST(N'2019-10-09 08:22:10.000' AS DateTime), CAST(N'2019-10-09 08:22:10.000' AS DateTime), CAST(N'2019-10-09 08:22:10.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (9, N'2', N'MNM', 1, 0, N'0,9,', N'Cat Ba Island, Ha Long Bay Tours', N'?go=tour&page=c&igid=3', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 3, CAST(N'2019-10-08 23:43:39.000' AS DateTime), CAST(N'2019-10-08 23:43:39.000' AS DateTime), CAST(N'2019-10-08 23:43:39.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (10, N'2', N'MNM', 1, 0, N'0,10,', N'Viet nam tours', N'?go=tour&page=c&igid=4', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 4, CAST(N'2019-10-08 23:43:44.000' AS DateTime), CAST(N'2019-10-08 23:43:44.000' AS DateTime), CAST(N'2019-10-08 23:43:44.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (11, N'2', N'MNM', 1, 0, N'0,11,', N'Transport Services', N'?go=dich-vu', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 5, CAST(N'2019-10-09 08:53:55.000' AS DateTime), CAST(N'2019-10-09 08:53:55.000' AS DateTime), CAST(N'2019-10-09 08:53:55.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (12, N'2', N'MNM', 1, 0, N'0,12,', N'Accomodation', N'?go=khach-san&page=c&igid=6', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 6, CAST(N'2019-10-08 23:43:55.000' AS DateTime), CAST(N'2019-10-09 08:23:41.000' AS DateTime), CAST(N'2019-10-08 23:43:55.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (13, N'2', N'MNM', 1, 0, N'0,13,', N'Contact Us', N'?go=lien-he', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 7, CAST(N'2019-10-09 08:22:21.000' AS DateTime), CAST(N'2019-10-09 08:22:21.000' AS DateTime), CAST(N'2019-10-09 08:22:21.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (14, N'2', N'ADV', 1, 0, N'0,14,', N'Logo', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'0', 0, 1, CAST(N'2019-10-08 23:49:21.000' AS DateTime), CAST(N'2019-10-08 23:49:21.000' AS DateTime), CAST(N'2019-10-08 23:49:21.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (15, N'2', N'ADV', 1, 0, N'0,15,', N'Slide chính tại trang chủ', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'1', 0, 2, CAST(N'2019-10-08 23:49:24.000' AS DateTime), CAST(N'2019-10-08 23:49:24.000' AS DateTime), CAST(N'2019-10-08 23:49:24.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (16, N'2', N'ADV', 1, 0, N'0,16,', N'Các mạng xã hội đầu trang', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'2', 0, 3, CAST(N'2019-10-08 23:49:28.000' AS DateTime), CAST(N'2019-10-08 23:49:28.000' AS DateTime), CAST(N'2019-10-08 23:49:28.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (17, N'2', N'CustomerReviews', 1, 0, N'0,17,', N'Customer Comments', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'Customer Comments', N'Customer Comments', N'Customer-Comments', N'Customer Comments', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 08:07:51.000' AS DateTime), CAST(N'2019-10-09 08:07:51.000' AS DateTime), CAST(N'2019-10-09 08:07:51.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (18, N'2', N'Hotel', 1, 0, N'0,18,', N'Hotel Cat Ba, Ha Long', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'Hotel Cat Ba, Ha Long', N'Hotel Cat Ba, Ha Long', N'Hotel-Cat-Ba-Ha-Long', N'Hotel Cat Ba, Ha Long', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 18:06:09.000' AS DateTime), CAST(N'2019-10-09 18:06:09.000' AS DateTime), CAST(N'2019-10-09 18:06:09.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (19, N'2', N'Hotel', 1, 0, N'0,19,', N'Hotel Viet Nam', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'Hotel Viet Nam', N'Hotel Viet Nam', N'Hotel-Viet-Nam', N'Hotel Viet Nam', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 18:06:13.000' AS DateTime), CAST(N'2019-10-09 18:06:13.000' AS DateTime), CAST(N'2019-10-09 18:06:13.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (20, N'2', N'MNM', 1, 0, N'0,20,', N'Accomodation', N'?go=khach-san', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 6, CAST(N'2019-10-09 08:23:54.000' AS DateTime), CAST(N'2019-10-09 08:23:54.000' AS DateTime), CAST(N'2019-10-09 08:23:54.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (21, N'2', N'AboutUs', 1, 0, N'0,21,', N'Tầm nhìn sứ mệnh', N'', N'', N'Tầm nhìn sứ mệnh', N'Tầm nhìn sứ mệnh', N'Tam-nhin-su-menh', N'Tầm nhìn sứ mệnh', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 08:48:20.000' AS DateTime), CAST(N'2019-10-09 08:48:20.000' AS DateTime), CAST(N'2019-10-09 08:48:20.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (22, N'2', N'AboutUs', 1, 0, N'0,22,', N'Sơ đồ tổ chức', N'', N'', N'Sơ đồ tổ chức', N'Sơ đồ tổ chức', N'So-do-to-chuc', N'Sơ đồ tổ chức', N'', N'', N'', N'', N'', N'', 0, 2, CAST(N'2019-10-09 08:48:26.000' AS DateTime), CAST(N'2019-10-09 08:48:26.000' AS DateTime), CAST(N'2019-10-09 08:48:26.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (23, N'2', N'AboutUs', 1, 0, N'0,23,', N'Giá trị cốt lõi', N'', N'', N'Giá trị cốt lõi', N'Giá trị cốt lõi', N'Gia-tri-cot-loi', N'Giá trị cốt lõi', N'', N'', N'', N'', N'', N'', 0, 3, CAST(N'2019-10-09 08:48:38.000' AS DateTime), CAST(N'2019-10-09 08:48:38.000' AS DateTime), CAST(N'2019-10-09 08:48:38.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (24, N'2', N'AboutUs', 1, 0, N'0,24,', N'Đối tác - Khách hàng', N'', N'', N'Đối tác - Khách hàng', N'Đối tác - Khách hàng', N'Doi-tac-Khach-hang', N'Đối tác - Khách hàng', N'', N'', N'', N'', N'', N'', 0, 4, CAST(N'2019-10-09 08:48:49.000' AS DateTime), CAST(N'2019-10-09 08:48:49.000' AS DateTime), CAST(N'2019-10-09 08:48:49.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (25, N'2', N'AboutUs', 1, 0, N'0,25,', N'Tuyển dụng', N'', N'', N'Tuyển dụng', N'Tuyển dụng', N'Tuyen-dung', N'Tuyển dụng', N'', N'', N'', N'', N'', N'', 0, 5, CAST(N'2019-10-09 08:48:53.000' AS DateTime), CAST(N'2019-10-09 08:48:53.000' AS DateTime), CAST(N'2019-10-09 08:48:53.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (26, N'2', N'Tour', 2, 3, N'0,3,26,', N'Viet - Muong Ethnic Group', N'', N'', N'Viet - Muong Ethnic Group', N'Viet - Muong Ethnic Group', N'Viet-Muong-Ethnic-Group', N'Viet - Muong Ethnic Group', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 08:49:46.000' AS DateTime), CAST(N'2019-10-09 08:49:46.000' AS DateTime), CAST(N'2019-10-09 08:49:46.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (27, N'2', N'Tour', 2, 3, N'0,3,27,', N'Tay - Thai Ethnic Group', N'', N'', N'Tay - Thai Ethnic Group', N'Tay - Thai Ethnic Group', N'Tay-Thai-Ethnic-Group', N'Tay - Thai Ethnic Group', N'', N'', N'', N'', N'', N'', 0, 2, CAST(N'2019-10-09 08:49:59.000' AS DateTime), CAST(N'2019-10-09 08:49:59.000' AS DateTime), CAST(N'2019-10-09 08:49:59.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (28, N'2', N'Tour', 2, 3, N'0,3,28,', N'Mon - Khmer Ethnic Group', N'', N'', N'Mon - Khmer Ethnic Group', N'Mon - Khmer Ethnic Group', N'Mon-Khmer-Ethnic-Group', N'Mon - Khmer Ethnic Group', N'', N'', N'', N'', N'', N'', 0, 3, CAST(N'2019-10-09 08:50:10.000' AS DateTime), CAST(N'2019-10-09 08:50:10.000' AS DateTime), CAST(N'2019-10-09 08:50:10.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (29, N'2', N'Tour', 2, 3, N'0,3,29,', N'Mong - Dao Ethnic Group', N'', N'', N'Mong - Dao Ethnic Group', N'Mong - Dao Ethnic Group', N'Mong-Dao-Ethnic-Group', N'Mong - Dao Ethnic Group', N'', N'', N'', N'', N'', N'', 0, 4, CAST(N'2019-10-09 08:50:21.000' AS DateTime), CAST(N'2019-10-09 08:50:21.000' AS DateTime), CAST(N'2019-10-09 08:50:21.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (30, N'2', N'Tour', 2, 3, N'0,3,30,', N'Tibeto - Burman Ethnic Group', N'', N'', N'Tibeto - Burman Ethnic Group', N'Tibeto - Burman Ethnic Group', N'Tibeto-Burman-Ethnic-Group', N'Tibeto - Burman Ethnic Group', N'', N'', N'', N'', N'', N'', 0, 5, CAST(N'2019-10-09 08:50:35.000' AS DateTime), CAST(N'2019-10-09 08:50:35.000' AS DateTime), CAST(N'2019-10-09 08:50:35.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (31, N'2', N'Tour', 2, 3, N'0,3,31,', N'Kadai - Co Lao Ethnic Group', N'', N'', N'Kadai - Co Lao Ethnic Group', N'Kadai - Co Lao Ethnic Group', N'Kadai-Co-Lao-Ethnic-Group', N'Kadai - Co Lao Ethnic Group', N'', N'', N'', N'', N'', N'', 0, 6, CAST(N'2019-10-09 08:50:47.000' AS DateTime), CAST(N'2019-10-09 08:50:47.000' AS DateTime), CAST(N'2019-10-09 08:50:47.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (32, N'2', N'Tour', 2, 3, N'0,3,32,', N'Han - Hoa Ethnic Group', N'', N'', N'Han - Hoa Ethnic Group', N'Han - Hoa Ethnic Group', N'Han-Hoa-Ethnic-Group', N'Han - Hoa Ethnic Group', N'', N'', N'', N'', N'', N'', 0, 7, CAST(N'2019-10-09 08:50:57.000' AS DateTime), CAST(N'2019-10-09 08:50:57.000' AS DateTime), CAST(N'2019-10-09 08:50:57.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (33, N'2', N'Tour', 2, 3, N'0,3,33,', N'Malayo - Polynesian Ethnic', N'', N'', N'Malayo - Polynesian Ethnic', N'Malayo - Polynesian Ethnic', N'Malayo-Polynesian-Ethnic', N'Malayo - Polynesian Ethnic', N'', N'', N'', N'', N'', N'', 0, 8, CAST(N'2019-10-09 08:51:12.000' AS DateTime), CAST(N'2019-10-09 08:51:12.000' AS DateTime), CAST(N'2019-10-09 08:51:12.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (34, N'2', N'Tour', 2, 4, N'0,4,34,', N'Travel Blog', N'', N'', N'Travel Blog', N'Travel Blog', N'Travel-Blog', N'Travel Blog', N'', N'', N'', N'', N'', N'', 0, 9, CAST(N'2019-10-09 08:51:22.000' AS DateTime), CAST(N'2019-10-09 08:51:22.000' AS DateTime), CAST(N'2019-10-09 08:51:22.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (35, N'2', N'Tour', 2, 4, N'0,4,35,', N'Vietnam Travel Guides', N'', N'', N'Vietnam Travel Guides', N'Vietnam Travel Guides', N'Vietnam-Travel-Guides', N'Vietnam Travel Guides', N'', N'', N'', N'', N'', N'', 0, 10, CAST(N'2019-10-09 08:51:35.000' AS DateTime), CAST(N'2019-10-09 08:51:35.000' AS DateTime), CAST(N'2019-10-09 08:51:35.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (36, N'2', N'Tour', 2, 4, N'0,4,36,', N'Vietnam Itinerary Ideas', N'', N'', N'Vietnam Itinerary Ideas', N'Vietnam Itinerary Ideas', N'Vietnam-Itinerary-Ideas', N'Vietnam Itinerary Ideas', N'', N'', N'', N'', N'', N'', 0, 11, CAST(N'2019-10-09 08:51:59.000' AS DateTime), CAST(N'2019-10-09 08:51:59.000' AS DateTime), CAST(N'2019-10-09 08:51:59.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (37, N'2', N'Tour', 2, 4, N'0,4,37,', N'Weather and Season in Vietnam', N'', N'', N'Weather and Season in Vietnam', N'Weather and Season in Vietnam', N'Weather-and-Season-in-Vietnam', N'Weather and Season in Vietnam', N'', N'', N'', N'', N'', N'', 0, 12, CAST(N'2019-10-09 08:52:10.000' AS DateTime), CAST(N'2019-10-09 08:52:10.000' AS DateTime), CAST(N'2019-10-09 08:52:10.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (38, N'2', N'Tour', 2, 4, N'0,4,38,', N'Mai Chau Tours', N'', N'', N'Mai Chau Tours', N'Mai Chau Tours', N'Mai-Chau-Tours', N'Mai Chau Tours', N'', N'', N'', N'', N'', N'', 0, 13, CAST(N'2019-10-09 08:52:19.000' AS DateTime), CAST(N'2019-10-09 08:52:19.000' AS DateTime), CAST(N'2019-10-09 08:52:19.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (39, N'2', N'Tour', 2, 4, N'0,4,39,', N'Chau Doc Tours', N'', N'', N'Chau Doc Tours', N'Chau Doc Tours', N'Chau-Doc-Tours', N'Chau Doc Tours', N'', N'', N'', N'', N'', N'', 0, 14, CAST(N'2019-10-09 08:52:26.000' AS DateTime), CAST(N'2019-10-09 08:52:26.000' AS DateTime), CAST(N'2019-10-09 08:52:26.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (44, N'2', N'MNB', 1, 0, N'0,44,', N'About us', N'?go=gioi-thieu', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 1, CAST(N'2019-10-09 08:54:30.000' AS DateTime), CAST(N'2019-10-09 08:54:30.000' AS DateTime), CAST(N'2019-10-09 08:54:30.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (45, N'2', N'MNB', 2, 44, N'0,44,45,', N'Tầm nhìn sứ mệnh', N'?go=gioi-thieu&page=c&igid=21', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 1, CAST(N'2019-10-09 08:55:53.000' AS DateTime), CAST(N'2019-10-09 08:55:53.000' AS DateTime), CAST(N'2019-10-09 08:55:53.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (46, N'2', N'MNB', 2, 44, N'0,44,46,', N'Sơ đồ tổ chức', N'?go=gioi-thieu&page=c&igid=22', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 2, CAST(N'2019-10-09 08:56:00.000' AS DateTime), CAST(N'2019-10-09 08:56:00.000' AS DateTime), CAST(N'2019-10-09 08:56:00.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (47, N'2', N'MNB', 2, 44, N'0,44,47,', N'Giá trị cốt lõi', N'?go=gioi-thieu&page=c&igid=23', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 3, CAST(N'2019-10-09 08:56:02.000' AS DateTime), CAST(N'2019-10-09 08:56:02.000' AS DateTime), CAST(N'2019-10-09 08:56:02.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (48, N'2', N'MNB', 2, 44, N'0,44,48,', N'Đối tác - Khách hàng', N'?go=gioi-thieu&page=c&igid=24', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 4, CAST(N'2019-10-09 08:56:05.000' AS DateTime), CAST(N'2019-10-09 08:56:05.000' AS DateTime), CAST(N'2019-10-09 08:56:05.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (49, N'2', N'MNB', 2, 44, N'0,44,49,', N'Tuyển dụng', N'?go=gioi-thieu&page=c&igid=25', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 5, CAST(N'2019-10-09 08:56:07.000' AS DateTime), CAST(N'2019-10-09 08:56:07.000' AS DateTime), CAST(N'2019-10-09 08:56:07.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (50, N'2', N'MNB', 1, 0, N'0,50,', N'Cat Ba Island, Ha Long Bay Tours', N'?go=tour&page=c&igid=3', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 2, CAST(N'2019-10-09 08:57:06.000' AS DateTime), CAST(N'2019-10-09 08:57:06.000' AS DateTime), CAST(N'2019-10-09 08:57:06.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (51, N'2', N'MNB', 2, 50, N'0,50,51,', N'Viet - Muong Ethnic Group', N'?go=tour&page=c&igid=26', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 1, CAST(N'2019-10-09 08:57:18.000' AS DateTime), CAST(N'2019-10-09 08:57:18.000' AS DateTime), CAST(N'2019-10-09 08:57:18.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (52, N'2', N'MNB', 2, 50, N'0,50,52,', N'Tay - Thai Ethnic Group', N'?go=tour&page=c&igid=27', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 2, CAST(N'2019-10-09 08:57:20.000' AS DateTime), CAST(N'2019-10-09 08:57:20.000' AS DateTime), CAST(N'2019-10-09 08:57:20.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (53, N'2', N'MNB', 2, 50, N'0,50,53,', N'Mon - Khmer Ethnic Group', N'?go=tour&page=c&igid=28', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 3, CAST(N'2019-10-09 08:57:23.000' AS DateTime), CAST(N'2019-10-09 08:57:23.000' AS DateTime), CAST(N'2019-10-09 08:57:23.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (54, N'2', N'MNB', 2, 50, N'0,50,54,', N'Mong - Dao Ethnic Group', N'?go=tour&page=c&igid=29', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 4, CAST(N'2019-10-09 08:57:26.000' AS DateTime), CAST(N'2019-10-09 08:57:26.000' AS DateTime), CAST(N'2019-10-09 08:57:26.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (55, N'2', N'MNB', 2, 50, N'0,50,55,', N'Tibeto - Burman Ethnic Group', N'?go=tour&page=c&igid=30', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 5, CAST(N'2019-10-09 08:57:29.000' AS DateTime), CAST(N'2019-10-09 08:57:29.000' AS DateTime), CAST(N'2019-10-09 08:57:29.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (56, N'2', N'MNB', 2, 50, N'0,50,56,', N'Kadai - Co Lao Ethnic Group', N'?go=tour&page=c&igid=31', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 6, CAST(N'2019-10-09 08:57:31.000' AS DateTime), CAST(N'2019-10-09 08:57:31.000' AS DateTime), CAST(N'2019-10-09 08:57:31.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (57, N'2', N'MNB', 2, 50, N'0,50,57,', N'Han - Hoa Ethnic Group', N'?go=tour&page=c&igid=32', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 7, CAST(N'2019-10-09 08:57:34.000' AS DateTime), CAST(N'2019-10-09 08:57:34.000' AS DateTime), CAST(N'2019-10-09 08:57:34.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (58, N'2', N'MNB', 2, 50, N'0,50,58,', N'Malayo - Polynesian Ethnic', N'?go=tour&page=c&igid=33', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 8, CAST(N'2019-10-09 08:57:37.000' AS DateTime), CAST(N'2019-10-09 08:57:37.000' AS DateTime), CAST(N'2019-10-09 08:57:37.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (59, N'2', N'MNB', 1, 0, N'0,59,', N'Viet nam tours', N'?go=tour&page=c&igid=4', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 3, CAST(N'2019-10-09 08:57:47.000' AS DateTime), CAST(N'2019-10-09 08:57:47.000' AS DateTime), CAST(N'2019-10-09 08:57:47.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (60, N'2', N'MNB', 2, 59, N'0,59,60,', N'Travel Blog', N'?go=tour&page=c&igid=34', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 1, CAST(N'2019-10-09 08:57:55.000' AS DateTime), CAST(N'2019-10-09 08:57:55.000' AS DateTime), CAST(N'2019-10-09 08:57:55.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (61, N'2', N'MNB', 2, 59, N'0,59,61,', N'Vietnam Travel Guides', N'?go=tour&page=c&igid=35', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 2, CAST(N'2019-10-09 08:57:58.000' AS DateTime), CAST(N'2019-10-09 08:57:58.000' AS DateTime), CAST(N'2019-10-09 08:57:58.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (62, N'2', N'MNB', 2, 59, N'0,59,62,', N'Vietnam Itinerary Ideas', N'?go=tour&page=c&igid=36', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 3, CAST(N'2019-10-09 08:58:00.000' AS DateTime), CAST(N'2019-10-09 08:58:00.000' AS DateTime), CAST(N'2019-10-09 08:58:00.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (63, N'2', N'MNB', 2, 59, N'0,59,63,', N'Weather and Season in Vietnam', N'?go=tour&page=c&igid=37', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 4, CAST(N'2019-10-09 08:58:02.000' AS DateTime), CAST(N'2019-10-09 08:58:02.000' AS DateTime), CAST(N'2019-10-09 08:58:02.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (64, N'2', N'MNB', 2, 59, N'0,59,64,', N'Mai Chau Tours', N'?go=tour&page=c&igid=38', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 5, CAST(N'2019-10-09 08:58:04.000' AS DateTime), CAST(N'2019-10-09 08:58:04.000' AS DateTime), CAST(N'2019-10-09 08:58:04.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (65, N'2', N'MNB', 2, 59, N'0,59,65,', N'Chau Doc Tours', N'?go=tour&page=c&igid=39', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 6, CAST(N'2019-10-09 08:58:07.000' AS DateTime), CAST(N'2019-10-09 08:58:07.000' AS DateTime), CAST(N'2019-10-09 08:58:07.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (66, N'2', N'MNB', 1, 0, N'0,66,', N'Service', N'?go=dich-vu', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 4, CAST(N'2019-10-09 08:58:22.000' AS DateTime), CAST(N'2019-10-09 08:58:22.000' AS DateTime), CAST(N'2019-10-09 08:58:22.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (67, N'2', N'MNB', 2, 66, N'0,66,67,', N'Car Rental', N'/car-rental.html', N'', N'Car Rental', N'Car Rental', N'Car-Rental', N'Car Rental', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 1, CAST(N'2019-10-09 11:40:14.000' AS DateTime), CAST(N'2019-10-09 11:40:14.000' AS DateTime), CAST(N'2019-10-09 11:40:14.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (68, N'2', N'MNB', 2, 66, N'0,66,68,', N'Air ticket', N'/air-ticket.html', N'', N'Air ticket', N'Air ticket', N'Air-ticket', N'Air ticket', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 2, CAST(N'2019-10-09 11:40:00.000' AS DateTime), CAST(N'2019-10-09 11:40:00.000' AS DateTime), CAST(N'2019-10-09 11:40:00.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (69, N'2', N'MNB', 2, 66, N'0,66,69,', N'Book Hotel', N'/book-hotel.html', N'', N'Book Hotel', N'Book Hotel', N'Book-Hotel', N'Book Hotel', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 3, CAST(N'2019-10-09 11:40:38.000' AS DateTime), CAST(N'2019-10-09 11:40:38.000' AS DateTime), CAST(N'2019-10-09 11:40:38.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (70, N'2', N'MNB', 2, 66, N'0,66,70,', N'Da Nang Airport to Hoi An - Hue', N'/da-nang-airport-to-hoi-an-hue.html', N'', N'Da Nang Airport to Hoi An - Hue', N'Da Nang Airport to Hoi An - Hue', N'Da-Nang-Airport-to-Hoi-An-Hue', N'Da Nang Airport to Hoi An - Hue', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!0*!<=*ParamsSpilitItems*=>*!', 0, 4, CAST(N'2019-10-09 11:41:08.000' AS DateTime), CAST(N'2019-10-09 11:41:08.000' AS DateTime), CAST(N'2019-10-09 11:41:08.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (71, N'2', N'S', 1, 0, N'0,71,', N'Transport Services', N'', N'', N'Transport Services', N'Transport Services', N'Transport-Services', N'Transport Services', N'', N'', N'', N'', N'', N'', 1, 1, CAST(N'2019-10-09 09:59:33.000' AS DateTime), CAST(N'2019-10-09 09:59:33.000' AS DateTime), CAST(N'2019-10-09 09:59:33.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1042, N'2', N'ADV', 1, 0, N'0,1042,', N'About us', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'3', 0, 1, CAST(N'2019-10-09 11:55:14.000' AS DateTime), CAST(N'2019-10-09 11:55:14.000' AS DateTime), CAST(N'2019-10-09 11:55:14.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1043, N'2', N'CustomerReviewsGroupItem', 1, 0, N'0,1043,', N'CUSTOMER COMMENTS', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'CUSTOMER COMMENTS', N'GROUP CUSTOMER COMMENTS', N'GROUP-CUSTOMER-COMMENTS', N'CUSTOMER COMMENTS', N'If you want to travel to Quang Ninh and especially want to go to Ha Long, here are the most useful Ha Long travel experiences: How to travel to Ha Long? Where to Ha Long to go, eat, play what? Hotels in Ha Long', N'', N'', N'', N'', N'0', 10, 1, CAST(N'2019-10-09 12:10:20.000' AS DateTime), CAST(N'2019-10-09 12:10:20.000' AS DateTime), CAST(N'2019-10-09 12:10:20.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1044, N'2', N'Hotel', 1, 0, N'0,1044,', N'Villa', N'', N'', N'Villa', N'Villa', N'Villa', N'Villa', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 18:06:17.000' AS DateTime), CAST(N'2019-10-09 18:06:17.000' AS DateTime), CAST(N'2019-10-09 18:06:17.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1045, N'2', N'Hotel', 1, 0, N'0,1045,', N'Homestay', N'', N'', N'Homestay', N'Homestay', N'Homestay', N'Homestay', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 18:06:05.000' AS DateTime), CAST(N'2019-10-09 18:06:05.000' AS DateTime), CAST(N'2019-10-09 18:06:05.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1046, N'2', N'Hotel', 1, 0, N'0,1046,', N'Campground', N'', N'', N'Campground', N'Campground', N'Campground', N'Campground', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 18:06:00.000' AS DateTime), CAST(N'2019-10-09 18:06:00.000' AS DateTime), CAST(N'2019-10-09 18:06:00.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1047, N'2', N'HotelGI', 1, 0, N'0,1047,', N'Hotel', N'', N'', N'', N'', N'', N'', N'', N'19', N'', N'', N'news_0_637062413451139929.jpg', N'0', 10, 1, CAST(N'2019-10-10 11:45:19.000' AS DateTime), CAST(N'2019-10-10 11:45:19.000' AS DateTime), CAST(N'2019-10-10 11:45:19.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1048, N'2', N'HotelGI', 1, 0, N'0,1048,', N'Villa', N'', N'', N'', N'', N'', N'', N'', N'1044', N'', N'', N'news_0_637062413562192713.jpg', N'0', 10, 2, CAST(N'2019-10-10 11:45:36.000' AS DateTime), CAST(N'2019-10-10 11:45:36.000' AS DateTime), CAST(N'2019-10-10 11:45:36.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1049, N'2', N'HotelGI', 1, 0, N'0,1049,', N'Homestay', N'', N'', N'', N'', N'', N'', N'', N'1045', N'', N'', N'news_0_637062413652362297.jpg', N'0', 10, 3, CAST(N'2019-10-10 11:45:38.000' AS DateTime), CAST(N'2019-10-10 11:45:38.000' AS DateTime), CAST(N'2019-10-10 11:45:38.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1050, N'2', N'HotelGI', 1, 0, N'0,1050,', N'Campgrounds', N'', N'', N'', N'', N'', N'', N'', N'1046', N'', N'', N'news_1_637062413848914910.jpg', N'0', 10, 4, CAST(N'2019-10-10 11:45:40.000' AS DateTime), CAST(N'2019-10-10 11:45:40.000' AS DateTime), CAST(N'2019-10-10 11:45:40.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1052, N'2', N'TourService', 1, 0, N'0,1052,', N'TEST DICH VU', N'', N'', N'TEST DICH VU', N'TEST DICH VU', N'TEST-DICH-VU', N'TEST DICH VU', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 18:35:16.000' AS DateTime), CAST(N'2019-10-09 18:35:16.000' AS DateTime), CAST(N'2019-10-09 18:35:16.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1053, N'2', N'TourService', 2, 1052, N'0,1052,1053,', N'TEST DICH VU CON', N'', N'', N'TEST DICH VU CON', N'TEST DICH VU CON', N'TEST-DICH-VU-CON', N'TEST DICH VU CON', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 18:36:38.000' AS DateTime), CAST(N'2019-10-09 18:36:38.000' AS DateTime), CAST(N'2019-10-09 18:36:38.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1060, N'2', N'TourVehicle', 1, 0, N'0,1060,', N'3 ngày 2 đêm', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 20:15:08.000' AS DateTime), CAST(N'2019-10-09 20:15:08.000' AS DateTime), CAST(N'2019-10-09 20:15:08.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1061, N'2', N'TourVehicle', 1, 0, N'0,1061,', N'1 ngày', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 20:17:48.000' AS DateTime), CAST(N'2019-10-09 20:17:48.000' AS DateTime), CAST(N'2019-10-09 20:17:48.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1062, N'2', N'TourVehicle', 1, 0, N'0,1062,', N'7 ngày', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 20:17:56.000' AS DateTime), CAST(N'2019-10-09 20:17:56.000' AS DateTime), CAST(N'2019-10-09 20:17:56.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1063, N'2', N'TourProperty', 1, 0, N'0,1063,', N'Hà Nội', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 0, 1, CAST(N'2019-10-09 20:21:55.000' AS DateTime), CAST(N'2019-10-09 20:21:55.000' AS DateTime), CAST(N'2019-10-09 20:21:55.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1065, N'2', N'TourProperty', 1, 0, N'0,1065,', N'Đà Nẵng', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 0, 2, CAST(N'2019-10-09 20:23:17.000' AS DateTime), CAST(N'2019-10-09 20:23:17.000' AS DateTime), CAST(N'2019-10-09 20:23:17.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1067, N'2', N'TourGI', 1, 0, N'0,1067,', N'Cat Ba Island, Ha Long Bay Tours', N'', N'', N'', N'', N'', N'', N'', N'3', N'', N'', N'', N'0', 5, 1, CAST(N'2019-10-10 12:50:29.000' AS DateTime), CAST(N'2019-10-10 12:50:29.000' AS DateTime), CAST(N'2019-10-10 12:50:29.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS] ([IGID], [VGLANG], [VGAPP], [IGLEVEL], [IGPARENTID], [IGPARENTSID], [VGNAME], [VGDESC], [VGCONTENT], [VGSEOTITLE], [VGSEOLINK], [VGSEOLINKSEARCH], [VGSEOMETAKEY], [VGSEOMETADESC], [VGSEOMETACANONICAL], [VGSEOMETALANG], [VGSEOMETAPARAMS], [VGIMAGE], [VGPARAMS], [IGTOTALITEMS], [IGORDER], [DGCREATEDATE], [DGUPDATE], [DGENDDATE], [IGENABLE], [web]) VALUES (1068, N'2', N'TourGI', 1, 0, N'0,1068,', N'Viet nam tours', N'', N'', N'', N'', N'', N'', N'', N'4', N'', N'', N'', N'0', 5, 2, CAST(N'2019-10-10 12:50:34.000' AS DateTime), CAST(N'2019-10-10 12:50:34.000' AS DateTime), CAST(N'2019-10-10 12:50:34.000' AS DateTime), 1, N'')
SET IDENTITY_INSERT [dbo].[GROUPS] OFF
SET IDENTITY_INSERT [dbo].[GROUPS_ITEMS] ON 

INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1, 2, 1, N'0,2,', CAST(N'2019-10-08 23:20:08.000' AS DateTime), CAST(N'2019-10-08 23:21:35.000' AS DateTime), CAST(N'2019-10-08 23:21:35.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (2, 2, 2, N'0,2,', CAST(N'2019-10-08 23:21:35.000' AS DateTime), CAST(N'2019-10-08 23:22:09.000' AS DateTime), CAST(N'2019-10-08 23:22:09.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (3, 2, 3, N'0,2,', CAST(N'2019-10-08 23:22:09.000' AS DateTime), CAST(N'2019-10-08 23:22:20.000' AS DateTime), CAST(N'2019-10-08 23:22:20.000' AS DateTime), 3, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (4, 2, 4, N'0,2,', CAST(N'2019-10-08 23:22:20.000' AS DateTime), CAST(N'2019-10-08 23:22:46.000' AS DateTime), CAST(N'2019-10-08 23:22:46.000' AS DateTime), 4, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (5, 2, 5, N'0,2,', CAST(N'2019-10-08 23:24:04.000' AS DateTime), CAST(N'2019-10-08 23:24:12.000' AS DateTime), CAST(N'2019-10-08 23:24:12.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (6, 2, 6, N'0,2,', CAST(N'2019-10-08 23:24:12.000' AS DateTime), CAST(N'2019-10-08 23:24:20.000' AS DateTime), CAST(N'2019-10-08 23:24:20.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (7, 14, 7, N'0,14,', CAST(N'2019-10-08 23:49:59.000' AS DateTime), CAST(N'2019-10-08 23:49:59.000' AS DateTime), CAST(N'2019-10-08 23:49:59.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (8, 15, 8, N'0,15,', CAST(N'2019-10-08 23:51:04.000' AS DateTime), CAST(N'2019-10-08 23:51:04.000' AS DateTime), CAST(N'2019-10-08 23:51:04.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (9, 15, 9, N'0,15,', CAST(N'2019-10-08 23:51:13.000' AS DateTime), CAST(N'2019-10-08 23:51:13.000' AS DateTime), CAST(N'2019-10-08 23:51:13.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (10, 16, 10, N'0,16,', CAST(N'2019-10-08 23:51:31.000' AS DateTime), CAST(N'2019-10-08 23:51:31.000' AS DateTime), CAST(N'2019-10-08 23:51:31.000' AS DateTime), 3, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (11, 16, 11, N'0,16,', CAST(N'2019-10-08 23:51:46.000' AS DateTime), CAST(N'2019-10-08 23:51:46.000' AS DateTime), CAST(N'2019-10-08 23:51:46.000' AS DateTime), 4, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (12, 16, 12, N'0,16,', CAST(N'2019-10-08 23:51:55.000' AS DateTime), CAST(N'2019-10-08 23:51:55.000' AS DateTime), CAST(N'2019-10-08 23:51:55.000' AS DateTime), 5, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (13, 16, 13, N'0,16,', CAST(N'2019-10-09 00:29:14.000' AS DateTime), CAST(N'2019-10-09 00:29:14.000' AS DateTime), CAST(N'2019-10-09 00:29:14.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (14, 1, 14, N'0,1,', CAST(N'2019-10-09 01:40:25.000' AS DateTime), CAST(N'2019-10-09 01:40:25.000' AS DateTime), CAST(N'2019-10-09 01:40:25.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (15, 1, 15, N'0,1,', CAST(N'2019-10-09 01:40:34.000' AS DateTime), CAST(N'2019-10-09 01:40:34.000' AS DateTime), CAST(N'2019-10-09 01:40:34.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (16, 1, 16, N'0,1,', CAST(N'2019-10-09 01:42:04.000' AS DateTime), CAST(N'2019-10-09 01:42:04.000' AS DateTime), CAST(N'2019-10-09 01:42:04.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (24, 17, 18, N'0,17,', CAST(N'2019-10-09 08:09:10.000' AS DateTime), CAST(N'2019-10-09 08:30:42.000' AS DateTime), CAST(N'2019-10-09 08:30:42.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (25, 17, 17, N'0,17,', CAST(N'2019-10-09 08:08:16.000' AS DateTime), CAST(N'2019-10-09 08:30:51.000' AS DateTime), CAST(N'2019-10-09 08:30:51.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (26, 17, 19, N'0,17,', CAST(N'2019-10-09 08:09:51.000' AS DateTime), CAST(N'2019-10-09 08:30:55.000' AS DateTime), CAST(N'2019-10-09 08:30:55.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (28, 17, 20, N'0,17,', CAST(N'2019-10-09 08:10:05.000' AS DateTime), CAST(N'2019-10-09 08:31:04.000' AS DateTime), CAST(N'2019-10-09 08:31:04.000' AS DateTime), 3, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (29, 17, 21, N'0,17,', CAST(N'2019-10-09 08:10:18.000' AS DateTime), CAST(N'2019-10-09 08:31:07.000' AS DateTime), CAST(N'2019-10-09 08:31:07.000' AS DateTime), 4, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (30, 17, 22, N'0,17,', CAST(N'2019-10-09 08:10:26.000' AS DateTime), CAST(N'2019-10-09 08:31:11.000' AS DateTime), CAST(N'2019-10-09 08:31:11.000' AS DateTime), 5, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (32, 71, 24, N'0,71,', CAST(N'2019-10-09 10:00:54.000' AS DateTime), CAST(N'2019-10-09 10:01:25.000' AS DateTime), CAST(N'2019-10-09 10:01:25.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (33, 71, 25, N'0,71,', CAST(N'2019-10-09 10:01:26.000' AS DateTime), CAST(N'2019-10-09 10:01:40.000' AS DateTime), CAST(N'2019-10-09 10:01:40.000' AS DateTime), 3, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (34, 71, 26, N'0,71,', CAST(N'2019-10-09 10:01:40.000' AS DateTime), CAST(N'2019-10-09 10:02:06.000' AS DateTime), CAST(N'2019-10-09 10:02:06.000' AS DateTime), 4, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (35, 71, 23, N'0,71,', CAST(N'2019-10-09 09:59:57.000' AS DateTime), CAST(N'2019-10-09 10:02:12.000' AS DateTime), CAST(N'2019-10-09 10:02:12.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1031, 71, 1023, N'0,71,', CAST(N'2019-10-09 11:05:08.000' AS DateTime), CAST(N'2019-10-09 11:05:08.000' AS DateTime), CAST(N'2019-10-09 11:05:08.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1033, 71, 1025, N'0,71,', CAST(N'2019-10-09 11:20:14.000' AS DateTime), CAST(N'2019-10-09 11:20:14.000' AS DateTime), CAST(N'2019-10-09 11:20:14.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1034, 71, 1026, N'0,71,', CAST(N'2019-10-09 11:21:26.000' AS DateTime), CAST(N'2019-10-09 11:21:26.000' AS DateTime), CAST(N'2019-10-09 11:21:26.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1035, 71, 1027, N'0,71,', CAST(N'2019-10-09 11:38:17.000' AS DateTime), CAST(N'2019-10-09 11:38:17.000' AS DateTime), CAST(N'2019-10-09 11:38:17.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1036, 71, 1028, N'0,71,', CAST(N'2019-10-09 11:48:16.000' AS DateTime), CAST(N'2019-10-09 11:48:16.000' AS DateTime), CAST(N'2019-10-09 11:48:16.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1037, 1042, 1029, N'0,1042,', CAST(N'2019-10-09 11:55:53.000' AS DateTime), CAST(N'2019-10-09 11:55:53.000' AS DateTime), CAST(N'2019-10-09 11:55:53.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1038, 1042, 1030, N'0,1042,', CAST(N'2019-10-09 11:55:55.000' AS DateTime), CAST(N'2019-10-09 11:55:55.000' AS DateTime), CAST(N'2019-10-09 11:55:55.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1039, 1042, 1031, N'0,1042,', CAST(N'2019-10-09 11:56:13.000' AS DateTime), CAST(N'2019-10-09 11:56:13.000' AS DateTime), CAST(N'2019-10-09 11:56:13.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1040, 1042, 1032, N'0,1042,', CAST(N'2019-10-09 11:56:24.000' AS DateTime), CAST(N'2019-10-09 11:56:24.000' AS DateTime), CAST(N'2019-10-09 11:56:24.000' AS DateTime), 3, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1041, 1042, 1033, N'0,1042,', CAST(N'2019-10-09 11:56:36.000' AS DateTime), CAST(N'2019-10-09 11:56:36.000' AS DateTime), CAST(N'2019-10-09 11:56:36.000' AS DateTime), 4, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1042, 1042, 1034, N'0,1042,', CAST(N'2019-10-09 11:56:50.000' AS DateTime), CAST(N'2019-10-09 11:56:50.000' AS DateTime), CAST(N'2019-10-09 11:56:50.000' AS DateTime), 5, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1043, 1042, 1035, N'0,1042,', CAST(N'2019-10-09 11:57:04.000' AS DateTime), CAST(N'2019-10-09 11:57:04.000' AS DateTime), CAST(N'2019-10-09 11:57:04.000' AS DateTime), 6, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1044, 1042, 1036, N'0,1042,', CAST(N'2019-10-09 11:57:05.000' AS DateTime), CAST(N'2019-10-09 11:57:05.000' AS DateTime), CAST(N'2019-10-09 11:57:05.000' AS DateTime), 6, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1045, 18, 1037, N'0,18,', CAST(N'2019-10-09 13:59:34.000' AS DateTime), CAST(N'2019-10-09 14:02:43.000' AS DateTime), CAST(N'2019-10-09 14:02:43.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1046, 18, 1038, N'0,18,', CAST(N'2019-10-09 14:18:55.000' AS DateTime), CAST(N'2019-10-09 14:19:32.000' AS DateTime), CAST(N'2019-10-09 14:19:32.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1047, 18, 1039, N'0,18,', CAST(N'2019-10-09 14:19:32.000' AS DateTime), CAST(N'2019-10-09 14:19:59.000' AS DateTime), CAST(N'2019-10-09 14:19:59.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1048, 18, 1040, N'0,18,', CAST(N'2019-10-09 14:19:59.000' AS DateTime), CAST(N'2019-10-09 14:20:18.000' AS DateTime), CAST(N'2019-10-09 14:20:18.000' AS DateTime), 3, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1049, 18, 1041, N'0,18,', CAST(N'2019-10-09 14:20:18.000' AS DateTime), CAST(N'2019-10-09 14:20:33.000' AS DateTime), CAST(N'2019-10-09 14:20:33.000' AS DateTime), 4, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1050, 18, 1042, N'0,18,', CAST(N'2019-10-09 14:20:33.000' AS DateTime), CAST(N'2019-10-09 14:20:50.000' AS DateTime), CAST(N'2019-10-09 14:20:50.000' AS DateTime), 5, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1051, 18, 1043, N'0,18,', CAST(N'2019-10-09 14:21:13.000' AS DateTime), CAST(N'2019-10-09 14:21:35.000' AS DateTime), CAST(N'2019-10-09 14:21:35.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1052, 19, 1044, N'0,19,', CAST(N'2019-10-09 14:21:35.000' AS DateTime), CAST(N'2019-10-09 14:22:12.000' AS DateTime), CAST(N'2019-10-09 14:22:12.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1053, 19, 1045, N'0,19,', CAST(N'2019-10-09 14:22:12.000' AS DateTime), CAST(N'2019-10-09 14:22:22.000' AS DateTime), CAST(N'2019-10-09 14:22:22.000' AS DateTime), 3, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1054, 19, 1046, N'0,19,', CAST(N'2019-10-09 14:22:22.000' AS DateTime), CAST(N'2019-10-09 14:22:34.000' AS DateTime), CAST(N'2019-10-09 14:22:34.000' AS DateTime), 4, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1055, 19, 1047, N'0,19,', CAST(N'2019-10-09 14:22:35.000' AS DateTime), CAST(N'2019-10-09 14:22:45.000' AS DateTime), CAST(N'2019-10-09 14:22:45.000' AS DateTime), 5, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1056, 19, 1048, N'0,19,', CAST(N'2019-10-09 14:22:45.000' AS DateTime), CAST(N'2019-10-09 14:22:56.000' AS DateTime), CAST(N'2019-10-09 14:22:56.000' AS DateTime), 6, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1057, 19, 1049, N'0,19,', CAST(N'2019-10-09 14:22:56.000' AS DateTime), CAST(N'2019-10-09 14:23:05.000' AS DateTime), CAST(N'2019-10-09 14:23:05.000' AS DateTime), 7, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1058, 19, 1050, N'0,19,', CAST(N'2019-10-09 14:23:05.000' AS DateTime), CAST(N'2019-10-09 14:23:15.000' AS DateTime), CAST(N'2019-10-09 14:23:15.000' AS DateTime), 8, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1062, 3, 1056, N'0,3,', CAST(N'2019-10-09 22:41:58.000' AS DateTime), CAST(N'2019-10-09 22:42:14.000' AS DateTime), CAST(N'2019-10-09 22:42:14.000' AS DateTime), 2, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1063, 3, 1057, N'0,3,', CAST(N'2019-10-09 22:42:14.000' AS DateTime), CAST(N'2019-10-09 22:42:22.000' AS DateTime), CAST(N'2019-10-09 22:42:22.000' AS DateTime), 3, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1064, 3, 1058, N'0,3,', CAST(N'2019-10-09 22:42:22.000' AS DateTime), CAST(N'2019-10-09 22:42:30.000' AS DateTime), CAST(N'2019-10-09 22:42:30.000' AS DateTime), 4, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1065, 3, 1059, N'0,3,', CAST(N'2019-10-09 22:42:30.000' AS DateTime), CAST(N'2019-10-09 22:42:40.000' AS DateTime), CAST(N'2019-10-09 22:42:40.000' AS DateTime), 5, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1066, 4, 1060, N'0,4,', CAST(N'2019-10-09 22:42:40.000' AS DateTime), CAST(N'2019-10-09 22:42:59.000' AS DateTime), CAST(N'2019-10-09 22:42:59.000' AS DateTime), 6, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1067, 4, 1061, N'0,4,', CAST(N'2019-10-09 22:42:59.000' AS DateTime), CAST(N'2019-10-09 22:43:07.000' AS DateTime), CAST(N'2019-10-09 22:43:07.000' AS DateTime), 7, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1068, 4, 1062, N'0,4,', CAST(N'2019-10-09 22:43:07.000' AS DateTime), CAST(N'2019-10-09 22:43:15.000' AS DateTime), CAST(N'2019-10-09 22:43:15.000' AS DateTime), 8, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1069, 4, 1063, N'0,4,', CAST(N'2019-10-09 22:43:15.000' AS DateTime), CAST(N'2019-10-09 22:43:25.000' AS DateTime), CAST(N'2019-10-09 22:43:25.000' AS DateTime), 9, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1070, 4, 1064, N'0,4,', CAST(N'2019-10-09 22:43:25.000' AS DateTime), CAST(N'2019-10-09 22:43:33.000' AS DateTime), CAST(N'2019-10-09 22:43:33.000' AS DateTime), 10, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1071, 4, 1065, N'0,4,', CAST(N'2019-10-09 22:43:33.000' AS DateTime), CAST(N'2019-10-09 22:43:41.000' AS DateTime), CAST(N'2019-10-09 22:43:41.000' AS DateTime), 11, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1074, 3, 1055, N'0,3,', CAST(N'2019-10-09 22:39:22.000' AS DateTime), CAST(N'2019-10-10 07:56:24.000' AS DateTime), CAST(N'2019-10-10 07:56:24.000' AS DateTime), 1, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1076, 3, 1054, N'0,3,', CAST(N'2019-10-09 20:24:45.000' AS DateTime), CAST(N'2019-10-10 08:33:56.000' AS DateTime), CAST(N'2019-10-10 08:33:56.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1077, 71, 1066, N'0,71,', CAST(N'2019-10-10 11:14:58.000' AS DateTime), CAST(N'2019-10-10 11:14:58.000' AS DateTime), CAST(N'2019-10-10 11:14:58.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1078, 71, 1067, N'0,71,', CAST(N'2019-10-10 11:17:19.000' AS DateTime), CAST(N'2019-10-10 11:17:19.000' AS DateTime), CAST(N'2019-10-10 11:17:19.000' AS DateTime), 0, N'')
INSERT [dbo].[GROUPS_ITEMS] ([IGIID], [IGID], [IID], [VPARAMS], [DCREATEDATE], [DUPDATE], [DENDDATE], [IORDER], [web]) VALUES (1079, 71, 1068, N'0,71,', CAST(N'2019-10-10 11:17:46.000' AS DateTime), CAST(N'2019-10-10 11:17:46.000' AS DateTime), CAST(N'2019-10-10 11:17:46.000' AS DateTime), 0, N'')
SET IDENTITY_INSERT [dbo].[GROUPS_ITEMS] OFF
SET IDENTITY_INSERT [dbo].[ITEMS] ON 

INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1, N'2', N'AboutUs', N'', N'General introduction', N'', N'<p>
	Ltravel is driven by a group of experienced Vietnam travel specialist, we have been operating in the all travel services of tour operator in Vietnam<br />
	We are local tour operator that working directly to customers , has thousands of clients have put their faith in us to provide fascinating and exciting tours all around VietNam, each tailored to their specific interests and requirements.</p>
<br />
<p>
	Our mission is to provide the high quality customer service to our customers. Our friendly, qualified, experienced staff will treat you, our valued customers, with the utmost care and will provide the best possible service to ensure your individual travel requirements are met to your satisfaction.<br />
	Our goal is to make your visit to Vietnam enjoyable, comfortable and memorable whilst introducing you to the beauty and diversity of Vietnam and its cultures.</p>
<br />
<p>
	Before running a tour, we will have chosen the best car, restaurants, attractions, hotels &hellip;we put them to the test by carefully monitoring our customer&rsquo;s feedback. This continual review process ensures that we act quickly if our high standards are not maintained by our suppliers.<br />
	We always try to use services of local people and experienced local guides, particularly in rural and mountainous areas in order to increase employment opportunities for local communities in the region and allow you to discover more of the local culture.<br />
	Goodmorningvietnam team is made up of our sales executive, products marketing , customer services, IT teams, drivers team as well as our experienced tour guides, we are all working together to provide you with the highest level of service from your first inquiry and throughout your tour, until you arrive back home.</p>
<br />
<p>
	Ltravel - We commit to quality<br />
	Quality people &ndash; Highly trained professionals in all departments, We work by our passionate and knowledges<br />
	Quality tours &ndash; We put ourselves in our clients&rsquo; shoes &ndash; We KNOW what clients WANT<br />
	Quality service &ndash; &ldquo;Our future depends on our Clients&rsquo;s satisfaction<br />
	Quality website &ndash; Easy to navigate with comprehensive content</p>
<br />
<p>
	HOW WE DIFFERENT TO THE OTHER<br />
	We understand what a traveller&rsquo;s needs and we do our bests to ensure you will feel professionalism while traveling with us.<br />
	Goodmorningvietnam - We always pay attention to the smallest details of service to maximize your satisfaction while visiting Vietnam.<br />
	When you contact us, our personalized consultant who is an expert of the region will assist you for first-hand advice and suggestions. Our requests or bookings will be carefully handled with attention to details and more importantly, there is no hassle while you are proceeding with your booking</p>
<br />
<p>
	As the owner of Goodmorningvietnam Travel, my main goal is to educate and train my team to &ldquo;put themselves in our customers&rsquo; shoes,&rdquo; inspired to my team , cater to their needs and wishes, and provide the best possible customer service, the best possible experience in Vietnam. My team and I are highly motivated and strive to make Goodmorningvietnam Travel one of the best travel agencies in Vietnam.<br />
	My team is made up of our sales executive, products marketing, customer services, IT teams, as well as our experienced tour guides, we are all working togetther,<br />
	We are locally employed, have received excellent training and speak English well, we know the destinations, history and culture inside out, and offer a friendly, entertaining and efficient service at every stage of your journey.<br />
	At Goodmorningvietnam, we determined that have no distance between the owner and staffs, we are a team &ndash; we share passion ,knowledge and respondsibilities - we totally committed to being successful</p>
<br />
<p>
	COME TO US TO START YOUR HAPPYNESS JOURNEY</p>
<br />
', N'02-new_637061736955086054.jpg', N'', N'', N'General introduction', N'General introduction', N'General-introduction', N'General introduction', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 6, 1, CAST(N'2019-10-08 23:21:35.530' AS DateTime), CAST(N'2019-10-08 23:20:08.000' AS DateTime), CAST(N'2019-10-08 23:21:35.000' AS DateTime), CAST(N'2019-10-08 23:21:35.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (2, N'2', N'AboutUs', N'', N'organizational chart', N'', N'<p>
	Ltravel is driven by a group of experienced Vietnam travel specialist, we have been operating in the all travel services of tour operator in Vietnam<br />
	We are local tour operator that working directly to customers , has thousands of clients have put their faith in us to provide fascinating and exciting tours all around VietNam, each tailored to their specific interests and requirements.</p>
<br />
<p>
	Our mission is to provide the high quality customer service to our customers. Our friendly, qualified, experienced staff will treat you, our valued customers, with the utmost care and will provide the best possible service to ensure your individual travel requirements are met to your satisfaction.<br />
	Our goal is to make your visit to Vietnam enjoyable, comfortable and memorable whilst introducing you to the beauty and diversity of Vietnam and its cultures.</p>
<br />
<p>
	Before running a tour, we will have chosen the best car, restaurants, attractions, hotels &hellip;we put them to the test by carefully monitoring our customer&rsquo;s feedback. This continual review process ensures that we act quickly if our high standards are not maintained by our suppliers.<br />
	We always try to use services of local people and experienced local guides, particularly in rural and mountainous areas in order to increase employment opportunities for local communities in the region and allow you to discover more of the local culture.<br />
	Goodmorningvietnam team is made up of our sales executive, products marketing , customer services, IT teams, drivers team as well as our experienced tour guides, we are all working together to provide you with the highest level of service from your first inquiry and throughout your tour, until you arrive back home.</p>
<br />
<p>
	Ltravel - We commit to quality<br />
	Quality people &ndash; Highly trained professionals in all departments, We work by our passionate and knowledges<br />
	Quality tours &ndash; We put ourselves in our clients&rsquo; shoes &ndash; We KNOW what clients WANT<br />
	Quality service &ndash; &ldquo;Our future depends on our Clients&rsquo;s satisfaction<br />
	Quality website &ndash; Easy to navigate with comprehensive content</p>
<br />
<p>
	HOW WE DIFFERENT TO THE OTHER<br />
	We understand what a traveller&rsquo;s needs and we do our bests to ensure you will feel professionalism while traveling with us.<br />
	Goodmorningvietnam - We always pay attention to the smallest details of service to maximize your satisfaction while visiting Vietnam.<br />
	When you contact us, our personalized consultant who is an expert of the region will assist you for first-hand advice and suggestions. Our requests or bookings will be carefully handled with attention to details and more importantly, there is no hassle while you are proceeding with your booking</p>
<br />
<p>
	As the owner of Goodmorningvietnam Travel, my main goal is to educate and train my team to &ldquo;put themselves in our customers&rsquo; shoes,&rdquo; inspired to my team , cater to their needs and wishes, and provide the best possible customer service, the best possible experience in Vietnam. My team and I are highly motivated and strive to make Goodmorningvietnam Travel one of the best travel agencies in Vietnam.<br />
	My team is made up of our sales executive, products marketing, customer services, IT teams, as well as our experienced tour guides, we are all working togetther,<br />
	We are locally employed, have received excellent training and speak English well, we know the destinations, history and culture inside out, and offer a friendly, entertaining and efficient service at every stage of your journey.<br />
	At Goodmorningvietnam, we determined that have no distance between the owner and staffs, we are a team &ndash; we share passion ,knowledge and respondsibilities - we totally committed to being successful</p>
<br />
<p>
	COME TO US TO START YOUR HAPPYNESS JOURNEY</p>
<br />
', N'02-news_637061737298941575.jpg', N'', N'', N'organizational chart', N'organizational chart', N'organizational-chart', N'organizational chart', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 2, CAST(N'2019-10-08 23:22:09.913' AS DateTime), CAST(N'2019-10-08 23:21:35.000' AS DateTime), CAST(N'2019-10-08 23:22:09.000' AS DateTime), CAST(N'2019-10-08 23:22:09.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (3, N'2', N'AboutUs', N'', N'Vision & mission', N'', N'', N'02-news_637061737403523318.jpg', N'', N'', N'Vision & mission', N'Vision & mission', N'Vision-mission', N'Vision & mission', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 3, CAST(N'2019-10-08 23:22:20.367' AS DateTime), CAST(N'2019-10-08 23:22:09.000' AS DateTime), CAST(N'2019-10-08 23:22:20.000' AS DateTime), CAST(N'2019-10-08 23:22:20.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (4, N'2', N'AboutUs', N'', N'Company cultruea', N'', N'', N'02-news_637061737662274714.jpg', N'', N'', N'Company cultruea', N'Company cultruea', N'Company-cultruea', N'Company cultruea', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 1, 4, CAST(N'2019-10-08 23:22:46.240' AS DateTime), CAST(N'2019-10-08 23:22:20.000' AS DateTime), CAST(N'2019-10-08 23:22:46.000' AS DateTime), CAST(N'2019-10-08 23:22:46.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (5, N'2', N'AboutUs', N'', N'organizational chart 2', N'', N'', N'02-news_637061738529270826.jpg', N'', N'', N'organizational chart 2', N'organizational chart 2', N'organizational-chart-2', N'organizational chart 2', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 13, 1, CAST(N'2019-10-08 23:24:12.950' AS DateTime), CAST(N'2019-10-08 23:24:04.000' AS DateTime), CAST(N'2019-10-08 23:24:12.000' AS DateTime), CAST(N'2019-10-08 23:24:12.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (6, N'2', N'AboutUs', N'', N'Vision & mission 2', N'', N'', N'02-news_637061738606341746.jpg', N'', N'', N'Vision & mission 2', N'Vision & mission 2', N'Vision-mission-2', N'Vision & mission 2', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 1, 2, CAST(N'2019-10-08 23:24:20.657' AS DateTime), CAST(N'2019-10-08 23:24:12.000' AS DateTime), CAST(N'2019-10-08 23:24:20.000' AS DateTime), CAST(N'2019-10-08 23:24:20.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (7, N'2', N'ADV', N'', N'Ltravel.com.vn', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'logo-mai_637061753990487705.png', N'', N'', N'', N'/', N'', N'', N'', N'', N'', N'', N'0', 1, 0, 0, 0, 0, CAST(N'2019-10-08 23:49:59.060' AS DateTime), CAST(N'2019-10-08 23:49:59.000' AS DateTime), CAST(N'2019-10-08 23:49:59.000' AS DateTime), CAST(N'2019-10-08 23:49:59.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (8, N'2', N'ADV', N'', N'Banner 1', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'banne_637061754642245586.jpg', N'', N'', N'', N'/', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-08 23:51:04.240' AS DateTime), CAST(N'2019-10-08 23:51:04.000' AS DateTime), CAST(N'2019-10-08 23:51:04.000' AS DateTime), CAST(N'2019-10-08 23:51:04.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (9, N'2', N'ADV', N'', N'Banner 2', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'bg-banner_637061754732521929.jpg', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-08 23:51:13.260' AS DateTime), CAST(N'2019-10-08 23:51:13.000' AS DateTime), CAST(N'2019-10-08 23:51:13.000' AS DateTime), CAST(N'2019-10-08 23:51:13.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (10, N'2', N'ADV', N'', N'Facebook', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-fac_637061754918641319.png', N'', N'', N'', N'/', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-08 23:51:31.873' AS DateTime), CAST(N'2019-10-08 23:51:31.000' AS DateTime), CAST(N'2019-10-08 23:51:31.000' AS DateTime), CAST(N'2019-10-08 23:51:31.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (11, N'2', N'ADV', N'', N'Youtube', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-yout_637061755064809648.png', N'', N'', N'', N'/', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-08 23:51:46.490' AS DateTime), CAST(N'2019-10-08 23:51:46.000' AS DateTime), CAST(N'2019-10-08 23:51:46.000' AS DateTime), CAST(N'2019-10-08 23:51:46.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (12, N'2', N'ADV', N'', N'Google Plus', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-goog_637061755151626394.png', N'', N'', N'', N'/', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-08 23:51:55.167' AS DateTime), CAST(N'2019-10-08 23:51:55.000' AS DateTime), CAST(N'2019-10-08 23:51:55.000' AS DateTime), CAST(N'2019-10-08 23:51:55.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (13, N'2', N'ADV', N'', N'Zalo', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-zal_637061777542526788.png', N'', N'', N'', N'/', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 00:29:14.263' AS DateTime), CAST(N'2019-10-09 00:29:14.000' AS DateTime), CAST(N'2019-10-09 00:29:14.000' AS DateTime), CAST(N'2019-10-09 00:29:14.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (14, N'2', N'CUP', N'', N'Liên hệ', N'huyhung.dev@gmail.com', N'send contact', N'Cat Ba Freedom tour', N'', N'Đặng hồng phúc', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!222222222222*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-09 01:40:25.183' AS DateTime), CAST(N'2019-10-09 01:40:25.000' AS DateTime), CAST(N'2019-10-09 01:40:25.000' AS DateTime), CAST(N'2019-10-09 01:40:25.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (15, N'2', N'CUP', N'', N'Liên hệ', N'huyhung.dev@gmail.com', N'send contact', N'Cat Ba Freedom tour', N'', N'Đặng hồng phúc', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!222222222222*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-09 01:40:34.133' AS DateTime), CAST(N'2019-10-09 01:40:34.000' AS DateTime), CAST(N'2019-10-09 01:40:34.000' AS DateTime), CAST(N'2019-10-09 01:40:34.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (16, N'2', N'CUP', N'', N'Liên hệ', N'huyhung.dev@gmail.com', N'send contact', N'Cat Ba Freedom tour', N'', N'Đặng hồng phúc', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!222222222222*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-09 01:42:04.507' AS DateTime), CAST(N'2019-10-09 01:42:04.000' AS DateTime), CAST(N'2019-10-09 01:42:04.000' AS DateTime), CAST(N'2019-10-09 01:42:04.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (17, N'2', N'CustomerReviews', N'', N'Nguyen Duc Viet', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'<p>
	Ltravel is driven by a group of experienced Vietnam travel specialist, we have been operating in the all travel services of tour operator in Vietnam<br />
	We are local tour operator that working directly to customers , has thousands of clients have put their faith in us to provide fascinating and exciting tours all around VietNam, each tailored to their specific interests and requirements.</p>
<p>
	Our mission is to provide the high quality customer service to our customers. Our friendly, qualified, experienced staff will treat you, our valued customers, with the utmost care and will provide the best possible service to ensure your individual travel requirements are met to your satisfaction.<br />
	Our goal is to make your visit to Vietnam enjoyable, comfortable and memorable whilst introducing you to the beauty and diversity of Vietnam and its cultures.</p>
<p>
	Before running a tour, we will have chosen the best car, restaurants, attractions, hotels &hellip;we put them to the test by carefully monitoring our customer&rsquo;s feedback. This continual review process ensures that we act quickly if our high standards are not maintained by our suppliers.<br />
	We always try to use services of local people and experienced local guides, particularly in rural and mountainous areas in order to increase employment opportunities for local communities in the region and allow you to discover more of the local culture.<br />
	Goodmorningvietnam team is made up of our sales executive, products marketing , customer services, IT teams, drivers team as well as our experienced tour guides, we are all working together to provide you with the highest level of service from your first inquiry and throughout your tour, until you arrive back home.</p>
<p>
	Ltravel - We commit to quality<br />
	Quality people &ndash; Highly trained professionals in all departments, We work by our passionate and knowledges<br />
	Quality tours &ndash; We put ourselves in our clients&rsquo; shoes &ndash; We KNOW what clients WANT<br />
	Quality service &ndash; &ldquo;Our future depends on our Clients&rsquo;s satisfaction<br />
	Quality website &ndash; Easy to navigate with comprehensive content</p>
<p>
	HOW WE DIFFERENT TO THE OTHER<br />
	We understand what a traveller&rsquo;s needs and we do our bests to ensure you will feel professionalism while traveling with us.<br />
	Goodmorningvietnam - We always pay attention to the smallest details of service to maximize your satisfaction while visiting Vietnam.<br />
	When you contact us, our personalized consultant who is an expert of the region will assist you for first-hand advice and suggestions. Our requests or bookings will be carefully handled with attention to details and more importantly, there is no hassle while you are proceeding with your booking</p>
<p>
	As the owner of Goodmorningvietnam Travel, my main goal is to educate and train my team to &ldquo;put themselves in our customers&rsquo; shoes,&rdquo; inspired to my team , cater to their needs and wishes, and provide the best possible customer service, the best possible experience in Vietnam. My team and I are highly motivated and strive to make Goodmorningvietnam Travel one of the best travel agencies in Vietnam.<br />
	My team is made up of our sales executive, products marketing, customer services, IT teams, as well as our experienced tour guides, we are all working togetther,<br />
	We are locally employed, have received excellent training and speak English well, we know the destinations, history and culture inside out, and offer a friendly, entertaining and efficient service at every stage of your journey.<br />
	At Goodmorningvietnam, we determined that have no distance between the owner and staffs, we are a team &ndash; we share passion ,knowledge and respondsibilities - we totally committed to being successful</p>
', N'user-0_637062053441838924.png', N'', N'', N'Nguyen Duc Viet', N'Nguyen Duc Viet', N'Nguyen-Duc-Viet', N'Nguyen Duc Viet', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 2, 1, CAST(N'2019-10-09 08:30:51.590' AS DateTime), CAST(N'2019-10-09 08:08:16.000' AS DateTime), CAST(N'2019-10-09 08:30:51.000' AS DateTime), CAST(N'2019-10-09 08:30:51.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (18, N'2', N'CustomerReviews', N'', N'Le Viet Anh', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'user-0_637062053917523868.png', N'', N'', N'Le Viet Anh', N'Le Viet Anh', N'Le-Viet-Anh', N'Le Viet Anh', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 36, 1, CAST(N'2019-10-09 08:30:42.480' AS DateTime), CAST(N'2019-10-09 08:09:10.000' AS DateTime), CAST(N'2019-10-09 08:30:42.000' AS DateTime), CAST(N'2019-10-09 08:30:42.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (19, N'2', N'CustomerReviews', N'', N'Tran Dieu Linh', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'user-0_637062054051317247.png', N'', N'', N'Tran Dieu Linh', N'Tran Dieu Linh', N'Tran-Dieu-Linh', N'Tran Dieu Linh', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 2, 2, CAST(N'2019-10-09 08:30:55.247' AS DateTime), CAST(N'2019-10-09 08:09:51.000' AS DateTime), CAST(N'2019-10-09 08:30:55.000' AS DateTime), CAST(N'2019-10-09 08:30:55.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (20, N'2', N'CustomerReviews', N'', N'Nguyen Duc Viet 2', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'user-0_637062054182596628.png', N'', N'', N'Nguyen Duc Viet 2', N'Nguyen Duc Viet 2', N'Nguyen-Duc-Viet-2', N'Nguyen Duc Viet 2', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 1, 3, CAST(N'2019-10-09 08:31:04.103' AS DateTime), CAST(N'2019-10-09 08:10:05.000' AS DateTime), CAST(N'2019-10-09 08:31:04.000' AS DateTime), CAST(N'2019-10-09 08:31:04.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (21, N'2', N'CustomerReviews', N'', N'Le Viet Anh 2', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'user-0_637062054262872927.png', N'', N'', N'Le Viet Anh 2', N'Le Viet Anh 2', N'Le-Viet-Anh-2', N'Le Viet Anh 2', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 4, CAST(N'2019-10-09 08:31:07.537' AS DateTime), CAST(N'2019-10-09 08:10:18.000' AS DateTime), CAST(N'2019-10-09 08:31:07.000' AS DateTime), CAST(N'2019-10-09 08:31:07.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (22, N'2', N'CustomerReviews', N'', N'Tran Dieu Linh 2', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'user-0_637062054415701952.png', N'', N'', N'Tran Dieu Linh 2', N'Tran Dieu Linh 2', N'Tran-Dieu-Linh-2', N'Tran Dieu Linh 2', N'Jyw train is a life saver. I don''t have the time or money for a college education. My goal is to become a freelance web developer, and thanks to Jyw train', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 5, CAST(N'2019-10-09 08:31:11.247' AS DateTime), CAST(N'2019-10-09 08:10:26.000' AS DateTime), CAST(N'2019-10-09 08:31:11.000' AS DateTime), CAST(N'2019-10-09 08:31:11.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (23, N'2', N'S', N'', N'Car rental', N'Ninh Binh Province and is located in the south of the red River Delta region in northern Vietnam. It is famous for many beautifull sighseeings that also call “Halong Bay on Land”. These spectacular areas of limestone karsts and internal ', N'<p>
	Over view<br />
	Ha Noi airport tranfer service is supplied by Goodmorningvietnam, we have been working in tourism long time so we know what clients need for an amazing trip.</p>
<br />
<p>
	You can book a taxi when you arrived Vietnam but sometime make you confused about rate, car quality and how is driver, now Goodmorningvietnam will give you best solution to solve that problems, please tell us your schedule in Vietnam, you just enjoy the luxury of your own vehicle and professional driver as you make your way with comfort and easy from the airport to your hotel of choice.</p>
<br />
<p>
	Book in advance to ensure an easy arrival!<br />
	SUGGESTED ITINERARY</p>
<br />
<p>
	When making a booking, you will need to advise us of your flight details and your accommodation details.<br />
	Your transfer will be confirmed within 24 hours.</p>
<br />
<p>
	Useful Information<br />
	Noi Bai International Airport is the largest in the north of the country. It is 35 km from the city centre, it take approximately 45 minutes (1hour in peak times).</p>
<br />
<p>
	Warmly welcome to Vietnam<br />
	When you arrive at Noi Bai nternational Airport you&rsquo;ll see your name on our staffs&rsquo; hand sign board with logo of Goodmorningvietnam</p>
<br />
<p>
	Our drivers will wait for their passengers at the &ldquo;Arrivals&rdquo; area, . If you arrive at Noi bai Airport and do not see your name on a board, you or our driver, may be waiting in the wrong lobby. There are two Arrival lobbies at the airport, A and B, and if you cannot find the driver please go to the &ldquo;Information Desk &rdquo; and ring us on our hotline : ( +84 ) 888 488 135.</p>
<br />
<p>
	Should you tip for driver? It is up to you whether you want to tip the driver or not. If you are happy with the service he gave you can, however, there is no obligation.</p>
', N'service0_637062120546750369.jpg', N'', N'', N'Car rental', N'Car rental', N'Car-rental', N'Car rental', N'Ninh Binh Province and is located in the south of the red River Delta region in northern Vietnam. It is famous for many beautifull sighseeings that also call “Halong Bay on Land”. These spectacular areas of limestone karsts and internal ', N'', N'', N'', N'', 0, 0, 0, 7, 1, CAST(N'2019-10-09 10:02:12.970' AS DateTime), CAST(N'2019-10-09 09:59:57.000' AS DateTime), CAST(N'2019-10-09 10:02:12.000' AS DateTime), CAST(N'2019-10-09 10:02:12.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (24, N'2', N'S', N'', N'Air ticket', N'Ninh Binh Province and is located in the south of the red River Delta region in northern Vietnam. It is famous for many beautifull sighseeings that also call “Halong Bay on Land”. These spectacular areas of limestone karsts and internal ', N'<p>
	Over view<br />
	Ha Noi airport tranfer service is supplied by Goodmorningvietnam, we have been working in tourism long time so we know what clients need for an amazing trip.</p>
<br />
<p>
	You can book a taxi when you arrived Vietnam but sometime make you confused about rate, car quality and how is driver, now Goodmorningvietnam will give you best solution to solve that problems, please tell us your schedule in Vietnam, you just enjoy the luxury of your own vehicle and professional driver as you make your way with comfort and easy from the airport to your hotel of choice.</p>
<br />
<p>
	Book in advance to ensure an easy arrival!<br />
	SUGGESTED ITINERARY</p>
<br />
<p>
	When making a booking, you will need to advise us of your flight details and your accommodation details.<br />
	Your transfer will be confirmed within 24 hours.</p>
<br />
<p>
	Useful Information<br />
	Noi Bai International Airport is the largest in the north of the country. It is 35 km from the city centre, it take approximately 45 minutes (1hour in peak times).</p>
<br />
<p>
	Warmly welcome to Vietnam<br />
	When you arrive at Noi Bai nternational Airport you&rsquo;ll see your name on our staffs&rsquo; hand sign board with logo of Goodmorningvietnam</p>
<br />
<p>
	Our drivers will wait for their passengers at the &ldquo;Arrivals&rdquo; area, . If you arrive at Noi bai Airport and do not see your name on a board, you or our driver, may be waiting in the wrong lobby. There are two Arrival lobbies at the airport, A and B, and if you cannot find the driver please go to the &ldquo;Information Desk &rdquo; and ring us on our hotline : ( +84 ) 888 488 135.</p>
<br />
<p>
	Should you tip for driver? It is up to you whether you want to tip the driver or not. If you are happy with the service he gave you can, however, there is no obligation.</p>
', N'service0_637062120859469558.jpg', N'', N'', N'Air ticket', N'Air ticket', N'Air-ticket', N'Air ticket', N'Ninh Binh Province and is located in the south of the red River Delta region in northern Vietnam. It is famous for many beautifull sighseeings that also call “Halong Bay on Land”. These spectacular areas of limestone karsts and internal ', N'', N'', N'', N'', 0, 0, 0, 5, 2, CAST(N'2019-10-09 10:01:25.970' AS DateTime), CAST(N'2019-10-09 10:00:54.000' AS DateTime), CAST(N'2019-10-09 10:01:25.000' AS DateTime), CAST(N'2019-10-09 10:01:25.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (25, N'2', N'S', N'', N'Book Hotel', N'Ninh Binh Province and is located in the south of the red River Delta region in northern Vietnam. It is famous for many beautifull sighseeings that also call “Halong Bay on Land”. These spectacular areas of limestone karsts and internal ', N'', N'service0_637062121003559627.jpg', N'', N'', N'Book Hotel', N'Book Hotel', N'Book-Hotel', N'Book Hotel', N'Ninh Binh Province and is located in the south of the red River Delta region in northern Vietnam. It is famous for many beautifull sighseeings that also call “Halong Bay on Land”. These spectacular areas of limestone karsts and internal ', N'', N'', N'', N'', 0, 0, 0, 2, 3, CAST(N'2019-10-09 10:01:40.380' AS DateTime), CAST(N'2019-10-09 10:01:26.000' AS DateTime), CAST(N'2019-10-09 10:01:40.000' AS DateTime), CAST(N'2019-10-09 10:01:40.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (26, N'2', N'S', N'', N'Da Nang Airport to Hoi An - Hue', N'Ninh Binh Province and is located in the south of the red River Delta region in northern Vietnam. It is famous for many beautifull sighseeings that also call “Halong Bay on Land”. These spectacular areas of limestone karsts and internal ', N'', N'service0_637062121263903181.jpg', N'', N'', N'Da Nang Airport to Hoi An - Hue', N'Da Nang Airport to Hoi An - Hue', N'Da-Nang-Airport-to-Hoi-An-Hue', N'Da Nang Airport to Hoi An - Hue', N'Ninh Binh Province and is located in the south of the red River Delta region in northern Vietnam. It is famous for many beautifull sighseeings that also call “Halong Bay on Land”. These spectacular areas of limestone karsts and internal ', N'', N'', N'', N'', 0, 0, 0, 1, 4, CAST(N'2019-10-09 10:02:06.410' AS DateTime), CAST(N'2019-10-09 10:01:40.000' AS DateTime), CAST(N'2019-10-09 10:02:06.000' AS DateTime), CAST(N'2019-10-09 10:02:06.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1023, N'2', N'QLDDDV', N'', N'Da Nang Airport to Hoi An - Hue', N'', N'some text', N'', N'', N'Bui Huy Hung', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!113*!<=*ParamsSpilitItems*=>*!hung@gmail.com*!<=*ParamsSpilitItems*=>*!Viet nam*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-09 11:05:08.797' AS DateTime), CAST(N'2019-10-09 11:05:08.000' AS DateTime), CAST(N'2019-10-09 11:05:08.000' AS DateTime), CAST(N'2019-10-09 11:05:08.000' AS DateTime), 2, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1025, N'2', N'QLDDDV', N'', N'Car rental', N'', N'aaaaaaaaaaa', N'', N'', N'Bui Huy Hung', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!113*!<=*ParamsSpilitItems*=>*!h@gmail.com*!<=*ParamsSpilitItems*=>*!Viet nam*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-09 11:20:14.073' AS DateTime), CAST(N'2019-10-09 11:20:14.000' AS DateTime), CAST(N'2019-10-09 11:20:14.000' AS DateTime), CAST(N'2019-10-09 11:20:14.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1026, N'2', N'QLDDDV', N'', N'Da Nang Airport to Hoi An - Hue', N'', N'aaa', N'', N'', N'H', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!113*!<=*ParamsSpilitItems*=>*!h@gmail.com*!<=*ParamsSpilitItems*=>*!Viet nam*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-09 11:21:26.990' AS DateTime), CAST(N'2019-10-09 11:21:26.000' AS DateTime), CAST(N'2019-10-09 11:21:26.000' AS DateTime), CAST(N'2019-10-09 11:21:26.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1027, N'2', N'QLDDKTV', N'', N'Đăng ký tư vấn dịch vụ', N'', N'A', N'', N'', N'Đặng hồng phúc', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!huyhung@gmail.com*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-09 11:38:17.170' AS DateTime), CAST(N'2019-10-09 11:38:17.000' AS DateTime), CAST(N'2019-10-09 11:38:17.000' AS DateTime), CAST(N'2019-10-09 11:38:17.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1028, N'2', N'QLDDKTV', N'', N'Đăng ký tư vấn dịch vụ', N'', N'sfsf', N'', N'', N'Đặng hồng phúc', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!huyhung@gmail.com*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-09 11:48:16.440' AS DateTime), CAST(N'2019-10-09 11:48:16.000' AS DateTime), CAST(N'2019-10-09 11:48:16.000' AS DateTime), CAST(N'2019-10-09 11:48:16.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1029, N'2', N'ADV', N'', N'General introduction', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-ca_637062189539801140.png', N'', N'', N'We guarantee that our customers will have the best service, the most attractive promotions.', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 11:55:54.010' AS DateTime), CAST(N'2019-10-09 11:55:53.000' AS DateTime), CAST(N'2019-10-09 11:55:53.000' AS DateTime), CAST(N'2019-10-09 11:55:53.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1030, N'2', N'ADV', N'', N'General introduction', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-ca_637062189555662024.png', N'', N'', N'We guarantee that our customers will have the best service, the most attractive promotions.', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 11:55:55.583' AS DateTime), CAST(N'2019-10-09 11:55:55.000' AS DateTime), CAST(N'2019-10-09 11:55:55.000' AS DateTime), CAST(N'2019-10-09 11:55:55.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1031, N'2', N'ADV', N'', N'Experience when traveling', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-tie_637062189732633507.png', N'', N'', N'We guarantee that our customers will have the best service, the most attractive promotions.', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 11:56:13.280' AS DateTime), CAST(N'2019-10-09 11:56:13.000' AS DateTime), CAST(N'2019-10-09 11:56:13.000' AS DateTime), CAST(N'2019-10-09 11:56:13.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1032, N'2', N'ADV', N'', N'Our responsibility', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-ca_637062189846227722.png', N'', N'', N'We guarantee that our customers will have the best service, the most attractive promotions.', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 11:56:24.630' AS DateTime), CAST(N'2019-10-09 11:56:24.000' AS DateTime), CAST(N'2019-10-09 11:56:24.000' AS DateTime), CAST(N'2019-10-09 11:56:24.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1033, N'2', N'ADV', N'', N'Services we provide', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-tayt_637062189969046242.png', N'', N'', N'We guarantee that our customers will have the best service, the most attractive promotions.', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 11:56:36.917' AS DateTime), CAST(N'2019-10-09 11:56:36.000' AS DateTime), CAST(N'2019-10-09 11:56:36.000' AS DateTime), CAST(N'2019-10-09 11:56:36.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1034, N'2', N'ADV', N'', N'Contact us when you need it', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-th_637062190106009993.png', N'', N'', N'We guarantee that our customers will have the best service, the most attractive promotions.', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 11:56:50.603' AS DateTime), CAST(N'2019-10-09 11:56:50.000' AS DateTime), CAST(N'2019-10-09 11:56:50.000' AS DateTime), CAST(N'2019-10-09 11:56:50.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1035, N'2', N'ADV', N'', N'Always quality assurance for customers', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-sach_637062190244817078.png', N'', N'', N'We guarantee that our customers will have the best service, the most attractive promotions.', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 11:57:04.500' AS DateTime), CAST(N'2019-10-09 11:57:04.000' AS DateTime), CAST(N'2019-10-09 11:57:04.000' AS DateTime), CAST(N'2019-10-09 11:57:04.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1036, N'2', N'ADV', N'', N'Always quality assurance for customers', N'', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'icon-sach_637062190250363771.png', N'', N'', N'We guarantee that our customers will have the best service, the most attractive promotions.', N'', N'', N'', N'', N'', N'', N'', N'1', 1, 0, 0, 0, 0, CAST(N'2019-10-09 11:57:05.053' AS DateTime), CAST(N'2019-10-09 11:57:05.000' AS DateTime), CAST(N'2019-10-09 11:57:05.000' AS DateTime), CAST(N'2019-10-09 11:57:05.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1037, N'2', N'Hotel', N'', N'Oriana Villa Đà Lạt 103- Phòng 2 Người', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!<p>
	Ph&ograve;ng ri&ecirc;ng &middot; 1 ph&ograve;ng tắm &middot; 1 giường &middot; 1 ph&ograve;ng ngủ &middot; 2 kh&aacute;ch (tối đa 2 kh&aacute;ch)</p>
<p>
	Nếu bạn muốn t&igrave;m một nơi vừa ấm c&uacute;ng lại vừa tiện nghi, vừa c&oacute; thể tận hưởng kh&ocirc;ng kh&iacute; v&ugrave;ng ngoại &ocirc; y&ecirc;n b&igrave;nh vừa thuận tiện đi lại, Rabbit Hostel l&agrave; sự lựa chọn tốt nhất cho bạn. Nh&agrave; Thỏ c&aacute;ch trung t&acirc;m TP Cần Thơ 2km. c&aacute;ch Big C 1,5 km v&agrave; 7p đi xe m&aacute;y để đến Bến xe Cần Thơ.</p>
<p>
	Rabbit Hostel hứa hẹn mang đến cho du kh&aacute;ch kh&ocirc;ng gian thoải m&aacute;i c&ugrave;ng với đội ngũ nh&acirc;n vi&ecirc;n th&acirc;n thiện. Rabbit hostel c&oacute; cho thu&ecirc; xe m&aacute;y (150K/ng&agrave;y) v&agrave; xe đạp miễn ph&iacute; cũng như b&aacute;n c&aacute;c tour du lịch kh&aacute;m ph&aacute; Cần Thơ.</p>
<p>
	Ch&uacute;ng t&ocirc;i l&agrave; những người bản địa v&ocirc; c&ugrave;ng th&acirc;n thiện v&agrave; thoải m&aacute;i. Ch&iacute;nh v&igrave; vậy đừng ngại ngần m&agrave; chia sẻ với ch&uacute;ng t&ocirc;i những điều bạn đang thắc mắc hoặc những kh&oacute; khăn bạn gặp phải khi ở đ&acirc;y.</p>
<p>
	B&ecirc;n cạnh đ&oacute; ch&uacute;ng t&ocirc;i cũng lu&ocirc;n mong muốn được c&ugrave;ng bạn kh&aacute;m ph&aacute; nhiều địa điểm tốt đẹp nhất tại đ&acirc;y.</p>
<p>
	Ch&agrave;o mừng bạn đến với Rabbit Hostel !</p>
<p>
	<span class="title">Tiện nghi chỗ ở</span> Giới thiệu về c&aacute;c tiện nghi v&agrave; dịch vụ tại nơi lưu tr&uacute;</p>
<p>
	<span class="title">Tiện &iacute;ch gia đ&igrave;nh</span> Kh&ocirc;ng h&uacute;t thuốc</p>
<p>
	<span class="title">Tiện &iacute;ch ph&ograve;ng</span> Ban C&ocirc;ng</p>
<p>
	Lưu &yacute; đặc biệt<br />
	Check in hoặc out trễ hơn giờ quy định, ch&uacute;ng t&ocirc;i c&oacute; thể xem x&eacute;t t&igrave;nh h&igrave;nh v&agrave; phụ thu ph&iacute;:<br />
	Check in: 14h trước 9h: 100% gi&aacute; ph&ograve;ng, từ 9h-11h: 50%, sau 11h: 30%<br />
	Check out: 12h, trước 3h: 30%, từ 3h- 5h: 50%, sau 5h: 100%</p>
<p>
	Kh&ocirc;ng h&uacute;t thuốc<br />
	Kh&ocirc;ng sử dụng c&aacute;c chất k&iacute;ch th&iacute;ch, văn ho&aacute; phẩm đồi truỵ<br />
	Vui l&ograve;ng giữ im lặng sau 22h đ&ecirc;m<br />
	Vui l&ograve;ng tắt điện khi bạn rời khỏi mỗi ph&ograve;ng</p>
*!<=*ParamsSpilitItems*=>*!', N'service0_637062265632142019.jpg', N'', N'0', N'Oriana Villa Đà Lạt 103- Phòng 2 Người', N'Oriana Villa Đà Lạt 103- Phòng 2 Người', N'Oriana-Villa-Da-Lat-103-Phong-2-Nguoi', N'Oriana Villa Đà Lạt 103- Phòng 2 Người', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4', N'', N'', N'0', N'', 4600000, 3600000, 0, 88, 1, CAST(N'2019-10-09 14:02:43.237' AS DateTime), CAST(N'2019-10-09 13:59:34.000' AS DateTime), CAST(N'2019-10-09 14:02:43.000' AS DateTime), CAST(N'2019-10-09 14:02:43.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1038, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service0_637062275726526601.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4', N'', N'', N'', N'0', N'', 4600000, 3600000, 0, 0, 1, CAST(N'2019-10-09 14:19:32.670' AS DateTime), CAST(N'2019-10-09 14:18:55.000' AS DateTime), CAST(N'2019-10-09 14:19:32.000' AS DateTime), CAST(N'2019-10-09 14:19:32.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1039, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 2', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service0_637062275996836022.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 2', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 2', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-2', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 2', N'', N'', N'', N'', N'', 4600000, 3600000, 0, 0, 2, CAST(N'2019-10-09 14:19:59.700' AS DateTime), CAST(N'2019-10-09 14:19:32.000' AS DateTime), CAST(N'2019-10-09 14:19:59.000' AS DateTime), CAST(N'2019-10-09 14:19:59.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1040, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 3', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service0_637062276180335295.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 3', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 3', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-3', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 3', N'', N'', N'', N'', N'', 4600000, 3600000, 0, 0, 3, CAST(N'2019-10-09 14:20:18.047' AS DateTime), CAST(N'2019-10-09 14:19:59.000' AS DateTime), CAST(N'2019-10-09 14:20:18.000' AS DateTime), CAST(N'2019-10-09 14:20:18.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1041, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 4', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service0_637062276330590604.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 4', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 4', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-4', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 4', N'', N'', N'', N'', N'', 4600000, 3600000, 0, 0, 4, CAST(N'2019-10-09 14:20:33.080' AS DateTime), CAST(N'2019-10-09 14:20:18.000' AS DateTime), CAST(N'2019-10-09 14:20:33.000' AS DateTime), CAST(N'2019-10-09 14:20:33.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1042, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 5', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062276504153218.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 5', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 5', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-5', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 5', N'', N'', N'', N'', N'', 0, 0, 0, 0, 5, CAST(N'2019-10-09 14:20:50.430' AS DateTime), CAST(N'2019-10-09 14:20:33.000' AS DateTime), CAST(N'2019-10-09 14:20:50.000' AS DateTime), CAST(N'2019-10-09 14:20:50.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1043, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 6', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062276950328009.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 6', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 6', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-6', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 6', N'', N'', N'', N'0', N'', 4600000, 3600000, 0, 1, 1, CAST(N'2019-10-09 14:21:35.053' AS DateTime), CAST(N'2019-10-09 14:21:13.000' AS DateTime), CAST(N'2019-10-09 14:21:35.000' AS DateTime), CAST(N'2019-10-09 14:21:35.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1044, N'2', N'Hotel', N'', N'Oriana Villa Đà Lạt 103 - Phòng 2 người', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062277324780578.jpg', N'', N'0', N'Oriana Villa Đà Lạt 103 - Phòng 2 người', N'Oriana Villa Đà Lạt 103 - Phòng 2 người', N'Oriana-Villa-Da-Lat-103-Phong-2-nguoi', N'Oriana Villa Đà Lạt 103 - Phòng 2 người', N'', N'', N'', N'', N'', 4600000, 3600000, 0, 0, 2, CAST(N'2019-10-09 14:22:12.517' AS DateTime), CAST(N'2019-10-09 14:21:35.000' AS DateTime), CAST(N'2019-10-09 14:22:12.000' AS DateTime), CAST(N'2019-10-09 14:22:12.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1045, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 7', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service0_637062277427856475.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 7', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 7', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-7', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 7', N'', N'', N'', N'', N'', 0, 0, 0, 0, 3, CAST(N'2019-10-09 14:22:22.797' AS DateTime), CAST(N'2019-10-09 14:22:12.000' AS DateTime), CAST(N'2019-10-09 14:22:22.000' AS DateTime), CAST(N'2019-10-09 14:22:22.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1046, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 8', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062277549870812.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 8', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 8', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-8', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 8', N'', N'', N'', N'', N'', 4600000, 3600000, 0, 0, 4, CAST(N'2019-10-09 14:22:34.997' AS DateTime), CAST(N'2019-10-09 14:22:22.000' AS DateTime), CAST(N'2019-10-09 14:22:34.000' AS DateTime), CAST(N'2019-10-09 14:22:34.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1047, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 9', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service2_637062277654618395.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 9', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 9', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-9', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 9', N'', N'', N'', N'', N'', 0, 0, 0, 0, 5, CAST(N'2019-10-09 14:22:45.480' AS DateTime), CAST(N'2019-10-09 14:22:35.000' AS DateTime), CAST(N'2019-10-09 14:22:45.000' AS DateTime), CAST(N'2019-10-09 14:22:45.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1048, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 10', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service2_637062277760610353.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 10', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 10', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-10', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 10', N'', N'', N'', N'', N'', 0, 0, 0, 0, 6, CAST(N'2019-10-09 14:22:56.073' AS DateTime), CAST(N'2019-10-09 14:22:45.000' AS DateTime), CAST(N'2019-10-09 14:22:56.000' AS DateTime), CAST(N'2019-10-09 14:22:56.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1049, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 11', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service2_637062277855235509.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 11', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 11', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-11', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 11', N'', N'', N'', N'', N'', 0, 0, 0, 0, 7, CAST(N'2019-10-09 14:23:05.543' AS DateTime), CAST(N'2019-10-09 14:22:56.000' AS DateTime), CAST(N'2019-10-09 14:23:05.000' AS DateTime), CAST(N'2019-10-09 14:23:05.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1050, N'2', N'Hotel', N'', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 12', N'', N'*!<=*ParamsSpilitItems*=>*!<ul>
	<li>
		Ph&ograve;ng ri&ecirc;ng</li>
	<li>
		1 ph&ograve;ng tắm</li>
	<li>
		1 giường</li>
	<li>
		1 ph&ograve;ng ngủ</li>
	<li>
		2 kh&aacute;ch (đối đa 2 kh&aacute;ch)</li>
</ul>
Liệu bạn c&oacute; cần một nơi để chill ở Đ&agrave; Lạt . Th&igrave; t&ocirc;i chắc chắn ch&uacute;ng t&ocirc;i l&agrave; một địa chỉ tuyệt vời nhất m&agrave; bạn n&ecirc;n gh&eacute; tới. Xin được cung cấp cho bạn những tiện nghi tuyệt vời nhất:*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062277958911511.jpg', N'', N'0', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 12', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 12', N'Traveling-Cam-Ranh-Binh-Ba-Island-on-the-occasion-of-30-4-12', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 12', N'', N'', N'', N'', N'', 0, 0, 0, 0, 8, CAST(N'2019-10-09 14:23:15.907' AS DateTime), CAST(N'2019-10-09 14:23:05.000' AS DateTime), CAST(N'2019-10-09 14:23:15.000' AS DateTime), CAST(N'2019-10-09 14:23:15.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1051, N'2', N'HotelBooking', N'', N'Đơn đặt phòng', N'', N'
    <ul>
    <li>Tên Phòng: Oriana Villa Đà Lạt 103- Phòng 2 Người</li>
    <li>Ngày nhận phòng: 11/10/2019</li>
    <li>Ngày trả phòng: 18/10/2019</li>
    <li>Tổng tiền: 3.600.000VNĐ</li>
    <li>Họ tên: Bui Huy Hung</li>
    <li>Điện thoại: 113</li>
    <li>Email: hung@gmail.com</li>
    <li>Quốc tịch: Viet nam</li>
    <li>Nội dung: some text...</li>
    </ul>', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 0, 0, 0, 0, 0, CAST(N'2019-10-09 17:20:44.000' AS DateTime), CAST(N'2019-10-09 17:20:44.000' AS DateTime), CAST(N'2019-10-09 17:20:44.000' AS DateTime), CAST(N'2019-10-09 17:20:44.000' AS DateTime), 0, N'', NULL)
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1052, N'2', N'HotelBooking', N'', N'Đơn đặt phòng', N'', N'
    <ul>
    <li>Tên Phòng: Oriana Villa Đà Lạt 103- Phòng 2 Người</li>
    <li>Ngày nhận phòng: </li>
    <li>Ngày trả phòng: </li>
    <li>Tổng tiền: 3.600.000VNĐ</li>
    <li>Họ tên: Bui Huy Hung</li>
    <li>Điện thoại: 113</li>
    <li>Email: h@gmail.com</li>
    <li>Quốc tịch: </li>
    <li>Nội dung: </li>
    </ul>', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 0, 0, 0, 0, 0, CAST(N'2019-10-09 17:23:02.000' AS DateTime), CAST(N'2019-10-09 17:23:02.000' AS DateTime), CAST(N'2019-10-09 17:23:02.000' AS DateTime), CAST(N'2019-10-09 17:23:02.000' AS DateTime), 1, N'', NULL)
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1053, N'2', N'HotelBooking', N'', N'Đơn đặt phòng', N'', N'
    <ul>
    <li>Tên Phòng: Oriana Villa Đà Lạt 103- Phòng 2 Người</li>
    <li>Ngày nhận phòng: 11/10/2019</li>
    <li>Ngày trả phòng: 17/10/2019</li>
    <li>Tổng tiền: 3.600.000VNĐ</li>
    <li>Họ tên: Bui Huy Hung</li>
    <li>Điện thoại: 113</li>
    <li>Email: h@gmail.com</li>
    <li>Quốc tịch: Viet nam</li>
    <li>Nội dung: dsad</li>
    </ul>', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', N'', 0, 0, 0, 0, 0, CAST(N'2019-10-09 17:23:49.000' AS DateTime), CAST(N'2019-10-09 17:23:49.000' AS DateTime), CAST(N'2019-10-09 17:23:49.000' AS DateTime), CAST(N'2019-10-09 17:23:49.000' AS DateTime), 0, N'', NULL)
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1054, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!Đảo Cát Bà*!<=*ParamsSpilitItems*=>*!Thuyển du lịch*!<=*ParamsSpilitItems*=>*!<iframe width="560" height="315" src="https://www.youtube.com/embed/knW7-x7Y7RE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>*!<=*ParamsSpilitItems*=>*!<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d29853.451117920427!2d107.04168310549215!3d20.72315870360636!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x314a444a4adb83f1%3A0xe7902d18f44a272a!2zQ2F0IEJhLCBDw6F0IEjhuqNpLCBIYWkgUGhvbmcsIFZpZXRuYW0!5e0!3m2!1sen!2s!4v1570627822842!5m2!1sen!2s" width="600" height="450" frameborder="0" style="border:0;" allowfullscreen=""></iframe>*!<=*ParamsSpilitItems*=>*!8.30 am*!<=*ParamsSpilitItems*=>*!', N'tour_deta_637062498528055965.jpg', N'1060', N'1065', N'1 day boat trip with Captain Jack', N'1 day boat trip with Captain Jack', N'1-day-boat-trip-with-Captain-Jack', N'1 day boat trip with Captain Jack', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!3600000*!<=*ParamsSpilitItems*=>*!2500000*!<=*ParamsSpilitItems*=>*!1500000*!<=*ParamsSpilitItems*=>*!1000000*!<=*ParamsSpilitItems*=>*!', N'', N'Aprill 28, 2019', N'', 4600000, 3600000, 0, 84, 0, CAST(N'2019-10-10 08:33:56.203' AS DateTime), CAST(N'2019-10-09 20:24:45.000' AS DateTime), CAST(N'2019-10-10 08:33:56.000' AS DateTime), CAST(N'2019-10-10 08:33:56.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1055, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 2', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!Huế*!<=*ParamsSpilitItems*=>*!Ô tô*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'news_0_637062577181937968.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 2', N'1 day boat trip with Captain Jack 2', N'1-day-boat-trip-with-Captain-Jack-2', N'1 day boat trip with Captain Jack 2', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!1000000*!<=*ParamsSpilitItems*=>*!800000*!<=*ParamsSpilitItems*=>*!500000*!<=*ParamsSpilitItems*=>*!300000*!<=*ParamsSpilitItems*=>*!', N'', N'Aprill 28, 2019', N'', 5000000, 4000000, 0, 3, 1, CAST(N'2019-10-10 07:56:24.177' AS DateTime), CAST(N'2019-10-09 22:39:22.000' AS DateTime), CAST(N'2019-10-10 07:56:24.000' AS DateTime), CAST(N'2019-10-10 07:56:24.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1056, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 3', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'news_0_637062577340906915.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 3', N'1 day boat trip with Captain Jack 3', N'1-day-boat-trip-with-Captain-Jack-3', N'1 day boat trip with Captain Jack 3', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 1, 2, CAST(N'2019-10-09 22:42:14.097' AS DateTime), CAST(N'2019-10-09 22:41:58.000' AS DateTime), CAST(N'2019-10-09 22:42:14.000' AS DateTime), CAST(N'2019-10-09 22:42:14.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1057, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 4', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'tour_deta_637062577429457345.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 4', N'1 day boat trip with Captain Jack 4', N'1-day-boat-trip-with-Captain-Jack-4', N'1 day boat trip with Captain Jack 4', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 3, CAST(N'2019-10-09 22:42:22.953' AS DateTime), CAST(N'2019-10-09 22:42:14.000' AS DateTime), CAST(N'2019-10-09 22:42:22.000' AS DateTime), CAST(N'2019-10-09 22:42:22.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1058, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 5', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'news_0_637062577504410686.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 5', N'1 day boat trip with Captain Jack 5', N'1-day-boat-trip-with-Captain-Jack-5', N'1 day boat trip with Captain Jack 5', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 4, CAST(N'2019-10-09 22:42:30.447' AS DateTime), CAST(N'2019-10-09 22:42:22.000' AS DateTime), CAST(N'2019-10-09 22:42:30.000' AS DateTime), CAST(N'2019-10-09 22:42:30.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1059, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 6', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'news_0_637062577603743793.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 6', N'1 day boat trip with Captain Jack 6', N'1-day-boat-trip-with-Captain-Jack-6', N'1 day boat trip with Captain Jack 6', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 5, CAST(N'2019-10-09 22:42:40.390' AS DateTime), CAST(N'2019-10-09 22:42:30.000' AS DateTime), CAST(N'2019-10-09 22:42:40.000' AS DateTime), CAST(N'2019-10-09 22:42:40.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1060, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 11', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service0_637062577795996952.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 11', N'1 day boat trip with Captain Jack 11', N'1-day-boat-trip-with-Captain-Jack-11', N'1 day boat trip with Captain Jack 11', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 6, CAST(N'2019-10-09 22:42:59.610' AS DateTime), CAST(N'2019-10-09 22:42:40.000' AS DateTime), CAST(N'2019-10-09 22:42:59.000' AS DateTime), CAST(N'2019-10-09 22:42:59.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1061, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 12', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062577876076822.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 12', N'1 day boat trip with Captain Jack 12', N'1-day-boat-trip-with-Captain-Jack-12', N'1 day boat trip with Captain Jack 12', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 7, CAST(N'2019-10-09 22:43:07.620' AS DateTime), CAST(N'2019-10-09 22:42:59.000' AS DateTime), CAST(N'2019-10-09 22:43:07.000' AS DateTime), CAST(N'2019-10-09 22:43:07.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1062, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 13', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062577955210844.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 13', N'1 day boat trip with Captain Jack 13', N'1-day-boat-trip-with-Captain-Jack-13', N'1 day boat trip with Captain Jack 13', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 8, CAST(N'2019-10-09 22:43:15.530' AS DateTime), CAST(N'2019-10-09 22:43:07.000' AS DateTime), CAST(N'2019-10-09 22:43:15.000' AS DateTime), CAST(N'2019-10-09 22:43:15.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1063, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 14', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service0_637062578057545680.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 14', N'1 day boat trip with Captain Jack 14', N'1-day-boat-trip-with-Captain-Jack-14', N'1 day boat trip with Captain Jack 14', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 9, CAST(N'2019-10-09 22:43:25.763' AS DateTime), CAST(N'2019-10-09 22:43:15.000' AS DateTime), CAST(N'2019-10-09 22:43:25.000' AS DateTime), CAST(N'2019-10-09 22:43:25.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1064, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 15', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062578139207753.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 15', N'1 day boat trip with Captain Jack 15', N'1-day-boat-trip-with-Captain-Jack-15', N'1 day boat trip with Captain Jack 15', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 10, CAST(N'2019-10-09 22:43:33.927' AS DateTime), CAST(N'2019-10-09 22:43:25.000' AS DateTime), CAST(N'2019-10-09 22:43:33.000' AS DateTime), CAST(N'2019-10-09 22:43:33.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1065, N'2', N'Tour', N'', N'1 day boat trip with Captain Jack 16', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'service1_637062578218343427.jpg', N'1062', N'1065', N'1 day boat trip with Captain Jack 16', N'1 day boat trip with Captain Jack 16', N'1-day-boat-trip-with-Captain-Jack-16', N'1 day boat trip with Captain Jack 16', N'8:30: You will be collected from your Cat Ba hotel to Ben Beo wharf (2km). 9.00: Board our beautiful boat', N'*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!*!<=*ParamsSpilitItems*=>*!', N'', N'', N'', 0, 0, 0, 0, 11, CAST(N'2019-10-09 22:43:41.840' AS DateTime), CAST(N'2019-10-09 22:43:33.000' AS DateTime), CAST(N'2019-10-09 22:43:41.000' AS DateTime), CAST(N'2019-10-09 22:43:41.000' AS DateTime), 1, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1066, N'2', N'QLDDKTV', N'', N'Đăng ký tư vấn dịch vụ', N'', N'fdg', N'', N'', N'Đặng hồng phúc', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!huyhung@gmail.com*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-10 11:14:58.797' AS DateTime), CAST(N'2019-10-10 11:14:58.000' AS DateTime), CAST(N'2019-10-10 11:14:58.000' AS DateTime), CAST(N'2019-10-10 11:14:58.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1067, N'2', N'QLDDKTV', N'', N'Đăng ký tư vấn dịch vụ', N'', N'fdg', N'', N'', N'Đặng hồng phúc', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!huyhung@gmail.com*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-10 11:17:19.310' AS DateTime), CAST(N'2019-10-10 11:17:19.000' AS DateTime), CAST(N'2019-10-10 11:17:19.000' AS DateTime), CAST(N'2019-10-10 11:17:19.000' AS DateTime), 0, N'', N'')
INSERT [dbo].[ITEMS] ([IID], [VILANG], [VIAPP], [VIKEY], [VITITLE], [VIDESC], [VICONTENT], [VIIMAGE], [VIURL], [VIAUTHOR], [VISEOTITLE], [VISEOLINK], [VISEOLINKSEARCH], [VISEOMETAKEY], [VISEOMETADESC], [VISEOMETACANONICAL], [VISEOMETALANG], [VISEOMETAPARAMS], [VIPARAMS], [FIPRICE], [FISALEPRICE], [IITOTALSUBITEMS], [IITOTALVIEW], [IIORDER], [DILASTVIEW], [DICREATEDATE], [DIUPDATE], [DIENDDATE], [IIENABLE], [web], [vsearchkey]) VALUES (1068, N'2', N'QLDDKTV', N'', N'Đăng ký tư vấn dịch vụ', N'', N'fdg', N'', N'', N'Đặng hồng phúc', N'', N'', N'', N'', N'', N'', N'', N'', N'*!<=*ParamsSpilitItems*=>*!huyhung@gmail.com*!<=*ParamsSpilitItems*=>*!', 0, 0, 0, 0, 0, CAST(N'2019-10-10 11:17:46.913' AS DateTime), CAST(N'2019-10-10 11:17:46.000' AS DateTime), CAST(N'2019-10-10 11:17:46.000' AS DateTime), CAST(N'2019-10-10 11:17:46.000' AS DateTime), 0, N'', N'')
SET IDENTITY_INSERT [dbo].[ITEMS] OFF
SET IDENTITY_INSERT [dbo].[LanguageNational] ON 

INSERT [dbo].[LanguageNational] ([iLanguageNationalId], [nLanguageNationalName], [nLanguageNationalFlag], [nLanguageNationalDesc], [iLanguageNationalEnable], [web]) VALUES (1, N'Việt Nam', N'icon-VN637061727952271865.png', N'2', 1, N'')
INSERT [dbo].[LanguageNational] ([iLanguageNationalId], [nLanguageNationalName], [nLanguageNationalFlag], [nLanguageNationalDesc], [iLanguageNationalEnable], [web]) VALUES (2, N'English', N'icon-Anh637061728063302009.png', N'1', 1, N'')
SET IDENTITY_INSERT [dbo].[LanguageNational] OFF
SET IDENTITY_INSERT [dbo].[Logs] ON 

INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2247, CAST(N'2019-08-21 08:47:41.000' AS DateTime), N'http://localhost:58247/admin.aspx?uc=Systemwebsite&suc=optimize', N'                                                                                                    ', N'Thông tin tối ưu website                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'8/21/2019 8:47:41 AM: admin cập nhật thông tin hệ thống (Thông tin tối ưu website)                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2248, CAST(N'2019-08-21 08:48:46.000' AS DateTime), N'http://localhost:58247/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'8/21/2019 8:48:46 AM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2249, CAST(N'2019-10-08 21:53:42.000' AS DateTime), N'http://localhost:57803/login.aspx', N'                                                                                                    ', N'admin                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 9:53:42 PM: admin đăng nhập vào hệ thống quản trị                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2250, CAST(N'2019-10-08 22:14:09.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=email', N'                                                                                                    ', N'PropertyMailWebsite                                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 10:14:09 PM: admin cập nhật thông tin hệ thống (PropertyMailWebsite)                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2251, CAST(N'2019-10-08 22:44:10.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=optimize', N'                                                                                                    ', N'Thông tin tối ưu website                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 10:44:10 PM: admin cập nhật thông tin hệ thống (Thông tin tối ưu website)                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2252, CAST(N'2019-10-08 22:45:22.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 10:45:22 PM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2253, CAST(N'2019-10-08 22:48:22.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Language&suc=national', N'                                                                                                    ', N'English                                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 10:48:22 PM: admin thay đổi trạng thái ngôn ngữ English                                                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2254, CAST(N'2019-10-08 23:06:35.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Language&suc=UpdateLanguageNational&iLanguageNationalId=1', N'                                                                                                    ', N'Việt Nam                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:06:35 PM: admin cập nhật ngôn ngữ Việt Nam                                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2255, CAST(N'2019-10-08 23:06:46.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Language&suc=UpdateLanguageNational&iLanguageNationalId=2', N'                                                                                                    ', N'English                                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:06:46 PM: admin cập nhật ngôn ngữ English                                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2256, CAST(N'2019-10-08 23:20:04.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateCate', N'                                                                                                    ', N'About us                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:20:04 PM: admin tạo mới About us                                                                                                                                                                                                                                                               ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2257, CAST(N'2019-10-08 23:21:35.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateItem&igid=', N'                                                                                                    ', N'General introduction                                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:21:35 PM: admin tạo mới General introduction                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2258, CAST(N'2019-10-08 23:22:09.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateItem&igid=', N'                                                                                                    ', N'organizational chart                                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:22:09 PM: admin tạo mới organizational chart                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2259, CAST(N'2019-10-08 23:22:20.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateItem&igid=', N'                                                                                                    ', N'Vision & mission                                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:22:20 PM: admin tạo mới Vision & mission                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2260, CAST(N'2019-10-08 23:22:46.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateItem&igid=', N'                                                                                                    ', N'Company cultruea                                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:22:46 PM: admin tạo mới Company cultruea                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2261, CAST(N'2019-10-08 23:24:12.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateItem&igid=', N'                                                                                                    ', N'organizational chart 2                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:24:12 PM: admin tạo mới organizational chart 2                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2262, CAST(N'2019-10-08 23:24:20.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateItem&igid=', N'                                                                                                    ', N'Vision & mission 2                                                                                                                                                                                                                                                                                          ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:24:20 PM: admin tạo mới Vision & mission 2                                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2263, CAST(N'2019-10-08 23:29:52.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:29:52 PM: admin tạo mới Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2264, CAST(N'2019-10-08 23:30:33.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Viet nam tours                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:30:33 PM: admin tạo mới Viet nam tours                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2265, CAST(N'2019-10-08 23:41:10.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateCate', N'                                                                                                    ', N'Transport Services                                                                                                                                                                                                                                                                                          ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:41:10 PM: admin tạo mới Transport Services                                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2266, CAST(N'2019-10-08 23:42:25.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateCate', N'                                                                                                    ', N'Accomodation                                                                                                                                                                                                                                                                                                ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:42:25 PM: admin tạo mới Accomodation                                                                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2267, CAST(N'2019-10-08 23:49:21.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateCate', N'                                                                                                    ', N'Logo                                                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:49:21 PM: admin tạo mới Logo                                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2268, CAST(N'2019-10-08 23:49:24.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateCate', N'                                                                                                    ', N'Slide chính tại trang chủ                                                                                                                                                                                                                                                                                   ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:49:24 PM: admin tạo mới Slide chính tại trang chủ                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2269, CAST(N'2019-10-08 23:49:28.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateCate', N'                                                                                                    ', N'Các mạng xã hội đầu trang                                                                                                                                                                                                                                                                                   ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:49:28 PM: admin tạo mới Các mạng xã hội đầu trang                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2270, CAST(N'2019-10-08 23:49:59.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem&igid=', N'                                                                                                    ', N'Ltravel.com.vn                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:49:59 PM: admin tạo mới Ltravel.com.vn                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2271, CAST(N'2019-10-08 23:51:04.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem&igid=', N'                                                                                                    ', N'Banner 1                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:51:04 PM: admin tạo mới Banner 1                                                                                                                                                                                                                                                               ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2272, CAST(N'2019-10-08 23:51:13.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem&igid=', N'                                                                                                    ', N'Banner 2                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:51:13 PM: admin tạo mới Banner 2                                                                                                                                                                                                                                                               ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2273, CAST(N'2019-10-08 23:51:31.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem&igid=', N'                                                                                                    ', N'Facebook                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:51:31 PM: admin tạo mới Facebook                                                                                                                                                                                                                                                               ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2274, CAST(N'2019-10-08 23:51:46.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem&igid=', N'                                                                                                    ', N'Youtube                                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:51:46 PM: admin tạo mới Youtube                                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2275, CAST(N'2019-10-08 23:51:55.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem&igid=', N'                                                                                                    ', N'Google Plus                                                                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:51:55 PM: admin tạo mới Google Plus                                                                                                                                                                                                                                                            ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2276, CAST(N'2019-10-08 23:59:46.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/8/2019 11:59:46 PM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2277, CAST(N'2019-10-09 00:02:39.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 12:02:39 AM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2278, CAST(N'2019-10-09 00:03:57.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 12:03:57 AM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2279, CAST(N'2019-10-09 00:04:13.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 12:04:13 AM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2280, CAST(N'2019-10-09 00:05:16.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 12:05:16 AM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2281, CAST(N'2019-10-09 00:29:14.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem&igid=', N'                                                                                                    ', N'Zalo                                                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 12:29:14 AM: admin tạo mới Zalo                                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2282, CAST(N'2019-10-09 00:29:22.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Items/UpdateEnableItem.aspx', N'                                                                                                    ', N'Zalo                                                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 12:29:22 AM: admin thay đổi trạng thái Zalo (id: 13)                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2283, CAST(N'2019-10-09 07:56:11.000' AS DateTime), N'http://localhost:57803/login.aspx', N'                                                                                                    ', N'admin                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 7:56:11 AM: admin đăng nhập vào hệ thống quản trị                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2284, CAST(N'2019-10-09 08:02:48.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=CreateCate', N'                                                                                                    ', N'Customer Comments                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:02:48 AM: admin tạo mới Customer Comments                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2285, CAST(N'2019-10-09 08:07:51.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateCate&igid=17', N'                                                                                                    ', N'Customer Comments                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:07:51 AM: admin cập nhật Customer Comments                                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2286, CAST(N'2019-10-09 08:09:04.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=CreateItem', N'                                                                                                    ', N'Nguyen Duc Viet                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:09:04 AM: admin tạo mới Nguyen Duc Viet                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2287, CAST(N'2019-10-09 08:09:51.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=CreateItem&igid=17', N'                                                                                                    ', N'Le Viet Anh                                                                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:09:51 AM: admin tạo mới Le Viet Anh                                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2288, CAST(N'2019-10-09 08:10:05.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=CreateItem&igid=17', N'                                                                                                    ', N'Tran Dieu Linh                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:10:05 AM: admin tạo mới Tran Dieu Linh                                                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2289, CAST(N'2019-10-09 08:10:18.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=CreateItem&igid=17', N'                                                                                                    ', N'Nguyen Duc Viet 2                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:10:18 AM: admin tạo mới Nguyen Duc Viet 2                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2290, CAST(N'2019-10-09 08:10:26.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=CreateItem&igid=17', N'                                                                                                    ', N'Le Viet Anh 2                                                                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:10:26 AM: admin tạo mới Le Viet Anh 2                                                                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2291, CAST(N'2019-10-09 08:10:29.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=CreateItem&igid=17', N'                                                                                                    ', N'Tra                                                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:10:29 AM: admin tạo mới Tra                                                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2292, CAST(N'2019-10-09 08:10:41.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateItem&iid=22&ni=10&p=1', N'                                                                                                    ', N'Tran Dieu Linh 2                                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:10:41 AM: admin cập nhật Tran Dieu Linh 2                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2293, CAST(N'2019-10-09 08:23:02.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Accomodation                                                                                                                                                                                                                                                                                                ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:23:02 AM: admin xóa Accomodation (id: 6)                                                                                                                                                                                                                                                        ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2294, CAST(N'2019-10-09 08:23:25.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateCate', N'                                                                                                    ', N'Hotel Cat Ba, Ha Long                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:23:25 AM: admin tạo mới Hotel Cat Ba, Ha Long                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2295, CAST(N'2019-10-09 08:23:35.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateCate', N'                                                                                                    ', N'Hotel Viet Nam                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:23:35 AM: admin tạo mới Hotel Viet Nam                                                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2296, CAST(N'2019-10-09 08:23:41.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Accomodation                                                                                                                                                                                                                                                                                                ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:23:41 AM: admin xóa Accomodation (id: 12)                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2297, CAST(N'2019-10-09 08:30:42.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateItem&iid=18&ni=10&p=1', N'                                                                                                    ', N'Le Viet Anh                                                                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:30:42 AM: admin cập nhật Le Viet Anh                                                                                                                                                                                                                                                            ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2298, CAST(N'2019-10-09 08:30:51.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateItem&iid=17&ni=10&p=1', N'                                                                                                    ', N'Nguyen Duc Viet                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:30:51 AM: admin cập nhật Nguyen Duc Viet                                                                                                                                                                                                                                                        ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2299, CAST(N'2019-10-09 08:30:55.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateItem&iid=19&ni=10&p=1', N'                                                                                                    ', N'Tran Dieu Linh                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:30:55 AM: admin cập nhật Tran Dieu Linh                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2300, CAST(N'2019-10-09 08:30:59.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateItem&iid=20&ni=10&p=1', N'                                                                                                    ', N'Nguyen Duc Viet 2                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:30:59 AM: admin cập nhật Nguyen Duc Viet 2                                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2301, CAST(N'2019-10-09 08:31:04.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateItem&iid=20&ni=10&p=1', N'                                                                                                    ', N'Nguyen Duc Viet 2                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:31:04 AM: admin cập nhật Nguyen Duc Viet 2                                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2302, CAST(N'2019-10-09 08:31:07.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateItem&iid=21&ni=10&p=1', N'                                                                                                    ', N'Le Viet Anh 2                                                                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:31:07 AM: admin cập nhật Le Viet Anh 2                                                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2303, CAST(N'2019-10-09 08:31:11.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=UpdateItem&iid=22&ni=10&p=1', N'                                                                                                    ', N'Tran Dieu Linh 2                                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:31:11 AM: admin cập nhật Tran Dieu Linh 2                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2304, CAST(N'2019-10-09 08:48:20.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateCate', N'                                                                                                    ', N'Tầm nhìn sứ mệnh                                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:48:20 AM: admin tạo mới Tầm nhìn sứ mệnh                                                                                                                                                                                                                                                        ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2305, CAST(N'2019-10-09 08:48:26.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateCate', N'                                                                                                    ', N'Sơ đồ tổ chức                                                                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:48:26 AM: admin tạo mới Sơ đồ tổ chức                                                                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2306, CAST(N'2019-10-09 08:48:38.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateCate', N'                                                                                                    ', N'Giá trị cốt lõi                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:48:38 AM: admin tạo mới Giá trị cốt lõi                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2307, CAST(N'2019-10-09 08:48:49.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateCate', N'                                                                                                    ', N'Đối tác - Khách hàng                                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:48:49 AM: admin tạo mới Đối tác - Khách hàng                                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2308, CAST(N'2019-10-09 08:48:53.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=AboutUs&suc=CreateCate', N'                                                                                                    ', N'Tuyển dụng                                                                                                                                                                                                                                                                                                  ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:48:53 AM: admin tạo mới Tuyển dụng                                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2309, CAST(N'2019-10-09 08:49:46.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Viet - Muong Ethnic Group                                                                                                                                                                                                                                                                                   ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:49:46 AM: admin tạo mới Viet - Muong Ethnic Group                                                                                                                                                                                                                                               ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2310, CAST(N'2019-10-09 08:49:59.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Tay - Thai Ethnic Group                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:49:59 AM: admin tạo mới Tay - Thai Ethnic Group                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2311, CAST(N'2019-10-09 08:50:10.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Mon - Khmer Ethnic Group                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:50:10 AM: admin tạo mới Mon - Khmer Ethnic Group                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2312, CAST(N'2019-10-09 08:50:21.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Mong - Dao Ethnic Group                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:50:21 AM: admin tạo mới Mong - Dao Ethnic Group                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2313, CAST(N'2019-10-09 08:50:35.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Tibeto - Burman Ethnic Group                                                                                                                                                                                                                                                                                ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:50:35 AM: admin tạo mới Tibeto - Burman Ethnic Group                                                                                                                                                                                                                                            ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2314, CAST(N'2019-10-09 08:50:47.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Kadai - Co Lao Ethnic Group                                                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:50:47 AM: admin tạo mới Kadai - Co Lao Ethnic Group                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2315, CAST(N'2019-10-09 08:50:57.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Han - Hoa Ethnic Group                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:50:57 AM: admin tạo mới Han - Hoa Ethnic Group                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2316, CAST(N'2019-10-09 08:51:12.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Malayo - Polynesian Ethnic                                                                                                                                                                                                                                                                                  ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:51:12 AM: admin tạo mới Malayo - Polynesian Ethnic                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2317, CAST(N'2019-10-09 08:51:22.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Travel Blog                                                                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:51:22 AM: admin tạo mới Travel Blog                                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2318, CAST(N'2019-10-09 08:51:35.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Vietnam Travel Guides                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:51:35 AM: admin tạo mới Vietnam Travel Guides                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2319, CAST(N'2019-10-09 08:51:59.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Vietnam Itinerary Ideas                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:51:59 AM: admin tạo mới Vietnam Itinerary Ideas                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2320, CAST(N'2019-10-09 08:52:10.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Weather and Season in Vietnam                                                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:52:10 AM: admin tạo mới Weather and Season in Vietnam                                                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2321, CAST(N'2019-10-09 08:52:19.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Mai Chau Tours                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:52:19 AM: admin tạo mới Mai Chau Tours                                                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2322, CAST(N'2019-10-09 08:52:26.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateCate', N'                                                                                                    ', N'Chau Doc Tours                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:52:26 AM: admin tạo mới Chau Doc Tours                                                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2323, CAST(N'2019-10-09 08:52:50.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Transport Services                                                                                                                                                                                                                                                                                          ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:52:50 AM: admin xóa Transport Services (id: 5)                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2324, CAST(N'2019-10-09 08:53:10.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateCate', N'                                                                                                    ', N'Đăng ký thuê xe                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:53:10 AM: admin tạo mới Đăng ký thuê xe                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2325, CAST(N'2019-10-09 08:53:16.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateCate', N'                                                                                                    ', N'Làm visa                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:53:16 AM: admin tạo mới Làm visa                                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2326, CAST(N'2019-10-09 08:53:25.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateCate', N'                                                                                                    ', N'Đặt vé máy bay                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:53:25 AM: admin tạo mới Đặt vé máy bay                                                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2327, CAST(N'2019-10-09 08:53:30.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateCate', N'                                                                                                    ', N'Đặt phòng khách sạn                                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:53:30 AM: admin tạo mới Đặt phòng khách sạn                                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2328, CAST(N'2019-10-09 09:41:22.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 9:41:22 AM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2329, CAST(N'2019-10-09 09:41:26.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 9:41:26 AM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2330, CAST(N'2019-10-09 09:58:30.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=optimize', N'                                                                                                    ', N'Thông tin tối ưu website                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 9:58:30 AM: admin cập nhật thông tin hệ thống (Thông tin tối ưu website)                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2331, CAST(N'2019-10-09 09:59:33.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateCate', N'                                                                                                    ', N'Transport Services                                                                                                                                                                                                                                                                                          ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 9:59:33 AM: admin tạo mới Transport Services                                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2332, CAST(N'2019-10-09 09:59:41.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Đăng ký thuê xe                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 9:59:41 AM: admin xóa Đăng ký thuê xe (id: 40)                                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2333, CAST(N'2019-10-09 09:59:43.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Làm visa                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 9:59:43 AM: admin xóa Làm visa (id: 41)                                                                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2334, CAST(N'2019-10-09 09:59:45.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Đặt vé máy bay                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 9:59:45 AM: admin xóa Đặt vé máy bay (id: 42)                                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2335, CAST(N'2019-10-09 09:59:46.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Đặt phòng khách sạn                                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 9:59:46 AM: admin xóa Đặt phòng khách sạn (id: 43)                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2336, CAST(N'2019-10-09 10:00:54.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateItem&igid=', N'                                                                                                    ', N'Car rental                                                                                                                                                                                                                                                                                                  ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:00:54 AM: admin tạo mới Car rental                                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2337, CAST(N'2019-10-09 10:01:26.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateItem&igid=', N'                                                                                                    ', N'Air ticket                                                                                                                                                                                                                                                                                                  ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:01:26 AM: admin tạo mới Air ticket                                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2338, CAST(N'2019-10-09 10:01:40.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateItem&igid=', N'                                                                                                    ', N'Book Hotel                                                                                                                                                                                                                                                                                                  ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:01:40 AM: admin tạo mới Book Hotel                                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2339, CAST(N'2019-10-09 10:02:06.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateItem&igid=', N'                                                                                                    ', N'Da Nang Airport to Hoi An - Hue                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:02:06 AM: admin tạo mới Da Nang Airport to Hoi An - Hue                                                                                                                                                                                                                                        ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (2340, CAST(N'2019-10-09 10:02:12.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=UpdateItem&iid=23&ni=10&p=1', N'                                                                                                    ', N'Car rental                                                                                                                                                                                                                                                                                                  ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:02:12 AM: admin cập nhật Car rental                                                                                                                                                                                                                                                            ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3326, CAST(N'2019-10-09 10:58:31.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=email', N'                                                                                                    ', N'PropertyMailWebsite                                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:58:31 AM: admin cập nhật thông tin hệ thống (PropertyMailWebsite)                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3327, CAST(N'2019-10-09 10:58:50.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:58:50 AM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3328, CAST(N'2019-10-09 11:16:13.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Items/DeleteItem.aspx', N'                                                                                                    ', N'Da Nang Airport to Hoi An - Hue                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:16:13 AM: admin xóa Da Nang Airport to Hoi An - Hue (id: 1023)                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3329, CAST(N'2019-10-09 11:16:31.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=S&suc=CreateItem&igid=', N'                                                                                                    ', N'c                                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:16:31 AM: admin tạo mới c                                                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3330, CAST(N'2019-10-09 11:16:35.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Items/DeleteItem.aspx', N'                                                                                                    ', N'c                                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:16:35 AM: admin xóa c (id: 1024)                                                                                                                                                                                                                                                               ', N'')
GO
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3331, CAST(N'2019-10-09 11:54:34.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateCate', N'                                                                                                    ', N'Nhóm giới thiệu trang chủ                                                                                                                                                                                                                                                                                   ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:54:34 AM: admin tạo mới Nhóm giới thiệu trang chủ                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3332, CAST(N'2019-10-09 11:55:14.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=UpdateCate&igid=1042', N'                                                                                                    ', N'About us                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:55:14 AM: admin cập nhật About us                                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3333, CAST(N'2019-10-09 11:55:54.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem', N'                                                                                                    ', N'General introduction                                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:55:54 AM: admin tạo mới General introduction                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3334, CAST(N'2019-10-09 11:55:55.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem', N'                                                                                                    ', N'General introduction                                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:55:55 AM: admin tạo mới General introduction                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3335, CAST(N'2019-10-09 11:56:13.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem', N'                                                                                                    ', N'Experience when traveling                                                                                                                                                                                                                                                                                   ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:56:13 AM: admin tạo mới Experience when traveling                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3336, CAST(N'2019-10-09 11:56:24.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem', N'                                                                                                    ', N'Our responsibility                                                                                                                                                                                                                                                                                          ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:56:24 AM: admin tạo mới Our responsibility                                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3337, CAST(N'2019-10-09 11:56:36.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem', N'                                                                                                    ', N'Services we provide                                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:56:36 AM: admin tạo mới Services we provide                                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3338, CAST(N'2019-10-09 11:56:50.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem', N'                                                                                                    ', N'Contact us when you need it                                                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:56:50 AM: admin tạo mới Contact us when you need it                                                                                                                                                                                                                                            ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3339, CAST(N'2019-10-09 11:57:04.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem', N'                                                                                                    ', N'Always quality assurance for customers                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:57:04 AM: admin tạo mới Always quality assurance for customers                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3340, CAST(N'2019-10-09 11:57:05.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=ADV&suc=CreateItem', N'                                                                                                    ', N'Always quality assurance for customers                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 11:57:05 AM: admin tạo mới Always quality assurance for customers                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3341, CAST(N'2019-10-09 12:10:20.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=CustomerReviews&suc=CreateGroupItem', N'                                                                                                    ', N'CUSTOMER COMMENTS                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 12:10:20 PM: admin tạo mới CUSTOMER COMMENTS                                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3342, CAST(N'2019-10-09 14:02:43.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem', N'                                                                                                    ', N'Oriana Villa Đà Lạt 103- Phòng 2 Người                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:02:43 PM: admin tạo mới Oriana Villa Đà Lạt 103- Phòng 2 Người                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3343, CAST(N'2019-10-09 14:19:32.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:19:32 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3344, CAST(N'2019-10-09 14:19:59.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 2                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:19:59 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 2                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3345, CAST(N'2019-10-09 14:20:18.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 3                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:20:18 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 3                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3346, CAST(N'2019-10-09 14:20:33.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 4                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:20:33 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 4                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3347, CAST(N'2019-10-09 14:20:50.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 5                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:20:50 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 5                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3348, CAST(N'2019-10-09 14:21:35.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 6                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:21:35 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 6                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3349, CAST(N'2019-10-09 14:22:12.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Oriana Villa Đà Lạt 103 - Phòng 2 người                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:22:12 PM: admin tạo mới Oriana Villa Đà Lạt 103 - Phòng 2 người                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3350, CAST(N'2019-10-09 14:22:22.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 7                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:22:22 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 7                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3351, CAST(N'2019-10-09 14:22:35.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 8                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:22:35 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 8                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3352, CAST(N'2019-10-09 14:22:45.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 9                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:22:45 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 9                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3353, CAST(N'2019-10-09 14:22:56.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 10                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:22:56 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 10                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3354, CAST(N'2019-10-09 14:23:05.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 11                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:23:05 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 11                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3355, CAST(N'2019-10-09 14:23:15.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateItem&igid=', N'                                                                                                    ', N'Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 12                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:23:15 PM: admin tạo mới Traveling Cam Ranh - Binh Ba Island on the occasion of 30/4 12                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3356, CAST(N'2019-10-09 14:26:56.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=18', N'                                                                                                    ', N'Hotel Cat Ba, Ha Long                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:26:56 PM: admin cập nhật Hotel Cat Ba, Ha Long                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3357, CAST(N'2019-10-09 14:27:02.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=19', N'                                                                                                    ', N'Hotel Viet Nam                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 2:27:02 PM: admin cập nhật Hotel Viet Nam                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3358, CAST(N'2019-10-09 15:09:15.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel', N'                                                                                                    ', N'admin                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 3:09:15 PM: admin đăng xuất khỏi hệ thống quản trị                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3359, CAST(N'2019-10-09 15:09:18.000' AS DateTime), N'http://localhost:57803/login.aspx', N'                                                                                                    ', N'admin                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 3:09:18 PM: admin đăng nhập vào hệ thống quản trị                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3360, CAST(N'2019-10-09 17:27:32.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Items/UpdateEnableItem.aspx', N'                                                                                                    ', N'Đơn đặt phòng                                                                                                                                                                                                                                                                                               ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 5:27:32 PM: admin thay đổi trạng thái Đơn đặt phòng (id: 1052)                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3361, CAST(N'2019-10-09 17:40:43.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=18', N'                                                                                                    ', N'Hotel Cat Ba, Ha Long                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 5:40:43 PM: admin cập nhật Hotel Cat Ba, Ha Long                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3362, CAST(N'2019-10-09 17:40:58.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=19', N'                                                                                                    ', N'Hotel Viet Nam                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 5:40:58 PM: admin cập nhật Hotel Viet Nam                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3363, CAST(N'2019-10-09 17:46:20.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 5:46:20 PM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3364, CAST(N'2019-10-09 17:54:24.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 5:54:24 PM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3365, CAST(N'2019-10-09 17:54:25.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Systemwebsite&suc=information', N'                                                                                                    ', N'Thông tin chung                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 5:54:25 PM: admin cập nhật thông tin hệ thống (Thông tin chung)                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3366, CAST(N'2019-10-09 18:04:27.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateCate', N'                                                                                                    ', N'Villa                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:04:27 PM: admin tạo mới Villa                                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3367, CAST(N'2019-10-09 18:04:37.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateCate', N'                                                                                                    ', N'Homestay                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:04:37 PM: admin tạo mới Homestay                                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3368, CAST(N'2019-10-09 18:04:49.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateCate', N'                                                                                                    ', N'Campground                                                                                                                                                                                                                                                                                                  ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:04:49 PM: admin tạo mới Campground                                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3369, CAST(N'2019-10-09 18:05:29.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=19', N'                                                                                                    ', N'Hotel Viet Nam                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:05:29 PM: admin cập nhật Hotel Viet Nam                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3370, CAST(N'2019-10-09 18:06:00.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=1046', N'                                                                                                    ', N'Campground                                                                                                                                                                                                                                                                                                  ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:06:00 PM: admin cập nhật Campground                                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3371, CAST(N'2019-10-09 18:06:05.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=1045', N'                                                                                                    ', N'Homestay                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:06:05 PM: admin cập nhật Homestay                                                                                                                                                                                                                                                               ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3372, CAST(N'2019-10-09 18:06:09.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=18', N'                                                                                                    ', N'Hotel Cat Ba, Ha Long                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:06:09 PM: admin cập nhật Hotel Cat Ba, Ha Long                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3373, CAST(N'2019-10-09 18:06:13.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=19', N'                                                                                                    ', N'Hotel Viet Nam                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:06:13 PM: admin cập nhật Hotel Viet Nam                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3374, CAST(N'2019-10-09 18:06:17.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateCate&igid=1044', N'                                                                                                    ', N'Villa                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:06:17 PM: admin cập nhật Villa                                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3375, CAST(N'2019-10-09 18:09:05.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateGroupItem', N'                                                                                                    ', N'Hotel                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:09:05 PM: admin tạo mới Hotel                                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3376, CAST(N'2019-10-09 18:09:16.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateGroupItem', N'                                                                                                    ', N'Villa                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:09:16 PM: admin tạo mới Villa                                                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3377, CAST(N'2019-10-09 18:09:25.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateGroupItem', N'                                                                                                    ', N'Homestay                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:09:25 PM: admin tạo mới Homestay                                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3378, CAST(N'2019-10-09 18:09:44.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=CreateGroupItem', N'                                                                                                    ', N'Campgrounds                                                                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:09:44 PM: admin tạo mới Campgrounds                                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3379, CAST(N'2019-10-09 18:32:08.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateGroupItem&igid=1049', N'                                                                                                    ', N'Homestay                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:32:08 PM: admin cập nhật Homestay                                                                                                                                                                                                                                                               ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3380, CAST(N'2019-10-09 18:34:55.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateVehicle', N'                                                                                                    ', N'TEST PHUONG TIEN                                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:34:55 PM: admin tạo mới TEST PHUONG TIEN                                                                                                                                                                                                                                                        ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3381, CAST(N'2019-10-09 18:35:16.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateService', N'                                                                                                    ', N'TEST DICH VU                                                                                                                                                                                                                                                                                                ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:35:16 PM: admin tạo mới TEST DICH VU                                                                                                                                                                                                                                                            ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3382, CAST(N'2019-10-09 18:36:38.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateService', N'                                                                                                    ', N'TEST DICH VU CON                                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:36:38 PM: admin tạo mới TEST DICH VU CON                                                                                                                                                                                                                                                        ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3383, CAST(N'2019-10-09 18:42:10.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'TEST THUOC TINH                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:42:10 PM: admin tạo mới TEST THUOC TINH                                                                                                                                                                                                                                                         ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3384, CAST(N'2019-10-09 18:42:18.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'TEST THUOC TINH CON                                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:42:18 PM: admin tạo mới TEST THUOC TINH CON                                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3385, CAST(N'2019-10-09 18:42:34.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'TEST THUOC TINH 2                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:42:34 PM: admin tạo mới TEST THUOC TINH 2                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3386, CAST(N'2019-10-09 18:43:03.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'TEST THUOC TINH 3                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:43:03 PM: admin tạo mới TEST THUOC TINH 3                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3387, CAST(N'2019-10-09 18:43:10.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'TEST THUOC TINH 4                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:43:10 PM: admin tạo mới TEST THUOC TINH 4                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3388, CAST(N'2019-10-09 18:43:16.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'TEST THUOC TINH 5                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 6:43:16 PM: admin tạo mới TEST THUOC TINH 5                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3389, CAST(N'2019-10-09 20:15:08.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateVehicle', N'                                                                                                    ', N'3 ngày 2 đêm                                                                                                                                                                                                                                                                                                ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:15:08 PM: admin tạo mới 3 ngày 2 đêm                                                                                                                                                                                                                                                            ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3390, CAST(N'2019-10-09 20:15:16.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'TEST PHUONG TIEN                                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:15:16 PM: admin xóa TEST PHUONG TIEN (id: 1051)                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3391, CAST(N'2019-10-09 20:17:48.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateVehicle', N'                                                                                                    ', N'1 ngày                                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:17:48 PM: admin tạo mới 1 ngày                                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3392, CAST(N'2019-10-09 20:17:56.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateVehicle', N'                                                                                                    ', N'7 ngày                                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:17:56 PM: admin tạo mới 7 ngày                                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3393, CAST(N'2019-10-09 20:18:14.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteListGroups.aspx', N'                                                                                                    ', N'TEST THUOC TINH                                                                                                                                                                                                                                                                                             ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:18:14 PM: admin xóa TEST THUOC TINH (id: 1054)                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3394, CAST(N'2019-10-09 20:18:14.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteListGroups.aspx', N'                                                                                                    ', N'TEST THUOC TINH CON                                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:18:14 PM: admin xóa TEST THUOC TINH CON (id: 1055)                                                                                                                                                                                                                                              ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3395, CAST(N'2019-10-09 20:18:14.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteListGroups.aspx', N'                                                                                                    ', N'TEST THUOC TINH 2                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:18:14 PM: admin xóa TEST THUOC TINH 2 (id: 1056)                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3396, CAST(N'2019-10-09 20:18:14.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteListGroups.aspx', N'                                                                                                    ', N'TEST THUOC TINH 3                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:18:14 PM: admin xóa TEST THUOC TINH 3 (id: 1057)                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3397, CAST(N'2019-10-09 20:18:14.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteListGroups.aspx', N'                                                                                                    ', N'TEST THUOC TINH 4                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:18:14 PM: admin xóa TEST THUOC TINH 4 (id: 1058)                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3398, CAST(N'2019-10-09 20:18:14.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteListGroups.aspx', N'                                                                                                    ', N'TEST THUOC TINH 5                                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:18:14 PM: admin xóa TEST THUOC TINH 5 (id: 1059)                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3399, CAST(N'2019-10-09 20:21:55.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'Hà Nội                                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:21:55 PM: admin tạo mới Hà Nội                                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3400, CAST(N'2019-10-09 20:22:12.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'Hà Nội                                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:22:12 PM: admin tạo mới Hà Nội                                                                                                                                                                                                                                                                  ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3401, CAST(N'2019-10-09 20:23:17.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'Đà Nẵng                                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:23:17 PM: admin tạo mới Đà Nẵng                                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3402, CAST(N'2019-10-09 20:23:39.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateProperty', N'                                                                                                    ', N'Đà Nẵng                                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:23:39 PM: admin tạo mới Đà Nẵng                                                                                                                                                                                                                                                                 ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3403, CAST(N'2019-10-09 20:23:47.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Hà Nội                                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:23:47 PM: admin xóa Hà Nội (id: 1064)                                                                                                                                                                                                                                                           ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3404, CAST(N'2019-10-09 20:23:49.000' AS DateTime), N'http://localhost:57803/cms/admin/Ajax/Groups/DeleteGroup.aspx', N'                                                                                                    ', N'Đà Nẵng                                                                                                                                                                                                                                                                                                     ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:23:49 PM: admin xóa Đà Nẵng (id: 1066)                                                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3405, CAST(N'2019-10-09 20:30:52.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem&igid=', N'                                                                                                    ', N'1 day boat trip with Captain Jack                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:30:52 PM: admin tạo mới 1 day boat trip with Captain Jack                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3406, CAST(N'2019-10-09 20:31:35.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateItem&iid=1054&ni=10&p=1', N'                                                                                                    ', N'1 day boat trip with Captain Jack                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 8:31:35 PM: admin cập nhật 1 day boat trip with Captain Jack                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3407, CAST(N'2019-10-09 22:39:07.000' AS DateTime), N'http://localhost:57803/login.aspx', N'                                                                                                    ', N'admin                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:39:07 PM: admin đăng nhập vào hệ thống quản trị                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3408, CAST(N'2019-10-09 22:41:58.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 2                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:41:58 PM: admin tạo mới 1 day boat trip with Captain Jack 2                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3409, CAST(N'2019-10-09 22:42:14.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 3                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:42:14 PM: admin tạo mới 1 day boat trip with Captain Jack 3                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3410, CAST(N'2019-10-09 22:42:22.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 4                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:42:22 PM: admin tạo mới 1 day boat trip with Captain Jack 4                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3411, CAST(N'2019-10-09 22:42:30.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 5                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:42:30 PM: admin tạo mới 1 day boat trip with Captain Jack 5                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3412, CAST(N'2019-10-09 22:42:40.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 6                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:42:40 PM: admin tạo mới 1 day boat trip with Captain Jack 6                                                                                                                                                                                                                                    ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3413, CAST(N'2019-10-09 22:42:59.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 11                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:42:59 PM: admin tạo mới 1 day boat trip with Captain Jack 11                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3414, CAST(N'2019-10-09 22:43:07.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 12                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:43:07 PM: admin tạo mới 1 day boat trip with Captain Jack 12                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3415, CAST(N'2019-10-09 22:43:15.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 13                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:43:15 PM: admin tạo mới 1 day boat trip with Captain Jack 13                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3416, CAST(N'2019-10-09 22:43:25.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 14                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:43:25 PM: admin tạo mới 1 day boat trip with Captain Jack 14                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3417, CAST(N'2019-10-09 22:43:33.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 15                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:43:33 PM: admin tạo mới 1 day boat trip with Captain Jack 15                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3418, CAST(N'2019-10-09 22:43:41.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateItem', N'                                                                                                    ', N'1 day boat trip with Captain Jack 16                                                                                                                                                                                                                                                                        ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:43:41 PM: admin tạo mới 1 day boat trip with Captain Jack 16                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3419, CAST(N'2019-10-09 22:44:01.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateItem&iid=1054&ni=10&p=1', N'                                                                                                    ', N'1 day boat trip with Captain Jack                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:44:01 PM: admin cập nhật 1 day boat trip with Captain Jack                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3420, CAST(N'2019-10-09 22:48:42.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateCate&igid=3', N'                                                                                                    ', N'Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:48:42 PM: admin cập nhật Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                      ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3421, CAST(N'2019-10-09 22:48:59.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateCate&igid=4', N'                                                                                                    ', N'Viet nam tours                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/9/2019 10:48:59 PM: admin cập nhật Viet nam tours                                                                                                                                                                                                                                                        ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3422, CAST(N'2019-10-10 07:55:05.000' AS DateTime), N'http://localhost:57803/login.aspx', N'                                                                                                    ', N'admin                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 7:55:05 AM: admin đăng nhập vào hệ thống quản trị                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3423, CAST(N'2019-10-10 07:56:15.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateItem&iid=1054&ni=10&p=1', N'                                                                                                    ', N'1 day boat trip with Captain Jack                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 7:56:15 AM: admin cập nhật 1 day boat trip with Captain Jack                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3424, CAST(N'2019-10-10 07:56:24.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateItem&iid=1055&ni=10&p=1', N'                                                                                                    ', N'1 day boat trip with Captain Jack 2                                                                                                                                                                                                                                                                         ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 7:56:24 AM: admin cập nhật 1 day boat trip with Captain Jack 2                                                                                                                                                                                                                                   ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3425, CAST(N'2019-10-10 08:09:49.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateItem&iid=1054&ni=10&p=1', N'                                                                                                    ', N'1 day boat trip with Captain Jack                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 8:09:49 AM: admin cập nhật 1 day boat trip with Captain Jack                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3426, CAST(N'2019-10-10 08:33:56.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateItem&iid=1054&ni=10&p=1', N'                                                                                                    ', N'1 day boat trip with Captain Jack                                                                                                                                                                                                                                                                           ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 8:33:56 AM: admin cập nhật 1 day boat trip with Captain Jack                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3427, CAST(N'2019-10-10 11:42:22.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateGroupItem', N'                                                                                                    ', N'Nhóm 1                                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 11:42:22 AM: admin tạo mới Nhóm 1                                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3428, CAST(N'2019-10-10 11:42:28.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=CreateGroupItem', N'                                                                                                    ', N'Nhóm 2                                                                                                                                                                                                                                                                                                      ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 11:42:28 AM: admin tạo mới Nhóm 2                                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3429, CAST(N'2019-10-10 11:43:57.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateGroupItem&igid=1067', N'                                                                                                    ', N'Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 11:43:57 AM: admin cập nhật Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3430, CAST(N'2019-10-10 11:44:02.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateGroupItem&igid=1068', N'                                                                                                    ', N'Viet nam tours                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 11:44:02 AM: admin cập nhật Viet nam tours                                                                                                                                                                                                                                                       ', N'')
GO
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3431, CAST(N'2019-10-10 11:45:19.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateGroupItem&igid=1047', N'                                                                                                    ', N'Hotel                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 11:45:19 AM: admin cập nhật Hotel                                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3432, CAST(N'2019-10-10 11:45:36.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateGroupItem&igid=1048', N'                                                                                                    ', N'Villa                                                                                                                                                                                                                                                                                                       ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 11:45:36 AM: admin cập nhật Villa                                                                                                                                                                                                                                                                ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3433, CAST(N'2019-10-10 11:45:38.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateGroupItem&igid=1049', N'                                                                                                    ', N'Homestay                                                                                                                                                                                                                                                                                                    ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 11:45:38 AM: admin cập nhật Homestay                                                                                                                                                                                                                                                             ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3434, CAST(N'2019-10-10 11:45:40.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Hotel&suc=UpdateGroupItem&igid=1050', N'                                                                                                    ', N'Campgrounds                                                                                                                                                                                                                                                                                                 ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 11:45:40 AM: admin cập nhật Campgrounds                                                                                                                                                                                                                                                          ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3435, CAST(N'2019-10-10 12:50:06.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateGroupItem&igid=1067', N'                                                                                                    ', N'Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 12:50:06 PM: admin cập nhật Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3436, CAST(N'2019-10-10 12:50:17.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateGroupItem&igid=1068', N'                                                                                                    ', N'Viet nam tours                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 12:50:17 PM: admin cập nhật Viet nam tours                                                                                                                                                                                                                                                       ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3437, CAST(N'2019-10-10 12:50:29.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateGroupItem&igid=1067', N'                                                                                                    ', N'Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                                                            ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 12:50:29 PM: admin cập nhật Cat Ba Island, Ha Long Bay Tours                                                                                                                                                                                                                                     ', N'')
INSERT [dbo].[Logs] ([ilId], [dlCreateDate], [vlUrl], [vlIP], [vlInfo], [vlAuthor], [vlType], [vlDesc], [web]) VALUES (3438, CAST(N'2019-10-10 12:50:34.000' AS DateTime), N'http://localhost:57803/admin.aspx?uc=Tour&suc=UpdateGroupItem&igid=1068', N'                                                                                                    ', N'Viet nam tours                                                                                                                                                                                                                                                                                              ', N'admin                                                                                               ', N'                                                                                                    ', N'10/10/2019 12:50:34 PM: admin cập nhật Viet nam tours                                                                                                                                                                                                                                                       ', N'')
SET IDENTITY_INSERT [dbo].[Logs] OFF
SET IDENTITY_INSERT [dbo].[Members] ON 

INSERT [dbo].[Members] ([IMID], [vProperty], [vMemberAccount], [vMemberPassword], [vMemberName], [vMemberAddress], [vMemberPhone], [vMemberEmail], [dMemberBirthday], [vMemberIdentityCard], [vMemberRelationship], [vMemberEdu], [vMemberJob], [vMemberYahooNick], [vMemberImage], [vMemberPasswordQuestion], [vMemberPasswordAnswer], [iMemberIsApproved], [iMemberIsLockedOut], [dMemberCreatedate], [dMemberLastLoginDate], [dMemberLastChangePasswordDate], [dMemberLastLogOutDate], [vMemberComment], [iMemberTotalLogin], [iMemberTotalview], [vMemberWeight], [vMemberHeight], [vMemberBlast], [web]) VALUES (1, N'MemberNewsletter', N'hung@gmail.com', N'7e7424f8fece989090808e9e040b2b0008f8d9d8c81d1d4d', N'', N'', N'', N'hung@gmail.com', CAST(N'2019-10-09 09:50:54.000' AS DateTime), N'', N'', N'', N'', N'', N'', N'', N'', 1, 0, CAST(N'2019-10-09 09:50:54.000' AS DateTime), CAST(N'2019-10-09 09:50:54.000' AS DateTime), CAST(N'2019-10-09 09:50:54.000' AS DateTime), CAST(N'2019-10-09 09:50:54.000' AS DateTime), N'', 0, 0, N'', N'', N'', N'')
SET IDENTITY_INSERT [dbo].[Members] OFF
SET IDENTITY_INSERT [dbo].[Roles] ON 

INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription], [RoleLevel], [web]) VALUES (11, N'', N',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,', 0, N'')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription], [RoleLevel], [web]) VALUES (19, N'', N',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,', 0, N'')
INSERT [dbo].[Roles] ([RoleId], [RoleName], [RoleDescription], [RoleLevel], [web]) VALUES (20, N'', N',1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,', 0, N'')
SET IDENTITY_INSERT [dbo].[Roles] OFF
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'00d0d0a78e860ff9dc710ff9d9b20bb8', N'cms/admin/Moduls/QA/Index.ascx', N'->cms/admin/Moduls/QA/Index.ascx->cms/admin/Moduls/QA/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'00efc793200d7143e9c83b6569bd4d69', N'cms/admin/Moduls/Tour/Index.ascx', N'->cms/admin/Moduls/Tour/Index.ascx->cms/admin/Moduls/Tour/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'01e9190c871d6b57d247952720a76749', N'cms/admin/Moduls/Deal/Index.ascx', N'->cms/admin/moduls/deal/index.ascx->cms/admin/moduls/deal/item/subcontrol/subcontrolcomment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'033c169c39665f9141f1ad48ab8e8514', N'cms/admin/Moduls/Video/Index.ascx', N'->cms/admin/moduls/video/index.ascx->cms/admin/moduls/video/item/subcontrol/subcontrolcomment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'0d09e9888f1f3534d47276f69793b30900e0323f6fbaba5a', N'cms/admin/Moduls/PhotoAlbum/Index.ascx', N'->cms/admin/Moduls/PhotoAlbum/Index.ascx->cms/admin/Moduls/PhotoAlbum/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'10540acca9f44d84b30b981146a315ff', N'cms/admin/Moduls/Tour/Index.ascx', N'->cms/admin/Moduls/Tour/Index.ascx->cms/admin/Moduls/Tour/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'121e1e2128e80f0282bab141717898fbf7d7e2e0102f2e7e', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'121e1e2128e80f0282bab141717898fbf7d7e2e0102f2e7e', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlItemHostest.ascx->1', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'181fbf494fff8a8757c5c9599f9a2aa7a7e73b34c4000e2e', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'181fbf494fff8a8757c5c9599f9a2aa7a7e73b34c4000e2e', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlComment.ascx->0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'1d1efe4349491518f8aba7379892b28181f1e2ed1dd7de0e', N'cms/admin/Moduls/New/Index.ascx', N'->cms/admin/Moduls/New/Index.ascx->cms/admin/Moduls/New/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'35df7140dc1290715994029d0cd6fdbc', N'cms/admin/Moduls/Deal/Index.ascx', N'->cms/admin/moduls/deal/index.ascx->cms/admin/moduls/deal/item/subcontrol/subcontrolitemhostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'3b5512d6e9c8df500ea4a7d730723271', N'cms/admin/Moduls/Product/Index.ascx', N'->cms/admin/moduls/product/index.ascx->cms/admin/moduls/product/item/subcontrol/subcontrolcomment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'47fa8bd772c0ed7734ce5fee07cffce2', N'cms/admin/Moduls/FileLibrary/Index.ascx', N'->cms/admin/moduls/filelibrary/index.ascx->cms/admin/moduls/filelibrary/item/subcontrol/subcontrolitemhostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'4a4692c03751cf7c2909ac6a6e409488', N'cms/admin/Moduls/QA/Index.ascx', N'->cms/admin/Moduls/QA/Index.ascx->cms/admin/Moduls/QA/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'4f242977d2c7d365bb1e0a92f45d57e8', N'cms/admin/Moduls/Hotel/Index.ascx', N'->cms/admin/moduls/hotel/index.ascx->cms/admin/moduls/hotel/item/subcontrol/subcontrolitemlastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'5151444180a389193dc069608ec12385', N'cms/admin/Moduls/Product/Index.ascx', N'->cms/admin/moduls/product/index.ascx->cms/admin/moduls/product/item/subcontrol/subcontrolitemhostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'570a27035fc1fbd29e96f77e749161dd', N'cms/admin/Moduls/Video/Index.ascx', N'->cms/admin/moduls/video/index.ascx->cms/admin/moduls/video/item/subcontrol/subcontrolitemhostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'5a4affe583c64233a94896f4c6a0aa8d', N'cms/admin/Moduls/Tour/Index.ascx', N'->cms/admin/Moduls/Tour/Index.ascx->cms/admin/Moduls/Tour/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'5d68bb5a131f5baa1d224d20adb78496', N'cms/admin/Moduls/Blog/Index.ascx', N'->cms/admin/Moduls/Blog/Index.ascx->cms/admin/Moduls/Blog/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'5d714440d91c2bbbcea7670a9068a8eb', N'cms/admin/Moduls/PhotoAlbum/Index.ascx', N'->cms/admin/moduls/photoalbum/index.ascx->cms/admin/moduls/photoalbum/item/subcontrol/subcontrolitemlastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'717323727303d7da7aa4a0e0505dfdc8ce9ed6d1215553b3', N'cms/admin/Moduls/Product/Index.ascx', N'->cms/admin/Moduls/Product/Index.ascx->cms/admin/Moduls/Product/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'7e76163a3b9bf1f5d59d9b7b242494787e4eece020202d0d', N'cms/admin/Moduls/PhotoAlbum/Index.ascx', N'->cms/admin/Moduls/PhotoAlbum/Index.ascx->cms/admin/Moduls/PhotoAlbum/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'858232c1c8e8606696c0c3d3191898a3a808414444515515', N'cms/admin/Moduls/Product/Index.ascx', N'->cms/admin/Moduls/Product/Index.ascx->cms/admin/Moduls/Product/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'8a422ee913bf016498f96965e96a23f0', N'cms/admin/Moduls/Hotel/Index.ascx', N'->cms/admin/moduls/hotel/index.ascx->cms/admin/moduls/hotel/item/subcontrol/subcontrolitemhostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'9581e424b0c96450846e5166cf8c7048', N'cms/admin/Moduls/FileLibrary2/Index.ascx', N'->cms/admin/Moduls/FileLibrary2/Index.ascx->cms/admin/Moduls/FileLibrary2/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'a5baf6320e093b976f724d35f1889e0d', N'cms/admin/Moduls/PhotoAlbum/Index.ascx', N'->cms/admin/moduls/photoalbum/index.ascx->cms/admin/moduls/photoalbum/item/subcontrol/subcontrolcomment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'a639bc1937eb11930a0f7e110c9f9e86', N'cms/admin/Moduls/Customer/Index.ascx', N'->cms/admin/moduls/customer/index.ascx->cms/admin/moduls/customer/item/subcontrol/subcontrolitemhostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'aadde6b2c95ef8ed6931081b90279ca5', N'cms/admin/Moduls/FileLibrary2/Index.ascx', N'->cms/admin/Moduls/FileLibrary2/Index.ascx->cms/admin/Moduls/FileLibrary2/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'b187554c052573bcf4505c30582aa9d9', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'BaiVietTrangLichHoc', N'', N'<div style="text-align: center;">
	<img alt="" src="/pic/service/images/lich-hoc.jpg" /></div>
', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'BaiVietTrangLichHoc', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'c856113269ab2b2b150f977fe33ae9dd', N'cms/admin/Moduls/New/Index.ascx', N'->cms/admin/moduls/new/index.ascx->cms/admin/moduls/new/item/subcontrol/subcontrolitemhostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'c92259f62bba842d787e1469a18e5e5a', N'cms/admin/Moduls/Deal/Index.ascx', N'->cms/admin/moduls/deal/index.ascx->cms/admin/moduls/deal/item/subcontrol/subcontrolitemlastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'cbcb8b141d1d0f0a6a6463f3d2daba0201814b40402c2e4e', N'cms/admin/Moduls/New/Index.ascx', N'->cms/admin/Moduls/New/Index.ascx->cms/admin/Moduls/New/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ce5bc3d440335d87573f8989bbbbb561', N'cms/admin/Moduls/Customer/Index.ascx', N'->cms/admin/moduls/customer/index.ascx->cms/admin/moduls/customer/item/subcontrol/subcontrolcomment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'cfbf3dd57c3791ae4589dad5fda2dade', N'cms/admin/Moduls/Customer/Index.ascx', N'->cms/admin/moduls/customer/index.ascx->cms/admin/moduls/customer/item/subcontrol/subcontrolitemlastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ChoPhepTTATM', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ChoPhepTTATM', N'', N'1', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ChoPhepTTCK', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ChoPhepTTCK', N'', N'1', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'd02002ece4784924b79d5df1b93a617e', N'cms/admin/Moduls/PhotoAlbum/Index.ascx', N'->cms/admin/moduls/photoalbum/index.ascx->cms/admin/moduls/photoalbum/item/subcontrol/subcontrolitemhostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'd6b99133f509d5e8a7b865d1f2ecbb23', N'cms/admin/Moduls/FileLibrary/Index.ascx', N'->cms/admin/moduls/filelibrary/index.ascx->cms/admin/moduls/filelibrary/item/subcontrol/subcontrolcomment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'd8191d4bebdbeed9b9488c271ed425da', N'cms/admin/Moduls/Product/Index.ascx', N'->cms/admin/moduls/product/index.ascx->cms/admin/moduls/product/item/subcontrol/subcontrolitemlastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'd99318540664f15d9f701f95144e7cda', N'cms/admin/Moduls/Blog/Index.ascx', N'->cms/admin/Moduls/Blog/Index.ascx->cms/admin/Moduls/Blog/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'd9da9a2a25853035c5505f4fbcb7372520504c4555878b1b', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'd9da9a2a25853035c5505f4fbcb7372520504c4555878b1b', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlItemLastest.ascx->1', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'dad252d4d1e12728c8484b9bd9deeedbdebe4b41d1191d8d', N'cms/admin/Moduls/Product/Index.ascx', N'->cms/admin/Moduls/Product/Index.ascx->cms/admin/Moduls/Product/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ddde9e3a3e3e7f79790f01512b22b2aba696323111565c8c', N'cms/admin/Moduls/New/Index.ascx', N'->cms/admin/Moduls/New/Index.ascx->cms/admin/Moduls/New/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'e0d7d1e21f812b9873ab8f159443ef1d', N'cms/admin/Moduls/New/Index.ascx', N'->cms/admin/moduls/new/index.ascx->cms/admin/moduls/new/item/subcontrol/subcontrolitemlastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'e2004c3b7ea7a29f95c5758aff49fb18', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlComment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'e42c044b1802abd23f64a60fd114b8cb', N'cms/admin/Moduls/New/Index.ascx', N'->cms/admin/moduls/new/index.ascx->cms/admin/moduls/new/item/subcontrol/subcontrolcomment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'e4ea721e6f3e410407d6c6b6852c0b49', N'cms/admin/Moduls/Hotel/Index.ascx', N'->cms/admin/moduls/hotel/index.ascx->cms/admin/moduls/hotel/item/subcontrol/subcontrolcomment.ascx->0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'e72f01e27dfb897114ba280f8e21e112', N'cms/admin/Moduls/Service/Index.ascx', N'->cms/admin/Moduls/Service/Index.ascx->cms/admin/Moduls/Service/Item/SubControl/SubControlItemHostest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'e964d97680adaa3795c5c05ebba98b6d', N'cms/admin/Moduls/FileLibrary2/Index.ascx', N'->cms/admin/Moduls/FileLibrary2/Index.ascx->cms/admin/Moduls/FileLibrary2/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ea5fba968089d6710c88b550f8a5de37', N'cms/admin/Moduls/QA/Index.ascx', N'->cms/admin/Moduls/QA/Index.ascx->cms/admin/Moduls/QA/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ebea8a6869090a0676a7acecbbb2b21c1d9d4044447175d5', N'cms/admin/Moduls/PhotoAlbum/Index.ascx', N'->cms/admin/Moduls/PhotoAlbum/Index.ascx->cms/admin/Moduls/PhotoAlbum/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'efbd10f5743ecfbb376a03973cc1db02', N'cms/admin/Moduls/Blog/Index.ascx', N'->cms/admin/Moduls/Blog/Index.ascx->cms/admin/Moduls/Blog/Item/SubControl/SubControlItemLastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'efc51d52a52a5d41715b5994c78a78df', N'cms/admin/Moduls/FileLibrary/Index.ascx', N'->cms/admin/moduls/filelibrary/index.ascx->cms/admin/moduls/filelibrary/item/subcontrol/subcontrolitemlastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'f7910623425a0b4ec8adbe1dbda787a2', N'cms/admin/Moduls/Video/Index.ascx', N'->cms/admin/moduls/video/index.ascx->cms/admin/moduls/video/item/subcontrol/subcontrolitemlastest.ascx->1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyAddressCompanyHeader', N'', N'Amega Travel, Vietnam', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyContactEmail', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyContactEmail', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyContentLibraryHeader', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyCurrency', N'', N'USD', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyCurrency', N'', N'VND', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyDateLibraryHeader', N'', N'23/01/2016', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyLinkFanPageFaceBook', N'', N'https://www.facebook.com/facebook', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyLinkFanPageFaceBook', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyLinkFanPageGPlus', N'', N'Tầng 5, Khán đài B, SVĐ Mỹ Đình', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyLinkFanPageGPlus', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyLinkFanPageTwitter', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyLinkFanPageTwitter', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyNoiDungCuoiTrangDanhSachHotel', N'', N'<p class="text">
	Discuss your trip ideas and inspirations with Goodmorningvietnam Travel experts to tailor an authentic and satisfy Vietnam adventure Most destinations have high and low seasons. By planning in advance and traveling in the low season, you can secure better rates as well as avoiding a high rate of local tourists.</p>
<br />
<p class="text">
	Pay attention to the weather forecast; make sure you don&rsquo;t spend your vacation in stormy season. Prepare sunscreen, hat, umbrella and sunglasses. The hot weather may cause sunburn. Bring some recyclable bags to collect all waste. Remember: &lsquo;Take nothing but photos, leave nothing but footprints&rsquo;. Check with your tour operator about the destinations that you will visit and culture to have a basic understanding, what should bring or not, children policy, etc. If you book your own accommodations, make sure to book a safe and comfortable hotel in the central area that is close to local attractions</p>
', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyNoiDungDauTrangVideo', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyNoiDungTaiTrangDatHang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyThongBaoDatPhongThanhCong', N'', N'<a class="item-title" href="#">Submit successful information</a>
<p class="item-text">
	Thank customers for contacting <span>Ltravel</span><br />
	We will get back to you within 24 hours. If you need direct advice to understand more about product services please call: <span>844-378 22816</span></p>
', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyThongBaoSauDatHang', N'', N'<img class="db ma pb15" src="Css/Common/success.png" />
<p class="fs30 ce80a0a tac pb15">
	Gửi đơn h&agrave;ng th&agrave;nh c&ocirc;ng</p>
<div>
	<p class="tac db lh22 c000 pb10">
		Cảm ơn bạn đ&atilde; quan t&acirc;m v&agrave; li&ecirc;n hệ đến Ha Noi Sport</p>
	<p class="tac db lh22">
		Ch&uacute;ng t&ocirc;i sẽ li&ecirc;n hệ với bạn trong v&ograve;ng 24h. Nếu bạn c&oacute; bất cứ thắc mắc hay c&acirc;u hỏi n&agrave;o vui l&ograve;ng gọi điện để được tư vấn: <span class="cred fSegoeUIBold">04.22.187.222 - 092.587.1166 - 0982357.555</span></p>
</div>
<br />
', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyThongBaoSauDatHangDeal', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyTripAdVisor', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyTripadvisor', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'KeyViewLibraryHeader', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'LogoShareHomepage', N'', N'T1P1-logo636988826633568073.png', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'LogoShareHomepage', N'', N'Layer-0637062404650052615.png', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'luotxemtin', N'', N'267', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'motadautrangtin', N'', N'Vietnam is a developing country and has a potential tourism for the recent years. The number of travelers coming into Vietnam increases dramatically. There are various reasons why tourists determine to travel in Vietnam such as diverse regions, famous beauty spots, many famous beaches, cuisine as well as culture-rich. Vietnam is a developing country and has a potential tourism for the recent years. The number of travelers coming into Vietnam increases dramatically. There are various reasons why tourists determine to travel in Vietnam such as diverse regions, famous beauty spots, many famous beaches, cuisine as well as culture-rich. Vietnam is a developing country and has a potential tourism for the recent years. The number of travelers coming into Vietnam increases dramatically. There are various reasons why tourists determine to travel in Vietnam such as diverse regions, famous beauty spots, many famous beaches, cuisine as well as culture-rich.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'NoiDungCuoiTrangDanhMucSanPham', N'', N'<p>
	Với mong muốn tạo ra một s&acirc;n chơi cộng đồng, để c&aacute;c em nhỏ c&oacute; thể tham gia sau những giờ học căng thẳng v&agrave; thỏa sức thể hiện niềm đam m&ecirc; với tr&aacute;i b&oacute;ng v&agrave; gi&uacute;p c&aacute;c em kh&ocirc;ng chỉ tiếp thu được những kỹ năng b&oacute;ng đ&aacute; m&agrave; c&ograve;n r&egrave;n luyện v&agrave; ph&aacute;t triển những kỹ năng sống quan trọng kh&aacute;c như t&iacute;nh tự gi&aacute;c, tinh thần tập thể, bản lĩnh sống&hellip;B&ecirc;n cạnh những buổi học, ch&uacute;ng t&ocirc;i c&ograve;n thường xuy&ecirc;n tổ chức những buổi thi đấu giao hữu, giao lưu nhằm tăng t&iacute;nh đo&agrave;n kết giữa c&aacute;c học vi&ecirc;n v&agrave; tạo sự gần gũi hơn giữa bố mẹ v&agrave; c&aacute;c con.</p>
<br />
<p>
	Trong tất cả hoạt động của trung t&acirc;m, ch&uacute;ng t&ocirc;i đều hướng đến nhu cầu được vui chơi, giải tr&iacute; của c&aacute;c em. V&igrave; vậy, c&aacute;c b&agrave;i tập thường được thiết kế dưới dạng tr&ograve; chơi vận động, ưu ti&ecirc;n những tr&ograve; chơi với b&oacute;ng để tạo sự thoải m&aacute;i v&agrave; hứng th&uacute; cho c&aacute;c em. Ch&uacute;ng t&ocirc;i lu&ocirc;n tạo cơ hội cho c&aacute;c em tiếp x&uacute;c v&agrave; l&agrave;m quen với b&oacute;ng nhiều nhất c&oacute; thể, hạn chế tối đa việc xếp h&agrave;ng, chờ đợi hoặc thực hiện 1 động t&aacute;c lặp đi lặp lại qu&aacute;n hiều lần. Những tr&ograve; chơi m&agrave; HLV ch&uacute;ng t&ocirc;i đưa ra,vừagi&uacute;p c&aacute;c em thoả m&atilde;n t&acirc;m l&yacute; được chơi, được vận động, vừa gi&uacute;p r&egrave;n luyện những kỹ năng b&oacute;ng đ&aacute; như: dẫn b&oacute;ng, chuyền b&oacute;ng, s&uacute;t b&oacute;ng&hellip;</p>
<br />
<p>
	Mỗi buổi học đều được chuẩn bị kỹ lưỡng với gi&aacute; o &aacute;n cụ thể v&agrave; phương ph&aacute;p tổchức, l&ecirc;n lớp b&agrave;i bản từ khởi động, huấn luyện kỹ thuật, tr&ograve; chơi bổt rợ, thi đấu v&agrave; thả lỏng. C&aacute;c em nhỏ, khi đến với trung t&acirc;m ngo&agrave;i việc được tiếp cận v&agrave; r&egrave;n luyện những kỹ năng b&oacute;ng đ&aacute;, kỹ năng vận động cần thiết, sẽ từng bước h&igrave;nh th&agrave;nh</p>
', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'NoiDungCuoiTrangDanhSachTour', N'', N'<p class="text">
	Discuss your trip ideas and inspirations with Goodmorningvietnam Travel experts to tailor an authentic and satisfy Vietnam adventure Most destinations have high and low seasons. By planning in advance and traveling in the low season, you can secure better rates as well as avoiding a high rate of local tourists.</p>
<br />
<p class="text">
	Pay attention to the weather forecast; make sure you don&rsquo;t spend your vacation in stormy season. Prepare sunscreen, hat, umbrella and sunglasses. The hot weather may cause sunburn. Bring some recyclable bags to collect all waste. Remember: &lsquo;Take nothing but photos, leave nothing but footprints&rsquo;. Check with your tour operator about the destinations that you will visit and culture to have a basic understanding, what should bring or not, children policy, etc. If you book your own accommodations, make sure to book a safe and comfortable hotel in the central area that is close to local attractions</p>
', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'NoiDungDauTrangVisa', N'', N'<span style="color:#ff0000;"><strong>Our service includes:</strong></span>
<p>
	- Receive and check your visa information via our website - Contact you for reviewing your visa information - Process your visa information into a visa application - Receive and check your visa information via our website - Submit your application on your behalf to Vietnam Immigration Department - Notify you of the visa approval letter processing schedule via email - Follow other procedures pursuant to the regulations of Immigration Department to get Visa approval letter granted by Immigration Department - Send the visa approval letter via email to you after 1-2 working day(s).</p>
<span style="color:#ff0000;"><strong>Vietnam visa-on-arrival service and stamp fees</strong></span>
<p>
	The price is very cheap from US$ 8 per person for visa approval letter processing fee and from US$ 45 per person for the stamp fee, paid at the airport on your arrival. Please go to the NEXT STEPS and our visa supporter will give you more information.</p>
<span style="color:#ff0000;"><strong>Visa Tips</strong></span>
<p>
	With Visa on arrival, travelers to Vietnam will get their Vietnam visa stamped at the Vietnam Airport. Thus, it is applicable to air travelers only, not land or sea travelers. However, you are free to exit at any port. You can use the visa-on-arrival at: - Noi Bai International Airport (HAN) - Tan Son Nhat International Airport (SGN) - Da Nang International Airport (DAD) No original passport sending is required when applying for Vietnam visa-on-arrival, so applicants should make sure that all the information filled in the Visa application is correct. Once the Visa approval letter is issued, no amendment can be made. And if you wish to make any change, you must apply for a new one.</p>
', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionAboutUs', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionCruises', N'', N'For 8 years, more than 10,000 travelers have traveled with Amega Travel to discover Indochina through our unique customized tours which are rich, diverse, and focusing on culture, landscapes as well as interacts with local people.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionCustomerReviews', N'', N'Trung tâm HanoiSport xin chân thành cảm ơn Quý phụ huynh, các em học viên đã luôn tin tưởng và đồng hành cùng chúng tôi trong thời gian qua!', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionDestination', N'', N'For 8 years, more than 10,000 travelers have traveled with Amega Travel to discover Indochina through our unique customized tours which are rich, diverse, and focusing on culture, landscapes as well as interacts with local people.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionHotel', N'', N'For 8 years, more than 10,000 travelers have traveled with Amega Travel to discover Indochina through our unique customized tours which are rich, diverse, and focusing on culture, landscapes as well as interacts with local people.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionHotel', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionService', N'', N'6 khóa học chính gồm: Bóng đá - Bóng rổ - Cầu lông - Bơi lội - Võ Karate - Võ Aikido', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionService', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionTour', N'', N'For 8 years, more than 10,000 travelers have traveled with Amega Travel to discover Indochina through our unique customized tours which are rich, diverse, and focusing on culture, landscapes as well as interacts with local people.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDescriptionTour', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhAboutUs', N'', N'0', N'1', N'')
GO
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhAboutUs_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhAboutUs_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhAboutUs_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhAboutUs_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhAboutUs_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhBlog', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhBlog_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhBlog_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhBlog_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhBlog_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhBlog_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCruises', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCruises_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCruises_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCruises_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCruises_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCruises_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCustomerReviews', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCustomerReviews_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCustomerReviews_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCustomerReviews_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCustomerReviews_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhCustomerReviews_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDeal', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDeal_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDeal_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDeal_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDeal_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDeal_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDestination', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDestination_AnhDau', N'', N'WatermarkLogo.gif', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDestination_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDestination_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDestination_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDestination_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDestination_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_LeDoc', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_LeNgang', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_TrongSuot', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_TyLe', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDichVu_ViTri', N'', N'4', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu2', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu2_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu2_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu2_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu2_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhDuLieu2_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHinhAnh', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHinhAnh_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHinhAnh_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHinhAnh_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHinhAnh_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHinhAnh_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_LeDoc', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_LeNgang', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_TrongSuot', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_TyLe', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhHotel_ViTri', N'', N'4', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhKhachHang', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhKhachHang_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhKhachHang_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhKhachHang_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhKhachHang_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhKhachHang_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhMember', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhMember_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhMember_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhMember_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhMember_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhMember_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhQA', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhQA_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhQA_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhQA_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhQA_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhQA_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhSanPham', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhSanPham_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhSanPham_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhSanPham_TrongSuot', N'', N'', N'1', N'')
GO
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhSanPham_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhSanPham_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTinTuc', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTinTuc_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTinTuc_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTinTuc_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTinTuc_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTinTuc_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_LeDoc', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_LeNgang', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_TrongSuot', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_TyLe', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhTour_ViTri', N'', N'4', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhVideo', N'', N'0', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhVideo_LeDoc', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhVideo_LeNgang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhVideo_TrongSuot', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhVideo_TyLe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingDongDauAnhVideo_ViTri', N'', N'4', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhAboutUs', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhAboutUs_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhAboutUs_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhBlog', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhBlog_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhBlog_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhCruises', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhCruises_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhCruises_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhCustomerReviews', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhCustomerReviews_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhCustomerReviews_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDeal', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDeal_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDeal_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDestination', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDestination_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDestination_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDichVu', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDichVu', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDichVu_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDichVu_MaxHeight', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDichVu_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDichVu_MaxWidth', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDuLieu', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDuLieu_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDuLieu_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDuLieu2', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDuLieu2_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhDuLieu2_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHinhAnh', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHinhAnh_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHinhAnh_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHotel', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHotel', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHotel_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHotel_MaxHeight', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHotel_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhHotel_MaxWidth', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhKhachHang', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhKhachHang_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhKhachHang_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhMember', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhMember_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhMember_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhQA', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhQA_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhQA_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhSanPham', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhSanPham_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhSanPham_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTinTuc', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTinTuc_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTinTuc_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTour', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTour', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTour_MaxHeight', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTour_MaxHeight', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTour_MaxWidth', N'', N'1600', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhTour_MaxWidth', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhVideo', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhVideo_MaxHeight', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingHanCheKichThuocAnhVideo_MaxWidth', N'', N'1000', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungCuoiDonHang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungCuoiDonHangDeal', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungCuoiDonHangHotel', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungCuoiDonHangTour', N'', N'<span style="color:#0099ff;"><strong>Account information (Đ&acirc;y l&agrave; dữ liệu demo, quản trị web c&oacute; thể thay đổi <u><a href="/admin.aspx?uc=Tour&amp;suc=Configuration" target="_blank">tại đ&acirc;y</a></u>)</strong></span><br />
<br />
<table align="center" border="0" cellpadding="1" cellspacing="1" style="width: 100%">
	<tbody>
		<tr>
			<td>
				<img alt="" src="/pic/Tour/images/vcb.jpg" style="width: 160px; height: 160px;" /></td>
			<td>
				<div>
					+ Bank Vietcombank:</div>
				<div>
					Name: Nguyen Van A</div>
				<div>
					Account Number: 0021001297955</div>
				<div>
					Opened at Vietnam Bank for Foreign Trade Vietcombank Thanh Xuan Branch - Hanoi</div>
			</td>
			<td>
				<img alt="" src="/pic/Tour/images/agribank.jpg" style="width: 160px; height: 160px;" /></td>
			<td>
				<div>
					+ Bank Agribank:</div>
				<div>
					Name: Nguyen Van B</div>
				<div>
					Account Number: 1410205261071</div>
				<div>
					Opened at the ARD Bank Vietnam - My Dinh Branch - Hanoi</div>
			</td>
		</tr>
	</tbody>
</table>
<br />
', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungCuoiDonHangTour', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungDauDonHang', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungDauDonHangDeal', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungDauDonHangHotel', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungDauDonHangTour', N'', N'<span style="color:#0099ff;"><strong>Terms and condition</strong></span><strong style="color: rgb(0, 153, 255);">&nbsp;(Đ&acirc;y l&agrave; dữ liệu demo, quản trị web c&oacute; thể thay đổi&nbsp;<u><a href="/admin.aspx?uc=Tour&amp;suc=Configuration" target="_blank">tại đ&acirc;y</a></u>)</strong><span style="color:#0099ff;"><strong>:</strong></span><br />
<br />
Tincidunt integer eu augue augue nunc elit dolor, luctus placerat scelerisque euismod, iaculis eu lacus nunc mi elit, vehicula ut laoreet ac, aliquam sit amet justo nunc tempor, metus vel.<br />
<br />
Tincidunt integer eu augue augue nunc elit dolor, luctus placerat scelerisque euismod, iaculis eu lacus nunc mi elit, vehicula ut laoreet ac, aliquam sit amet justo nunc tempor, metus vel.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingNoiDungDauDonHangTour', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionAboutUs', N'', N'', N'1', N'')
GO
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionCruises', N'', N'For 8 years, more than 10,000 travelers have traveled with Amega Travel to discover Indochina through our unique customized tours which are rich, diverse, and focusing on culture, landscapes as well as interacts with local people.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionCustomerReviews', N'', N'Trung tâm HanoiSport xin chân thành cảm ơn Quý phụ huynh, các em học viên đã luôn tin tưởng và đồng hành cùng chúng tôi trong thời gian qua!', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionDestination', N'', N'For 8 years, more than 10,000 travelers have traveled with Amega Travel to discover Indochina through our unique customized tours which are rich, diverse, and focusing on culture, landscapes as well as interacts with local people.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionHotel', N'', N'For 8 years, more than 10,000 travelers have traveled with Amega Travel to discover Indochina through our unique customized tours which are rich, diverse, and focusing on culture, landscapes as well as interacts with local people.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionHotel', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionService', N'', N'6 khóa học chính gồm: Bóng đá - Bóng rổ - Cầu lông - Bơi lội - Võ Karate - Võ Aikido', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionService', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionTour', N'', N'For 8 years, more than 10,000 travelers have traveled with Amega Travel to discover Indochina through our unique customized tours which are rich, diverse, and focusing on culture, landscapes as well as interacts with local people.', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoDescriptionTour', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoImageDestination', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordAboutUs', N'', N'Về chúng tôi', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordCruises', N'', N'Cruises', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordCustomerReviews', N'', N'Cảm nhận về trung tâm', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordDestination', N'', N'Destination', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordHotel', N'', N'Hotels', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordHotel', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordService', N'', N'Khóa học tại trung tâm', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordService', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordTour', N'', N'Tours', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoKeywordTour', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleAboutUs', N'', N'Về chúng tôi', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleCruises', N'', N'Cruises', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleCustomerReviews', N'', N'Cảm nhận về trung tâm', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleDestination', N'', N'Destination', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleHotel', N'', N'Hotels', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleHotel', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleService', N'', N'Khóa học tại trung tâm', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleService', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleTour', N'', N'Tours', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoTitleTour', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlAboutUs', N'', N'Về chúng tôi', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlCruises', N'', N'Cruises', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlCustomerReviews', N'', N'Cảm nhận về trung tâm', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlDestination', N'', N'Destination', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlHotel', N'', N'Hotels', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlHotel', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlService', N'', N'Khóa học tại trung tâm', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlService', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlTour', N'', N'Tours', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSeoUrlTour', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoAboutUsKhacTrenMotTrang', N'', N'6', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoAboutUsTrenTrangChu', N'', N'6', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoAboutUsTrenTrangDanhMuc', N'', N'6', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoBlogKhacTrenMotTrang', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoBlogTrenTrangChu', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoBlogTrenTrangDanhMuc', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoCruisesKhacTrenMotTrang', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoCruisesTrenTrangChu', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoCruisesTrenTrangDanhMuc', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoCustomerReviewsKhacTrenMotTrang', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoCustomerReviewsTrenTrangChu', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoCustomerReviewsTrenTrangDanhMuc', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDealKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDealTrenTrangChu', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDealTrenTrangDanhMuc', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDestinationKhacTrenMotTrang', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDestinationTrenTrangChu', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDestinationTrenTrangDanhMuc', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDichVuKhacTrenMotTrang', N'', N'2', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDichVuKhacTrenMotTrang', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDichVuTrenTrangChu', N'', N'2', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDichVuTrenTrangChu', N'', N'3', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDichVuTrenTrangDanhMuc', N'', N'2', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDichVuTrenTrangDanhMuc', N'', N'3', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDuLieu2KhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDuLieu2TrenTrangChu', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDuLieu2TrenTrangDanhMuc', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDuLieuKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDuLieuTrenTrangChu', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoDuLieuTrenTrangDanhMuc', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHinhAnhKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHinhAnhTrenTrangChu', N'', N'5', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHinhAnhTrenTrangDanhMuc', N'', N'18', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHotelKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHotelKhacTrenMotTrang', N'', N'10', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHotelTrenTrangChu', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHotelTrenTrangChu', N'', N'10', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHotelTrenTrangDanhMuc', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoHotelTrenTrangDanhMuc', N'', N'10', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoKhachHangKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoKhachHangTrenTrangChu', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoKhachHangTrenTrangDanhMuc', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoMemberKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoMemberTrenTrangChu', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoMemberTrenTrangDanhMuc', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoQAKhacTrenMotTrang', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoQATrenTrangChu', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoQATrenTrangDanhMuc', N'', N'10', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoSanPhamKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoSanPhamTrenTrangChu', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoSanPhamTrenTrangDanhMuc', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTinTucKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTinTucTrenTrangChu', N'', N'2', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTinTucTrenTrangDanhMuc', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTourKhacTrenMotTrang', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTourKhacTrenMotTrang', N'', N'10', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTourTrenTrangChu', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTourTrenTrangChu', N'', N'10', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTourTrenTrangDanhMuc', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoTourTrenTrangDanhMuc', N'', N'10', N'2', N'')
GO
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoVideoKhacTrenMotTrang', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoVideoTrenTrangChu', N'', N'20', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingSoVideoTrenTrangDanhMuc', N'', N'8', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhAboutUs', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhAboutUs_MaxHeight', N'', N'250', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhAboutUs_MaxWidth', N'', N'250', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhBlog', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhBlog_MaxHeight', N'', N'350', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhBlog_MaxWidth', N'', N'350', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhCruises', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhCruises_MaxHeight', N'', N'350', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhCruises_MaxWidth', N'', N'350', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhCustomerReviews', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhCustomerReviews_MaxHeight', N'', N'250', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhCustomerReviews_MaxWidth', N'', N'250', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDeal', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDeal_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDeal_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDestination', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDestination_MaxHeight', N'', N'350', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDestination_MaxWidth', N'', N'350', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDichVu', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDichVu', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDichVu_MaxHeight', N'', N'400', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDichVu_MaxHeight', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDichVu_MaxWidth', N'', N'400', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDichVu_MaxWidth', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDuLieu', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDuLieu_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDuLieu_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDuLieu2', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDuLieu2_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhDuLieu2_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHinhAnh', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHinhAnh_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHinhAnh_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHotel', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHotel', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHotel_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHotel_MaxHeight', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHotel_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhHotel_MaxWidth', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhKhachHang', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhKhachHang_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhKhachHang_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhMember', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhMember_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhMember_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhQA', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhQA_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhQA_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhSanPham', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhSanPham_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhSanPham_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTinTuc', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTinTuc_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTinTuc_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTour', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTour', N'', N'0', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTour_MaxHeight', N'', N'350', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTour_MaxHeight', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTour_MaxWidth', N'', N'350', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhTour_MaxWidth', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhVideo', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhVideo_MaxHeight', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTaoAnhNhoChoAnhVideo_MaxWidth', N'', N'300', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingThongBaoSauKhiGuiLienHe', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingThongBaoSauKhiGuiLienHe', N'', N'<h1>
	<a class="item-title" href="#">Send contact information successful!</a></h1>
<p class="item-text">
	Thank customers for contacting <span>Ltravel</span><br />
	We will get back to you within 24 hours. If you need direct advice to understand more about product services please call: <span>844-378 22816</span></p>
', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleAboutUs', N'', N'Về chúng tôi', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleCruises', N'', N'Cruises', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleCustomerReviews', N'', N'Cảm nhận về trung tâm', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleDestination', N'', N'Destination', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleHotel', N'', N'Hotels', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleHotel', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleService', N'', N'Khóa học tại trung tâm', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleService', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleTour', N'', N'Tours', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'OtherSettingTitleTour', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyBatTatTuDongLayAnh', N'', N'1', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyContentContactWebsite', N'', N'<div class="fs18 pb12 ttu fSegoeUIBold" style="font-size: 18px; text-transform: uppercase; padding-bottom: 12px; font-family: SegoeUIBold; color: rgb(51, 51, 51);">
	TRUNG T&Acirc;M DỊCH VỤ THỂ THAO H&Agrave; NỘI</div>
<div class="info" style="line-height: 20px; color: rgb(51, 51, 51); font-family: SegoeUI; font-size: 15px;">
	<div style="margin-bottom: 4px;">
		Địa chỉ: Tầng 5, Kh&aacute;n đ&agrave;i B, SVĐ Mỹ Đ&igrave;nh</div>
	<div style="margin-bottom: 4px;">
		Hotline:&nbsp;<strong><span class="cred" style="transition: all 0.3s ease 0s; color: red;">0422.187.222 - 092.587.1166 - 0982.357.555</span></strong></div>
	<div style="margin-bottom: 4px;">
		Email: hanoisport.vn@gmail.com</div>
	<div style="margin-bottom: 4px;">
		Webiste: www.hanoisport.vn</div>
</div>
<br />
', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyContentContactWebsite', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyContentFooterWebsite', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyContentFooterWebsite', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyContentFooterWebsiteTop', N'', N'&#169; Copyright by Ltravel.com.vn', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyContentFooterWebsiteTop', N'', N'&copy; Copyright by Ltravel.com.vn', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyDescMetatagWebsite', N'', N'Ltravel - travel gets to big smile!', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyDescMetatagWebsite', N'', N'Ltravel - travel gets to big smile!', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyEmailPhu', N'', N'huyhung.dev@gmail.com', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyEmailPhu', N'', N'huyhung.dev@gmail.com', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyFavicon', N'', N't1p1_logo_7ca_icon636988828227925748.ico', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyFavicon', N'', N'favicon637062404649522926.ico', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyHotLine', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyHotLine', N'', N'0947.868.084', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyKeyGoogleAnalytics', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyKeyGoogleAnalytics', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyKeyWebsite', N'', N'Ltravel - travel gets to big smile!', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyKeyWebsite', N'', N'Ltravel - travel gets to big smile!', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyLogoAdminWebsite', N'', N'T1P1-logo636988826633308395.png', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyLogoAdminWebsite', N'', N'Layer-0637062404648933241.png', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyMailPasswordWebsite', N'', N'tatthanh', N'1', N'')
GO
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyMailPasswordWebsite', N'', N'tatthanh', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyMailWebsite', N'', N'ltravel.noreply@gmail.com', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyMailWebsite', N'', N'ltravel.noreply@gmail.com', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyPhoneContact', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyPhoneContact', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyTitleWebsite', N'', N'Ltravel - travel gets to big smile!', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyTitleWebsite', N'', N'Ltravel - travel gets to big smile!', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyTotalView', N'', N'24152', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'PropertyTotalView', N'', N'100', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ThongBaoDatDichVuThanhCong', N'', N'<a class="item-title" href="#">Submit successful information</a>
<p class="item-text">
	Thank customers for contacting <span>Ltravel</span><br />
	We will get back to you within 24 hours. If you need direct advice to understand more about product services please call: <span>844-378 22816</span></p>
', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ThongBaoDatTourThanhCong', N'', N'<a class="item-title" href="#">Submit successful information</a>
<p class="item-text">
	Thank customers for contacting <span>Ltravel</span><br />
	We will get back to you within 24 hours. If you need direct advice to understand more about product services please call: <span>844-378 22816</span></p>
', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ThongBaoSauKhiGuiDKDichVu', N'', N'<div style="text-align: center;">
	<img alt="" src="/pic/Contact/images/success.png" /></div>
<p class="fs30 ce80a0a tac pb15">
	Gửi đăng k&yacute; dịch vụ th&agrave;nh c&ocirc;ng</p>
<div>
	<p class="tac db lh22 c000 pb10">
		Cảm ơn bạn đ&atilde; quan t&acirc;m v&agrave; li&ecirc;n hệ đến Ha Noi Sport</p>
	<p class="tac db lh22">
		Ch&uacute;ng t&ocirc;i sẽ li&ecirc;n hệ với bạn trong v&ograve;ng 24h. Nếu bạn c&oacute; bất cứ thắc mắc hay c&acirc;u hỏi n&agrave;o vui l&ograve;ng gọi điện để được tư vấn: <span class="cred fSegoeUIBold">04.22.187.222 - 092.587.1166 - 0982357.555</span></p>
</div>
<br />
', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ThongBaoSauKhiGuiDKDichVu', N'', N'', N'2', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'ThongTinChuyenKhoanTaiTrangGioHang', N'', N'<div>
	<strong>Ng&acirc;n h&agrave;ng Agribank</strong></div>
<p>
	Chủ t&agrave;i khoản: Nguyễn Văn A<br />
	Số t&agrave;i khoản: 8013215001060<br />
	Chi nh&aacute;nh: Agribank H&Agrave; Nội</p>
', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'YoutubeVideo', N'', N'', N'1', N'')
INSERT [dbo].[SETTINGS] ([VSKEY], [VSDESC], [VSVALUE], [VSLANG], [web]) VALUES (N'YoutubeVideo', N'', N'', N'2', N'')
SET IDENTITY_INSERT [dbo].[SUBITEMS] ON 

INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (1, 1037, N'2', N'HotelPhoto', N'anh1', N'', N'service0_637062270450892166.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:10:45.000' AS DateTime), CAST(N'2019-10-09 14:10:45.000' AS DateTime), CAST(N'2019-10-09 14:10:45.000' AS DateTime), 2, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (2, 1037, N'2', N'HotelPhoto', N'anh1', N'', N'service0_637062270476230379.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:10:47.000' AS DateTime), CAST(N'2019-10-09 14:10:47.000' AS DateTime), CAST(N'2019-10-09 14:10:47.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (3, 1037, N'2', N'HotelPhoto', N'anh2', N'', N'service1_637062272381658782.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:13:58.000' AS DateTime), CAST(N'2019-10-09 14:13:58.000' AS DateTime), CAST(N'2019-10-09 14:13:58.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (4, 1037, N'2', N'HotelPhoto', N'anh2', N'', N'service1_637062272401986972.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:14:00.000' AS DateTime), CAST(N'2019-10-09 14:14:00.000' AS DateTime), CAST(N'2019-10-09 14:14:00.000' AS DateTime), 2, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (5, 1037, N'2', N'HotelPhoto', N'anh3', N'', N'service1_637062272565748790.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:14:16.000' AS DateTime), CAST(N'2019-10-09 14:14:16.000' AS DateTime), CAST(N'2019-10-09 14:14:16.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (6, 1037, N'2', N'HotelPhoto', N'anh3', N'', N'service1_637062272584958024.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:14:18.000' AS DateTime), CAST(N'2019-10-09 14:14:18.000' AS DateTime), CAST(N'2019-10-09 14:14:18.000' AS DateTime), 2, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (7, 1037, N'2', N'HotelPhoto', N'anh4', N'', N'service1_637062272709113368.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:14:30.000' AS DateTime), CAST(N'2019-10-09 14:14:30.000' AS DateTime), CAST(N'2019-10-09 14:14:30.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (8, 1037, N'2', N'HotelPhoto', N'anh4', N'', N'service1_637062272728961829.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:14:32.000' AS DateTime), CAST(N'2019-10-09 14:14:32.000' AS DateTime), CAST(N'2019-10-09 14:14:32.000' AS DateTime), 2, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (9, 1037, N'2', N'HotelPhoto', N'anh 5', N'', N'service1_637062272894281964.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:14:49.000' AS DateTime), CAST(N'2019-10-09 14:14:49.000' AS DateTime), CAST(N'2019-10-09 14:14:49.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (10, 1037, N'2', N'HotelPhoto', N'anh 5', N'', N'service1_637062272909723131.jpg', N'', N'1', N'', CAST(N'2019-10-09 14:14:50.000' AS DateTime), CAST(N'2019-10-09 14:14:50.000' AS DateTime), CAST(N'2019-10-09 14:14:50.000' AS DateTime), 2, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (11, 1054, N'2', N'TourItinerary', N'*!<=*ParamsSpilitItems*=>*!DAY 1*!<=*ParamsSpilitItems*=>*!HCMC - MADAGUI - DA LAT (Breakfast, lunch, dinner)*!<=*ParamsSpilitItems*=>*!', N'<p>
	In the morning: Tour and Vietnamese Tour Guide pick you up at the meeting point of departure to travel to fall in Dalat. Have breakfast at Nga Dau Dau cross. Continue to depart to TP. Da Lat.<br />
	Stop to visit Madagui tourist area, with a collection of bamboos of nearly 50 different types, discover the mysterious system of natural caves, nature reserve with many wild animals living naturally.</p>
<br />
<p>
	Freedom to explore thrilling game systems such as kayaking, zipline, mountain climbing, aerial walking, skiing, horseback riding, paintball shooting, etc. (expenses excluded)</p>
<br />
<p>
	Lunch: Have lunch at the Muong Xanh restaurant. Continue to visit Truc Lam Zen Monastery, take the cable car through R&ocirc;bin hill (expenses excluded), admire the pine forest, Tuyen Lam lake, Phuong Hoang mountain from above.</p>
<br />
<p>
	Evening: Have dinner, check in and rest. You are self-sufficient walking around the city of Da Lat at night, admire the scenery of Xuan Huong Lake, enjoy the taste of coffee in the mountain town (self-sufficient). Overnight hotel in Da Lat.</p>
', N'', N'', N'1', N'', CAST(N'2019-10-09 20:32:46.000' AS DateTime), CAST(N'2019-10-09 20:32:46.000' AS DateTime), CAST(N'2019-10-09 20:32:46.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (12, 1054, N'2', N'TourItinerary', N'*!<=*ParamsSpilitItems*=>*!DAY 2*!<=*ParamsSpilitItems*=>*!SON SON FILLED PAGE - VEGETABLE FARM AND FLOWER (Breakfast, lunch, dinner)*!<=*ParamsSpilitItems*=>*!', N'<p>
	In the morning: Tour and Vietnamese Tour Guide pick you up at the meeting point of departure to travel to fall in Dalat. Have breakfast at Nga Dau Dau cross. Continue to depart to TP. Da Lat.<br />
	Stop to visit Madagui tourist area, with a collection of bamboos of nearly 50 different types, discover the mysterious system of natural caves, nature reserve with many wild animals living naturally.</p>
<br />
<p>
	Freedom to explore thrilling game systems such as kayaking, zipline, mountain climbing, aerial walking, skiing, horseback riding, paintball shooting, etc. (expenses excluded)</p>
<br />
<p>
	Lunch: Have lunch at the Muong Xanh restaurant. Continue to visit Truc Lam Zen Monastery, take the cable car through R&ocirc;bin hill (expenses excluded), admire the pine forest, Tuyen Lam lake, Phuong Hoang mountain from above.</p>
<br />
<p>
	Evening: Have dinner, check in and rest. You are self-sufficient walking around the city of Da Lat at night, admire the scenery of Xuan Huong Lake, enjoy the taste of coffee in the mountain town (self-sufficient). Overnight hotel in Da Lat.</p>
', N'', N'', N'2', N'', CAST(N'2019-10-09 20:34:43.000' AS DateTime), CAST(N'2019-10-09 20:34:43.000' AS DateTime), CAST(N'2019-10-09 20:34:43.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (13, 1054, N'2', N'TourItinerary', N'*!<=*ParamsSpilitItems*=>*!DAY 3*!<=*ParamsSpilitItems*=>*!DATANLA - HCMC (Breakfast, Lunch)*!<=*ParamsSpilitItems*=>*!', N'<p>
	In the morning: Tour and Vietnamese Tour Guide pick you up at the meeting point of departure to travel to fall in Dalat. Have breakfast at Nga Dau Dau cross. Continue to depart to TP. Da Lat.<br />
	Stop to visit Madagui tourist area, with a collection of bamboos of nearly 50 different types, discover the mysterious system of natural caves, nature reserve with many wild animals living naturally.</p>
<br />
<p>
	Freedom to explore thrilling game systems such as kayaking, zipline, mountain climbing, aerial walking, skiing, horseback riding, paintball shooting, etc. (expenses excluded)</p>
<br />
<p>
	Lunch: Have lunch at the Muong Xanh restaurant. Continue to visit Truc Lam Zen Monastery, take the cable car through R&ocirc;bin hill (expenses excluded), admire the pine forest, Tuyen Lam lake, Phuong Hoang mountain from above.</p>
<br />
<p>
	Evening: Have dinner, check in and rest. You are self-sufficient walking around the city of Da Lat at night, admire the scenery of Xuan Huong Lake, enjoy the taste of coffee in the mountain town (self-sufficient). Overnight hotel in Da Lat.</p>
', N'', N'', N'3', N'', CAST(N'2019-10-09 20:35:03.000' AS DateTime), CAST(N'2019-10-09 20:35:03.000' AS DateTime), CAST(N'2019-10-09 20:35:03.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (14, 1054, N'2', N'TourPhoto', N'Ha Long', N'', N'tour_deta_637062501346027985.jpg', N'', N'1', N'', CAST(N'2019-10-09 20:35:34.000' AS DateTime), CAST(N'2019-10-09 20:35:34.000' AS DateTime), CAST(N'2019-10-09 20:35:34.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (15, 1054, N'2', N'TourItinerary', N'*!<=*ParamsSpilitItems*=>*!DAY 3*!<=*ParamsSpilitItems*=>*!DATANLA - HCMC (Breakfast, Lunch)*!<=*ParamsSpilitItems*=>*!', N'<p>
	In the morning: Tour and Vietnamese Tour Guide pick you up at the meeting point of departure to travel to fall in Dalat. Have breakfast at Nga Dau Dau cross. Continue to depart to TP. Da Lat.<br />
	Stop to visit Madagui tourist area, with a collection of bamboos of nearly 50 different types, discover the mysterious system of natural caves, nature reserve with many wild animals living naturally.</p>
<br />
<p>
	Freedom to explore thrilling game systems such as kayaking, zipline, mountain climbing, aerial walking, skiing, horseback riding, paintball shooting, etc. (expenses excluded)</p>
<br />
<p>
	Lunch: Have lunch at the Muong Xanh restaurant. Continue to visit Truc Lam Zen Monastery, take the cable car through R&ocirc;bin hill (expenses excluded), admire the pine forest, Tuyen Lam lake, Phuong Hoang mountain from above.</p>
<br />
<p>
	Evening: Have dinner, check in and rest. You are self-sufficient walking around the city of Da Lat at night, admire the scenery of Xuan Huong Lake, enjoy the taste of coffee in the mountain town (self-sufficient). Overnight hotel in Da Lat.</p>
', N'', N'', N'3', N'', CAST(N'2019-10-09 20:35:35.000' AS DateTime), CAST(N'2019-10-09 20:35:35.000' AS DateTime), CAST(N'2019-10-09 20:35:35.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (16, 1054, N'2', N'TourPhoto', N'Ha Long', N'', N'tour_deta_637062501361059371.jpg', N'', N'1', N'', CAST(N'2019-10-09 20:35:36.000' AS DateTime), CAST(N'2019-10-09 20:35:36.000' AS DateTime), CAST(N'2019-10-09 20:35:36.000' AS DateTime), 2, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (17, 1054, N'2', N'TourPhoto', N'Thuyền du lịch', N'', N'tour_deta_637062501595296162.jpg', N'', N'1', N'', CAST(N'2019-10-09 20:35:59.000' AS DateTime), CAST(N'2019-10-09 20:35:59.000' AS DateTime), CAST(N'2019-10-09 20:35:59.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (18, 1054, N'2', N'TourPhoto', N'Thuyền du lịch', N'', N'tour_deta_637062501606321108.jpg', N'', N'1', N'', CAST(N'2019-10-09 20:36:00.000' AS DateTime), CAST(N'2019-10-09 20:36:00.000' AS DateTime), CAST(N'2019-10-09 20:36:00.000' AS DateTime), 2, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (20, 1054, N'2', N'TourBooking', N'Đơn đặt tour', N'
    <div>Thông tin tour:</div>
    <ul>
    <li>Tên Tour: <b>1 day boat trip with Captain Jack</b></li>
    <li>Ngày khởi hành: <b>22/10/2019</b></li>
    <li>Số lượng người lớn: <b>2</b></li>
    <li>Số lượng trẻ em từ 8 - 11 tuổi: <b>3</b></li>
    <li>Số lượng trẻ em từ 3 - 7 tuổi: <b>4</b></li>
    <li>Số lượng trẻ em nhỏ hơn 3 tuổi: <b>5</b></li>
    <li>Tổng giá tiền: <b style=''color:#e90d0d''>5</b></li>
    </ul>
    <div>Thông tin người đặt:</div>
    <ul>
    <li>Họ tên: Bui Huy Hung</li>
    <li>Điện thoại: 113</li>
    <li>Email: hung@gmail.com</li>
    <li>Quốc tịch: Viet nam</li>
    <li>Ghi chú: some text...</li>
    </ul>', N'', N'', N'', N'', CAST(N'2019-10-10 11:05:53.000' AS DateTime), CAST(N'2019-10-10 11:05:53.000' AS DateTime), CAST(N'2019-10-10 11:05:53.000' AS DateTime), 0, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (21, 1054, N'2', N'TourBooking', N'Đơn đặt tour', N'
    <div>Thông tin tour:</div>
    <ul>
    <li>Tên Tour: <b>1 day boat trip with Captain Jack</b></li>
    <li>Ngày khởi hành: <b>15/10/2019</b></li>
    <li>Số lượng người lớn: <b>2</b></li>
    <li>Số lượng trẻ em từ 8 - 11 tuổi: <b>3</b></li>
    <li>Số lượng trẻ em từ 3 - 7 tuổi: <b>4</b></li>
    <li>Số lượng trẻ em nhỏ hơn 3 tuổi: <b>1</b></li>
    <li>Tổng giá tiền: <b style=''color:#e90d0d''>21.700.000 VND</b></li>
    </ul>
    <div>Thông tin người đặt:</div>
    <ul>
    <li>Họ tên: H</li>
    <li>Điện thoại: 113</li>
    <li>Email: h@gmail.com</li>
    <li>Quốc tịch: Viet nam</li>
    <li>Ghi chú: no...</li>
    </ul>', N'', N'', N'', N'', CAST(N'2019-10-10 11:09:45.000' AS DateTime), CAST(N'2019-10-10 11:09:45.000' AS DateTime), CAST(N'2019-10-10 11:09:45.000' AS DateTime), 1, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (22, 1054, N'2', N'TourBooking', N'Đơn đặt tour', N'
    <div>Thông tin tour:</div>
    <ul>
    <li>Tên Tour: <b>1 day boat trip with Captain Jack</b></li>
    <li>Ngày khởi hành: <b>25/10/2019</b></li>
    <li>Số lượng người lớn: <b>2</b></li>
    <li>Số lượng trẻ em từ 8 - 11 tuổi: <b>1</b></li>
    <li>Số lượng trẻ em từ 3 - 7 tuổi: <b>4</b></li>
    <li>Số lượng trẻ em nhỏ hơn 3 tuổi: <b>2</b></li>
    <li>Tổng giá tiền: <b style=''color:#e90d0d''>17.700.000 VND</b></li>
    </ul>
    <div>Thông tin người đặt:</div>
    <ul>
    <li>Họ tên: Bui Huy Hung</li>
    <li>Điện thoại: 113</li>
    <li>Email: hung@gmail.com</li>
    <li>Quốc tịch: Viet nam</li>
    <li>Ghi chú: d</li>
    </ul>', N'', N'', N'', N'', CAST(N'2019-10-10 11:14:09.000' AS DateTime), CAST(N'2019-10-10 11:14:09.000' AS DateTime), CAST(N'2019-10-10 11:14:09.000' AS DateTime), 0, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (23, 1054, N'2', N'TourBooking', N'Đơn đặt tour', N'
    <div>Thông tin tour:</div>
    <ul>
    <li>Tên Tour: <b>1 day boat trip with Captain Jack</b></li>
    <li>Ngày khởi hành: <b></b></li>
    <li>Số lượng người lớn: <b>1</b></li>
    <li>Số lượng trẻ em từ 8 - 11 tuổi: <b>0</b></li>
    <li>Số lượng trẻ em từ 3 - 7 tuổi: <b>0</b></li>
    <li>Số lượng trẻ em nhỏ hơn 3 tuổi: <b>0</b></li>
    <li>Tổng giá tiền: <b style=''color:#e90d0d''>3.600.000 VND</b></li>
    </ul>
    <div>Thông tin người đặt:</div>
    <ul>
    <li>Họ tên: Bui Huy Hung</li>
    <li>Điện thoại: 113</li>
    <li>Email: h@gmail.com</li>
    <li>Quốc tịch: Viet nam</li>
    <li>Ghi chú: </li>
    </ul>', N'', N'', N'', N'', CAST(N'2019-10-10 11:19:35.000' AS DateTime), CAST(N'2019-10-10 11:19:35.000' AS DateTime), CAST(N'2019-10-10 11:19:35.000' AS DateTime), 0, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[SUBITEMS] ([ISID], [IID], [VSLANG], [VSKEY], [VSTITLE], [VSCONTENT], [VSIMAGE], [VSEMAIL], [VSATUTHOR], [VSURL], [DSCREATEDATE], [DSUPDATE], [DSENDDATE], [ISENABLE], [web], [fsPrice], [fsSalePrice], [vsDesc], [vsParams], [isTotalView], [isTotalSubitem], [isOrder], [isParam1], [isParam2], [vsParam1], [vsParam2], [dsParam1], [dsParam2]) VALUES (24, 1055, N'2', N'TourBooking', N'Đơn đặt tour', N'
    <div>Thông tin tour:</div>
    <ul>
    <li>Tên Tour: <b>1 day boat trip with Captain Jack 2</b></li>
    <li>Ngày khởi hành: <b>23/10/2019</b></li>
    <li>Số lượng người lớn: <b>2</b></li>
    <li>Số lượng trẻ em từ 8 - 11 tuổi: <b>2</b></li>
    <li>Số lượng trẻ em từ 3 - 7 tuổi: <b>2</b></li>
    <li>Số lượng trẻ em nhỏ hơn 3 tuổi: <b>2</b></li>
    <li>Tổng giá tiền: <b style=''color:#e90d0d''>8.200.000 VND</b></li>
    </ul>
    <div>Thông tin người đặt:</div>
    <ul>
    <li>Họ tên: Bui Huy Hung</li>
    <li>Điện thoại: 113</li>
    <li>Email: hung@gmail.com</li>
    <li>Quốc tịch: Viet nam</li>
    <li>Ghi chú: ki</li>
    </ul>', N'', N'', N'', N'', CAST(N'2019-10-10 11:35:23.000' AS DateTime), CAST(N'2019-10-10 11:35:23.000' AS DateTime), CAST(N'2019-10-10 11:35:23.000' AS DateTime), 0, N'', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[SUBITEMS] OFF
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([UserId], [RoleId], [UserName], [UserPassword], [UserPasswordSalt], [UserFirstName], [UserLastName], [UserAddress], [UserPhoneNumber], [UserEmail], [UserIdentityCard], [UserPasswordQuestion], [UserPasswordAnswer], [UserIsApproved], [UserIsLockedout], [UserCreateDate], [UserLastLogindate], [UserLastPasswordChangedDate], [UserLastLockoutDate], [UserComment], [web]) VALUES (11, 11, N'admin', N'a8a5a5898080e6e0308d81212525452627e70704143c3e8e', N'03d46935*!<=*ParamsSpilitItems*=>*!d2072773c2471b5542afc4c385a4e686*!<=*ParamsSpilitItems*=>*!0', N'Quản trị', N'Hệ thống', N'Hà nội', N'04 625 12 958', N'hotro@tatthanh.com.vn', N'', N'', N'', 1, 0, CAST(N'2011-08-29 13:36:34.000' AS DateTime), CAST(N'2019-10-10 07:55:05.000' AS DateTime), CAST(N'2011-08-29 13:36:34.000' AS DateTime), CAST(N'2019-10-09 15:09:15.000' AS DateTime), N'', N'')
SET IDENTITY_INSERT [dbo].[Users] OFF
ALTER TABLE [dbo].[GROUPS_ITEMS]  WITH CHECK ADD  CONSTRAINT [FK_GROUPS_ITEMS_GROUPS] FOREIGN KEY([IGID])
REFERENCES [dbo].[GROUPS] ([IGID])
GO
ALTER TABLE [dbo].[GROUPS_ITEMS] CHECK CONSTRAINT [FK_GROUPS_ITEMS_GROUPS]
GO
ALTER TABLE [dbo].[GROUPS_ITEMS]  WITH CHECK ADD  CONSTRAINT [FK_GROUPS_ITEMS_ITEMS] FOREIGN KEY([IID])
REFERENCES [dbo].[ITEMS] ([IID])
GO
ALTER TABLE [dbo].[GROUPS_ITEMS] CHECK CONSTRAINT [FK_GROUPS_ITEMS_ITEMS]
GO
ALTER TABLE [dbo].[LanguageItem]  WITH CHECK ADD  CONSTRAINT [FK_LanguageItem_LanguageKey] FOREIGN KEY([iLanguageKeyId])
REFERENCES [dbo].[LanguageKey] ([iLanguageKeyId])
GO
ALTER TABLE [dbo].[LanguageItem] CHECK CONSTRAINT [FK_LanguageItem_LanguageKey]
GO
ALTER TABLE [dbo].[LanguageItem]  WITH CHECK ADD  CONSTRAINT [FK_LanguageItem_LanguageNational] FOREIGN KEY([iLanguageNationalId])
REFERENCES [dbo].[LanguageNational] ([iLanguageNationalId])
GO
ALTER TABLE [dbo].[LanguageItem] CHECK CONSTRAINT [FK_LanguageItem_LanguageNational]
GO
ALTER TABLE [dbo].[ReportsDetail]  WITH CHECK ADD  CONSTRAINT [FK_ReportsDetail_ReportsBrowser] FOREIGN KEY([iReportBrowserId])
REFERENCES [dbo].[ReportsBrowser] ([iReportBrowserId])
GO
ALTER TABLE [dbo].[ReportsDetail] CHECK CONSTRAINT [FK_ReportsDetail_ReportsBrowser]
GO
ALTER TABLE [dbo].[ReportsDetail]  WITH CHECK ADD  CONSTRAINT [FK_ReportsDetail_ReportsLocation] FOREIGN KEY([iReportsLocationId])
REFERENCES [dbo].[ReportsLocation] ([iReportsLocationId])
GO
ALTER TABLE [dbo].[ReportsDetail] CHECK CONSTRAINT [FK_ReportsDetail_ReportsLocation]
GO
ALTER TABLE [dbo].[ReportsLink]  WITH CHECK ADD  CONSTRAINT [FK_ReportsLink_ReportsDetail] FOREIGN KEY([iReportDetailId])
REFERENCES [dbo].[ReportsDetail] ([iReportDetailId])
GO
ALTER TABLE [dbo].[ReportsLink] CHECK CONSTRAINT [FK_ReportsLink_ReportsDetail]
GO
ALTER TABLE [dbo].[SUBITEMS]  WITH CHECK ADD  CONSTRAINT [FK_SUBITEMS_ITEMS] FOREIGN KEY([IID])
REFERENCES [dbo].[ITEMS] ([IID])
GO
ALTER TABLE [dbo].[SUBITEMS] CHECK CONSTRAINT [FK_SUBITEMS_ITEMS]
GO
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Roles] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([RoleId])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Roles]
GO
