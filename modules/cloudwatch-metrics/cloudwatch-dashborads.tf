provider "aws" {
  region = var.aws_region
}

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
    },
    {
      "type": "metric",
      "x": 8,
      "y": 24,
      "width": 8,
      "height": 6,
      "properties": {
        "metrics": [
          [
            "AWS/S3",
            "BucketSizeBytes"
          ],
          [
            "AWS/S3",
            "NumberOfObjects"
          ],
          [
            "AWS/S3",
            "DeleteRequests"
          ],
          [
            "AWS/S3",
            "5xxErrors"
          ],
          [
            "AWS/S3",
            "TotalRequestLatency"
          ]
        ],
        "period": 60,
        "stat": "Maximum",
        "region": "ap-southeast-1",
        "title": "S3|Main Stats"
      }
    }
  ]
}
EOF

}

 
