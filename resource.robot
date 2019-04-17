*** Settings ***
Library		Selenium2Library
Library		RequestsLibrary
Library		Collections
Library		String

*** Variables ***
${city}			html/body/footer//div[@class='text-center mt-2'
${address}		html/body/footer//div[@class='text-center mt-3'
${API}			http://maps.googleapis.com/
${up_value}		7

${site1}		0
${site2}		0
${site3}		0
${site4}		0
${site5}		0
${site6}		0

    
*** Keywords ***


