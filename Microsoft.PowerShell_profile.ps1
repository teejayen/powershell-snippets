function prompt
{
    $Host.UI.RawUI.WindowTitle = "PowerShell v" + (get-host).Version.Major + "." + (get-host).Version.Minor + " (" + $pwd.Provider.Name + ") " + $pwd.Path
 
    # Am I admin?
    if( (
        New-Object Security.Principal.WindowsPrincipal (
            [Security.Principal.WindowsIdentity]::GetCurrent())
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
    {
        $Host.UI.RawUI.WindowTitle = "[Admin] " + $Host.UI.RawUI.WindowTitle
        Write-Host "[" -nonewline -foregroundcolor DarkRed
        Write-Host "Admin" -nonewline -foregroundcolor Red
        Write-Host "] " -nonewline -foregroundcolor DarkRed
    }
 
    return " "
}

Function Get-DinoPass {
    $Password = Invoke-WebRequest -uri http://www.dinopass.com/password/strong
    Set-Clipboard $Password.Content
    Return $Password.Content
}

Clear-Host
Set-ExecutionPolicy Bypass -Force
$autoload="%UserProfile%\Documents\WindowsPowerShell\Scripts\autoload"
Get-ChildItem "${autoload}\*.ps1" | For Each-Object {.$_} 
Write-Host "Custom PowerShell Environment Loaded" 
