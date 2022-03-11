# ************************************************************************
#  Incorta REST API Sample
#
#  These functions format and issue the Incorta authentication request
# ************************************************************************
import json

def request_tokens(hostname, tenant, username, api_key):
    import requests
    import urllib3

    tokens_url = hostname + '/incorta/api/v1/tokens'
    headers = {'Content-type': 'application/json'}
    request_payload = construct_authentication_request(tenant, username, api_key)

    urllib3.disable_warnings() # Prevent InsecureRequestWarning

    result = requests.post(tokens_url, data=request_payload, headers=headers, verify=False)

    if result.status_code != 201:
        print("Error while requesting tokens: ")
        print("Response code from server is: " + str(result.status_code))
        print("Response body is: " + result.text)
        return "Error"
    else:
        tokens_dictionary = json.loads(result.text)
        return tokens_dictionary['accessToken']



def construct_authentication_request(tenant, username, api_key):
    import hashlib
    import time
    import calendar

    timestamp = calendar.timegm(time.gmtime()) * 1000  # convert to milliseconds
    print("timestamp: " + str(timestamp))
    request = api_key + str(timestamp)
    request_hash = hashlib.sha256(request.encode('utf-8')).hexdigest()

    request_payload = {
        'tenantName': tenant,
        'loginName': username,
        'requestHash': request_hash,
        'timestamp': timestamp
    }
    return json.dumps(request_payload)
