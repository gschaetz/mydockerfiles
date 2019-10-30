FROM alpine:latest

RUN apk update \
    && apk upgrade \
    && apk --no-cache add \
	ca-certificates \
	groff \
	less \
	python \
	py2-pip \
	&& pip install awscli \
        && bash \
        && bash-doc \
        && bash-completion \
	&& mkdir -p /root/.aws \
	&& { \
		echo '[default]'; \
		echo 'output = json'; \
		echo 'region = $AWS_DEFAULT_REGION'; \
		echo 'aws_access_key_id = $AMAZON_ACCESS_KEY_ID'; \
		echo 'aws_secret_access_key = $AMAZON_SECRET_ACCESS_KEY'; \
	} > /root/.aws/config

ENV HOME /home/user
RUN addgroup -g 1000 user \
 && adduser -u 1000 -G user -s /bin/bash -D -h $HOME user 
USER user

ENTRYPOINT [ "bash" ]
