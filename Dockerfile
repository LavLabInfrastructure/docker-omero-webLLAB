FROM node:16 as iviewer
RUN apt update && apt upgrade -y
RUN apt install -y ant npm nodejs python3-wheel python3-pip
RUN pip3 install --upgrade pip wheel 
RUN git clone https://github.com/barrettMCW/omero-iviewer.git

WORKDIR /omero-iviewer
RUN npm update && \
    npm run prod
RUN cd plugin && \
    python3 setup.py bdist_wheel && \
    mv dist/omero_iviewer* /

FROM openmicroscopy/omero-web:latest
USER root
# redis support
RUN yum -y install redis python-redis
# omero web plugins
COPY --from=iviewer /omero_iviewer* /tmp
RUN /opt/omero/web/venv3/bin/pip3 install \
    omero-figure \
    omero-mapr \
    omero-parade \
    omero-webtagging-tagsearch omero-webtagging-autotag \
    omero-gallery 
RUN /opt/omero/web/venv3/bin/pip3 install /tmp/omero_iviewer*
#    omero-iviewer 

# web owner
USER omero-web
#.omero config file
ADD 01-default-webapps.omero /opt/omero/web/config/
