###########################################################
# Dockerfile that builds a Valheim Gameserver
###########################################################
FROM cm2network/steamcmd:root

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 896660
ENV STEAMAPP valheim
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/CM2Walki/Valheim

# Create autoupdate config
# Add entry script & ESL config
# Remove packages and tidy up
RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.20.1-1.1 \
		ca-certificates=20200601~deb10u2 \
		lib32z1=1:1.2.11.dfsg-1 \
		tini=0.18.0-1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& wget --max-redirect=30 "${DLURL}/master/etc/entry.sh" -O "${HOMEDIR}/entry.sh" \
	&& wget --max-redirect=30 "${DLURL}/master/etc/tinientry.sh" -O "${HOMEDIR}/tinientry.sh" \
	&& chmod +x "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" "${STEAMAPPDIR}" \	
	&& rm -rf /var/lib/apt/lists/*
	
ENV SERVER_PORT=2456 \
	SERVER_PUBLIC=1 \
	SERVER_WORLD_NAME="BraveNewWorld" \
	SERVER_PW="changeme" \
	SERVER_NAME="New \"${STEAMAPP}\" Server" \
	SERVER_LOG_PATH="logs_output/outputlog_server.txt" \
	SERVER_SAVE_DIR="Worlds" \
	SCREEN_QUALITY="Fastest" \
	SCREEN_WIDTH=640 \
	SCREEN_HEIGHT=480 \
	ADDITIONAL_ARGS="" \
	STEAMCMD_UPDATE_ARGS=""

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

STOPSIGNAL SIGINT

ENTRYPOINT ["tini", "-g", "--", "/home/steam/tinientry.sh"]

# Expose ports
EXPOSE 2456/tcp \
	2456/udp
