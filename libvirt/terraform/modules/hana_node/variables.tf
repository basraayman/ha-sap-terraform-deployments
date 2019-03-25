variable "base_configuration" {
  description = "use ${module.base.configuration}, see the main.tf example file"
  type        = "map"
}

variable "name" {
  description = "hostname, without the domain part"
  type        = "string"
}

variable "reg_code" {
  description = "If informed, register the product using SUSEConnect"
  default     = ""
}

variable "reg_email" {
  description = "Email used for the registration"
  default     = ""
}

variable "reg_additional_modules" {
  description = "Map of the modules to be registered. Module name = Regcode, when needed."
  type        = "map"
  default     = {}
}

variable "additional_repos" {
  description = "extra repositories used for installation {label = url}"
  default     = {}
}

variable "ha_sap_deployment_repo" {
  description = "Repository url used to install install HA/SAP deployment packages"
  type        = "string"
}

variable "additional_packages" {
  description = "extra packages which should be installed"
  default     = []
}

variable "count" {
  description = "number of hosts like this one"
  default     = 1
}

variable "ssh_key_path" {
  description = "path of additional pub ssh key you want to use to access VMs, see README_ADVANCED.md"
  default     = "/dev/null"

  # HACK: "" cannot be used as a default because of https://github.com/hashicorp/hil/issues/50
}

variable "hana_disk_size" {
  description = "hana partition disk size"
  default     = "68719476736"              # 64GB
}

variable "host_ips" {
  description = "ip addresses to set to the nodes"
  type        = "list"
}

variable "sbd_disk_id" {
  description = "SBD disk volume id"
  type        = "string"
}

variable "sap_inst_media" {
  description = "URL of the NFS share where the SAP software installer is stored. This media shall be mounted in /root/sap_inst"
  type        = "string"
}

variable "hana_inst_folder" {
  description = "Folder where SAP HANA installation files are stored"
  type        = "string"
}

// Provider-specific variables

variable "memory" {
  description = "RAM memory in MiB"
  default     = 512
}

variable "vcpu" {
  description = "Number of virtual CPUs"
  default     = 1
}

variable "running" {
  description = "Whether this host should be turned on or off"
  default     = true
}

variable "mac" {
  description = "a MAC address in the form AA:BB:CC:11:22:22"
  default     = ""
}
