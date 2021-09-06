
def lambda_handler(event, context):
    data = event.get('data')
    data = [1,5,13]
    for i in range(len(data)):
        if data[i]%3==0 and data[i]%5==0:
            data[i] = "fizzbuzz"
        elif data[i]%3==0:
            data[i] = "fizz"
        elif data[i]%5==0:
            data[i] = "buzz"
    print (data)