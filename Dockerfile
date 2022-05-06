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
        https://github.com/barrettMCW/omero-iviewerLLAB/suites/6407785013/artifacts/233459949

ADD 01-default-webapps.omero /opt/omero/web/config/

USER omero-web
