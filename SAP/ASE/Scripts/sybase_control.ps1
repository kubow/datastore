function Show-Menu
{
     param (
           [string]$Title = 'ASE on Windows Control Menu',
           [string]$Submenu = 'ASE actions'
     )
     cls
     Write-Host "================= $Title ================="
     
     Write-Output (Get-Service "SYBSQL*")
     Write-Output (Get-Service "SYBBCK*")
     Write-Output (Get-Service "SYBXPS*")
     Write-Output (Get-Service "Sybase*")
     Write-Output (Get-Service "COC*")
     Write-Output (Get-Service "SYBIQ*")
     Write-Output ('')
     Write-Host "============== $Submenu ============="

     Write-Host "1: ASE error log (last 1000 rows)"
     Write-Host "2: ASE Run if neccesary (+ BS)."
     Write-Host "3: ASE Re-start"
     Write-Host "4: ASE Run Script (sql)"
     Write-Host "5: ASE Cockpit error log (-1 hour)"
     Write-Host "6: ASE Cockpit Run if neccesary"
     Write-Host "7: ASE Run if neccesary (+ BS)"
     Write-Host "8: ASE Run if neccesary (+ BS)"
     Write-Host "Q: Press 'Q' to quit."
}
function Show-Form
{
    param (
        [string]$Title = 'Basic Form'
    )
    cls
    Add-Type -assembly System.Windows.Forms
    $main_form = New-Object System.Windows.Forms.Form
    $main_form.Text =$Title
    $main_form.Width = 600
    $main_form.Height = 400
    $main_form.AutoSize = $true
    $main_form.ShowDialog()
}
do
{
     Show-Menu
     $input = Read-Host "Please make a selection"
     switch ($input)
     {
           '1' {
                #cls
                ################
                #  ASE SERVER  #
                ################
                # Error log
                <# $fltr=@{
                    LogName='application';
                    ProviderName='SAP*';
                    Level=0,1,2,3,4;
                    #StartTime=[datetime]::Today.AddDays(-7);
                    StartTime=[datetime]::Today.AddDays(-2);
                    EndTime=[datetime]::Today
                }
                if (Get-WinEvent -FilterHashtable $fltr -ErrorAction SilentlyContinue) {
                    Get-WinEvent -FilterHashtable $fltr | ogv
                } else {
                    Write-Output "no corresponding log found"
                    } #>
                if (Get-EventLog -LogName Application -Source SAPWIN_DS -Newest 1 -ErrorAction SilentlyContinue) {
                    Get-EventLog -LogName Application -Source SAPWIN_DS -Newest 1000| ogv
                } else {
                    Write-Output "no corresponding log found"
                }
           } '2' {
                cls
                # ASE run
                $ase_service = Get-Service -DisplayName 'SAP SQL*'
                while ($ase_service.Status -ne 'Running')
                {
                    Start-Service $ase_service
                }
                Write-Host 'ASE is' $ase_service.Status
                # ASE Backup Run
                $bck_service = Get-Service -DisplayName 'SAP BCK*'
                while ($bck_service.Status -ne 'Running')
                {                    
                    Start-Service $bck_service
                }
                Write-Host 'ASE Backup Server is' $bck_service.Status
           } '3' {
                cls

           } '4' {
                cls

           } '5' {
                #cls
                ###############
                #  COCKPIT 4  #
                ###############
                # Cockpit log
                Get-WinEvent -FilterHashtable @{LogName='application'; ProviderName='Cockpit*'} | ogv
           } '6' {
                cls
                'ASE Cockpit Run if neccesary'
                # Cockpit run
                $cockpit_service = Get-Service "cockpit*"
                while ($cockpit_service.Status -ne 'Running')
                {
                    Start-Service $cockpit_service
                }
                # Cockpit stop
                #Stop-Service (Get-Service "cockpit*")
           } 'q' {
                return
           }
     }
     pause
}
until ($input -eq 'q')

# gsv | ? Status -eq Running | ogv
#gsv | ogv
#Get-Service "Agent*"
#$host.ui | gm
#gsv | gm