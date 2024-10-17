FROM python:3.12

# docker buildx build --load -t exo:local . 
# docker run -it --rm -p 8000:8000 -p 10128:10128 -v ./.cache:/root/.cache exo:local

SHELL ["/bin/bash", "-c"] 

COPY . /exo

WORKDIR /exo

ENV PATH="$PATH:/root/.cargo/bin:/exo/.venv/bin:/usr/lib/llvm-18/bin"

EXPOSE 10128/udp
EXPOSE 8000/tcp

VOLUME /root/.cache

RUN apt update && apt install -y lsb-release gnupg software-properties-common && apt-get clean && \
    wget -qO- https://apt.llvm.org/llvm.sh | bash -s -- 18 && \
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    python3 -m venv .venv && \
    source .venv/bin/activate && \
    pip install -e .

CMD [ "exo", "--disable-tui" ]