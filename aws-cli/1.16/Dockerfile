FROM alpine:3.8

RUN apk -v --update add \
        python \
        py-pip

# https://github.com/aws/aws-cli
RUN pip install --upgrade awscli==1.16

RUN rm /var/cache/apk/*

WORKDIR /var/www

ENTRYPOINT ["aws"]

CMD ['-']
