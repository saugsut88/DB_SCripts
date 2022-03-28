/* Insert test material into tblMaterials */

USE [IntelligentCorrosionTool]
GO

INSERT INTO [dbo].[tblMaterials]
           ([material_type_id]
           ,[alloy_number]
           ,[atomic_mass]
           ,[valence_state]
           ,[bulk_resistivity]
           ,[specification]
           ,[material_status]
           ,[material_name])
     VALUES
           (2
           ,'Carbon Steel'
           ,55.8450
           ,'2+/3+'
           ,1.6E-07
           ,'ASTM A36'
           ,1
           ,'Plain Carbon Steel')
GO


