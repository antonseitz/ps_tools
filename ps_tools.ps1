# ACHTUNG : Wenn man mit Copy Paste arbeitet, sollte man mit Umbrüchen sparen, da sonst z.B. die switch Anweisungen nicht mehr gehen.
$tools=@("BlueScreenViewer", "PSTools", "RegistryChangesView","wol.exe", "TeamviewerQuickSupport", "CPU-Z", "Notepad_plus_plus", "7-Zip", "Speccy", "StressMyPC", "TreeSizeFree","WinDirStat", "WinMerge", "VenMon_Multipinger", "AllDup Dedup tool" , "Github Desktop")

$n=1
$run_this_exe_after_unzip=$null
$url=$null
$name=$null
#### TOOL AUSWAEHLEN #####

foreach ($name in $tools) { "`n$n" + ": " + "$name"
$n=$n +1
}

"`n"
$choice = Read-Host 'Bitte etwas eingeben!'
#### TOOL AUSWAEHLEN #####

switch ($choice ) { 
"1" { 
$url='https://www.nirsoft.net/utils/bluescreenview-x64.zip' 
$run_this_exe_after_unzip="BlueScreenView.exe" }

"2" { $url='https://download.sysinternals.com/files/PSTools.zip' }

"3" { $url='https://www.nirsoft.net/utils/registrychangesview-x64.zip'
$run_this_exe_after_unzip ="RegistryChangesView.exe"}

"4" { $url='https://www.gammadyne.com/wol.exe'
#$run_this_exe_after_unzip='wol.exe'
}


"5" {$url='https://download.teamviewer.com/download/TeamViewerQS_x64.exe' }

"6" { $url='https://www.cpuid.com/downloads/cpu-z/cpu-z_2.10-en.exe' } 
"7" { $url='https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v8.6.7/npp.8.6.7.Installer.x64.exe'}

"8" { $url='https://7-zip.org/a/7z2408-x64.exe'}

"9" { $url='https://download.ccleaner.com/spsetup133.exe'}

"10" { $url='http://www.softwareok.com/Download/StressMyPC.zip'
$run_this_exe_after_unzip='StressMyPC.exe'}

"11" { $url='https://downloads.jam-software.de/treesize_free/TreeSizeFree-Portable.zip' 
$run_this_exe_after_unzip='TreeSizeFree.exe'
}

"12" { $url='https://github.com/windirstat/windirstat/releases/download/release%2Fv2.0.1/WinDirStat-x64.msi'}


"13" { $url='https://github.com/WinMerge/winmerge/releases/download/v2.16.42.1/WinMerge-2.16.42.1-x64-Setup.exe' }

"14" { $url='https://sites.google.com/site/venturalcom/VM-232.zip' 
$run_this_exe_after_unzip='Venmon64.exe' }

"15" {$url='https://www.alldup.de/download/AllDupSetup.exe'

}

"16" {$url='https://central.github.com/deployments/desktop/desktop/latest/win32'
$is_exe=$True
}

}


$name=$tools[$choice - 1 ]
$exe =$url.EndsWith(".exe")
$msi =$url.EndsWith(".msi")
$zip =$url.EndsWith(".zip")
cd $env:USERPROFILE
if (test-path "Downloads") { 
cd Downloads
$Downloads=$true
}

if ($zip) { $file= $name + ".zip" }
if ($msi) { $file= $name + ".msi" }
if ($exe -or $is_exe) { $file= $name + ".exe"} 
#else {$file = $name}

if ( -not (test-path $name) ) { mkdir $name }

# Sonst ist der Download sehr langsam

$ProgressPreference = 'SilentlyContinue'


'Bitte Geduld: Der Download kann ein paar Minuten dauern...'

if (test-path $file) { remove-item $file }

[Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls"
Invoke-WebRequest -Uri $url -outfile $file

if ($zip){ expand-archive -destinationpath $name -path $file -force } else { move-item -force $file $name}

cd $name

if ( $run_this_exe_after_unzip -ne $null ){ . "./$run_this_exe_after_unzip" } elseif ($exe -or $is_exe -or $msi) { . "./$file" } else { dir }

if ( $zip -eq $true ){

cd ..
remove-item $file
} 
if ($Downloads){
cd ..
}





'Ende'
