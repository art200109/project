FROM python:3.6

ARG ssh_prv_key
ARG ssh_pub_key

RUN apt-get update -y && apt-get -y install ssh

RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh

RUN echo "$ssh_prv_key" > /root/.ssh/id_rsa && \
    echo "$ssh_pub_key" > /root/.ssh/id_rsa.pub && \
    chmod 600 /root/.ssh/id_rsa && \
    chmod 600 /root/.ssh/id_rsa.pub



COPY ./req.txt /var/www/requirements.txt
RUN pip install -r /var/www/requirements.txt

WORKDIR /app

COPY ./app.py /app

EXPOSE 5000
ENTRYPOINT [ "python" ]
CMD [ "app.py" ]
