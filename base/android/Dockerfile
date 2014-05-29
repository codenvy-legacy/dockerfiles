FROM sleshchenko/vnc

RUN chown user:user /home/user -R

USER user

# Main Android SDK
RUN wget -qO- "http://dl.google.com/android/android-sdk_r22.6.2-linux.tgz" | tar -zxv -C /home/user/

# Other tools and resources of Android SDK
ENV ANDROID_HOME /home/user/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools

RUN echo y | android update sdk --filter platform-tools,build-tools-19.0.3,android-17,sysimg-17,extra-android-support --no-ui --force &&/
    echo no | android create avd -n myandroid -t android-17

USER root
RUN apt-get install -y libswt-gtk-3-java lib32z1 lib32ncurses5 lib32stdc++6

ENTRYPOINT ["/startup.sh"]