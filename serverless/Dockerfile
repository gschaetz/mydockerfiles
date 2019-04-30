FROM alpine:latest
LABEL maintainer "Gary Schaetz"

RUN apk --no-cache add \
        nodejs \ 
        nodejs-npm  && \
        npm install serverless -g

ENV HOME /home/user
RUN addgroup -g 1000 user \
 && adduser -u 1000 -G user -D -h $HOME user 
USER user

ENTRYPOINT [ "/usr/bin/serverless" ]
