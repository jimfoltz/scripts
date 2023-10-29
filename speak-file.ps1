# Windows 10 Text-to-Speech Example

Add-Type -AssemblyName System.Speech
$SpeechSynthesizer = New-Object System.Speech.Synthesis.SpeechSynthesizer
$SpeechSynthesizer.SelectVoice("Microsoft Zira Desktop")
$SpeechSynthesizer.Rate = -2  # -10 is slowest, 10 is fastest

if ($args[1]) {
        Write-Host -ForegroundCOlor red "Writing sound file" $args[1]
        $WavFileOut = Join-Path (Get-location).tostring() -childpath $args[1]
        $SpeechSynthesizer.SetOutputToWaveFile($WavFileOut)
}

#$RecordedText = '
#Thank you for trying out the Think PowerShell Text-to-speech demo.
#Learn more at thinkpowershell.com.
#'
$RecordedText = Get-Content $args[0]

$SpeechSynthesizer.Speak($RecordedText)
$SpeechSynthesizer.Dispose()

Write-Host "Usage: speak-file textfile [saved-audio-file]"
