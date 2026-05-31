$ErrorActionPreference = "Continue"

$Keywords = @("APT", "campaign", "Advanced Persistent Threat", "Zero-day", "Ransomware", "Lateral movement", "Persistence", "Evasion", "Data leaks", "Privilege Escalation", "Trojan", "Infostealer", "Botnet", "Banking Trojan", "spear phishing", "social engineering", "credential dumping", "EDR bypass", "DLL sideloading", "Process Injection", "Reflective DLL", "sandbox escape", "fileless malware", "in-memory malware", "supply chain", "compromise", "breach", "Malware", "CVE", "Exploit", "vulnerability", "phishing", "initial access")

$MitreKeywords = @{
    "T1566" = @{
        Name = "Phishing"
        Keywords = @("phishing", "spear phishing", "malicious email", "email lure", "attachment", "spoofed email", "fake invoice")
    }
    "T1059" = @{
        Name = "Command and Scripting Interpreter"
        Keywords = @("powershell", "pwsh", "ps1", "cmd.exe", "command line", "bash", "sh", "zsh", "python", "python script", "wscript", "cscript", "javascript", "vbscript")
    }
    "T1055" = @{
        Name = "Process Injection"
        Keywords = @("process injection", "dll injection", "reflective loading", "hollowing", "process hollowing", "thread injection", "apc injection")
    }
    "T1190" = @{
        Name = "Exploit Public-Facing Application"
        Keywords = @("web exploit", "sql injection", "sqli", "rce", "remote code execution", "zero-day", "path traversal", "file upload exploit")
    }
    "T1078" = @{
        Name = "Valid Accounts"
        Keywords = @("compromised credentials", "stolen password", "valid account", "successful logon", "unauthorized login", "credential reuse")
    }
    "T1021" = @{
        Name = "Remote Services"
        Keywords = @("rdp", "remote desktop", "ssh", "smb", "psexec", "winrm", "remote login", "vnc", "teamviewer", "anydesk")
    }
    "T1105" = @{
        Name = "Ingress Tool Transfer"
        Keywords = @("download payload", "curl", "wget", "bitsadmin", "file transfer", "dropper", "stager", "malware download")
    }
    "T1486" = @{
        Name = "Data Encrypted for Impact"
        Keywords = @("ransomware", "encryption", "encrypted files", "crypto locker", "ransom note", "file encryption")
    }
    "T1082" = @{
        Name = "System Information Discovery"
        Keywords = @("system info", "host discovery", "os version", "hardware info", "environment discovery")
    }
    "T1071" = @{
        Name = "Application Layer Protocol"
        Keywords = @("c2", "command and control", "c&c", "http c2", "dns tunneling", "https beacon", "websocket")
    }
    "T1083" = @{
        Name = "File and Directory Discovery"
        Keywords = @("file search", "directory listing", "dir listing", "file enumeration", "tree", "find", "ls", "get-childitem")
    }
    "T1574" = @{
        Name = "Hijack Execution Flow"
        Keywords = @("dll hijacking", "search order hijack", "path interception", "side loading")
    }
    "T1003" = @{
        Name = "OS Credential Dumping"
        Keywords = @("mimikatz", "lsass dump", "procdump lsass", "sam dump", "credential dumping", "sekurlsa")
    }
    "T1027" = @{
        Name = "Obfuscated Files or Information"
        Keywords = @("obfuscation", "encoded", "base64 payload", "packed malware", "steganography", "encrypted payload")
    }
    "T1070" = @{
        Name = "Indicator Removal"
        Keywords = @("clear logs", "log deletion", "wevtutil", "anti-forensics", "clear event log")
    }
    "T1204" = @{
        Name = "User Execution"
        Keywords = @("user clicked", "user opened", "malicious macro", "document execution", "unsafe download")
    }
    "T1053" = @{
        Name = "Scheduled Task/Job"
        Keywords = @("schtasks", "cron job", "task scheduler", "at command", "persistent task")
    }
    "T1562" = @{
        Name = "Impair Defenses"
        Keywords = @("disable antivirus", "tamper protection", "disable firewall", "stop security service", "endpoint protection disabled")
    }
    "T1087" = @{
        Name = "Account Discovery"
        Keywords = @("user enumeration", "net user", "active directory users", "whoami", "account discovery")
    }
    "T1018" = @{
        Name = "Remote System Discovery"
        Keywords = @("network scan", "nmap", "ping sweep", "port scan", "host scan", "net view")
    }
}

$Feeds = @(
    "https://www.thehackernews.com/feeds/posts/default",
    "https://www.securelist.com/feed/",
    "https://www.microsoft.com/en-us/security/blog/feed/",
    "https://unit42.paloaltonetworks.com/feed/",
    "https://www.welivesecurity.com/feed/",
    "https://www.crowdstrike.com/blog/feed/",
    "https://www.mandiant.com/resources/blog/rss.xml",
    "https://research.checkpoint.com/feed/",
    "https://blog.badsectorlabs.com/feeds/all.atom.xml",
    "https://cyberbuilders.substack.com/feed",
    "https://www.ncsc.gov.uk/api/1/services/v1/all-rss-feed.xml",
    "https://blogs.cisco.com/security/feed",
    "http://feeds.trendmicro.com/TrendMicroResearch",
    "https://www.bleepingcomputer.com/feed/",
    "https://www.techrepublic.com/rssfeeds/topic/cybersecurity/",
    "https://www.proofpoint.com/us/rss.xml",
    "https://www.imperva.com/blog/feed/",
    "https://heimdalsecurity.com/blog/feed/",
    "https://www.yeswehack.com/rss.xml",
    "https://feeds.feedburner.com/GoogleOnlineSecurityBlog",
    "https://heimdalsecurity.com/blog/feed/",
    "https://any.run/cybersecurity-blog/feed/",
    "https://www.exploitone.com/feed/",
    "https://www.cisa.gov/cybersecurity-advisories/all.xml",
    "https://hackread.com/feed/",
    "https://www.hackmageddon.com/feed/",
    "https://www.infosecurity-magazine.com/rss/news/",
    "https://krebsonsecurity.com/feed/",
    "https://www.zdnet.com/news/rss.xml",
    "https://blog.0patch.com/feeds/posts/default",
    "https://www.bitdefender.com/nuxt/api/en-us/rss/labs/",
    "https://feeds.feedburner.com/feedburner/Talos",
    "https://blog.cloudflare.com/tag/security/rss",
    "https://projectzero.google/feed.xml",
    "https://www.malwarebytes.com/blog/feed/index.xml",
    "https://www.cisecurity.org/feed/advisories",
    "https://isc.sans.edu/rssfeed_full.xml",
    "https://nao-sec.org/feed",
    "https://www.reddit.com/r/cybersecurity/.rss",
    "https://www.reddit.com/r/netsec/.rss",
    "https://www.reddit.com/r/blueteamsec/.rss",
    "https://www.reddit.com/r/purpleteamsec/.rss",
    "https://www.reddit.com/r/redteamsec/.rss",
    "https://blog.qualys.com/feed",
    "https://blog.quarkslab.com/feeds/all.rss.xml",
    "https://sensepost.com/rss.xml",
    "https://www.sentinelone.com/labs/feed/",
    "https://www.darkreading.com/rss.xml",
    "https://cybersecuritynews.com/feed/"
)

$ScriptRoot = $PSScriptRoot
if (-not $ScriptRoot) { $ScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Path }
$ProjectRoot = Split-Path -Parent $ScriptRoot
$DataPath = Join-Path $ProjectRoot "data"
$JsonPath = Join-Path $DataPath "feed-data.json"

if (-not (Test-Path $DataPath)) {
    New-Item -ItemType Directory -Force -Path $DataPath | Out-Null
}

$Results = New-Object System.Collections.Generic.List[PSObject]
$ExistingLinks = @{}
$PreviousArticles = @()

if (Test-Path $JsonPath) {
    Write-Host "[*] Loading existing data for deduplication..." -ForegroundColor Yellow
    try {
        $existingJson = Get-Content -Path $JsonPath -Raw -Encoding UTF8 | ConvertFrom-Json
        if ($existingJson.articles) {
            foreach ($article in $existingJson.articles) {
                if ($article.lnk -and -not $ExistingLinks.ContainsKey($article.lnk)) {
                    $ExistingLinks[$article.lnk] = $true
                }
                $PreviousArticles += [PSCustomObject]@{
                    ts    = $article.ts
                    dt    = $article.dt
                    src   = $article.src
                    ttl   = $article.ttl
                    kw    = $article.kw
                    mitre = $article.mitre
                    lnk   = $article.lnk
                    isNew = $false
                }
            }
        }
        Write-Host "[+] Loaded $($ExistingLinks.Count) existing links." -ForegroundColor Green
    } catch {
        Write-Host "[!] Error reading existing data: $($_.Exception.Message)" -ForegroundColor Red
        $ExistingLinks = @{}
        $PreviousArticles = @()
    }
}

function Get-AllTextContent {
    param($Item)
    $textParts = @()

    $fieldsToCheck = @(
        'title', 'description', 'summary', 'content',
        'encoded', 'contentEncoded', 'content:encoded',
        '#text', 'subtitle', 'rights', 'category'
    )

    foreach ($field in $fieldsToCheck) {
        try {
            if ($Item.PSObject.Properties[$field]) {
                $value = $Item.$field
                if ($value -is [string] -and $value.Trim() -ne "") {
                    $textParts += $value
                } elseif ($value -is [System.Xml.XmlElement]) {
                    $textParts += $value.InnerText
                } elseif ($value -is [array]) {
                    foreach ($v in $value) {
                        if ($v -is [string]) {
                            $textParts += $v
                        } elseif ($v.InnerText) {
                            $textParts += $v.InnerText
                        }
                    }
                }
            }
        } catch {
            continue
        }
    }

    try {
        if ($Item.'content:encoded') {
            $textParts += $Item.'content:encoded'
        }
    } catch { }

    $combinedText = $textParts -join " "
    $combinedText = $combinedText -replace '<[^>]+>', ' '
    $combinedText = $combinedText -replace '&nbsp;', ' '
    $combinedText = $combinedText -replace '&amp;', '&'
    $combinedText = $combinedText -replace '&lt;', '<'
    $combinedText = $combinedText -replace '&gt;', '>'
    $combinedText = $combinedText -replace '&quot;', '"'
    $combinedText = $combinedText -replace '&#39;', "'"
    $combinedText = $combinedText -replace '\s+', ' '

    return $combinedText.Trim()
}

function Get-MitreTechniques {
    param([string]$Text)

    $detectedTechniques = @()

    foreach ($techniqueId in $MitreKeywords.Keys) {
        $technique = $MitreKeywords[$techniqueId]
        foreach ($keyword in $technique.Keywords) {
            if ($Text -match "(?i)\b$keyword\b") {
                $detectedTechniques += "$techniqueId - $($technique.Name)"
                break
            }
        }
    }

    return $detectedTechniques | Sort-Object -Unique
}

function Get-ItemLink {
    param($Item, $FeedUrl)
    $extractedLink = $null

    if ($FeedUrl -match '0patch\.com') {
        if ($Item.link -and $Item.link -is [string] -and $Item.link -match '^https?://blog\.0patch\.com/\d{4}/\d{2}/' -and $Item.link -notmatch '/feeds/|/comments/') {
            return $Item.link.Trim()
        }
        if ($Item.guid) {
            $guidText = if ($Item.guid -is [string]) { $Item.guid } else { $Item.guid.'#text' }
            if ($guidText -match '^https?://blog\.0patch\.com/\d{4}/\d{2}/[^/]+\.html') {
                return $guidText.Trim()
            }
        }
        $contentToSearch = ""
        if ($Item.content) {
            if ($Item.content -is [string]) { $contentToSearch += $Item.content }
            else { $contentToSearch += $Item.content.InnerText }
        }
        if ($Item.description) {
            if ($Item.description -is [string]) { $contentToSearch += " " + $Item.description }
            else { $contentToSearch += " " + $Item.description.InnerText }
        }
        if ($contentToSearch -match 'href="(https?://blog\.0patch\.com/\d{4}/\d{2}/[^"]+\.html)"') {
            return $matches[1].Trim()
        }
    }

    if ($FeedUrl -match 'any\.run') {
        if ($Item.link) {
            if ($Item.link -is [string]) { $extractedLink = $Item.link }
            elseif ($Item.link.'#text') { $extractedLink = $Item.link.'#text' }
            elseif ($Item.link.href) { $extractedLink = $Item.link.href }
        }
        if (-not $extractedLink -and $Item.guid) {
            if ($Item.guid -is [string]) { $extractedLink = $Item.guid }
            elseif ($Item.guid.'#text') { $extractedLink = $Item.guid.'#text' }
        }
        if (-not $extractedLink -and $Item.id) { $extractedLink = $Item.id }
        if ($extractedLink) {
            if ($extractedLink -match '^/') { $extractedLink = "https://any.run" + $extractedLink }
            elseif ($extractedLink -match '^cybersecurity-blog') { $extractedLink = "https://any.run/" + $extractedLink }
            elseif ($extractedLink -match '^\?p=') { $extractedLink = "https://any.run/cybersecurity-blog/" + $extractedLink }
            if ($extractedLink -match '^https?://any\.run/' -and $extractedLink -notmatch '\.xml$|/feed/?$') {
                return $extractedLink.Trim()
            }
        }
        $contentToSearch = ""
        if ($Item.description) {
            $contentToSearch += if ($Item.description -is [string]) { $Item.description } else { $Item.description.InnerText }
        }
        if ($Item.content) {
            $contentToSearch += " " + (if ($Item.content -is [string]) { $Item.content } else { $Item.content.InnerText })
        }
        if ($contentToSearch -match 'href="(https?://any\.run/[^"]+)"') {
            return $matches[1].Trim()
        }
    }

    if ($FeedUrl -match 'reddit\.com') {
        $redditPostLink = $null
        if ($Item.link -and $Item.link -match 'reddit\.com/r/[^/]+/comments/') { $redditPostLink = $Item.link }
        elseif ($Item.id -and $Item.id -match 'reddit\.com/r/[^/]+/comments/') { $redditPostLink = $Item.id }
        elseif ($Item.guid) {
            $guidValue = if ($Item.guid -is [string]) { $Item.guid } else { $Item.guid.'#text' }
            if ($guidValue -and $guidValue -match 'reddit\.com/r/[^/]+/comments/') { $redditPostLink = $guidValue }
        }
        if (-not $redditPostLink) {
            $contentToSearch = ""
            if ($Item.content) {
                $contentToSearch += if ($Item.content -is [string]) { $Item.content } else { $Item.content.InnerText }
            }
            if ($Item.description) {
                $contentToSearch += " " + (if ($Item.description -is [string]) { $Item.description } else { $Item.description.InnerText })
            }
            if ($contentToSearch) {
                if ($contentToSearch -match 'href="(https?://[^"]*reddit\.com/r/[^/]+/comments/[^"]*)"') {
                    $redditPostLink = $matches[1].Trim()
                }
                if (-not $redditPostLink -and $contentToSearch -match '(https?://[^\s<>"]*reddit\.com/r/[^/]+/comments/[^\s<>"]*)') {
                    $redditPostLink = $matches[1].Trim()
                }
            }
        }
        if ($redditPostLink) { return $redditPostLink.Trim() }
        return $null
    }

    $linkSources = @(
        { $Item.link },
        { $Item.guid },
        { $Item.id },
        { $Item.url },
        { $Item.'feedburner:origLink' },
        { $Item.origLink }
    )

    foreach ($source in $linkSources) {
        try {
            $value = & $source
            if ($value) {
                if ($value -is [string]) {
                    if ($value -match '^https?://' -and $value -notmatch '\.xml$|/feed/?$|/rss/?$|/feeds/|/comments/') {
                        $extractedLink = $value; break
                    }
                }
                elseif ($value.href) {
                    if ($value.href -match '^https?://' -and $value.href -notmatch '\.xml$|/feed/?$|/rss/?$|/feeds/|/comments/') {
                        $extractedLink = $value.href; break
                    }
                }
                elseif ($value.'#text') {
                    if ($value.'#text' -match '^https?://' -and $value.'#text' -notmatch '\.xml$|/feed/?$|/rss/?$|/feeds/|/comments/') {
                        $extractedLink = $value.'#text'; break
                    }
                }
                elseif ($value.InnerText) {
                    if ($value.InnerText -match '^https?://' -and $value.InnerText -notmatch '\.xml$|/feed/?$|/rss/?$|/feeds/|/comments/') {
                        $extractedLink = $value.InnerText; break
                    }
                }
                elseif ($value -is [array]) {
                    foreach ($linkItem in $value) {
                        if ($linkItem -is [string] -and $linkItem -match '^https?://' -and $linkItem -notmatch '\.xml$|/feed/?$|/rss/?$|/feeds/|/comments/') {
                            $extractedLink = $linkItem; break
                        } elseif ($linkItem.href -and $linkItem.href -match '^https?://' -and $linkItem.href -notmatch '\.xml$|/feed/?$|/rss/?$|/feeds/|/comments/') {
                            $extractedLink = $linkItem.href; break
                        }
                    }
                    if ($extractedLink) { break }
                }
            }
        } catch { continue }
    }

    if ((-not $extractedLink -or $extractedLink -eq $FeedUrl) -and $FeedUrl -match 'cisa\.gov') {
        if ($Item.id -or $Item.guid) {
            $advisoryId = if ($Item.id) { $Item.id } else { $Item.guid }
            if ($advisoryId -match '(AA|ICSA?|ICS-?ALERT|CSAF)-\d{2}-\d{3,6}') {
                $extractedLink = "https://www.cisa.gov/news-events/cybersecurity-advisories/$advisoryId"
            }
        }
    }

    if ((-not $extractedLink -or $extractedLink -eq $FeedUrl) -and $FeedUrl -match 'talosintelligence|feedburner/Talos') {
        if ($Item.description -match 'href="(https?://[^"]+)"') {
            $extractedLink = $matches[1]
        }
    }

    if (-not $extractedLink -or
        $extractedLink -match '\.xml$|/feed/?$|/rss/?$|/feeds/.*comments|/comments/' -or
        $extractedLink -eq $FeedUrl) {
        $extractedLink = $FeedUrl
    }

    return $extractedLink.Trim()
}

Write-Host "`n=== ThreatFeed Analyzer - Automated Run ===" -ForegroundColor Cyan
Write-Host "[*] Scraping RSS Feeds..." -ForegroundColor Cyan
Write-Host "Total Feeds: $($Feeds.Count)" -ForegroundColor Yellow

$CurrentFeed = 0
$TotalFeeds = $Feeds.Count
$NewLinksCount = 0
$DuplicatesSkipped = 0

foreach ($url in $Feeds) {
    $CurrentFeed++
    $FeedName = ([System.Uri]$url).Host
    Write-Host "[$CurrentFeed/$TotalFeeds] Checking: $FeedName" -ForegroundColor Gray -NoNewline

    try {
        $webRequest = $null
        $fetchSuccess = $false

        $userAgents = @(
            "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
            "Mozilla/5.0 (compatible; Feedfetcher-Google; +http://www.google.com/feedfetcher.html)",
            "FeedBurner/1.0 (http://www.FeedBurner.com)"
        )

        foreach ($agent in $userAgents) {
            try {
                $feedHost = ([System.Uri]$url).Scheme + "://" + ([System.Uri]$url).Host
                $webRequest = Invoke-WebRequest -Uri $url -TimeoutSec 30 -UseBasicParsing -Headers @{
                    "User-Agent"      = $agent
                    "Accept"          = "application/rss+xml, application/atom+xml, application/xml, text/xml, */*"
                    "Accept-Language"  = "en-US,en;q=0.9"
                    "Cache-Control"   = "no-cache"
                    "Referer"         = $feedHost
                }
                $fetchSuccess = $true
                break
            } catch {
                $errMsg = $_.Exception.Message
                if ($errMsg -match "timed out|timeout|TaskCanceledException") {
                    Start-Sleep -Seconds 2
                    continue
                }
                if ($errMsg -match "403|Forbidden") {
                    Start-Sleep -Seconds 1
                    continue
                }
                if ($errMsg -match "404|401|410|Not Found|Unauthorized|Gone") {
                    Write-Host " - Unavailable ($errMsg)" -ForegroundColor DarkYellow
                    break
                }
                throw
            }
        }

        if (-not $fetchSuccess -or $null -eq $webRequest) { continue }

        $content = [xml]$webRequest.Content

        $items = @()
        if ($content.rss.channel.item) { $items = $content.rss.channel.item }
        elseif ($content.feed.entry) { $items = $content.feed.entry }
        elseif ($content.rdf.item) { $items = $content.rdf.item }

        if ($items.Count -eq 0) {
            Write-Host " - No items found" -ForegroundColor DarkYellow
            continue
        }

        $MatchCount = 0
        $DuplicateCount = 0

        foreach ($item in $items) {
            $matchedKeywords = @()
            $fullText = Get-AllTextContent -Item $item

            if ([string]::IsNullOrWhiteSpace($fullText)) { continue }

            foreach ($keyword in $Keywords) {
                if ($fullText -match "(?i)\b$keyword\b") {
                    $matchedKeywords += $keyword
                }
            }

            if ($matchedKeywords.Count -gt 0) {
                $itemTitle = "Untitled"
                if ($item.title) {
                    if ($item.title -is [string]) { $itemTitle = $item.title.ToString().Trim() }
                    elseif ($item.title.'#text') { $itemTitle = $item.title.'#text'.ToString().Trim() }
                    else { $itemTitle = $item.title.InnerText.Trim() }
                }

                $itemLink = Get-ItemLink -Item $item -FeedUrl $url

                if ([string]::IsNullOrWhiteSpace($itemLink)) { continue }

                if ($ExistingLinks.ContainsKey($itemLink)) {
                    $DuplicateCount++
                    $DuplicatesSkipped++
                    continue
                }

                $MatchCount++
                $NewLinksCount++

                $itemDate = Get-Date
                if ($item.pubDate) {
                    try { $itemDate = [DateTime]$item.pubDate } catch { }
                } elseif ($item.published) {
                    try { $itemDate = [DateTime]$item.published } catch { }
                }

                $mitreTechniques = Get-MitreTechniques -Text $fullText
                $mitreString = if ($mitreTechniques.Count -gt 0) { $mitreTechniques -join "; " } else { "" }

                $timestamp = [Math]::Floor(([DateTimeOffset]$itemDate).ToUnixTimeSeconds())
                $dateStr = $itemDate.ToString("yyyy-MM-dd HH:mm")

                $Results.Add([PSCustomObject]@{
                    ts    = $timestamp
                    dt    = $dateStr
                    src   = $url
                    ttl   = $itemTitle
                    kw    = ($matchedKeywords | Sort-Object -Unique) -join ", "
                    mitre = $mitreString
                    lnk   = $itemLink
                    isNew = $true
                })
            }
        }

        if ($MatchCount -gt 0) {
            $statusMsg = " - Found $MatchCount new"
            if ($DuplicateCount -gt 0) { $statusMsg += " ($DuplicateCount duplicates skipped)" }
            Write-Host $statusMsg -ForegroundColor Green
        } else {
            Write-Host " - No matches" -ForegroundColor DarkGray
        }
    } catch {
        Write-Host " - Failed: $($_.Exception.Message)" -ForegroundColor Red
    }
}

Write-Host "`n[*] Processing results..." -ForegroundColor Cyan
Write-Host "New matches found: $NewLinksCount" -ForegroundColor Green
Write-Host "Duplicates skipped: $DuplicatesSkipped" -ForegroundColor Yellow

$AllArticles = @()
$UniqueNewResults = $Results | Sort-Object lnk -Unique
foreach ($item in $UniqueNewResults) {
    $AllArticles += $item
}
foreach ($item in $PreviousArticles) {
    $AllArticles += $item
}

$AllArticles = $AllArticles | Sort-Object {
    [int]$_.ts
} -Descending

$KeywordStats = @{}
foreach ($article in $AllArticles) {
    if ($article.kw) {
        $kwList = $article.kw -split ',\s*'
        foreach ($kw in $kwList) {
            $kw = $kw.Trim()
            if ($kw -ne "") {
                if ($KeywordStats.ContainsKey($kw)) { $KeywordStats[$kw]++ }
                else { $KeywordStats[$kw] = 1 }
            }
        }
    }
}

$MitreStats = @{}
foreach ($article in $AllArticles) {
    if ($article.mitre) {
        $techList = $article.mitre -split ';\s*'
        foreach ($tech in $techList) {
            $tech = $tech.Trim()
            if ($tech -ne "") {
                if ($MitreStats.ContainsKey($tech)) { $MitreStats[$tech]++ }
                else { $MitreStats[$tech] = 1 }
            }
        }
    }
}

$outputData = [ordered]@{
    metadata = [ordered]@{
        lastUpdated       = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
        totalFeeds        = $TotalFeeds
        totalArticles     = $AllArticles.Count
        newThisRun        = $NewLinksCount
        duplicatesSkipped = $DuplicatesSkipped
    }
    articles     = @($AllArticles | ForEach-Object {
        [ordered]@{
            ts    = $_.ts
            dt    = $_.dt
            src   = $_.src
            ttl   = $_.ttl
            kw    = $_.kw
            mitre = $_.mitre
            lnk   = $_.lnk
            isNew = $_.isNew
        }
    })
    keywordStats = $KeywordStats
    mitreStats   = $MitreStats
}

$jsonOutput = $outputData | ConvertTo-Json -Depth 10 -Compress
[System.IO.File]::WriteAllText($JsonPath, $jsonOutput, [System.Text.UTF8Encoding]::new($false))

Write-Host "`n[+] Data written to: $JsonPath" -ForegroundColor Green
Write-Host "Total articles: $($AllArticles.Count)" -ForegroundColor Cyan
Write-Host "New this run: $NewLinksCount" -ForegroundColor Green
Write-Host "MITRE Techniques: $($MitreStats.Count)" -ForegroundColor Magenta
