# kubectl apply -f <file>

## Usage


### Token

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    apply_file: build/config.yaml
    server: "secret"
    server_ca: "secret"
    token: "secret"
```

### Client key

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    apply_file: build/config.yaml
    server: "secret"
    server_ca: "secret"
    client_crt: "secret"
    client_key: "secret"
```

### Basic auth

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    apply_file: build/config.yaml
    server: "secret"
    server_ca: "secret"
    username: "secret"
    password: "secret"
```

### AWS EKS

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    apply_file: build/config.yaml
    eks_cluster_region: "secret"
    eks_cluster_name: "secret"
    aws_access_key_id: "secret"
    aws_secret_access_key: "secret"
```
