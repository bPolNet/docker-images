FROM node:8.12

# Add Tini
ENV TINI_VERSION v0.18.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

RUN usermod -u 1000 -s /bin/bash node

WORKDIR /var/www

USER node

ENTRYPOINT ["/tini", "--"]

CMD ["npm", "install"]


