import cert_manager.v1 as cm

cluster_names = ["cluster-a", "cluster-b", "cluster-c", "cluster-d"]

https_certificate: [cm.Certificate] = [ # Use type-safe object
    { 
        metadata = {
            name = "wildcard-crt"
            namespace = cluster_name
        }
        spec = {
            dnsNames = [
                "*.${cluster_name}.example.io" # Use variable in string interpolation
            ]
            issuerRef = {
                kind = "ClusterIssuer"
                name = "letsencrypt-prod"
            }
            secretName = "wildcard-crt"
        }
    } for cluster_name in cluster_names # Loop over cluster names
]
