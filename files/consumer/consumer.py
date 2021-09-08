import logging
import json
logger = logging.getLogger()
logger.setLevel(logging.INFO)
#using the python AWS libraries for storing the events logger.info


def lambda_handler(event, context):
    data = json.load(event)
#FizzBuzz section of the stored array 
    for i in data:
        if data[i]%3==0 and data[i]%5==0:
            data[i] = "fizzbuzz"
        elif data[i]%3==0:
            data[i] = "fizz"
        elif data[i]%5==0:
            data[i] = "buzz"
    logger.info(data)
    print(data)

#Store the array in Cloudwatc