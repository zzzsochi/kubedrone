# Apply [kubernetes](https://kubernetes.io/) configuration from [drone](https://drone.io/)

## kubectl apply -f <file>

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    apply_file: build/config.yaml
    ...
```

## kubectl apply -k <kustomize-dir>

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    apply_kustomize: build/kustomize/stage
    ...
```

## Authentification

### Token

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    server: "secret"
    server_ca: "secret"
    token: "secret"
    ...
```

### Client key

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    server: "secret"
    server_ca: "secret"
    client_crt: "secret"
    client_key: "secret"
    ...
```

### Basic auth

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    server: "secret"
    server_ca: "secret"
    username: "secret"
    password: "secret"
    ...
```

### AWS EKS

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    eks_cluster_region: "secret"
    eks_cluster_name: "secret"
    aws_access_key_id: "secret"
    aws_secret_access_key: "secret"
    ...
```

## Verbose mode

```yaml
- name: deploy
  image: zzzsochi/kubedrone
  settings:
    debug: "true"
    ...
```

# Work with version of your project

We need to save version when project build for _stage_ and get this version when project deploy from _master_.

## Save version for commit

```yaml
- name: version
  image: zzzsochi/kubedrone:version
  settings:
    command: save
    vendor: tc
    service: core
    status: ok
    version_file: build/version
    ...
```

This stage will save version to ConfigMap.


## Get version by commit

```yaml
- name: version
  image: zzzsochi/kubedrone:version
  settings:
    command: get
    vendor: tc
    service: core
    status: ok
    version_file: build/version
    ...
```

This stage will create the file ``build/version`` with your project version, saved by previews example.
