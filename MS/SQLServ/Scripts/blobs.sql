-- How tohandle BLOB like objects

USE pubs;
GO

DECLARE @ptrval VARBINARY(16);
SELECT
    @ptrval = TEXTPTR(logo)  --this is usage
FROM
    pub_info pr, publishers p
WHERE p.pub_id = pr.pub_id
   AND p.pub_name = 'New Moon Books';
GO

