resource "aws_api_gateway_rest_api" "example_gw" {
  name = "example_rest_api"

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  body = jsonencode({
    openapi = "3.0.1"
    info = {
      title   = "example_gw"
      version = "1.0"
    }
    paths = {
      "/path1" = {
        get = {
          x-amazon-apigateway-integration = {
            httpMethod           = "GET"
            payloadFormatVersion = "1.0"
            type                 = "HTTP_PROXY"
            uri                  = "https://ip-ranges.amazonaws.com/ip-ranges.json"
          }
        }
      }
    }
  })
}

resource "aws_api_gateway_deployment" "example_gw" {
  rest_api_id = aws_api_gateway_rest_api.example_gw.id

  triggers = {
    redeployment = sha1(jsonencode(aws_api_gateway_rest_api.example_gw.body))
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_api_gateway_stage" "example_gw" {
  deployment_id = aws_api_gateway_deployment.example_gw.id
  rest_api_id   = aws_api_gateway_rest_api.example_gw.id
  stage_name    = "example_gw"
}
