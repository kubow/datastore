- Calculation made on top of the underlying data. 
- Allows to create standartizes set of calculations that build on top of each other.
- Aim is to make it available even without neccesity of knowing SQL.
- [Multidimensional Analytical Query Language](https://help.gooddata.com/doc/enterprise/en/dashboards-and-insights/maql-analytical-query-language) - porprietary GoodData language. 

[Getting Started with MAQL in GoodData.CN](https://university.gooddata.com/)
[MAQL: Powerful Analytical Querying Made Simple | GoodData](https://www.gooddata.com/blog/maql-powerful-analytical-querying-made-simple/)


SQL-like syntax over Logical Data Model
- no joins

```sql
SELECT aggregation_function({fact/dataset/fact_column})
```

- [Aggregation functions](#aggregation-functions)
- [Details](#details)
- [Using an API to create a metric](#using-an-api-to-create-a-metric)


## Aggregation functions

[Aggregation Functions | GoodData Cloud Native](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/)

- [AVG](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/avg/)
- [APPROXIMATE_COUNT (Vertica only)](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/approximate_count/) / [COUNT](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/count/)
- [FIRST_VALUE](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/first/) / [LAST_VALUE](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/last/)
- [MIN](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/min/) / [MAX](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/max/)
- [MEDIAN](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/median/)
- [SUM](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/aggregation/sum/)


#### Date time analysis


- [DATETIME_ADD](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/time-arithmetics/datetime-add/)
- [DATETIME_DIFF](https://www.gooddata.com/developers/cloud-native/doc/cloud/create-metrics/maql/time-arithmetics/datetime-diff/)

## Details

[📢 Introducing Enhanced Metrics: Outer Joins and Advanced Date Arithmetic in MAQL | by Patrik Braborec | GoodData Developers | Mar, 2023 | Medium](https://medium.com/gooddata-developers/introducing-enhanced-metrics-outer-joins-and-advanced-date-arithmetic-in-maql-6f02bd6436ee)


```sql
SELECT aggregation_function(fact1*fact2)
WHERE condition_column=condition


SELECT SUM(SELECT AVG(ammount) BY user)  -- BY detail level
SELECT SUM(SELECT AVG(ammount) BY user, ALL country)  -- ALL do not group by
SELECT SUM(SELECT AVG(ammount) BY user, ALL OTHER)  -- OTHER  forget about the rest
SELECT SUM(SELECT AVG(ammount) BY user, ALL OTHER WITHOUT PF)  -- do not apply any filter (even not primry dashboard filter)

SELECT (SELECT SUM(a)) / (SELECT SUM(a) BY ALL country) -- % % % % percentage

SELECT SUM(ammount) WHERE
(SELECT COUNT(user) BY user, ALL OTHER WHERE product=x) > 0 -- greater than

```



## Using an API to create a metric

```bash
curl http://localhost:3000/api/entities/workspaces/demo/metrics \
  -H "Content-Type: application/vnd.gooddata.api+json" \
  -H "Accept: application/vnd.gooddata.api+json" \
  -H "Authorization: Bearer YWRtaW46Ym9vdHN0cmFwOmFkbWluMTIz" \
  -X POST \
  -d '{ 
    "data": {
       "id": "Metric1",
       "type": "metric",
       "attributes": {
         "title": "Sum of Campaign Spend",
         "description": "Sum of total campaign spend",
         "content": {
           "format": "0.00",
           "maql": "SELECT SUM({fact/campaign_channels.spend})"
          }
        }
      }
    }'
```




