FROM openmicroscopy/omero-web:latest

USER root
RUN yum -y install git 
RUN /opt/omero/web/venv3/bin/pip install \
        omero-figure \
#        omero-iviewer \
#        omero-fpbioimage \
        omero-mapr \
        omero-parade \
#        omero-webtagging-autotag \
#        omero-webtagging-tagsearch \
        git+https://github.com/barrettMCW/omero-iviewerLLAB.git 

ADD 01-default-webapps.omero /opt/omero/web/config/

USER omero-web
