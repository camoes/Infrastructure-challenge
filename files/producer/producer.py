import json
import boto3
 
# Define the client to interact with AWS Lambda
client = boto3.client('lambda')
 
def lambda_handler(event,context):
 
    # Define the input parameters that will be passed
    # on to the child function
    lambda_payload = event.get('data')
    response = client.invoke(
        FunctionName = 'arn:aws:lambda:eu-west-1:251673427141:function:consumer_lambda',
        InvocationType = 'RequestResponse',
        Payload = json.dumps(lambda_payload)
    )
 
    responseFromChild = json.load(response['Payload'])
 
    print('\n')
    print(responseFromChild)
