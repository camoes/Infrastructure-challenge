import logging
import json
logger = logging.getLogger()
logger.setLevel(logging.INFO)
#using the python AWS libraries for storing the events logger.info


def lambda_handler(event, context):
    event_data = event["data"]
    #FizzBuzz section of the stored array 
    for i in event_data:
        if event_data[i]%3==0 and event_data[i]%5==0:
            event_data[i] = "fizzbuzz"
        elif event_data[i]%3==0:
            event_data[i] = "fizz"
        elif event_data[i]%5==0:
            event_data[i] = "buzz"
    logger.info(event_data)

#Store the array in Cloudwatc