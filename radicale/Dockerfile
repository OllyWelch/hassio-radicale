ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_FROM
FROM $BUILD_FROM

ARG BUILD_UID
ENV BUILD_UID ${BUILD_UID:-2999}

ARG BUILD_GID
ENV BUILD_GID ${BUILD_GID:-2999}

ARG VERSION
ENV VERSION ${VERSION:-3.1.5}

# Install requirements for add-on
RUN apk add --no-cache --virtual=build-dependencies \
        gcc \
        musl-dev \
        libffi-dev \
        python3-dev \
    && apk add --no-cache \
        apache2-utils \
        curl \
        git \
        openssh \
        shadow \
        su-exec \
        tzdata \
        wget \
        python3 \
        py3-tz \
        py3-pip \
    && python3 -m pip install --upgrade pip \
    && python3 -m pip install radicale==$VERSION passlib[bcrypt] \
    && apk del --purge build-dependencies \
    && addgroup -g $BUILD_GID radicale \
    && adduser -D -s /bin/false -H -u $BUILD_UID -G radicale radicale \
    && mkdir -p /config /data \
    && chmod -R 770 /data \
    && chown -R radicale:radicale /data \
    && rm -fr /root/.cache

# Copy root filesystem
COPY rootfs /