*** Settings ***
Resource	resource.robot
Library		Selenium2Library
Library		RequestsLibrary

*** Variables ***
${list}

*** Keywords ***
Fetch information from google api
    [Arguments]    ${site}
	:FOR    ${INDEX}    IN RANGE    1    10
	\    ${response}	Get Request	googleapi	/maps/api/geocode/json?address=${site}
	\    Should Be Equal		${response.status_code}		${200}
	\    ${status_element}=    Get From Dictionary       ${response.json()}    status
	\    ${status}    Run Keyword And Return Status    Should Be Equal As Strings    ${status_element}    OK        
	\    Exit For Loop If    ${status}    
	\    sleep    1
	[Return]    ${response}
	
	
	
*** Test Cases ***
Test_1
	[Documentation]  Addresses are picked up
 	
	Open Browser    http://www.cinia.fi    firefox
	
	Click Element	xpath=/${city}/span[1]
	${site1}     Get Text    xpath=/${address}/div[1]/span[1]	#Helsinki address
	Set Suite Variable    ${site1}    #lisäys
	
	Click Element	xpath=/${city}/span[3]
	${site2}     Get Text    xpath=/${address}/div[2]/span[1]	#Tampere address
	Set Suite Variable    ${site2}    #lisäys
	
	Click Element	xpath=/${city}/span[5]
	${site3}     Get Text    xpath=/${address}/div[3]/span[1]	#Vantaa address
	Set Suite Variable    ${site3}    #lisäys
	
	Click Element	xpath=/${city}/span[7]
	${site4}     Get Text    xpath=/${address}/div[4]/span[1]	#Jyvaskyla address
	Set Suite Variable    ${site4}    #lisäys
	
	Click Element	xpath=/${city}/span[9]
	${site5}   Get Text    xpath=/${address}/div[5]/span[1]		#Riihimaki address
	Set Suite Variable    ${site5}    #lisäys
	
	Click Element	xpath=/${city}/span[11]
	${site6}     Get Text    xpath=/${address}/div[6]/span[1]	#Espoo address
	Set Suite Variable    ${site6}    #lisäys
	
	Close Browser

Test_2
	[Documentation]	GPS coordinates from Google
	
	${list}=   Create List	0   1	2   3	4   5	6   7	8   9
	
	Set Global Variable	@{list}
	
	Create Session	googleapi	${API}	 
	
	:FOR	${num}    IN RANGE    1    ${up_value}

	\   ${response}    Fetch information from google api    ${site${num}}    #muutos ja lisäys

	
	\	${town}=	Set Variable	${response.json()['results'][0]['address_components'][2]['long_name']}
	\	${latitude}=    Set Variable    ${response.json()['results'][0]['geometry']['location']['lat']}
	\	${longitude}=    Set Variable    ${response.json()['results'][0]['geometry']['location']['lng']}

	\	${data}   Catenate   SEPARATOR=   {	${town}	}:   {	${latitude}   }   ,   {	${longitude}   }
	
	\	Set List Value	${list}	${num}	${data}
	\   Sleep    2

	
	Delete All Sessions
 
 Test_3
 	[Documentation]	City + GPS
 	
 	${out}	Get From List	${list}	${1}
	Log	${out}	console=yes
	
	${out}	Get From List	${list}	${2}
	Log	${out}	console=yes
	
	${out}	Get From List	${list}	${3}
	Log	${out}	console=yes
	
 	${out}	Get From List	${list}	${4}
	Log	${out}	console=yes
	
	${out}	Get From List	${list}	${5}
	Log	${out}	console=yes
	
	${out}	Get From List	${list}	${6}
	Log	${out}	console=yes
	
	