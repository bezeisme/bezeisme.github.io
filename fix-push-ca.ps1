# ---------------------------------------------------------------
# Refresh the S302 MITM CA into git's CA bundle, then push.
# Kept pure ASCII on purpose: Windows PowerShell 5.1 misreads
# UTF-8-without-BOM scripts containing non-ASCII characters.
# ---------------------------------------------------------------
$ErrorActionPreference = 'Stop'

$repo      = Split-Path -Parent $MyInvocation.MyCommand.Path
$gitExe    = 'C:\Users\35689\AppData\Local\Programs\PortableGit\cmd\git.exe'
$bundleSrc = 'C:\Users\35689\AppData\Local\Programs\PortableGit\mingw64\etc\ssl\certs\ca-bundle.crt'
$bundleDst = Join-Path $env:USERPROFILE '.git-ca-bundle.crt'

Write-Host ''
Write-Host '[1/3] Reading the certificate presented by 127.0.0.1:443 ...'
$tcp = New-Object System.Net.Sockets.TcpClient('127.0.0.1', 443)
$ssl = New-Object System.Net.Security.SslStream($tcp.GetStream(), $false, { param($a, $b, $c, $d) $true })
$ssl.AuthenticateAsClient('github.com')
$cert = New-Object System.Security.Cryptography.X509Certificates.X509Certificate2($ssl.RemoteCertificate)
$ssl.Close(); $tcp.Close()
Write-Host ('      subject : ' + $cert.Subject)
Write-Host ('      issuer  : ' + $cert.Issuer)

Write-Host '[2/3] Rebuilding the git CA bundle ...'
$b64  = [Convert]::ToBase64String($cert.RawData)
$body = ($b64 -split '(.{64})' | Where-Object { $_ }) -join "`n"
$pem  = "`n-----BEGIN CERTIFICATE-----`n$body`n-----END CERTIFICATE-----`n"
Copy-Item $bundleSrc $bundleDst -Force
Add-Content -Path $bundleDst -Value $pem -Encoding ASCII
Write-Host ('      bundle  : ' + $bundleDst + '  (' + [math]::Round((Get-Item $bundleDst).Length / 1KB, 1) + ' KB)')

& $gitExe -C $repo config --global http.sslBackend openssl
& $gitExe -C $repo config --global http.sslCAInfo ($bundleDst -replace '\\', '/')
& $gitExe -C $repo config --global http.version HTTP/1.1
Write-Host '      git settings updated'

Write-Host '[3/3] Pushing (up to 3 attempts) ...'
for ($i = 1; $i -le 3; $i++) {
    Write-Host ('      --- attempt ' + $i + ' ---')
    & $gitExe -C $repo push -u origin main
    if ($LASTEXITCODE -eq 0) {
        Write-Host ''
        Write-Host 'PUSH OK'
        exit 0
    }
    if ($i -lt 3) { Start-Sleep -Seconds 4 }
}
Write-Host ''
Write-Host 'PUSH FAILED after 3 attempts'
exit 1
