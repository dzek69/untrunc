# pull base image
FROM jrottenberg/ffmpeg:3.4-alpine
#LABEL stage=intermediate


RUN apk update \
    && apk add make g++

# copy code
ADD . /untrunc-src
WORKDIR /untrunc-src

# add deps needed to compile ffmpeg
RUN apk add --no-cache yasm coreutils

# build untrunc
RUN /usr/bin/make FF_VER=3.3.9 && strip untrunc

# non-root user
RUN adduser -D untrunc
USER untrunc

# execution
ENTRYPOINT ["/untrunc-src/untrunc"]
