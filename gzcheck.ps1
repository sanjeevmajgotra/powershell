
function greenzonecheck()
{
    $datetime  = (Get-Date).ToUniversalTime()
	$newdate=[TimeZoneInfo]::ConvertTimeBySystemTimeZoneId($datetime, 'Eastern Standard Time')
	$gzstarttime= Get-Date -Hour 08 -Minute 0
    $gzendtime= Get-Date -Hour 10 -Minute 0
    $message= "Cannot be deployed outside greenzone window.Please get exception approval on pipeline or rerun this stage during greenzone"

	if($newdate.TimeOfDay -gt  $gzendtime.TimeOfDay )
	{
		Write-Host $message -foreground Red 
		return $false
	}
	elseif ($newdate.TimeOfDay -lt  $gzstarttime.TimeOfDay )
	{
		Write-Host $message -foreground Red 
		return $false
	}

	return $true
	
}




greenzonecheck