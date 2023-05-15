#Это образ-решение. При его создании запустится сборка сервисов, а затем и сами сервисы.

FROM ghcr.io/userver-framework/ubuntu-userver-build-base:v1 AS builder

WORKDIR /enrollment_template

COPY ./third_party/userver/tools/docker /tools

COPY . /enrollment_template

RUN useradd --create-home --no-user-group user

RUN chown -R user:users /enrollment_template

EXPOSE 8080

RUN /tools/run_as_user.sh make build-release

RUN mkdir /usr/local/etc/enrollment_template/
RUN cp configs/* /usr/local/etc/enrollment_template/
RUN chown -R user:users /usr/local/etc/enrollment_template/

CMD /tools/run_as_user.sh make service-start-release

