module "test" {
  source = "./modules/21-rds"
}

output "test_output" {
  value = module.test
}