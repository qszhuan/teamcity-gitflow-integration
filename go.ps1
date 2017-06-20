param(
    [Parameter(Position=0,Mandatory=0)]
    [string[]]$taskList = @(),
    [Parameter(Position=1,Mandatory=0)]
    [string]$framework = "4.6.1",
    [Parameter(Position=2,Mandatory=0)]
    [switch]$docs = $false,
    [Parameter(Position=3,Mandatory=0)]
    [System.Collections.Hashtable]$parameters = @{},
    [Parameter(Position=4, Mandatory=0)]
    [System.Collections.Hashtable]$properties = @{},
    [Parameter(Position=5, Mandatory=0)]
    [alias("init")]
    [scriptblock]$initialization = {},
    [Parameter(Position=6, Mandatory=0)]
    [switch]$nologo = $false,
    [Parameter(Position=7, Mandatory=0)]
    [switch]$help = $false,
    [Parameter(Position=8, Mandatory=0)]
    [string]$scriptPath,
    [Parameter(Position=9,Mandatory=0)]
    [switch]$detailedDocs = $false
)


# setting $scriptPath here, not as default argument, to support calling as "powershell -File psake.ps1"
if (!$scriptPath) {
  $scriptPath = (join-path $(Split-Path -parent $MyInvocation.MyCommand.path) "scripts")
}

# '[p]sake' is the same as 'psake' but $Error is not polluted
remove-module [p]sake
$psakeModulePath = join-path $scriptPath "tools" | join-path -ChildPath "psake-4.6.0" | join-path -ChildPath psake.psm1
import-module $psakeModulePath
if ($help) {
  Get-Help Invoke-psake -full
  return
}

$buildFile = (join-path $scriptPath "tools\psake-4.6.0\tasks.ps1")


Invoke-psake $buildFile $taskList $framework $docs $parameters $properties $initialization $nologo $detailedDocs
exit (!$psake.build_success)
