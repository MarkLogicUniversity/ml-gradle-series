# Get the latest CentOS 7 image
FROM centos:7
MAINTAINER Alan Johnson <alan.johnson@marklogic.com>

# Get any CentOS updates then clear the Docker cache
RUN yum -y update && yum clean all

# Install MarkLogic dependencies
RUN yum -y install glibc.i686 gdb.x86_64 redhat-lsb.x86_64 && yum clean all

# install the initscripts package so MarkLogic starts ok
RUN yum -y install initscripts && yum clean all

# Set the Path
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Copy the MarkLogic installer to a temp directory in the Docker image being built
COPY MarkLogic-*.rpm /tmp/MarkLogic.rpm

# Install MarkLogic then delete the .RPM file if the install succeeded
RUN yum -y install /tmp/MarkLogic.rpm && rm /tmp/MarkLogic.rpm

# Expose MarkLogic Server ports
# Also expose any ports your own MarkLogic App Servers use such as
# HTTP, REST and XDBC App Servers for your applications
EXPOSE 7997-8002

# Start MarkLogic.
# Also, execute tail such that it waits forever. This prevents
# the container from automatically stopping after starting MarkLogic.
CMD /etc/init.d/MarkLogic start && tail -f /dev/null
