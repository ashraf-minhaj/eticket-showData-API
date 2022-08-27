# create rest API with name
resource "aws_api_gateway_rest_api" "rest_api" {
	name = "${var.rest_api_name}"
}

resource "aws_api_gateway_resource" "api_resource" {
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  parent_id   = "${aws_api_gateway_rest_api.rest_api.root_resource_id}"
  path_part   = "${var.rest_api_path_part}"
}

# a get method
resource "aws_api_gateway_method" "api_get_method" {
  rest_api_id   = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id   = "${aws_api_gateway_resource.api_resource.id}"
  http_method   = "GET"
  authorization = "NONE"
  # request_parameters = {
  #   "integration.request.querystring.date" = true
  #   }
}

# Method Integration
resource "aws_api_gateway_integration" "api_get_method_integration" {
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id = "${aws_api_gateway_resource.api_resource.id}"
  http_method = "${aws_api_gateway_method.api_get_method.http_method}"
  # integration_uri    = "${aws_lambda_function.lambda.invoke_arn}"
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "${aws_lambda_function.lambda.invoke_arn}"
}


# Method response parameters define which headers the 
# client receives in response to the associated method request. 
resource "aws_api_gateway_method_response" "api_get_method_response_200"{
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  resource_id = "${aws_api_gateway_resource.api_resource.id}"
  http_method = "${aws_api_gateway_method.api_get_method.http_method}"
  status_code = "200"
}

# resource "aws_api_gateway_integration_response" "get_method_integration_response" {
#   rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
#   resource_id = "${aws_api_gateway_resource.api_resource.id}"
#   http_method = "${aws_api_gateway_method.api_get_method.http_method}"
#   status_code = "${aws_api_gateway_method_response.api_get_method_response_200.status_code}"
# }

# old ------
# deploy
resource "aws_api_gateway_deployment" "deployment" {
  depends_on = [
    aws_api_gateway_integration.api_get_method_integration
  ]
  rest_api_id = "${aws_api_gateway_rest_api.rest_api.id}"
  stage_name  = "dev"
}

# get the url to trigger the api on terminal as output
output "base_url" {
  value = "${aws_api_gateway_deployment.deployment.invoke_url}"
}