# # S3 VPC Endpoint
# resource "aws_vpc_endpoint" "s3" {
#   count = var.enable_s3_endpoint ? 1 : 0

#   vpc_id       = aws_vpc.main.id
#   service_name = "com.amazonaws.${var.aws_region}.s3"

#   tags = merge(local.common_tags, {
#     Name = "${var.environment}-s3-endpoint"
#   })
# }

# # DynamoDB VPC Endpoint
# resource "aws_vpc_endpoint" "dynamodb" {
#   count = var.enable_dynamodb_endpoint ? 1 : 0

#   vpc_id       = aws_vpc.main.id
#   service_name = "com.amazonaws.${var.aws_region}.dynamodb"

#   tags = merge(local.common_tags, {
#     Name = "${var.environment}-dynamodb-endpoint"
#   })
# }

# # S3 Endpoint Route Table Associations (Private App Subnets)
# resource "aws_vpc_endpoint_route_table_association" "s3_private_app" {
#   count = var.enable_s3_endpoint ? length(aws_route_table.private_app) : 0

#   route_table_id  = aws_route_table.private_app[count.index].id
#   vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
# }

# # S3 Endpoint Route Table Associations (Private DB Subnets)
# resource "aws_vpc_endpoint_route_table_association" "s3_private_db" {
#   count = var.enable_s3_endpoint ? length(aws_route_table.private_db) : 0

#   route_table_id  = aws_route_table.private_db[count.index].id
#   vpc_endpoint_id = aws_vpc_endpoint.s3[0].id
# }

# # DynamoDB Endpoint Route Table Associations (Private App Subnets)
# resource "aws_vpc_endpoint_route_table_association" "dynamodb_private_app" {
#   count = var.enable_dynamodb_endpoint ? length(aws_route_table.private_app) : 0

#   route_table_id  = aws_route_table.private_app[count.index].id
#   vpc_endpoint_id = aws_vpc_endpoint.dynamodb[0].id
# }

# # DynamoDB Endpoint Route Table Associations (Private DB Subnets)
# resource "aws_vpc_endpoint_route_table_association" "dynamodb_private_db" {
#   count = var.enable_dynamodb_endpoint ? length(aws_route_table.private_db) : 0

#   route_table_id  = aws_route_table.private_db[count.index].id
#   vpc_endpoint_id = aws_vpc_endpoint.dynamodb[0].id
# }