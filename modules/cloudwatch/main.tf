module "cloudwatch_log_group" {
  source = "terraform-aws-modules/cloudwatch/aws//modules/log-group"

  # ... настройки модуля, например, имя группы логов, политики удержания и т.д.
}
 