*** Settings ***
Library         RequestsLibrary




*** Variables ***
${base_url}     https://api.api-ninjas.com/v1/quotes?


*** Keywords ***

*** Test Cases ***
TS01 Verify when input exist category in the list
    ${endpoint}    Create Dictionary    category=computers    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${endpoint}
    Status Should Be    200
    Should Be Equal As Strings          ${response.reason}  OK

TS02 Verify when input doesn't exist category in the list
    ${endpoint}    Create Dictionary    category=ps    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${endpoint}
    Status Should Be    404
    Should Be Equal As Strings          ${response.reason}  NOT FOUND

TS03 Verify when do not input category
    ${endpoint}    Create Dictionary    category=    X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${endpoint}
    Status Should Be    400
    Should Be Equal As Strings          ${response.reason}  Bad Request

TS04 Verify when add more request
    ${endpoint}    Create Dictionary    category=computers  author=Pierre Dukan  X-Api-Key=bIF7IeOciA8Ug1fiwLROYw==OcYET5Wvr3e5ounB
    ${response}=    GET  ${base_url}    ${endpoint}
    Status Should Be    400
    Should Be Equal As Strings          ${response.reason}  Bad Request

TS05 Verify when do not input API Key
    ${endpoint}    Create Dictionary    category=computers    X-Api-Key=
   ${response}=     GET  ${base_url}    ${endpoint}    expected_status=400
   Status Should Be    400
   Should Be Equal As Strings          ${response.reason}  Bad Request
