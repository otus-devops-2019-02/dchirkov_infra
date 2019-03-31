# Ресурс для проксирования запросов на внутренние инстансы
resource "google_compute_forwarding_rule" "reddit-lb" {
  name       = "reddit-forwarding-rule"
  target     = "${google_compute_target_pool.reddit-pool.self_link}"
  port_range = "9292"
}

# Ресурс пула для балансировки приложения
resource "google_compute_target_pool" "reddit-pool" {
  name = "reddit-ip-pool"

  instances = [
    "${google_compute_instance.app.*.self_link}",
  ]

  health_checks = [
    "${google_compute_http_health_check.reddit-app.name}",
  ]
}

# Ресурс для проверки доступности http
resource "google_compute_http_health_check" "reddit-app" {
  name               = "reddit-check-app"
  request_path       = "/"
  check_interval_sec = 1
  timeout_sec        = 1
  port               = 9292
}
