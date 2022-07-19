resource "kubernetes_deployment" "external-deployment" {
  metadata {
    name = "external-deployment"
    labels = {
      App = "external-deployment"
    }
    namespace = kubernetes_namespace.events_ns.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 90
    selector {
      match_labels = {
        App = "external-deployment"
      }
    }
    template {
      metadata {
        labels = {
          App = "external-deployment"
        }
      }
      spec {
        container {
          image = "${var.container_registry}/${var.external_image_name}"
          name  = "external-deployment"

          env {
            name  = "SERVER"
            value = "http://external-deployment:8082"
          }
          port {
            container_port = 8080
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
