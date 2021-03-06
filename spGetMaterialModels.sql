USE [IntelligentCorrosionTool]
GO
/****** Object:  StoredProcedure [dbo].[spGetMaterialModels]    Script Date: 1/10/2022 9:11:32 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spGetMaterialModels] 
-- Add the parameters for the stored procedure here
	@materialIDs NVarChar(100),
	@delimiter char(1)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

  -- create temp table of materialIDs to use in join
	DECLARE @materialTable Table (MaterialID int Not Null)
	INSERT @materialTable (MaterialID)
	SELECT * FROM fnSplitIntegerString(@materialIDs, @delimiter)

    -- Insert statements for procedure here
	--1st first set

	SELECT matTable.MaterialID as material_id, tblMaterials.material_name, COUNT(tblCorrosionModel_Materials.model_id) as ModelCount, dbo.fnMaterialGalvanicModelCheck(matTable.MaterialID) as IsGalvanic from @materialTable as matTable 
	left join tblCorrosionModel_Materials on matTable.MaterialID = tblCorrosionModel_Materials.material_id
	inner join tblMaterials on matTable.MaterialID = tblMaterials.material_id
	Group By MaterialID, material_name
	Order By material_id

	/*
	SELECT matTable.MaterialID, tblMaterials.material_name, tblCorrosionModel_Materials.model_id, tblCorrosionModels.model_name from @materialTable as matTable 
	left join tblCorrosionModel_Materials on matTable.MaterialID = tblCorrosionModel_Materials.material_id
	inner join tblMaterials on matTable.MaterialID = tblMaterials.material_id
	inner join tblCorrosionModels on tblCorrosionModel_Materials.model_id = tblCorrosionModels.model_id
	order by MaterialID, tblCorrosionModel_Materials.model_id
	*/

END
