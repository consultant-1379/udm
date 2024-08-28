#grant_type=refresh_token&client_id=<client_id>&client_secret=<client_secret>&refresh_token=<refresh_token>

Feature: FetchOauthToken
Scenario: FetchOauthToken
Given target type is EDA_HTTP
Given path is /oauth2/token
Given request header is Content-Type:application/x-www-form-urlencoded
Given request content is
"""
grant_type=client_credentials&nfInstanceId=<client_id>&nfType=5G-EIR&scope=n5g-eir-eic&targetNfInstanceId=841d1b7c-5103-11e9-8c09-285d06018f39
"""
Given action name is FetchOauthToken
When we send POST request
Then we expect response status code 200
Then we expect response time less than 10000 milliseconds
Then save response content property access_token value as fetchedToken
Then we store key token_eir value <fetchedToken>
