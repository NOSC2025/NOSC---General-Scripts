$source = "C:\SourceFolder"
$destination = "C:\DestinationFolder"

# Move all files from source to destination
Get-ChildItem -Path $source -File | ForEach-Object {
    Move-Item -Path $_.FullName -Destination $destination -Force
}
