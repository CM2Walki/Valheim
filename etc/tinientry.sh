#!/bin/bash
# Replace {{ADDITIONAL_ARGS}} in entry.sh; Since passing nested bash variables to binary is cancer
sed -i -e 's#{{ADDITIONAL_ARGS}}#'"${ADDITIONAL_ARGS}"'#g' "${HOMEDIR}/entry.sh"
bash "${HOMEDIR}/entry.sh"
