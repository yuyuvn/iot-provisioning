provider "oci" {}

data "oci_core_subnet" "reverse_proxy_subnet" {
	subnet_id = "ocid1.subnet.oc1.ap-tokyo-1.aaaaaaaau3ntyanseerv3vcqwiedmfp4cmjogstclbzowz35qmaossuez2ya"
}

resource "oci_core_network_security_group" "reverse_proxy_nsg" {
	compartment_id = "ocid1.tenancy.oc1..aaaaaaaaen7yrdnu2ec2nigeviabp7dxx7f5j5ihnco7m6uljcx2nkajc3sa"
	vcn_id         = data.oci_core_subnet.reverse_proxy_subnet.vcn_id
	display_name   = "reverse-proxy-nsg"
}

resource "oci_core_network_security_group_security_rule" "reverse_proxy_ingress_http" {
	network_security_group_id = oci_core_network_security_group.reverse_proxy_nsg.id
	direction                 = "INGRESS"
	protocol                  = "6"
	source                    = "0.0.0.0/0"
	source_type               = "CIDR_BLOCK"
	tcp_options {
		destination_port_range {
			min = 80
			max = 80
		}
	}
}

resource "oci_core_network_security_group_security_rule" "reverse_proxy_ingress_https" {
	network_security_group_id = oci_core_network_security_group.reverse_proxy_nsg.id
	direction                 = "INGRESS"
	protocol                  = "6"
	source                    = "0.0.0.0/0"
	source_type               = "CIDR_BLOCK"
	tcp_options {
		destination_port_range {
			min = 443
			max = 443
		}
	}
}

resource "oci_core_network_security_group_security_rule" "reverse_proxy_ingress_sish_ssh" {
	network_security_group_id = oci_core_network_security_group.reverse_proxy_nsg.id
	direction                 = "INGRESS"
	protocol                  = "6"
	source                    = "0.0.0.0/0"
	source_type               = "CIDR_BLOCK"
	tcp_options {
		destination_port_range {
			min = 2222
			max = 2222
		}
	}
}

resource "oci_core_instance" "generated_oci_core_instance" {
	agent_config {
		is_management_disabled = "false"
		is_monitoring_disabled = "false"
		plugins_config {
			desired_state = "DISABLED"
			name = "WebLogic Management Service"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Vulnerability Scanning"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Oracle Java Management Service"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "OS Management Hub Agent"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Management Agent"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Fleet Application Management Service"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Custom Logs Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute RDMA GPU Monitoring"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Run Command"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Compute Instance Monitoring"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute HPC RDMA Auto-Configuration"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Compute HPC RDMA Authentication"
		}
		plugins_config {
			desired_state = "ENABLED"
			name = "Cloud Guard Workload Protection"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Block Volume Management"
		}
		plugins_config {
			desired_state = "DISABLED"
			name = "Bastion"
		}
	}
	availability_config {
		recovery_action = "RESTORE_INSTANCE"
	}
	availability_domain = "GbJH:AP-TOKYO-1-AD-1"
	compartment_id = "ocid1.tenancy.oc1..aaaaaaaaen7yrdnu2ec2nigeviabp7dxx7f5j5ihnco7m6uljcx2nkajc3sa"
	create_vnic_details {
		assign_ipv6ip = "true"
		assign_private_dns_record = "true"
		assign_public_ip = "true"
		ipv6address_ipv6subnet_cidr_pair_details {
			ipv6subnet_cidr = "2603:c021:8018:6c01:0000:0000:0000:0000/64"
		}
		nsg_ids = [oci_core_network_security_group.reverse_proxy_nsg.id]
		subnet_id = "ocid1.subnet.oc1.ap-tokyo-1.aaaaaaaau3ntyanseerv3vcqwiedmfp4cmjogstclbzowz35qmaossuez2ya"
	}
	display_name = "instance-20250710-2354"
	instance_options {
		are_legacy_imds_endpoints_disabled = "false"
	}
	is_pv_encryption_in_transit_enabled = "true"
	metadata = {
		"ssh_authorized_keys" = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDxZLKY8cG2oMhcLJ5thXXmo8gza2Q+pY+abMQyVKueO clicia@clicia-workspace"
	}
	shape = "VM.Standard.A1.Flex"
	shape_config {
		memory_in_gbs = "12"
		ocpus = "2"
	}
	source_details {
		source_id = "ocid1.image.oc1.ap-tokyo-1.aaaaaaaaotyvuoiwlrfuqwqcnf2f3ihknlu25jzsye6svjaoplvbb65bwela"
		source_type = "image"
	}
}
