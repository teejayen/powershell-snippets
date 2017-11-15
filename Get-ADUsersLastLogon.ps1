Import-Module ActiveDirectory

function Get-ADUsersLastLogon()
{
  $DCs = Get-ADDomainController -Filter {Name -like "*"}
  $Users = Get-ADUser -Filter *
  $time = 0
  $exportFilePath = ":\lastLogon.csv"
  $columns = "Name,Username,Last Logon"

  Out-File -filepath $exportFilePath -force -InputObject $columns

  foreach($User in $Users)
  {
    foreach($DC in $DCss)
    { 
      $hostname = $DC.HostName
      $currentUser = Get-ADUser $user.SamAccountName | Get-ADObject -Server $hostname -Properties lastLogon

      if($currentUser.LastLogon -gt $time) 
      {
        $time = $currentUser.LastLogon
      }
    }

    $dt = [DateTime]::FromFileTime($time)
    $row = $user.Name+","+$user.SamAccountName+","+$dt

    Out-File -filepath $exportFilePath -append -noclobber -InputObject $row

    $time = 0
  }
}
