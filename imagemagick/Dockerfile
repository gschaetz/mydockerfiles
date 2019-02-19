FROM alpine:latest
LABEL maintainer "Jessie Frazelle <jess@linux.com>"

RUN apk --no-cache add \
	imagemagick \
	bash

ENV HOME /home/user
RUN addgroup -g 1000 user \
 && adduser -u 1000 -G user -D -h $HOME user 
USER user

CMD [ "echo", "Use one of the following commands [ animate | compare | composite | conjure | convert | display | identify | import | mogrify | montage | stream ]" ]
