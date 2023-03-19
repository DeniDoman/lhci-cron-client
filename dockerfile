FROM patrickhulce/lhci-client:0.11.0

COPY entrypoint.sh lhci-client.sh /home/lhci/

USER root

RUN apt-get update && \
    apt-get install -y cron && \
    adduser lhci crontab && \
    chmod +x /home/lhci/lhci-client.sh /home/lhci/entrypoint.sh

USER lhci

ENTRYPOINT ["/home/lhci/entrypoint.sh"]