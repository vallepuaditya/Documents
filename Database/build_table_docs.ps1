# Parse column metadata and generate complete table documentation
param(
    [string]$MetadataFile = "c:\TrackSystems\Docs\Database\table_metadata.txt",
    [string]$OutputDir = "c:\TrackSystems\Docs\Database\table_schemas"
)

# Read metadata from input (user should paste the tab-delimited data into table_metadata.txt)
if (-not (Test-Path $MetadataFile)) {
    Write-Error "Metadata file not found: $MetadataFile"
    Write-Host "Please create the file and paste your tab-delimited column data"
    exit 1
}

$content = Get-Content $MetadataFile -Raw
$lines = $content -split "`r?`n" | Where-Object { $_.Trim() }

# Parse into table structure
$tables = @{}
foreach ($line in $lines) {
    $fields = $line -split "`t"
    if ($fields.Count -ge 8) {
        $schema = $fields[0] -replace '"', ''
        $tableName = $fields[1] -replace '"', ''
        $columnName = $fields[2] -replace '"', ''
        $dataType = $fields[3] -replace '"', ''
        $charMaxLen = if ($fields.Count -gt 4) { $fields[4] -replace '"', '' } else { '' }
        $numPrec = if ($fields.Count -gt 5) { $fields[5] } else { '' }
        $numScale = if ($fields.Count -gt 6) { $fields[6] } else { '' }
        $nullable = $fields[7] -replace '"', ''
        $defaultVal = if ($fields.Count -gt 8) { $fields[8] -replace '"', '' } else { '' }
        
        if ($schema -eq 'public' -and $tableName) {
            if (-not $tables.ContainsKey($tableName)) {
                $tables[$tableName] = @()
            }
            
            # Build full type string
            $fullType = $dataType
            if ($charMaxLen) {
                $fullType += "($charMaxLen)"
            } elseif ($numPrec -and $numPrec -ne '0') {
                if ($numScale -and $numScale -ne '0') {
                    $fullType += "($numPrec,$numScale)"
                } else {
                    $fullType += "($numPrec)"
                }
            }
            
            $tables[$tableName] += [PSCustomObject]@{
                Column = $columnName
                Type = $fullType
                Nullable = $nullable
                Default = $defaultVal
            }
        }
    }
}

Write-Host "Parsed $($tables.Count) tables"

# Generate markdown for each table
foreach ($tableName in $tables.Keys | Sort-Object) {
    $columns = $tables[$tableName]
    $pkColumn = $columns | Where-Object { $_.Column -match '_id$|^id$' } | Select-Object -First 1
    
    $md = @"
# $tableName Table Schema

**Table:** ``$tableName``

**Purpose:** [FILL: Description of this table's purpose]

**Setup / Defaults:** [FILL: Any default rows or setup requirements]

---

## Dependencies

| Depends On | Relationship | Notes |
|------------|-------------|-------|
| [FILL] | [FILL] | [FILL] |

---

## Columns

| Column Name | Data Type | Nullable | Default | Constraints | Description |
|-------------|-----------|----------|---------|-------------|-------------|
"@

    foreach ($col in $columns) {
        $nullStr = if ($col.Nullable -eq 'NO') { 'NO' } else { 'YES' }
        $defStr = if ($col.Default) { "``$($col.Default)``" } else { '' }
        $constraint = ''
        if ($col.Column -eq $pkColumn.Column) {
            $constraint = 'PRIMARY KEY'
        } elseif ($col.Column -match '_id$' -and $col.Column -ne $pkColumn.Column) {
            $constraint = '[FK - FILL]'
        }
        
        $md += "`n| ``$($col.Column)`` | ``$($col.Type)`` | $nullStr | $defStr | $constraint | [FILL] |"
    }

    $md += @"


---

## Indexes

| Index Name | Columns | Type | Purpose |
|------------|---------|------|---------|
| [FILL] | [FILL] | B-tree | [FILL] |

---

## Foreign Keys

| Column | References | On Delete | On Update | Notes |
|--------|------------|-----------|-----------|-------|
| [FILL] | [FILL] | [FILL] | [FILL] | [FILL] |

---

## Triggers

| Trigger Name | Event | Function | Purpose |
|--------------|-------|----------|---------|
| ``trg_$($tableName)_updated_at`` | BEFORE UPDATE | ``update_updated_at_column()`` | Auto-update updated_at |

---

## Constraints

| Constraint Name | Type | Columns / Expression | Notes |
|-----------------|------|----------------------|-------|
| [FILL] | CHECK/UNIQUE | [FILL] | [FILL] |

---

## Waitlist Support

- [ ] This table directly represents a reservable resource
- [ ] This table has a related waitlist table
- [ ] Waitlist promotion handled by: [FILL]

---

## Audit Requirements

- [ ] Changes logged to: [FILL]
- [ ] Audit function: [FILL]

---

## SQL DDL

``````sql
-- See actual database schema
-- Use: \d $tableName in psql or pg_dump
``````

---

## Notes for Developer

- [FILL: Important notes about this table]
"@

    $outputFile = Join-Path $OutputDir "$tableName.md"
    $md | Out-File -FilePath $outputFile -Encoding UTF8
    Write-Host "Generated: $outputFile"
}

Write-Host "`nComplete! Generated schemas for $($tables.Count) tables"
Write-Host "Next: Fill in [FILL] placeholders with actual FK relationships and descriptions"
