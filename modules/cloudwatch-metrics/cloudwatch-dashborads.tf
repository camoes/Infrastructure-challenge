provider "aws" {
  region = var.aws_region
}

//this section must be improved, atm it has the bare minimum and its very barebones
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "${terraform.workspace}-cloudwatch-main-dashboard"
  
  dashboard_body = <<EOF
{
  "widgets": [
    {
      "type": "metric",
      "x": 16,
      "y": 6,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/ApiGateway",
            "4XXError"
          ],
          [
            "AWS/ApiGateway",
            "5XXError"
          ],
          [
            "AWS/ApiGateway",
            "Count"
          ],
          [
            "AWS/ApiGateway",
            "Latency"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "ap-southeast-1",
        "title": "API Gateway|Main Stats"
      }
    },
    {
      "type": "metric",
      "x": 0,
      "y": 24,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/Lambda",
            "Invocations"
          ],
          [
            "AWS/Lambda",
            "Errors"
          ],
          [
            "AWS/Lambda",
            "DestinationDeliveryFailures"
          ],
          [
            "AWS/Lambda",
            "Duration"
          ],
          [
            "AWS/Lambda",
            "RequestCount"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "ap-southeast-1",
        "title": "Lambda|Main Stats"
      }
    }
  ]
}
EOF

}


 
