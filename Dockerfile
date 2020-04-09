FROM zmaker123/lci-ubi:8.1-latest

USER root
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip ./awscliv2.zip \
    && ./aws/install \
    && rm -R ./awscliv2.zip ./aws