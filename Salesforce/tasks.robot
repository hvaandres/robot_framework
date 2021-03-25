*** Settings ***
Documentation     Template robot main suite.
...               Saves the original and the translated lyrics as text files
Library           RPA.Browser
Library           OperatingSystem

*** Keywords ***
Get lyrics
    Open Available Browser    https://www.lyrics.com/lyrics/Peaches
    Click Element When Visible    CSS:.best-matches a
    ${lyrics_element}=    Set Variable    id:lyric-body-text
    Wait Until Element Is Visible    ${lyrics_element}
    ${lyrics}=    Get Text    ${lyrics_element}
    [Return]    ${translation}

*** Keywords ***
Translate
    [Arguments]    ${lyrics}
    Go To    https://translate.google.com/#view=home&op=translate&sl=auto&tl=es&text=${lyrics}
    ${translation_element}    Set Variable    xpath://*[@id="ow158"]/div[1]/span[1]/span/span
    Wait Until Element Is Visible    ${translation_element}
    ${translation}=    Get Text    ${translation_element}
    [Return]    ${translation}

*** Keywords ***
Save lyrics
    [Arguments]    ${lyrics}    ${translation}
    Create File    ${OUTPUT_DIR}${/}original.txt    ${lyrics}
    Create File    ${OUTPUT_DIR}${/}translation.txt    ${lyrics}

*** Tasks ***
Google Translate song lyrics from source to target language
    ${lyrics}=    Get lyrics
    ${translation}=    Translate    ${lyrics}
    Save lyrics    ${lyrics}    ${translation}
