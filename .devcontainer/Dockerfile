# Use an official Flutter image as a base
FROM cirrusci/flutter:stable

# Install OpenJDK 17 (for Firebase, Android development, etc.)
RUN apt-get update && apt-get install -y openjdk-17-jdk

# Install Android SDK and required tools
RUN apt-get install -y \
    wget \
    unzip \
    lib32z1 \
    lib32ncurses6 \
    lib32stdc++6 \
    lib32gcc1 \
    lib32tinfo5 \
    && wget https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip \
    && unzip commandlinetools-linux-6858069_latest.zip -d /android-sdk \
    && rm commandlinetools-linux-6858069_latest.zip \
    && yes | /android-sdk/cmdline-tools/bin/sdkmanager --licenses \
    && /android-sdk/cmdline-tools/bin/sdkmanager --update

# Install Firebase CLI
RUN npm install -g firebase-tools

# Install dependencies for OpenCV or other AI tools you need (optional)
RUN apt-get install -y \
    python3-opencv \
    libopencv-dev \
    && apt-get clean

# Set the environment variable for the Android SDK
ENV ANDROID_SDK_ROOT="/android-sdk"
ENV PATH="${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${PATH}"
ENV PATH="${ANDROID_SDK_ROOT}/platform-tools:${PATH}"
ENV PATH="${ANDROID_SDK_ROOT}/tools:${PATH}"
ENV PATH="${ANDROID_SDK_ROOT}/tools/bin:${PATH}"
ENV PATH="/flutter/bin:${PATH}"

# Expose port for debugging, if necessary
EXPOSE 8080
