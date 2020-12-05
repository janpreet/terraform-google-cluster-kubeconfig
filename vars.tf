variable "project" {
  type = string
  default = ""
}
variable "region" {
  type = string
  default = ""
}
variable "credentials" {
  type = string
  default = ""
}
variable "username" {
  type = string
  default = ""
}
variable "password" {
  type = string
  default = ""
}
variable "cluster_name" {
  type = string
  default = "k8s-playground"
}
variable "machine_type" {
  type = string
  default = "n1-standard-1"
}
variable "initial_node_count" {
  type = string
  default = "1"
}
variable "kubeconfig" {
  type = string
  default = ""
}
variable "oauth_scopes" {
  type = list(string)
  default = [
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
        "https://www.googleapis.com/auth/service.management.readonly",
        "https://www.googleapis.com/auth/servicecontrol",
        "https://www.googleapis.com/auth/trace.append"     
    ]
}
variable "min_node_count" {
  type = string
  default = "3"
}
variable "max_node_count" {
  type = string
  default = "100"
}
