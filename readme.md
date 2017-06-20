
This repo is used for spike of git flow and CI integration.


### add this to pre-push hook to enable checking before pushing:

echo "Run pre-push checking............" >&2
powershell.exe -NoProfile ../../go.ps1
exit  $LASTEXITCODE