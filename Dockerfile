FROM python:3.9-alpine
LABEL maintainer="Alexander Zelenyak <zzz.sochi@gmail.com>"

ARG KUBECTL_VERSION=v1.21.2
ARG AWSCLI_VERSION=1.16.312
ARG AIA_VERSION_AND_DATE=1.19.6/2021-01-05
ARG KUSTOMIZE_VERSION=4.2.0

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/${AIA_VERSION_AND_DATE}/bin/linux/amd64/aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

ADD scripts/kubeauth /usr/local/bin/kubeauth
ADD scripts/kubeapply /usr/local/bin/kubeapply

RUN \
 chmod +x /usr/local/bin/aws-iam-authenticator /usr/local/bin/kubectl /usr/local/bin/kubeauth /usr/local/bin/kubeapply &&\
 apk add --no-cache jq && rm -rf /var/cache/apk/* &&\
 pip --no-cache-dir install "awscli==${AWSCLI_VERSION}" &&\
 wget -c -O - "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv${KUSTOMIZE_VERSION}/kustomize_v${KUSTOMIZE_VERSION}_linux_amd64.tar.gz" | tar xz kustomize &&\
 mv kustomize /usr/local/bin/kustomize

ENTRYPOINT ["/usr/local/bin/kubeapply"]
