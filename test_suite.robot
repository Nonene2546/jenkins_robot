*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       http://127.0.0.1:80

*** Test Cases ***

Test Happy Path Plus
    [Documentation]    Test happy path where 1 + 4 = 5
    ${response}=       GET  ${BASE_URL}/plus/1/4
    Status Should Be   200    ${response}
    ${data}=           To Json    ${response.content}
    Should Be Equal    ${data}    5

Test Decimal Plus
    [Documentation]    Test decimal addition where 1.5 + 2.5 = 4.0
    ${response}=       GET  ${BASE_URL}/plus/1.5/2.5
    Status Should Be   200    ${response}
    ${data}=           To Json    ${response.content}
    Should Be Equal    ${data}    4.0

Test Invalid Input
    [Documentation]    Test invalid input handling where `a + b` should return 400
    ${response}=       GET  ${BASE_URL}/plus/a/b
    Status Should Be   400    ${response}
    
*** Keywords ***
Status Should Be
    [Arguments]    ${expected_status}    ${response}
    Should Be Equal As Numbers    ${response.status_code}    ${expected_status}

To Json
    [Arguments]    ${content}
    ${json_data}=    Evaluate    json.loads('''${content}''')    json
    Return    ${json_data}
