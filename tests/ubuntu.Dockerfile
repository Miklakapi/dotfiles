FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    sudo \
    bash \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash testuser \
    && echo "testuser:testuser" | chpasswd \
    && echo "testuser ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/testuser

USER testuser
WORKDIR /home/testuser/dotfiles

COPY --chown=testuser:testuser . .

CMD ["bash"]
