properties {
    $packageVersion = "1.0.0.0-dev"
    $packagePublishDest = "c:\\temp\"
}

#Remove this link if want it Configurable
#$packagePublishDest = "\\kitmeloct1\NuGet Repository\RBH-PricePlus"
$rootPath = join-path $(Split-Path -parent $MyInvocation.MyCommand.path) "../../" 

task default -depends UT, FT, JT
task Ms-Test -depends UT, FT

task UT  -depends Build `
           -description "Run all the unit tests" { 
    write-host "unit test." -f green
}

task FT  -depends Build `
           -description "Run all the integration tests" { 
    write-host "functional test" -f green
}


task JT -depends Npm-Install `
        -description "Run javascript tests" {
    write-host "javasript test" -f green
}

task Npm-Install `
                -description "Install all the required front-end dependencies"{
    write-host "install npm packages." -f green
}

task Build -depends Clean `
            -description "Build sln" {
    write-host "msbuild" -f green
}

task Clean -description "clean sln" {
    write-host "clean" -f green
}
