# Use Amazon Linux image from ECR Public
FROM public.ecr.aws/amazonlinux/amazonlinux:latest

# Install dependencies
RUN yum update -y && \
    yum install -y httpd

# Copy the index.html file to the container
COPY index.html /var/www/html/index.html

# Configure Apache (httpd)
RUN echo '#!/bin/bash' > /root/run_apache.sh && \
    echo 'mkdir -p /var/run/httpd' >> /root/run_apache.sh && \
    echo 'mkdir -p /var/lock/httpd' >> /root/run_apache.sh && \
    echo '/usr/sbin/httpd -D FOREGROUND' >> /root/run_apache.sh && \
    chmod 755 /root/run_apache.sh

# Expose port 80
EXPOSE 80

# Start Apache when the container runs
CMD ["/root/run_apache.sh"]
