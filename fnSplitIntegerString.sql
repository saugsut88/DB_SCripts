
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION fnSplitIntegerString 
(	
	-- Add the parameters for the function here
	@String nvarchar(max),
	@Delimiter char(1)

)
RETURNS @output TABLE (MaterialID int Not Null)
AS
	Begin
		Declare @startPos smallint, @endPos smallint
		If (Right(@String, 1) != @Delimiter AND RIGHT(@String,1) != '')
		Set @String = @String + @Delimiter

		Set @startPos = 1
		Set @endPos = CharIndex(@Delimiter, @String)

		While @endPos > 0
			Begin
				Insert @output(MaterialID)
				Select LTrim(RTrim(SubString(@String, @startPos, @endPos - @startPos)))

				-- remove the delimiter just used
				Set @String = Stuff(@String, @endPos, 1, '')
		
				-- move string pointer to next delimiter
				Set @startPos = @endPos
				Set @endPos = CharIndex(@Delimiter, @String)
			End
			RETURN 
	END

GO