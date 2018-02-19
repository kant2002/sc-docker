docker build -f dockerfiles/wine.dockerfile  -t starcraft:wine   .
docker build -f dockerfiles/bwapi.dockerfile -t starcraft:bwapi  .
docker build -f dockerfiles/play.dockerfile  -t starcraft:play   .
docker build -f dockerfiles/java.dockerfile  -t starcraft:java   .

if (!(Test-Path jre-8u161-windows-i586.tar.gz))
{
    $session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
    $cookie = New-Object System.Net.Cookie
    $cookie.Name = "oraclelicense"
    $cookie.Value = "accept-securebackup-cookie"
    $cookie.Domain = "download.oracle.com"
    $session.Cookies.Add($cookie);
    $oracleUrl = "http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jre-8u161-windows-i586.tar.gz?AuthParam=1518889725_4d984ff498e07d4cd7144cd57c2f8cc8"
    Invoke-WebRequest $oracleUrl -WebSession $session -OutFile jre-8u161-windows-i586.tar.gz1
}

Push-Location ../scbw/local_docker
if (!(Test-Path starcraft.zip))
{
    Invoke-WebRequest 'http://files.theabyss.ru/sc/starcraft.zip' -OutFile starcraft.zip
}

docker build -f game.dockerfile  -t "starcraft:game" .
Pop-Location
