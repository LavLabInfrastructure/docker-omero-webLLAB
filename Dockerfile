FROM openmicroscopy/omero-web:latest
USER root
# redis support
RUN yum -y install redis python-redis
# omero web plugins
RUN /opt/omero/web/venv3/bin/pip install \
        omero-figure \
        omero-mapr \
        omero-parade \
        omero-webtagging-tagsearch omero-webtagging-autotag \
        omero-gallery \
        omero-iviewer 
# web owner
USER omero-web
#.omero config file
ADD 01-default-webapps.omero /opt/omero/web/config/
