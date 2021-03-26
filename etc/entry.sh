#!/bin/bash
mkdir -p "${STEAMAPPDIR}" || true

# Override SteamCMD launch arguments if necessary
# Used for subscribing to betas or for testing
if [ -z "$STEAMCMD_UPDATE_ARGS" ]; then
	bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "$STEAMAPPDIR" +app_update "$STEAMAPPID" +quit
else
	steamcmd_update_args=($STEAMCMD_UPDATE_ARGS)
	bash "${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "$STEAMAPPDIR" +app_update "$STEAMAPPID" "${steamcmd_update_args[@]}" +quit
fi

cd "${STEAMAPPDIR}"

"./valheim_server.x86_64" -batchmode \
				-nographics \
				-screen-width "${SCREEN_WIDTH}" \
				-screen-height "${SCREEN_HEIGHT}" \
				-screen-quality "${SCREEN_QUALITY}" \
				-logFile "${SERVER_LOG_PATH}" \
				-port "${SERVER_PORT}" \
				-name "${SERVER_WORLD_NAME}" \
				-password "${SERVER_PW}" \
				-public "${SERVER_PUBLIC}" \
				-savedir "${SERVER_SAVE_DIR}" \
				{{ADDITIONAL_ARGS}}
