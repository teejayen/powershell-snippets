Import-Module ActiveDirectory

function Get-ADUsersLastLogon()
{
  $DomainController = Get-ADDomainController -Filter {Name -like "*"}
  $Users = Get-ADUser -Filter *
  $time = 0
  $exportFilePath = "c:\lastLogon.csv"
  $columns = "Name,Username,Last Logon"

  Out-File -filepath $exportFilePath -force -InputObject $columns

  foreach($User in $Users)
  {
    foreach($DomainController in $DomainControllers)
    { 
      $hostname = $DomainController.HostName
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
