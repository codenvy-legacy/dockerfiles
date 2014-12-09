FROM codenvy/jdk7_vnc

RUN sudo apt-get update && sudo apt-get install -y libswt-gtk-3-java lib32z1 lib32ncurses5 lib32stdc++6

# Main Android SDK
RUN wget -qO- "http://dl.google.com/android/android-sdk_r23.0.2-linux.tgz" | tar -zxv -C /home/user/

# Other tools and resources of Android SDK
ENV ANDROID_HOME /home/user/android-sdk-linux
RUN echo "export ANDROID_HOME=$ANDROID_HOME" >> /home/user/.bashrc
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools
RUN echo "export PATH=$PATH" >> /home/user/.bashrc

RUN echo y | android update sdk --all --filter platform-tools,android-17,sys-img-armeabi-v7a-android-17 --no-ui --force && \
     echo no | android create avd -n myandroid -t android-17

RUN echo "[begin] (Blackbox) \n \
      [exec] (Terminal) {urxvt -fn "xft:Terminus:size=12"} \n \
      [exec] (Emulator) {emulator64-arm -avd myandroid} \n \
      [exec] (Install .apk) {adb install /home/user/application.apk} \n \
   [end]" | sudo tee /etc/X11/blackbox/blackbox-menu

# === Usage ===
# ADD $app$ /home/user/application.apk