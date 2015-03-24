FROM redmine
MAINTAINER stefanvanwouw@gmail.com

# This images installs the required backlogs plugin into the data container before starting the redmine app.


RUN apt-get update && apt-get install -y unzip
RUN mkdir /app/plugins/
ADD assets/init-with-plugins /app/
COPY assets/redmine_backlogs /app/plugins/redmine_backlogs
RUN chmod 755 /app/init-with-plugins

ENTRYPOINT ["/app/init-with-plugins"]
CMD ["app:start"]