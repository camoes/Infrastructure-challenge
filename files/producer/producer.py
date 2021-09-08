import boto3, json


def lambda_handler(event, context):

        lambda_client = boto3.client('lambda')
   

        response = lambda_client.invoke(
                FunctionName='arn:aws:lambda:eu-west-1:251673427141:function:consumer_lambda',
                Payload=json.dumps(event),
                )
        print(response['Payload'])
        print(response['Payload'].read().decode("utf-8"))

