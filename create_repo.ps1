$repoName = 'antigravity-awesome-skills'
$payload = @{name = $repoName; private = $false} | ConvertTo-Json -Compress
$headers = @{Authorization = "token $env:GH_TOKEN"; Accept = 'application/vnd.github+json'}
$response = Invoke-RestMethod -Method Post -Uri 'https://api.github.com/user/repos' -Headers $headers -Body $payload -ErrorAction Stop
Write-Host "Repo URL: $($response.html_url)"

Set-Location -Path 'C:\antigravityAS\antigravity-awesome-skills'
if (-not (Test-Path .git)) { git init }

git add .

git commit -m "Initial commit"

git remote add origin $response.clone_url

git push "https://$env:GH_TOKEN@github.com/$($response.full_name).git" --set-upstream origin master
