*** Setting ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         JsonValidator
Library         String
Library         Collections



*** Variables ***
${base_url}     https://api.api-ninjas.com
#${quote}        $.quote

*** Keywords ***
To JSON
    [Arguments]    ${content}
    ${json}=    Convert To JSON     ${content}
    [Return]    ${json}

Convert To JSON
    [Arguments]    ${content}
    ${json}=    Evaluate json.loads("""${content}""")  modules=json
    [Return]    ${json}
*** Test Cases ***
Test Title
    create session  session1    ${base_url}     disable_warnings=1
    ${endpoint}    set variable        /v1/quotes?category=happiness&X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    get on session  session1    ${endpoint}
    log to console  ${response.headers}
    log to console  ${response.status_code}
    log to console  ${response.content}
    log             ${response.content}

    #Validations
    ${status_code}=    convert to string     ${response.status_code}
    should be equal     ${status_code}    200

#    ${json_response}=    convert string to json    ${response.content}
    ${contents}=         get value from json        ${quote}
    ${contents}=         convert to string     ${contents}
    log       ${contents}


Test Get Quote
     create session  session1    ${base_url}     disable_warnings=1
    ${endpoint}    set variable        /v1/quotes?category=happiness&X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    get on session  session1    ${endpoint}
    Status Should Be      200
    ${json}=    To JSON      ${response.content}
    ${quote}=    Get From Dictionary    ${json}    $.quote

TS01

    Open Browser     https://www.google.com/   Chrome
    Log To Console     ("Hello World")
TS02
#    ${body}    Create Dictionary    category=happiness
    ${response}    GET    https://api.api-ninjas.com/v1/quotes? ${body}
    Status Should Be    200
    Log    ${response.json()}

TS03
    ${params}    Create Dictionary    category=computers    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  https://api.api-ninjas.com/v1/quotes?    ${params}
    Status Should Be    200
    log   ${response.content}
    log   ${response.json()}
    ${resp.json()}=     RequestsLibrary.To Json     ${response.text}
#    ${value}=    RequestsLibrary.GET     ${response.content}        $.totalJobs
     ${quote}    JsonValidator.Get Elements       ${resp.json()}   $.body
     log   ${quote}
#    https://api.api-ninjas.com/v1/quotes?category=computers&X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB

TS04
#    ${params}    Create Dictionary    category=computers    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5oun
#    ${response}=    GET  https://api.api-ninjas.com/v1/quotes?    ${params}
#    Status Should Be    400

    create session  session1    ${base_url}     disable_warnings=1
    ${endpoint}    set variable        /v1/quotes?category=happiness
    ${response}=    get on session  session1    ${endpoint}
    log to console  ${response.headers}
    log to console  ${response.status_code}
    log to console  ${response.content}
    log             ${response.content}

    #Validations
    ${status_code}=    convert to string     ${response.status_code}
    should be equal     ${status_code}    400



TS05
   Open Browser     https://www.memonotepad.com/   Chrome
   Input Text    //div[@id='notes']     PS

TS05_Feature_Delete
   Open Browser     https://www.memonotepad.com/   Chrome
   Input Text    //div[@id='notes']     PS
   Click Button    //button[@id='action_trash']
      Sleep  5s
   Element Should Be Visible   //button[@class='btn confirm pull-right span4 trash appear']
   Click Button   //button[@class='btn confirm pull-right span4 trash appear']
   Sleep  5s
   Element Text Should NOT Be    //div[@id='notes']    PS
   Sleep  10s


Test
    Create Session    jobsList    'url=https://api.api-ninjas.com/v1/quotes?'
    ${response}    GET On Session    jobsList    category=computers    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    Log    ${response.status_code} # Status code
    Log    ${response.json()}      # Json Response from API
    ${totalJobsInList}     JsonValidator.Get Elements    ${response.json()}    $.quote
#    ${companyInJob1}     JsonValidator.Get Elements    ${response.json()}    $.jobs[0].company
#    ${jobLocationInJob2}     JsonValidator.Get Elements    ${response.json()}    $.jobs[1].jobLocation
#    Log Many    ${totalJobsInList}	  ${companyInJob1}    ${jobLocationInJob2}
     Log     ${totalJobsInList}


Test01
   Create Session   ninjas   https://api.api-ninjas.com/v1/quotes?
   ${resp}=    GET On Session    ninjas   category=computers    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
   log    ${resp.content}


Test02
    ${response}=    GET  https://petstore.swagger.io/v2/store/inventory
    Status Should Be    200
   log   ${response.json()}
   ${sold}=    Get From Dictionary   ${response.json()}    sold
   log   ${sold}
TS05
    ${body}    Create Dictionary    category=computers    X-Api-Key=
    ${response}=   Run Keyword and Ignore Error    GET  ${base_url}    ${body}
   Status Should Be    400
   Should Be Equal As Strings          ${response.reason}  Bad Request