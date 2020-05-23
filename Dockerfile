FROM centos:latest

USER root

ENV WORK_SPACE /opt/projects/project-name

WORKDIR ${WORK_SPACE}

COPY ./mongodb-org-4.2.repo /etc/yum.repos.d/mongodb-org-4.2.repo

RUN yum -y update \
    && yum clean all \
    && curl -sL https://rpm.nodesource.com/setup_12.x | bash - \
    # 安装nodejs
    && yum -y install nodejs \
    && node --version \
    # 安装yarn
    && npm install -g yarn \
    && yarn -v \
    # 安装mongodb
    && yum -y install mongodb-org

COPY entrypoint.sh .
COPY deploy-server ./deploy-server
COPY deploy-board ./deploy-board

RUN chmod u+x entrypoint.sh \
    && cd ${WORK_SPACE}/deploy-board \
    && yarn \
    && yarn build \
    && cd ${WORK_SPACE}/deploy-server \
    && yarn

EXPOSE 3000

ENTRYPOINT [ "./entrypoint.sh" ]