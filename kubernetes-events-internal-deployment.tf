resource "kubernetes_deployment" "internal-deploymentt" {
  metadata {
    name = "internal-deployment"
    labels = {
      App = "internal-deployment"
    }
    namespace = kubernetes_namespace.events_ns.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "internal-deployment"
      }
    }
    template {
      metadata {
        labels = {
          App = "internal-deployment"
        }
      }
      spec {
        container {
          image = "${var.container_registry}/${var.internal_image_name}"
          name  = "internal-deployment"

          env {
            name  = "GOOGLE_CLOUD_PROJECT"
            value = var.project_id
          }
          env {
            name  = "PORT"
            value = 8082
          }
          port {
            container_port = 8082
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "256Mi"
            }
          }
        }
      }
    }
  }
}
