""" return show information based on query

get method \shows
 * working get request pipeline - done
 * send name of shows on a date - done
 * send show data by show name and date - done

 author: Ashraf Minhaj
 mail  : ashraf_minhaj@yahoo.com

Last coded: Aug 26 2022
Prev coded: Aug 26 2022
"""

from datetime import date
import json
import boto3
import logging
from boto3.dynamodb.conditions import Key

target_table = "db5"
partition_key = "date"
sort_key = "shows"

# initialize logger
logger = logging.getLogger()
logger.setLevel(logging.INFO)

logger.info("Init boto client and connecting with table")
db_table = boto3.resource('dynamodb').Table(target_table)  # connecting with table
logger.info("Connection with table: Success")
# logger.info(f"Table status {db_table.table_status}")

def lambda_handler(event, context):

    # response variables
    response_data = "No issues at all"
    status_code = 200

    # get insights of input event
    logger.info(f"Event Received = {event}")
    logger.info(f"Event dtype = {type(event)}")

    # check the request type
    logger.info('Check request type')

    if event['httpMethod'] == 'GET':
        logger.info("Check path/route")
        route = event['path']
        logger.info(f"Path/route {route}")

        try:
            if route == '/shows':
                logger.info("Getting the data we need ")
                body = event['body']

                if body:
                    data = json.loads(body)
                    logger.info(f"Clean data = {data}, dtype = {type(data)}")
                    
                    show_date = data['date']
                    # get shows from db table
                    logger.info(f"Performing Query for {partition_key} with {show_date}")

                    response = db_table.query(
                        KeyConditionExpression=Key(partition_key).eq(show_date),
                        ProjectionExpression = sort_key)

                    status_code = response["ResponseMetadata"]["HTTPStatusCode"]
                    logger.info(f"data type: {type(response)}, response data: {response}, \n getting list of shows")
                    shows = []
                    for item in response["Items"]:
                        shows.append(item['shows'])
                    
                    logger.info(shows)

                    response_data = {
                        "date": show_date,
                        "shows": shows,
                        "total_shows": len(shows)
                        }

        except Exception as e:
            logger.error(e)
            response_data = e
            status_code = 400

    return {
        'statusCode': status_code,
        'body': json.dumps(response_data)
    }


# {"date":"10-10-10"}