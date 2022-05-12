FROM openmicroscopy/omero-web:latest

USER root
RUN yum -y install git 
RUN yum -y install 'django-redis<4.9'
RUN /opt/omero/web/venv3/bin/pip install \
        omero-figure \
        llab-omero-iviewer \
#        omero-fpbioimage \
        omero-mapr \
        omero-parade 
#        omero-webtagging-autotag \
#        omero-webtagging-tagsearch \

ADD 01-default-webapps.omero /opt/omero/web/config/

USER omero-web