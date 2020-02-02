# The starting point for this Dockerfile is the wiki article that Crush support pointed out
# https://www.crushftp.com/crush9wiki/Wiki.jsp?page=Docker
FROM openjdk:latest

# RUN apt-get update && apt-get upgrade && apt-get install -y --no-install-recommends unzip
RUN yum -y install unzip

WORKDIR /var/opt

# Create a specific user so that the service does not run with root privs
RUN useradd crushadmin && echo "crushadmin:A_Long_And-RubbishPAsWurd" | chpasswd && \
    mkdir CrushFTP9 && \
    mkdir /data

# Copy the install package into the image
#COPY --chown=crushadmin ./CrushFTP9.zip ./
COPY ./CrushFTP9.zip ./

# Unzip the install file and then remove it
RUN unzip -q CrushFTP9.zip && rm CrushFTP9.zip

# Copy the startup script, make it runnable and remove the preexisting preferences file as it will
# be overwritten with one from the host, supllied as a volume mapping. If the prefs.XML file is not 
# removed then any changes to preferences when the container is running will not be persisted as the 
# contianer copy takes precedence than the volume mapped one
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
# Webdav on 9090
EXPOSE 9090 
EXPOSE 2000:2010

# Expose the various points in the dir structure where persistent data is stored
VOLUME /var/opt/CrushFTP9/users/
VOLUME /var/opt/CrushFTP9/jobs/
VOLUME /var/opt/CrushFTP9/backup/
VOLUME /data
# VOLUME /var/opt/CrushFTP9/prefs.XML

# Startup the crush server
ENTRYPOINT /var/opt/CrushFTP9/startup.sh
#
# TODO - Placed here to prevent changes from causing a rebuild of all intermediate containers
#
# 1. Figure out a way to make the crushftp dir owned by the crushadmin user so it is more secure than
# running as root
# 2. Add the crushftp enterprise license
# 3. Determine what volumes to exposed to persist any configuration changes outside of the container
# 4. Ensure that the container does not keep growing in size with internal log files such as CrushFTP.log
# 5. Remove nano editor from the yum install
# 6. Use an Ubuntu image if the container keeps being problematic, to see if that changes anything
# 7. Use unzip silent so all the files do not get displayed to stdout
# 8. MUST Register license so that it saves the preferences to the prefs.XML file.