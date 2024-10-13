FROM python:3.12

SHELL ["/bin/bash", "-c"] 

COPY . /exo

WORKDIR /exo

ENV PATH="$PATH:/root/.cargo/bin:/exo/.venv/bin"

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y && \
    python3 -m venv .venv && \
    source .venv/bin/activate && \
    pip install -e .

CMD [ "exo" ]