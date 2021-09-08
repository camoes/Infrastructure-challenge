import boto3, json


def lambda_handler(event, context):

        lambda_client = boto3.client('lambda')
        print(event["body"])
        event_body = json.loads(event["body"])


        response = lambda_client.invoke(
                FunctionName='arn:aws:lambda:eu-west-1:251673427141:function:consumer_lambda',
                Payload=json.dumps(event_body),
                )
        print(response['Payload'])
        print(response['Payload'].read().decode("utf-8"))

