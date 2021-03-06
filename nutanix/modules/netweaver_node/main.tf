resource "libvirt_volume" "netweaver_image_disk" {
  count            = var.netweaver_count
  name             = "${terraform.workspace}-${var.name}-${count.index + 1}-main-disk"
  source           = var.source_image
  base_volume_name = var.volume_name
  pool             = var.storage_container_uuid
}

resource "libvirt_domain" "netweaver_domain" {
  name       = "${terraform.workspace}-${var.name}-${count.index + 1}"
  memory     = var.memory
  vcpu       = var.vcpu
  count      = var.netweaver_count
  qemu_agent = true

  dynamic "disk" {
    for_each = slice([
      {
        "vol_id" = element(libvirt_volume.netweaver_image_disk.*.id, count.index)
      },
      {
        "vol_id" = var.shared_disk_id
      },
    ], 0, var.ha_enabled ? 2 : 1)
    content {
      volume_id = disk.value.vol_id
    }
  }

  network_interface {
    wait_for_lease = true
    network_uuid   = var.network_uuid
    bridge         = var.bridge
    mac            = var.mac
  }

  network_interface {
    wait_for_lease = false
    network_uuid   = var.isolated_network_uuid
    network_id     = var.isolated_network_id
    addresses      = [element(var.host_ips, count.index)]
  }

  xml {
    xslt = file("modules/netweaver_node/shareable.xls")
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }

  cpu = {
    mode = "host-passthrough"
  }
}

output "output_data" {
  value = {
    id                = libvirt_domain.netweaver_domain.*.id
    name              = libvirt_domain.netweaver_domain.*.name
    private_addresses = var.host_ips
    addresses         = libvirt_domain.netweaver_domain.*.network_interface.0.addresses.0
  }
}

module "netweaver_on_destroy" {
  source       = "../../../generic_modules/on_destroy"
  node_count   = var.netweaver_count
  instance_ids = libvirt_domain.netweaver_domain.*.id
  user         = "root"
  password     = "linux"
  public_ips   = libvirt_domain.netweaver_domain.*.network_interface.0.addresses.0
  dependencies = [libvirt_domain.netweaver_domain]
}
