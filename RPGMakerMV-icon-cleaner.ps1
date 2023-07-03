

$ROOT = "$ENV:USERPROFILE\AppData\Local\User Data\Default"
$FAVICON_DB = "$ROOT\Favicons"
$FAVICON_DB_JOURNAL = "$ROOT\Favicons-journal"
$WEB_APPLICATIONS = "$ROOT\Web Applications"


if (Test-Path $ROOT)
{
    Write-Output "根路径: `"$ROOT`""
    
    if (Test-Path $FAVICON_DB)
    {
        Write-Output "删除 FAVICON_DB: `"$FAVICON_DB`""
        Remove-Item -Recurse $FAVICON_DB
    }
    if (Test-Path $FAVICON_DB_JOURNAL)
    {
        Write-Output "删除 FAVICON_DB_JOURNAL: `"$FAVICON_DB_JOURNAL`""
        Remove-Item -Recurse $FAVICON_DB_JOURNAL
    }
    if (Test-Path $WEB_APPLICATIONS)
    {
        Write-Output "删除 WEB_APPLICATIONS: `"$WEB_APPLICATIONS`""
        Remove-Item -Recurse $WEB_APPLICATIONS
    }
}
else
{
    Write-Output "无法找到根路径: `"$ROOT`""
}

