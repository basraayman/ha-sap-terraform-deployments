project     = "suse-css-qa"

# Credentials file for GCP
gcp_credentials_file = "suse-css-qa.json"

# Internal IPv4 range
ip_cidr_range = "10.0.0.0/24"

# Type of VM (vCPUs and RAM)
machine_type = "n1-highmem-8"

# SSH public key file
ssh_pub_key_file = "ssh_pub.key"

region = "europe-west1"

prefix = "${terraform.workspace}-${var.name}"

# Debug
sap_deployment_debug = "Yes"

# The name of the GCP storage bucket in your project that contains the SAP HANA installation files
sap_hana_deployment_bucket = "sap_hana2"

# The instance number, 0 to 99, of the SAP HANA system.
sap_hana_instance_number = "0"

# The default group ID for sapsys
sap_hana_sapsys_gid = "79"

# The SAP HANA system ID. The ID must consist of three alphanumeric characters and begin with a letter. All letters must be uppercase.
sap_hana_sid = "HA0"

# The default value for the <sid>adm user ID is 900 to avoid user created groups conflicting with SAP HANA.
sap_hana_sidadm_uid = "900"

images_path_bucket = "sle-image-store"
sles4sap_os_image_file = "SLES12-SP4-SAP-GCE.x86_64-0.9.5-Build1.20.tar.gz"

# Specifies the URL location of a script to run after the deployment is complete.
# The script should be hosted on a web server or in a GCS bucket.
post_deployment_script = ""