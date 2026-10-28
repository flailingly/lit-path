# Serves docs/ at http://localhost:8765 for local testing. Stop with Ctrl+C or by ending the process.
param([string]$Root = (Split-Path $PSScriptRoot -Parent), [int]$Port = 8765)
$dir = Join-Path $Root 'docs'
$l = New-Object System.Net.HttpListener; $l.Prefixes.Add("http://localhost:$Port/"); $l.Start()
Write-Host "Serving $dir at http://localhost:$Port/"
$types = @{ '.html'='text/html; charset=utf-8'; '.png'='image/png'; '.json'='application/json'; '.webmanifest'='application/manifest+json' }
while ($true) {
  $c = $l.GetContext(); $p = $c.Request.Url.AbsolutePath.TrimStart('/'); if ($p -eq '') { $p = 'index.html' }
  $f = Join-Path $dir $p
  if (Test-Path $f -PathType Leaf) { $b = [IO.File]::ReadAllBytes($f); $c.Response.ContentType = $types[[IO.Path]::GetExtension($f)]; $c.Response.OutputStream.Write($b,0,$b.Length) } else { $c.Response.StatusCode = 404 }
  $c.Response.Close()
}
