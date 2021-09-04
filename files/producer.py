import boto3

def lambda_handler (event, context):
    lambda_client = boto3.client('lambda')
    lambda_payload = event.get('data')
    lambda_client.invoke(FunctionName='consumer', 
                        InvocationType='Event',
                        Payload=lambda_payload)