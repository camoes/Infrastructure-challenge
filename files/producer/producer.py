import boto3

def lambda_handler (event, context):
    #his section launches the lambda functtion consumer and send the event as data payload
    lambda_client = boto3.client('lambda')
    lambda_payload = event.get('data')
    lambda_client.invoke(FunctionName='consumer_lambda', 
                        InvocationType='Event',
                        Payload=lambda_payload)
    response = {
            'statusCode': 200,
            'header': {'Content-Type': 'application/json'},
            'body': 'path to file'
    }  #returns 200 from the previous message , this part needs refines 
    return response
