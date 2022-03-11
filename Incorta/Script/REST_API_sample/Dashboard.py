# ************************************************************************
#  Incorta REST API Sample
#
#  These functions format the query request and pretty-print the data
#
#  You may need to install a couple of required modules. Use:
#     $ pip3 install requests prettytable
# ************************************************************************


def query_insight(incorta_url, dashboard_guid, insight_guid, authorization, prompts=None, username=None):
    import json
    import requests

    query_insight_url = incorta_url + '/incorta/api/v1/dashboards/' + dashboard_guid + '/insights/' + insight_guid + '/query'

    # The query can be run with diferent filter prompts and as a particular user
    query_insight_request = { 'prompts': prompts }
    if username is not None:
        query_insight_request["username"] = username
    query_insight_request_as_json_string = json.dumps(query_insight_request)

    headers = {'Content-type': 'application/json', 'Authorization': 'Bearer ' + authorization}

    response = requests.post(query_insight_url, data=query_insight_request_as_json_string, headers=headers)

    return response.text


def render_data_as_table(response):
    from prettytable import PrettyTable

    data_headers = response["headers"]
    data_measures = data_headers["measures"]
    data_dimensions = data_headers["dimensions"]
    data_rows = response["data"]

    # Extract table column names
    headers = data_dimensions + data_measures
    def get_label(measure):
        return measure["label"]
    labels = map(get_label, headers)

    table = PrettyTable()
    table.field_names = labels
    table.add_rows(data_rows)

    print(table)
