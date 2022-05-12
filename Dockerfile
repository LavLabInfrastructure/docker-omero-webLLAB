FROM openmicroscopy/omero-web:latest

USER root
RUN yum -y install git 
RUN yum -y install 'django-redis<4.9'
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
RUN /opt/omero/server/OMERO.server/bin/omero config set omero.web.caches '{"default": {"BACKEND": "django_redis.cache.RedisCache","LOCATION": "redis://cache:6379/0"}}'
RUN /opt/omero/server/OMERO.server/bin/omero config set omero.web.session_engine 'django.contrib.sessions.backends.cache'