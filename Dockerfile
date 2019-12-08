FROM python:3.8-alpine
LABEL maintainer="Alexander Zelenyak <zzz.sochi@gmail.com>"

ARG KUBECTL_VERSION=v1.16.3
ARG AWSCLI_VERSION=1.16.290
ARG AIA_VERSION_AND_DATE=1.14.6/2019-08-22

ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
ADD https://amazon-eks.s3-us-west-2.amazonaws.com/${AIA_VERSION_AND_DATE}/bin/linux/amd64/aws-iam-authenticator /usr/local/bin/aws-iam-authenticator
ADD scripts/kubeauth /usr/local/bin/kubeauth
ADD scripts/kubeapply /usr/local/bin/kubeapply

RUN \
 chmod +x /usr/local/bin/aws-iam-authenticator /usr/local/bin/kubectl /usr/local/bin/kubeauth /usr/local/bin/kubeapply &&\
 apk add --no-cache jq && rm -rf /var/cache/apk/* &&\
 pip --no-cache-dir install "awscli==${AWSCLI_VERSION}"

ENTRYPOINT ["/usr/local/bin/kubeapply"]
