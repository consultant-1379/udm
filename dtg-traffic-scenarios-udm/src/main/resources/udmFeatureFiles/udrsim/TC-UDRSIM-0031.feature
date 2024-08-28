Feature:  Session management subscription population

#FT:
#curl --http2-prior-knowledge -k -i -m 1 -X POST -H'content-type:application/json' -d'[{"dnnConfigurations":{"ericsson-network":{"5gQosProfile":{"5Eqi": 1,"arp": {"preemptCap": "NOT_PREEMPT", "preemptVuln": "NOT_PREEMPTABLE", "priorityLevel": 1}},"pduSessionTypes": {"allowedSessionTypes": ["IPV4"], "defaultSessionType": "IPV4"},"sessionAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"},"sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},"ladnIndicator": true,"staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}]},"ericsson-5g-network":{"5gQosProfile":{"5qi": 2,"arp": {"preemptCap": "MAY_PREEMPT", "preemptVuln": "PREEMPTABLE", "priorityLevel": 15}},"pduSessionTypes": {"allowedSessionTypes": ["IPV4"], "defaultSessionType": "IPV4"},"sessionAmbr": {"uplink": "1000 Kbps", "downlink": "2 Mbps"},"sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},"ladnIndicator": true,"staticIpAddress": [{"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}, {"ipv6Prefix": "2001:db8:abcd:12::0/64"}]}},"singleNssai": {"sd": "133559", "sst": 1}},{"dnnConfigurations":{"IMS":{"5gQosProfile":{"5qi": 1,"arp": {"preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE", "priorityLevel": 2}},"pduSessionTypes": {"allowedSessionTypes": ["IPV4"], "defaultSessionType": "IPV4"},"sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},"sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},"ladnIndicator": true,"staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}]}},"singleNssai": {"sd": "000002", "sst": 2}},{"dnnConfigurations":{"iMs":{"5gQosProfile":{"5qi": 1,"arp": {"preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE", "priorityLevel": 2}},"pduSessionTypes": {"allowedSessionTypes": ["IPV4"], "defaultSessionType": "IPV4"},"sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},"sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},"ladnIndicator": true,"staticIpAddress": [{"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}, {"ipv6Prefix": "2001:db8:abcd:12::0/64"}]}},"singleNssai": {"sd": "000002", "sst": 2}},{"dnnConfigurations":{"03ims9.com":{"5gQosProfile":{"5qi": 1,"arp": {"preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE", "priorityLevel": 2}},"pduSessionTypes": {"allowedSessionTypes": ["IPV4"], "defaultSessionType": "IPV4"},"sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},"sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},"ladnIndicator": true,"staticIpAddress": [{"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}, {"ipv6Prefix": "2001:db8:abcd:12::0/64"}]}},"singleNssai": {"sd": "000002", "sst": 2}},{"dnnConfigurations":{"eric-ImImSScom":{"5gQosProfile":{"5qi": 1,"arp": {"preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE", "priorityLevel": 2}},"pduSessionTypes": {"allowedSessionTypes": ["IPV4"], "defaultSessionType": "IPV4"},"sessionAmbr":{"uplink": "1000 Gbps", "downlink": "2 Tbps"},"sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},"ladnIndicator": true,"staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}]}},"singleNssai": {"sd": "000002", "sst": 2}},{"dnnConfigurations":{"icMSi":{"5gQosProfile":{"5qi": 1,"arp": {"preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE", "priorityLevel": 2}},"pduSessionTypes": {"allowedSessionTypes": ["IPV4"], "defaultSessionType": "IPV4"},"sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},"sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},"ladnIndicator": true,"staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}]}},"singleNssai": {"sd": "000002", "sst": 2}},{"dnnConfigurations":{"-ims.network":{"5gQosProfile":{"5qi": 1,"arp": {"preemptCap": "NOT_PREEMPT", "preemptVuln": "PREEMPTABLE", "priorityLevel": 2}},"pduSessionTypes": {"allowedSessionTypes": ["IPV4"], "defaultSessionType": "IPV4"},"sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},"sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},"ladnIndicator": true,"staticIpAddress": [{"ipv4Addr": "1.2.3.4"}]}},"singleNssai": {"sd": "000002", "sst": 2}}]' 'http://127.0.0.1:30082/nudr-dr/v1/subscription-data/imsi-00031/111222/provisioned-data/sm-data'

Scenario: Send TC-UDRSIM-0031
   Given target type is UDR_HTTP
   Given path is /nudr-dr/v1/subscription-data/imsi-<imsi>/111222/provisioned-data/sm-data
   Given request header is Content-Type:application/json
   Given request content is
   """
   [
      {
         "dnnConfigurations": {
            "ericsson-network": {
               "5gQosProfile": {
                  "5Eqi": 1,
                  "arp": {
                     "preemptCap": "NOT_PREEMPT",
                     "preemptVuln": "NOT_PREEMPTABLE",
                     "priorityLevel": 1
                  }
               },
               "pduSessionTypes": {
                  "allowedSessionTypes": ["IPV4"],
                  "defaultSessionType": "IPV4"
               },
               "sessionAmbr": {"uplink": "1000 bps", "downlink": "2 Kbps"},
               "sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},
               "ladnIndicator": true,
               "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}]
            },
            "ericsson-5g-network": {
               "5gQosProfile": {
                  "5qi": 2,
                  "arp": {
                     "preemptCap": "MAY_PREEMPT",
                     "preemptVuln": "PREEMPTABLE",
                     "priorityLevel": 15
                  }
               },
               "pduSessionTypes": {
                  "allowedSessionTypes": ["IPV4"],
                  "defaultSessionType": "IPV4"
               },
               "sessionAmbr": {"uplink": "1000 Kbps", "downlink": "2 Mbps"},
               "sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},
               "ladnIndicator": true,
               "staticIpAddress": [{"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}, {"ipv6Prefix": "2001:db8:abcd:12::0/64"}]
            }
         },
         "singleNssai": {"sd": "133559", "sst": 1}
      },
      {
         "dnnConfigurations": {
            "IMS": {
               "5gQosProfile": {
                  "5qi": 1,
                  "arp": {
                     "preemptCap": "NOT_PREEMPT",
                     "preemptVuln": "PREEMPTABLE",
                     "priorityLevel": 2
                  }
               },
               "pduSessionTypes": {
                  "allowedSessionTypes": ["IPV4"],
                  "defaultSessionType": "IPV4"
               },
               "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},
               "sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},
               "ladnIndicator": true,
               "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}]
           }
         },
         "singleNssai": {"sd": "000002", "sst": 0}
      },
      {
         "dnnConfigurations": {
            "iMs": {
               "5gQosProfile": {
                  "5qi": 1,
                  "arp": {
                     "preemptCap": "NOT_PREEMPT",
                     "preemptVuln": "PREEMPTABLE",
                     "priorityLevel": 2
                  }
               },
               "pduSessionTypes": {
                  "allowedSessionTypes": ["IPV4"],
                  "defaultSessionType": "IPV4"
               },
               "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},
               "sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},
               "ladnIndicator": true,
               "staticIpAddress": [{"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}, {"ipv6Prefix": "2001:db8:abcd:12::0/64"}]
            }
         },
         "singleNssai": {"sd": "000002", "sst": 2}
      },
      {
         "dnnConfigurations": {
            "03ims9.com": {
               "5gQosProfile": {
                  "5qi": 1,
                  "arp": {
                     "preemptCap": "NOT_PREEMPT",
                     "preemptVuln": "PREEMPTABLE",
                     "priorityLevel": 2
                  }
               },
               "pduSessionTypes": {
                  "allowedSessionTypes": ["IPV4"],
                  "defaultSessionType": "IPV4"
               },
               "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},
               "sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},
               "ladnIndicator": true,
               "staticIpAddress": [{"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}, {"ipv6Prefix": "2001:db8:abcd:12::0/64"}]
            }
         },
         "singleNssai": {"sd": "000002", "sst": 3}
      },
      {
         "dnnConfigurations": {
            "eric-ImImSScom": {
               "5gQosProfile": {
                  "5qi": 1,
                  "arp": {
                     "preemptCap": "NOT_PREEMPT",
                     "preemptVuln": "PREEMPTABLE",
                     "priorityLevel": 2
                  }
               },
               "pduSessionTypes": {
                  "allowedSessionTypes": ["IPV4"],
                  "defaultSessionType": "IPV4"
               },
               "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},
               "sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},
               "ladnIndicator": true,
               "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}]
            }
         },
         "singleNssai": {"sd": "000002", "sst": 4}
      },
      {
         "dnnConfigurations": {
            "icMSi": {
               "5gQosProfile": {
                  "5qi": 1,
                  "arp": {
                     "preemptCap": "NOT_PREEMPT",
                     "preemptVuln": "PREEMPTABLE",
                     "priorityLevel": 2
                  }
               },
               "pduSessionTypes": {
                  "allowedSessionTypes": ["IPV4"],
                  "defaultSessionType": "IPV4"
               },
               "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},
               "sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},
               "ladnIndicator": true,
               "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}, {"ipv6Addr": "2001:db8:85a3::8a2e:370:7334"}]
            }
         },
         "singleNssai": {"sd": "000002", "sst": 5}
      },
      {
         "dnnConfigurations": {
            "-ims.network": {
               "5gQosProfile": {
                  "5qi": 1,
                  "arp": {
                     "preemptCap": "NOT_PREEMPT",
                     "preemptVuln": "PREEMPTABLE",
                     "priorityLevel": 2
                  }
               },
               "pduSessionTypes": {
                  "allowedSessionTypes": ["IPV4"],
                  "defaultSessionType": "IPV4"
               },
               "sessionAmbr": {"uplink": "1000 Gbps", "downlink": "2 Tbps"},
               "sscModes": {"allowedSscModes": ["SSC_MODE_1"], "defaultSscMode": "SSC_MODE_1"},
               "ladnIndicator": true,
               "staticIpAddress": [{"ipv4Addr": "1.2.3.4"}]
            }
         },
         "singleNssai": {"sd": "000002", "sst": 6}
      }
   ]
   """
   When we send POST request
   Then we expect response status code 200
   Then we expect response time less than 2000 milliseconds
