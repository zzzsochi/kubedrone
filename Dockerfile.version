FROM zzzsochi/kubedrone

ADD scripts/kubeversion /usr/local/bin/kubeversion
RUN chmod +x /usr/local/bin/kubeversion

ENTRYPOINT ["/usr/local/bin/kubeversion"]
