FROM hashicorp/terraform:latest

ENV HOME /home/user
RUN addgroup -g 1000 user \
 && adduser -u 1000 -G user -D -h $HOME user 
USER user

ENTRYPOINT [ "ash" ]
