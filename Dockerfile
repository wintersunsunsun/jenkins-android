FROM jenkins/jenkins

ENV ANDROID_HOME /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

USER root
RUN apt-get update && apt-get -y upgrade && apt-get install -y gradle

WORKDIR /opt

ARG SDK_FILE=android-sdk.zip

RUN wget -O ${SDK_FILE} https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && unzip ${SDK_FILE} -d ${ANDROID_HOME} \
    && rm ${SDK_FILE}

RUN chown -R jenkins:jenkins ${ANDROID_HOME}

USER jenkins
RUN mkdir -p $HOME/.android && touch $HOME/.android/repositories.cfg

RUN yes | sdkmanager --licenses

USER jenkins