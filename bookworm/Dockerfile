###########################################################
# Dockerfile that builds a Valheim Gameserver
###########################################################
FROM cm2network/steamcmd:root as build_stage

LABEL maintainer="walentinlamonos@gmail.com"

ENV STEAMAPPID 896660
ENV STEAMAPP valheim
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/CM2Walki/Valheim

COPY "etc/entry.sh" "${HOMEDIR}/entry.sh"
COPY "etc/tinientry.sh" "${HOMEDIR}/tinientry.sh"

RUN set -x \
	# Install, update & upgrade packages
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget=1.21.3-1+b2 \
		ca-certificates=20230311 \
		lib32z1=1:1.2.13.dfsg-1 \
		tini=0.19.0-1 \
		libc6-dev=2.36-9+deb12u9 \
		file=1:5.44-3 \
		libatomic1=12.2.0-14 \
		libpulse0=16.1+dfsg1-2+b1 \
		libpulse-dev=16.1+dfsg1-2+b1 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& chmod +x "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${HOMEDIR}/tinientry.sh" "${STEAMAPPDIR}" \
	# Clean up
	&& rm -rf /var/lib/apt/lists/*

FROM build_stage AS bookworm-base

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

# Switch to user
USER ${USER}

WORKDIR ${HOMEDIR}

# Overwrite Stopsignal for graceful server exits
STOPSIGNAL SIGINT

ENTRYPOINT ["tini", "-g", "--", "/home/steam/tinientry.sh"]

# Expose ports
EXPOSE 2456/tcp \
	2456/udp \
	2467/udp

FROM bookworm-base AS bookworm-plus

ENV VALHEIM_PLUS_VERSION 0.9.9.11
