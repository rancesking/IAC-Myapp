def lambda_handler(event, context):
 return {
  'statusCode': 200,
  'headers': {
   "Access-Control-Allow-Origin": "*",
  },
  'body': "This text is coming from Lambda22!"
 }