FROM debian:stretch

# change debian.org to archive.debian.org
RUN sed -i '/stretch-updates/d' /etc/apt/sources.list
RUN sed -i 's|deb.debian.org|archive.debian.org|g; s|security.debian.org/debian-security|archive.debian.org/debian-security|g' /etc/apt/sources.list

# update packages
RUN apt update
RUN apt install -y \
    git \
    curl \
    build-essential \
    gcc \
    g++ \
    make \
    zlib1g-dev

ENV RBENV_ROOT="/opt/rbenv"
ENV PATH="${RBENV_ROOT}/bin:${RBENV_ROOT}/shims:${PATH}"

# clone rbenv and ruby-build
RUN git clone https://github.com/rbenv/rbenv.git ${RBENV_ROOT} && \
    git clone https://github.com/rbenv/ruby-build.git ${RBENV_ROOT}/plugins/ruby-build


# check rbenv version
RUN rbenv --version    
RUN rbenv install 2.3.8 && \
    rbenv global 2.3.8 && \
    rbenv rehash

# check ruby version
RUN ruby --version

CMD ["irb"]