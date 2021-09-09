import boto3, json, logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)
lambda_client = boto3.client('lambda')


def lambda_handler(event, context):
        data = event['body']
        response = lambda_client.invoke(FunctionName='arn:aws:lambda:eu-west-1:251673427141:function:consumer_lambda',Payload=data)
        logger.info(data)