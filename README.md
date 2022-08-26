# eticket-adminEntry-API
Store show details sent from admin panel (get request)

## Done
get method \shows
 0. get request pipeline working
 1. working get request pipeline - done
 2. send name of shows on a date - done
 3. send show data by show name and date - done

## To Do
* another method /show_by_date
4. some complex queries in future?

### data (for testing purposes and reference):
##### Search list of shows by date
* `wwww.myapi.com/shows` with `{"date":"10-10-10"}` date in body, returns list of movies -

```
{"statusCode": 200, 
"body": "{\"date\": \"10-10-10\", 
\"shows\": [\"hawa\", \"letka\", \"poran\", \"valobasha dibi kina bol\"], 
\"total_shows\": 4}"} 
```
