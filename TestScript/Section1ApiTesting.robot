*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         Collections



*** Variables ***
${base_url}     https://api.api-ninjas.com/v1/quotes?


*** Keywords ***

*** Test Cases ***
TS01 Verify when input exist category in the list
    ${body}    Create Dictionary    category=computers    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${body}
    Status Should Be    200
    Should Be Equal As Strings          ${response.reason}  OK

TS02 Verify when input doesn't exist category in the list
    ${body}    Create Dictionary    category=ps    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${body}
    Status Should Be    404
    Should Be Equal As Strings          ${response.reason}  NOT FOUND

TS03 Verify when do not input category
    ${body}    Create Dictionary    category=    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${body}
    Status Should Be    400
    Should Be Equal As Strings          ${response.reason}  Bad Request

TS04 Verify when add more request
    ${body}    Create Dictionary    category=computers  author=Pierre Dukan  X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${body}
    Status Should Be    400
    Should Be Equal As Strings          ${response.reason}  Bad Request

TS05 Verify when do not input API Key
    ${body}    Create Dictionary    category=computers    X-Api-Key=
#    ${response}=   Run Keyword and Ignore Error    GET  ${base_url}    ${body}
   ${response}=     GET  ${base_url}    ${body}    expected_status=400
   Status Should Be    400
   Should Be Equal As Strings          ${response.reason}  Bad Request
