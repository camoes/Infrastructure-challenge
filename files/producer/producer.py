import boto3, json

lambda_client = boto3.client('lambda')

test_event = dict()

response = lambda_client.invoke(
  FunctionName='arn:aws:lambda:eu-west-1:251673427141:function:consumer_lambda',
  Payload=json.dumps(test_event),
)

print(response['Payload'])
print(response['Payload'].read().decode("utf-8"))