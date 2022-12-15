FROM python:3.11-alpine
LABEL maintainer="Alexander Zelenyak <zzz.sochi@gmail.com>"

ARG KUBECTL_VERSION=1.26.0
ARG AWSCLI_VERSION=1.27.30
ARG AIA_VERSION=0.5.9
ARG KUSTOMIZE_VERSION=4.5.7

ADD https://storage.googleapis.com/kubernetes-release/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD https://github.com/kubernetes-sigs/aws-iam-authenticator/releases/download/v${AIA_VERSION}/aws-iam-authenticator_${AIA_VERSION}_linux_amd64 /usr/local/bin/aws-iam-authenticator

ADD scripts/kubeauth /usr/local/bin/kubeauth
ADD scripts/kubeapply /usr/local/bin/kubeapply

RUN \
 chmod +x /usr/local/bin/aws-iam-authenticator /usr/local/bin/kubectl /usr/local/bin/kubeauth /usr/local/bin/kubeapply &&\
 apk add --no-cache jq && rm -rf /var/cache/apk/* &&\
 pip --no-cache-dir install "awscli==${AWSCLI_VERSION}" &&\
 wget -c -O - "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" | tar xz kustomize &&\
 mv kustomize /usr/local/bin/kustomize

ENTRYPOINT ["/usr/local/bin/kubeapply"]
