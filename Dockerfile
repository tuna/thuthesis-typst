FROM docker.io/texlive/texlive:latest

ARG TYPST_VERSION=0.15.1
RUN apt-get update \
  && apt-get install -y --no-install-recommends xz-utils \
  && rm -rf /var/lib/apt/lists/* \
  && curl -fLsS "https://github.com/typst/typst/releases/download/v${TYPST_VERSION}/typst-x86_64-unknown-linux-musl.tar.xz" \
  | tar xJ -C /usr/local/bin --strip-components=1 typst-x86_64-unknown-linux-musl/typst \
  && ln -s "$(kpsewhich -var-value=TEXMFDIST)/fonts" /opt/fonts

ENV TYPST_FONT_PATHS=/opt/fonts \
  TYPST_IGNORE_SYSTEM_FONTS=true
