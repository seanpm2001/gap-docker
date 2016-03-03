FROM gapsystem/gap-docker-base

MAINTAINER The GAP Group <support@gap-system.org>

# Install package dependencies
RUN    sudo apt-get -qq install -y cmake #for NormalizInterface

RUN    cd /home/gap/inst/gap4r8/pkg \
    && rm -rf \
    && wget -q http://www.gap-system.org/pub/gap/gap4pkgs/packages-v4.8.2.tar.gz \
    && tar xzf packages-v4.8.2.tar.gz \
    && rm packages-v4.8.2.tar.gz \
    && wget https://raw.githubusercontent.com/gap-system/gap-docker/master/InstPackages.sh \
    && chmod u+x InstPackages.sh \
    && ./InstPackages.sh

# Set up new user and home directory in environment.
# Note that WORKDIR will not expand environment variables in docker versions < 1.3.1.
# See docker issue 2637: https://github.com/docker/docker/issues/2637
USER gap
ENV HOME /home/gap
ENV GAP_HOME /home/gap/inst/gap4r8
ENV PATH ${GAP_HOME}/bin:${PATH}

# Start at $HOME.
WORKDIR /home/gap

# Start from a BASH shell.
CMD ["bash"]
