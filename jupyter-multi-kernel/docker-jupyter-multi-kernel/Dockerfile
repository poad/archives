FROM poad/docker-jupyter-haskell-base:latest

LABEL Kenji Saito "ken-yo@mbr.nifty.com"

RUN ihaskell install --stack && \
    rm -rf /tmp/* && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /root/notebook

EXPOSE 8888

WORKDIR /root/notebook

CMD ["stack", "exec", "--", "jupyter", "lab", "--port=8888", "--ip='*'", "--no-browser", "--allow-root"]
