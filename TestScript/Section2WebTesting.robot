*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         Collections

*** Variables ***
${base_url}     https://api.api-ninjas.com/v1/quotes?
@{quotes}
${note}      //div[@id='notes']
${first_trash}     //button[@id='action_trash']
${second_trash}     //button[@class='btn confirm pull-right span4 trash appear']

*** Keywords ***
Get 3 Quotes From API
    FOR    ${i}    IN RANGE    3
    ${endpoint}    Create Dictionary    category=computers    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${endpoint}
    Status Should Be    200
   log   ${response.json()}
   ${first_object}=    Get From List    ${response.json()}    0  ## to get object from list (There's only one object in the list )
   ${quote}=    Get From Dictionary    ${first_object}   quote   ## to get quote from dict
    Append To List    ${quotes}    ${quote}   ## to collect quote (3) to quotes
    END
     log   ${quotes}

Open Notepad Online Website
    Open Browser     https://www.memonotepad.com/   Chrome

Add Quotes into Notepad Online
    Input Text    ${note}      ${quotes}

Delete Quotes from Notepad Online
   Click Button    ${first_trash}
   Wait Until Element Is Visible     ${second_trash}
   Click Button   ${second_trash}

Check That Quotes Have Been Deleted
   Sleep  3s
   Element Text Should NOT Be    ${note}     ${quotes}      ## to make sure that quotes have been deleted
   Sleep  3s

*** Test Cases ***
TS01 Get Quotes and Input Them into Notepad Online
   Get 3 Quotes From API
   Open Notepad Online Website
   Add Quotes into Notepad Online
   Delete Quotes from Notepad Online
   Check That Quotes Have Been Deleted