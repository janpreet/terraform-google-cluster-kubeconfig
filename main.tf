# Cluster resource
resource "google_container_cluster" "primary" {
  name               = var.cluster_name
  location           = var.region
  master_auth {
    username = var.username
    password = var.password

    client_certificate_config {
      issue_client_certificate = true
    }
  }
  node_pool {
    name = "default-pool"
    initial_node_count = var.initial_node_count
    node_config {
      machine_type = var.machine_type
      oauth_scopes = var.oauth_scopes
      metadata = {
        disable-legacy-endpoints = "true"
      }
    }
    management {
      auto_repair = true
    }    
    autoscaling {
      min_node_count = var.min_node_count
      max_node_count = var.max_node_count
    }
  }    
  timeouts {
    create = "30m"
    update = "40m"
  }
}

# Kubeconfig
data "template_file" "kubeconfig" {
  template = file("${path.module}/template/kubeconfig.tpl")
  vars = {
    cluster_name    = google_container_cluster.primary.name
    endpoint        = google_container_cluster.primary.endpoint
    user_name       = google_container_cluster.primary.master_auth.0.username
    user_password   = google_container_cluster.primary.master_auth.0.password
    cluster_ca      = google_container_cluster.primary.master_auth.0.cluster_ca_certificate
    client_cert     = google_container_cluster.primary.master_auth.0.client_certificate
    client_cert_key = google_container_cluster.primary.master_auth.0.client_key
  }
}

resource "local_file" "kubeconfiggke" {
  content  = data.template_file.kubeconfig.rendered
  filename = var.kubeconfig
}