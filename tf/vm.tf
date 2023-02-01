

# Create cloudinit user template master-01

data "template_file" "master-01_userdata" {
  template = file("./cloud_userdata_cfg.yaml")
  vars = {
    hostname = "master-01"
  }
}

resource "xenorchestra_cloud_config" "master-01_userdataconfig" {
  name     = "user data config"
  template = data.template_file.master-01_userdata.rendered
}



# Create cloudinit metadata template master-01

data "template_file" "master-01_metadata" {
  template = file("./cloud_metadata_cfg.yaml")
  vars = {
    hostname  = "master-01"
    ipv4_addr_cidr = "192.168.0.134/24"    
    ipv4_gateway   = "192.168.0.1"
  }
}

# XOA Infrastructure parametrization master-01

resource "xenorchestra_cloud_config" "master-01_metadataconfig" {
  name     = "network data config"
  template = data.template_file.master-01_metadata.rendered
}

data "xenorchestra_pool" "master-01_pool" {
  name_label = "uscosvmeax11"
}

data "xenorchestra_template" "master-01_template" {
  name_label = "ubuntu-20.04-cloud-base"
  pool_id    = data.xenorchestra_pool.master-01_pool.id
}

data "xenorchestra_sr" "master-01_sr" {
  name_label = "Local storage"
  pool_id    = data.xenorchestra_pool.master-01_pool.id
}

data "xenorchestra_network" "master-01_network" {
  name_label = "Pool-wide network associated with eth0"
  pool_id    = data.xenorchestra_pool.master-01_pool.id
}


# VM creation master-01

resource "xenorchestra_vm" "master-01" {
  cloud_network_config = xenorchestra_cloud_config.master-01_metadataconfig.template
  cloud_config         = xenorchestra_cloud_config.master-01_userdataconfig.template
  memory_max           = 2147467264
  cpus                 = 2
  name_label           = "master-01"
  template             = data.xenorchestra_template.master-01_template.id

  network {
    network_id = data.xenorchestra_network.master-01_network.id
  }

  disk {
    sr_id      = data.xenorchestra_sr.master-01_sr.id
    name_label = "VM root volume"
    size       = 50212254720
  }
}


# Create cloudinit user template master-02

data "template_file" "master-02_userdata" {
  template = file("./cloud_userdata_cfg.yaml")
  vars = {
    hostname = "master-02"
  }
}

resource "xenorchestra_cloud_config" "master-02_userdataconfig" {
  name     = "user data config"
  template = data.template_file.master-02_userdata.rendered
}



# Create cloudinit metadata template master-02

data "template_file" "master-02_metadata" {
  template = file("./cloud_metadata_cfg.yaml")
  vars = {
    hostname  = "master-02"
    ipv4_addr_cidr = "192.168.0.135/24"    
    ipv4_gateway   = "192.168.0.1"
  }
}

# XOA Infrastructure parametrization master-02

resource "xenorchestra_cloud_config" "master-02_metadataconfig" {
  name     = "network data config"
  template = data.template_file.master-02_metadata.rendered
}

data "xenorchestra_pool" "master-02_pool" {
  name_label = "uscosvmeax11"
}

data "xenorchestra_template" "master-02_template" {
  name_label = "ubuntu-20.04-cloud-base"
  pool_id    = data.xenorchestra_pool.master-02_pool.id
}

data "xenorchestra_sr" "master-02_sr" {
  name_label = "Local storage"
  pool_id    = data.xenorchestra_pool.master-02_pool.id
}

data "xenorchestra_network" "master-02_network" {
  name_label = "Pool-wide network associated with eth0"
  pool_id    = data.xenorchestra_pool.master-02_pool.id
}


# VM creation master-02

resource "xenorchestra_vm" "master-02" {
  cloud_network_config = xenorchestra_cloud_config.master-02_metadataconfig.template
  cloud_config         = xenorchestra_cloud_config.master-02_userdataconfig.template
  memory_max           = 2147467264
  cpus                 = 2
  name_label           = "master-02"
  template             = data.xenorchestra_template.master-02_template.id

  network {
    network_id = data.xenorchestra_network.master-02_network.id
  }

  disk {
    sr_id      = data.xenorchestra_sr.master-02_sr.id
    name_label = "VM root volume"
    size       = 50212254720
  }
}

