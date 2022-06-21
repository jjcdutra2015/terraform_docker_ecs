module "prod" {
  source = "../../infra"

  nome_repositorio = "producao"

  cargoIAM = "producao"
}

output "IP_ALB" {
  value = module.prod.IP
}
