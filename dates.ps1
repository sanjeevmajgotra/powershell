
function CheckTurnOverWindow()
{
    $datetime  = (Get-Date).ToUniversalTime()
	$newdate=[TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($datetime, 'Eastern Standard Time')
	$dayofweek=$newdate.DayOfWeek
	$turnovertime= Get-Date -Hour 20 -Minute 0
	
	$turnoverdays= "Friday","Saturday","Sunday"

	if($turnoverdays -notcontains $dayofweek)
	{
		Write-Host "Cannot be executed outside turnover window" -foreground Red 
		return $false
	}
	elseif ($dayofweek -eq "Friday")
	{
		if($newdate.TimeOfDay -gt  $turnovertime.TimeOfDay )
		{
			Write-Host "Its Friday and executing in turnover window" -foreground Green 
			return $true
		}
		else
		{
			Write-Host "Cannot be executed outside turnover window" -foreground Red 
		    return $false
		}
	}
	elseif ($dayofweek -eq "Sunday")
	{
		if($newdate.TimeOfDay -lt  $turnovertime.TimeOfDay )
		{
			Write-Host "Its Sunday and executing in turnover window" -foreground Green 
			return $true
		}
		else
		{
			Write-Host "Cannot be executed outside turnover window" -foreground Red 
		    return $false
		}
	}

	Write-Host "Its Saturday and executing in turnover window" -foreground Green 
	return $true
	
}




CheckTurnOverWindow