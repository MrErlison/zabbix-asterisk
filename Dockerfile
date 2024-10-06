FROM    ubuntu:24.10

RUN     echo "America/Sao_Paulo" > /etc/timezone && \
        apt update && \
        apt install -y wget && \
        wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-20.9.3.tar.gz && \
        tar -xf asterisk-20.9.3.tar.gz && \
        rm -f asterisk-20.9.3.tar.gz && \
        /asterisk-20.9.3/contrib/scripts/install_prereq install

WORKDIR asterisk-20.9.3

RUN     ./configure --libdir=/usr/lib64 --with-jansson-bundled && \
        make -j$(nproc) menuselect.makeopts && \
        menuselect/menuselect \
                  --enable codec_opus \
                  --enable chan_ooh323 \
        menuselect.makeopts && \
        make && \
        make install && \
        make install-logrotate && \
        make samples && \
        make dist-clean && \
        sed -i -e 's/# MAXFILES=/MAXFILES=/' /usr/sbin/safe_asterisk && \
        useradd -m asterisk -s /sbin/nologin && \
        chown -R asterisk:asterisk /var/run/asterisk \
                                  /etc/asterisk/ \
                                  /var/lib/asterisk \
                                  /var/log/asterisk \
                                  /var/spool/asterisk \
                                  /usr/lib64/asterisk/ && \
        cd / && \
        rm -rf asterisk-20.9.3

WORKDIR /

COPY    ./aster_env/etc/asterisk/*.conf /etc/asterisk/

USER    asterisk

CMD     /usr/sbin/asterisk -f
