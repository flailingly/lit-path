# Wraps lamplighter.html into a standalone page in lamplighter-phone/ and writes the web app manifest.
param([string]$Root = (Split-Path $PSScriptRoot -Parent))
$out = Join-Path $Root 'lamplighter-phone'
New-Item -ItemType Directory -Force $out | Out-Null
$head = '<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"><meta name="theme-color" content="#e9dcbc"><meta name="mobile-web-app-capable" content="yes"><meta name="apple-mobile-web-app-capable" content="yes"><meta name="apple-mobile-web-app-status-bar-style" content="default"><meta name="apple-mobile-web-app-title" content="Scout''s Folio"><link rel="manifest" href="manifest.webmanifest"><link rel="apple-touch-icon" href="icon-180.png"><link rel="icon" href="icon-192.png"><style>[hidden]{display:none!important}body{margin:0}img{max-width:100%}</style></head><body>'
$body = [IO.File]::ReadAllText((Join-Path $Root 'lamplighter.html'))
$utf8 = New-Object System.Text.UTF8Encoding $false
[IO.File]::WriteAllText((Join-Path $out 'index.html'), $head + "`n" + $body + "`n</body></html>`n", $utf8)
Copy-Item (Join-Path $Root 'places.json') (Join-Path $out 'places.json') -Force
$manifest = @'
{
  "name": "Scout's Folio",
  "short_name": "Scout's Folio",
  "start_url": "./",
  "display": "standalone",
  "orientation": "portrait",
  "background_color": "#e9dcbc",
  "theme_color": "#e9dcbc",
  "icons": [
    { "src": "icon-192.png", "sizes": "192x192", "type": "image/png" },
    { "src": "icon-512.png", "sizes": "512x512", "type": "image/png" }
  ]
}
'@
[IO.File]::WriteAllText((Join-Path $out 'manifest.webmanifest'), $manifest, $utf8)
Get-ChildItem $out | Select-Object Name, Length
