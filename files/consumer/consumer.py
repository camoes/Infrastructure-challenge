import logging
import json
logger = logging.getLogger()
logger.setLevel(logging.INFO)
#using the python AWS libraries for storing the events logger.info


def lambda_handler(event, context):
    
    event_data_string = event['data']
    print(event_data_string)
    event_data = event_data_string

    #FizzBuzz section of the stored array 
    for index,  value in enumerate(event_data):
        if value%3==0 and value%5==0:
           event_data[index]  = "fizzbuzz"
        elif value%3==0:
            event_data[index] = "fizz"
        elif value%5==0:
            event_data[index] = "buzz"
    logger.info(event_data)
    return {'statusCode': 200, 'body': json.dumps({'message': 'successful lambda function call' }), 'headers': {'Access-Control-Allow-Origin': '*'}}


#Store the array in Cloudwat

#Store the array in Cloudwatc