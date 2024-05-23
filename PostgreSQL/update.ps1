# Not tested script, used ChatGPT to convert linux version

# Define the path to reflect the files in your system
$BWARM_PATH = "C:\opt\bwarm\"

# Function to execute each load function and then compress TSV files to save space
function Refresh-And-Compress {
    param(
        [string]$FunctionName,
        [string]$TarName
    )

    # Run the psql command
    psql -d bwarm -c "SET SCHEMA 'bwarm'; CALL $FunctionName('$BWARM_PATH');"

    # Check if the psql command was successful
    if ($?) {
        # Compress the TSV file into a tar.gz format and then remove the original TSV file
        Compress-Archive -Path "${TarName}.tsv" -DestinationPath "processed/${TarName}.tar.gz" -CompressionLevel Optimal
        Remove-Item "${TarName}.tsv"
    }
}

# Execute each function in parallel using PowerShell jobs
$jobs = @(
    "refresh_parties", "parties",
    "refresh_works", "works",
    "refresh_work_identifiers", "workidentifiers",
    "refresh_work_alternative_titles", "workalternativetitles",
    "refresh_work_right_shares", "workrightshares",
    "refresh_recordings", "recordings",
    "refresh_recording_identifiers", "recordingidentifiers",
    "refresh_recording_alternative_titles", "recordingalternativetitles",
    "refresh_releases", "releases",
    "refresh_release_identifiers", "releaseidentifiers",
    "refresh_work_recordings", "worksrecordings",
    "refresh_unclaimed_work_right_shares", "unclaimedworkrightshares"
)

for ($i = 0; $i -lt $jobs.Count; $i += 2) {
    Start-Job -ScriptBlock $Function:Refresh-And-Compress -ArgumentList $jobs[$i], $jobs[$i + 1]
}

# Wait for all jobs to complete
Get-Job | Wait-Job

# Clean up the jobs
Get-Job | Remove-Job
