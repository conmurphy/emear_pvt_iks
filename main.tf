provider "intersight" {
  apikey    = var.intersight_api_key
  secretkey = var.intersight_secret_key
  endpoint  = var.intersight_endpoint
}

module "terraform-intersight-iks" {
    source = "app.terraform.io/Cisco-IST-TigerTeam/iks/intersight"
    version ="2.0.3"

    cluster = {
        name = "emear-pvt-iks"
        action = "Deploy"
        wait_for_completion = false
        worker_nodes = 1
        load_balancers = 3
        worker_max = 20
        control_nodes = 1
        ssh_user = var.iks_ssh_user
        ssh_public_key = var.iks_ssh_key
    }

    ip_pool = {
        use_existing = true
        name = "RMLAB-IKS-IPPOOL-130"
    }

    sysconfig = {
        use_existing = true
        name = "rmlab-iks-sys-config-policy"
    }

    k8s_network = {
        use_existing = true
        name = "evolve_iks_cluster_k8s_net_policy"
    }

    runtime_policy = {
        use_existing = true
        name = "evolve_iks_cluster_runtime_policy"
    }

    version_policy = {
        use_existing = true
        name = "RMLAB-IKS-K8S-VERSION"
    }
    
    
    tr_policy = {
        use_existing = false
        create_new = false
    }
    

    # Infra Config Policy Information
    infra_config_policy = {
        use_existing = true
        name = "RMLAB-IKS-VM-CONFIG"
    }

    instance_type = {
        use_existing = true
        name = "RMLAB-IKS-VM-INSTANCE-TYPE"
    }
    
    organization = var.intersight_organization
}

