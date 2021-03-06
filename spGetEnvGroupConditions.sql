USE [IntelligentCorrosionTool]
GO
/****** Object:  StoredProcedure [dbo].[spGetEnvGroupConditions]    Script Date: 12/9/2021 9:15:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spGetEnvGroupConditions] 
	-- Add the parameters for the stored procedure here
	@envGroupID int = 0
	 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	-- OLD 12/9/21: SELECT       ' ' as checkboxPlaceholder, tblEnvironmentConditions.env_cond_id, tblEnvironmentConditions.env_cond_name, tblEnvironmentConditions.env_cond_value, tblEnvironmentConditions.env_cond_units
	SELECT  tblEnvironmentConditions.env_cond_id, tblEnvironmentConditions.env_cond_name, tblEnvironmentConditions.env_cond_value, tblEnvironmentConditions.env_cond_units
	FROM	tblEnvironmentConditions INNER JOIN
                         tblEnvironmentGroupConditions ON tblEnvironmentConditions.env_cond_id = tblEnvironmentGroupConditions.env_cond_id INNER JOIN
                         tblEnvironmentGroups ON tblEnvironmentGroupConditions.env_group_id = tblEnvironmentGroups.env_group_id
	WHERE tblEnvironmentConditions.env_cond_status = 1 AND tblEnvironmentGroupConditions.env_group_id = @envGroupID
	ORDER BY tblEnvironmentConditions.env_cond_name, tblEnvironmentConditions.env_cond_value
END
