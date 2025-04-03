# Dockerfile.flutter

FROM dart:stable AS dart-env

# Installer Flutter manuellement
RUN git clone https://github.com/HoudaTaleb/CalmCup /flutter -b stable
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

RUN flutter doctor

WORKDIR /app
COPY . .

RUN flutter pub get
RUN flutter build apk

# Le résultat sera dans :
# /app/build/app/outputs/flutter-apk/app-release.apk
