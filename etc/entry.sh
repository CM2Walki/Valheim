#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" +quit
else
	steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
	bash "${STEAMCMDDIR}/steamcmd.sh" +force_install_dir "$STEAMAPPDIR" +login anonymous +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

# We assume that if the valheim plus config is missing, that this is a fresh container
if [ ! -f "${STEAMAPPDIR}/start_server_bepinex.sh" ]; then
	# Are we in a valheim plus container?
	if [ ! -z "$VALHEIM_PLUS_VERSION" ]; then
		wget --max-redirect=30 -qO- https://github.com/valheimPlus/ValheimPlus/releases/download/"${VALHEIM_PLUS_VERSION}"/UnixServer.tar.gz | tar xvzf - -C "${STEAMAPPDIR}"
		chmod +x "${STEAMAPPDIR}/start_server_bepinex.sh"
	fi
fi

cd "${STEAMAPPDIR}"

if [ ! -z "$VALHEIM_PLUS_VERSION" ]; then
	# This is missing a couple of parameters, because the start_server_bepinex.sh doesn't support them
	# Are we in a valheim plus container?
	bash "start_server_bepinex.sh" -name "${SERVER_NAME}" \
						-password "${SERVER_PW}" \
						-port "${SERVER_PORT}" \
						-world "${SERVER_WORLD_NAME}" \
						-public "${SERVER_PUBLIC}"
else
	"./valheim_server.x86_64" -batchmode \
					-nographics \
					-screen-width "${SCREEN_WIDTH}" \
					-screen-height "${SCREEN_HEIGHT}" \
					-screen-quality "${SCREEN_QUALITY}" \
					-logFile "${SERVER_LOG_PATH}" \
					-port "${SERVER_PORT}" \
					-name "${SERVER_NAME}" \
					-world "${SERVER_WORLD_NAME}" \
					-password "${SERVER_PW}" \
					-public "${SERVER_PUBLIC}" \
					-savedir "${SERVER_SAVE_DIR}" \
					{{ADDITIONAL_ARGS}}
fi
