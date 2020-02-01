# TODO
# 1. Figure out a way to make the crushftp dir owned by the crushadmin user so it is more secure than
# running as root
# 2. Add the crushftp license
# 3. Determine what volumes to expose to persist any configuration changes outside of the container

# The starting point for this Dockerfile is the wiki article that Crush support pointed out
# https://www.crushftp.com/crush9wiki/Wiki.jsp?page=Docker
FROM openjdk:latest

# RUN apt-get update && apt-get upgrade && apt-get install -y --no-install-recommends unzip
RUN yum -y install unzip

WORKDIR /var/opt

# Create a specific user so that the service does not run with root privs
RUN useradd crushadmin && echo "crushadmin:A_Long_And-RubbishPAsWurd" | chpasswd && \
    mkdir CrushFTP9

# Copy the install package into the image
#COPY --chown=crushadmin ./CrushFTP9.zip ./
COPY ./CrushFTP9.zip ./

# Unzip the install file and then remove it
RUN unzip CrushFTP9.zip && rm CrushFTP9.zip

COPY ./startup.sh ./CrushFTP9/
RUN chmod +x ./CrushFTP9/startup.sh
# Change ownership of the install directory and all its contents, to the user who will
# be running the service
#RUN chown -R crushadmin:crushadmin ./CrushFTP9

#USER crushadmin:crushadmin

WORKDIR /var/opt/CrushFTP9

EXPOSE 21
EXPOSE 443
EXPOSE 2222
EXPOSE 8080

# Expose the various points in the dir structure where persistent data is stored
VOLUME /var/opt/CrushFTP9/users/
VOLUME /var/opt/CrushFTP9/jobs/
VOLUME /var/opt/CrushFTP9/backup/
VOLUME /var/opt/CrushFTP9/prefs.XML

# Startup the crush server
ENTRYPOINT /var/opt/CrushFTP9/startup.sh