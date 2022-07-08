FROM enclaive/gramine-os:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && apt-get install -y sendmail && apt-get install net-tools
RUN cp /usr/sbin/sendmail /entrypoint/

WORKDIR /manifest
COPY sendmail.manifest.template .
RUN ./manifest.sh sendmail

EXPOSE 25

ENTRYPOINT ["/entrypoint/enclaive.sh"]
CMD ["sendmail -bD"]