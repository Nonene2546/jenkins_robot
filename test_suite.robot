*** Settings ***
Library           RequestsLibrary
Library           Collections

*** Variables ***
${BASE_URL}       http://127.0.0.1:80

*** Test Cases ***

Test Happy Path Plus
    [Documentation]    Test happy path where 1 + 4 = 5
    ${response}=       GET  ${BASE_URL}/plus/1/4    expected_status=200
    ${data}=           To Json    ${response.content}
    Should Be Equal As Numbers    ${data}    5

Test Decimal Plus
    [Documentation]    Test decimal addition where 1.5 + 2.5 = 4.0
    ${response}=       GET  ${BASE_URL}/plus/1.5/2.5    expected_status=200
    ${data}=           To Json    ${response.content}
    Should Be Equal As Numbers    ${data}    4

Test Invalid Input
    [Documentation]    Test invalid input handling where `a + b` should return 400
    ${response}=       GET  ${BASE_URL}/plus/a/b    expected_status=400
    Log                 ${response.status_code}
    
*** Keywords ***
To Json
    [Arguments]    ${content}
    ${json_data}=    Evaluate    json.loads('''${content}''')    json
    RETURN    ${json_data}
