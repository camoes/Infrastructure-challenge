import logging
import json
logger = logging.getLogger()
logger.setLevel(logging.INFO)
#using the python AWS libraries for storing the events logger.info


def lambda_handler(event, context):
    data = event.get('data')
    resp_dict = json.loads(data)    

#FizzBuzz section of the stored array 
    for i in range(resp_dict):
        if resp_dict[i]%3==0 and resp_dict[i]%5==0:
            resp_dict[i] = "fizzbuzz"
        elif resp_dict[i]%3==0:
            resp_dict[i] = "fizz"
        elif resp_dict[i]%5==0:
            resp_dict[i] = "buzz"
    logger.info(resp_dict)
    print(resp_dict)

#Store the array in Cloudwatc