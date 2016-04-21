FROM operable/relay:0.3.1
USER root
RUN apt-get install zip libyaml-dev python-yaml && rm -rf /var/lib/apt/lists/*

USER operable
RUN cd /tmp && git clone https://github.com/cog-bundles/mist.git && cd mist && make install && make && cp mist.cog /home/operable/relay/data/pending && rm -rf /tmp/mist

ENTRYPOINT ["scripts/wait-for-it.sh", "-s", "-t", "0", "-h", "cog", "-p", "1883", "--", "elixir", "--no-halt", "--name", "relay@127.0.0.1", "-S", "mix"]
