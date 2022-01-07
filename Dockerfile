FROM laravelphp/vapor:php74

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.build-date=$BUILD_DATE \
      org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.schema-version="1.0" \
      org.label-schema.vendor="scriptor2k2" \
      org.label-schema.name="vapor-ci-74" \
      org.label-schema.description="Docker for Laravel in a CI environment" \
      org.label-schema.url="https://github.com/bogdankharchenko/vapor-ci"

RUN pecl install pcov
RUN docker-php-ext-enable pcov

ENV COMPOSER_NO_INTERACTION=1
ENV COMPOSER_ALLOW_SUPERUSER=1

COPY ./scripts ./scripts

RUN ./scripts/composer.sh

