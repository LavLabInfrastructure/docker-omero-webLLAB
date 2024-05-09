# build custom iviewer branch
FROM node:16 as iviewer
RUN apt update && apt upgrade -y
RUN apt install -y ant npm nodejs python3-wheel python3-pip
RUN pip3 install --upgrade pip wheel 
RUN git clone https://github.com/LavLabInfrastructure/omero-iviewer.git

WORKDIR /omero-iviewer
# build iviewer
RUN npm run prod
# package iviewer
RUN cd plugin && \
    python3 setup.py bdist_wheel && \
    mv dist/omero_iviewer* /

# omeroweb build
FROM openmicroscopy/omero-web-standalone:5.24.0
HEALTHCHECK CMD [ "curl", "-f", "http://localhost:4080" ]

# add plugin file
ADD ./py_plugins.txt /tmp/
USER root

# redis support
RUN yum -y install python-redis

# install plugins
RUN /opt/omero/web/venv3/bin/python3 -m pip install wheel && \
    /opt/omero/web/venv3/bin/python3 -m pip install -r /tmp/py_plugins.txt
# iviewer
COPY --from=iviewer /omero_iviewer* /tmp
RUN /opt/omero/web/venv3/bin/pip3 install /tmp/omero_iviewer*

# web owner
USER omero-web 

#.omero config file
ADD configs/*.omero /opt/omero/web/config/
