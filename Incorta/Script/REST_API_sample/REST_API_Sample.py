# ************************************************************************
#  Incorta REST API Sample
#
#  These functions format the query request and pretty-print the data
#
#  You may need to install a couple of required modules. Use:
#     $ pip3 install requests prettytable
# ************************************************************************

import Authentication as Auth
import Dashboard as Dashboard
import json

# Obtain the API key by visiting your user profile in Incorta, and clicking on the Security tab
# Obtain the GUIDs from the insight URL. Go to a dashboard, and then edit an insight. Then,
#    look at the URL. The dashboard_guid is the number after /dashboard/ in the URL, and the
#    insight_guid is the number after /analyze/ in the URL. Ignore the number after /tab/ if present.

tenant = 'default'
username = 'admin'
api_key = 'acd5c1d8-0f51-4b9c-a92c-09626fd9b629'
incorta_url = 'https://retail-sandbox.cloudstaging.incortalabs.com'
dashboard_guid = '4b7ddd90-02dd-4add-96ab-0401f5e4e00e' # 03. Mobile Dashboard
insight_guid = '495a08de-13aa-4da4-8825-82c229b8e830' # Revenue and Margin by Year and Category


def main():

    # Authenticate the user and obtain an access token. This only needs to be done once.
    access_token = Auth.request_tokens(incorta_url, tenant, username, api_key)

    # Query insight data. Multiple queries can reuse the same access token.
    results = Dashboard.query_insight(incorta_url, dashboard_guid, insight_guid, access_token)

    # Print out the results
    Dashboard.render_data_as_table(json.loads(results))


if __name__ == "__main__":
    main()
