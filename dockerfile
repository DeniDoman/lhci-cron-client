FROM patrickhulce/lhci-client:0.11.0

COPY entrypoint.sh lhci-client.sh /home/lhci/reports/

USER root

RUN apt-get update && \
    apt-get install -y cron && \
    apt-get clean && \
    adduser lhci crontab && \
    chmod +x /home/lhci/reports/lhci-client.sh /home/lhci/reports/entrypoint.sh

ENTRYPOINT ["/home/lhci/reports/entrypoint.sh"]