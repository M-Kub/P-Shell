#---- TEMPORARY ---
#Disable-UAC

#Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions
#Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -Lock
#Set-TaskbarOptions -Size Small -Dock Bottom -Combine Full -AlwaysShowIconsOn

# Feedback Hub
Get-AppxPackage Microsoft.WindowsFeedbackHub | Remove-AppxPackage
# Maps
Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage
# Netflix
Get-AppxPackage *Netflix* | Remove-AppxPackage
# Office Hub
Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
# One Connect
Get-AppxPackage Microsoft.OneConnect | Remove-AppxPackage
# OneNote
Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage
# People
Get-AppxPackage Microsoft.People | Remove-AppxPackage
# Phone
Get-AppxPackage Microsoft.WindowsPhone | Remove-AppxPackage
# Photos
Get-AppxPackage Microsoft.Windows.Photos | Remove-AppxPackage
# Sound Recorder
Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
# Solitaire
Get-AppxPackage *Solitaire* | Remove-AppxPackage
# Sticky Notes
Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
# Sway
Get-AppxPackage Microsoft.Office.Sway | Remove-AppxPackage
# Twitter
Get-AppxPackage *Twitter* | Remove-AppxPackage
# Xbox
Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
Get-AppxPackage Microsoft.XboxIdentityProvider | Remove-AppxPackage


# Privacy: Let apps use my advertising ID: Disable
If (-Not (Test-Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo")) {
    New-Item -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo | Out-Null
}
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo -Name Enabled -Type DWord -Value 0

# WiFi Sense: HotSpot Sharing: Disable
If (-Not (Test-Path "HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting")) {
    New-Item -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting | Out-Null
}
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting -Name value -Type DWord -Value 0

# WiFi Sense: Shared HotSpot Auto-Connect: Disable
Set-ItemProperty -Path HKLM:\Software\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots -Name value -Type DWord -Value 0

# Start Menu: Disable Bing Search Results
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search -Name BingSearchEnabled -Type DWord -Value 0

# Disable Telemetry (requires a reboot to take effect)
Set-ItemProperty -Path HKLM:\SOFTWARE\Policies\Microsoft\Windows\DataCollection -Name AllowTelemetry -Type DWord -Value 0
Get-Service DiagTrack,Dmwappushservice | Stop-Service | Set-Service -StartupType Disabled

# Change Explorer home screen back to "This PC"
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name LaunchTo -Type DWord -Value 1

# Better File Explorer
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneExpandToCurrentFolder -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name NavPaneShowAllFolders -Value 1
Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced -Name MMTaskbarMode -Value 2

# These make "Quick Access" behave much closer to the old "Favorites"
# Disable Quick Access: Recent Files
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowRecent -Type DWord -Value 0
# Disable Quick Access: Frequent Folders
Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer -Name ShowFrequent -Type DWord -Value 0

# Lock screen (not sleep) on lid close
Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name AwayModeEnabled -Type DWord -Value 1


# Turn off People in Taskbar
If (-Not (Test-Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People")) {
    New-Item -Path HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People | Out-Null
}
Set-ItemProperty -Path "HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\People" -Name PeopleBand -Type DWord -Value 0

#--- Restore Temporary Settings ---
#Enable-UAC
#Enable-MicrosoftUpdate
#Install-WindowsUpdate -acceptEula