module "test" {
  source = "./modules/19-serverless-lambda"
}

output "test_output" {
  value = module.test
}