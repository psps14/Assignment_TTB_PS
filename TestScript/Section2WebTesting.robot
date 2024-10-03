*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         Collections


*** Variables ***
${base_url}     https://api.api-ninjas.com/v1/quotes?

*** Keywords ***

*** Test Cases ***
TS01 Get Quotes and Input Them into Notepad Online
#### To Get 3 Quotes
   ${quotes}    Create List
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
#    log   ${quotes[0]}
#    log   ${quotes[1]}
#    log   ${quotes[2]}


   #### Add Quote into Notepad Online
   Open Browser     https://www.memonotepad.com/   Chrome
   Input Text    //div[@id='notes']     ${quotes}
#   Input Text    //div[@id='notes']     ${quotes[1]}
#   Input Text    //div[@id='notes']     ${quotes[2]}
   #### Add Feature Delete
   Click Button    //button[@id='action_trash']
   Sleep  3s
   Element Should Be Visible   //button[@class='btn confirm pull-right span4 trash appear']
   Click Button   //button[@class='btn confirm pull-right span4 trash appear']
   Sleep  3s
   Element Text Should NOT Be    //div[@id='notes']    ${quotes}      ## to make sure that quotes have been deleted
   Sleep  3s



