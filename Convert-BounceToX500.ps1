#.Description
#  Convert URL Encoded address in a Bounce message to an X500 address
#  that can be added as an alias to the mail-enabled object
#.Parameter bounceAddress
#  URL Encoded bounce message address#
#.Example
#  Convert-BounceToX500 "IMCEAEX-_O=CONTOSO_OU=First+20Administrative+20Group_cn=Recipients_cn=john+5Fjacob+2Esmith@contoso.com"
#.Example
#  "IMCEAEX-_O=CONTOSO_OU=First+20Administrative+20Group_cn=Recipients_cn=john+5Fjacob+2Esmith@contoso.com"|Convert-BounceToX500

[CmdletBinding()]
PARAM (
    [Parameter(Mandatory=$true,ValueFromPipeline=$true)][string]$bounceAddress
)
BEGIN
{
    $domainsuffix = "@contoso.com"
}
PROCESS
{
    if($_) {$bounceAddress = $_}
    #strip the beginning and our domain
    $bounceAddress = $bounceAddress -Replace "IMCEAEX-", ""
    $bounceAddress = $bounceAddress -Replace $domainsuffix, ""
    
    # convert the encoding 
    $bounceAddress = $bounceAddress -Replace "_"  ,"/"
    $bounceAddress = $bounceAddress -Replace "\+20"," "
    $bounceAddress = $bounceAddress -Replace "\+28","("
    $bounceAddress = $bounceAddress -Replace "\+29",")"
    $bounceAddress = $bounceAddress -Replace "\+40","@"
    $bounceAddress = $bounceAddress -Replace "\+40","@"
    $bounceAddress = $bounceAddress -Replace "\+2E","."
    $bounceAddress = $bounceAddress -Replace "\+2C",","
    $bounceAddress = $bounceAddress -Replace "\+5F","-"

    $bounceAddress
}
