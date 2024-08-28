Feature:  Nssai data population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'{"defaultSingleNssais": [{"sd": "133559", "sst": 1}, {"sd": "133559", "sst": 2}, {"sd": "133559", "sst": 3}, {"sd": "133559", "sst": 4}, {"sd": "133559", "sst": 5}], "singleNssais": [{"sd": "164685", "sst": 1}, {"sd": "164685", "sst": 2}, {"sd": "164685", "sst": 3}, {"sd": "164685", "sst": 4}, {"sd": "164685", "sst": 5}]}' 'http://udrsim:9082/nudr-dr/v1/subscription-data/imsi-00080/111222/provisioned-data/nssai'


Scenario: Send TC-UDRSIM-0080
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/111222/provisioned-data/nssai
   Given request header is Content-Type:application/json
   Given request content is

   """
   {"defaultSingleNssais": [{"sd": "133559", "sst": 1},
                            {"sd": "133559", "sst": 2},
                            {"sd": "133559", "sst": 3},
                            {"sd": "133559", "sst": 4},
                            {"sd": "133559", "sst": 5}],
    "singleNssais": [{"sd": "164685", "sst": 1},
                     {"sd": "164685", "sst": 2},
                     {"sd": "164685", "sst": 3},
                     {"sd": "164685", "sst": 4},
                     {"sd": "164685", "sst": 5}]}
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
