#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
: "${PROJECT_ID:?}" "${LOCATION:?}" "${INSTANCE:?}"
REMOTE_DIR=${REMOTE_DIR:-tdt4173-repo}
[[ "$REMOTE_DIR" =~ ^[a-zA-Z0-9_-]+$ ]] || { echo 'REMOTE_DIR must be a simple folder name.' >&2; exit 1; }
flags=(--project="$PROJECT_ID" --zone="$LOCATION")
state=$(gcloud compute instances describe "$INSTANCE" "${flags[@]}" --format='value(status)')
if [[ "$state" == TERMINATED ]]; then
    gcloud workbench instances start "$INSTANCE" --project="$PROJECT_ID" --location="$LOCATION" --format='value(state)'
fi
# Register the OS Login key and let gcloud establish the initial connection.
ready=false
for attempt in {1..12}; do
    if gcloud compute ssh "$INSTANCE" "${flags[@]}" --quiet --command=true --ssh-flag='-o ConnectTimeout=10'; then
        ready=true
        break
    fi
    sleep 5
done
[[ "$ready" == true ]] || { echo 'SSH is not ready. Check the VM status and SSH permissions.' >&2; exit 1; }
remote_user=$(gcloud compute os-login describe-profile --project="$PROJECT_ID" --format='value(posixAccounts[0].username)')
[[ "$remote_user" =~ ^[a-zA-Z0-9_-]+$ ]] || { echo 'Could not determine OS Login username.' >&2; exit 1; }
gcloud compute config-ssh --project="$PROJECT_ID" --quiet
host="$remote_user@$INSTANCE.$LOCATION.$PROJECT_ID"
remote_path="/home/$remote_user/$REMOTE_DIR"


ssh "$host" "test -d '$remote_path/.git'" || { echo "Git repo missing: $remote_path" >&2; exit 1; }
code --new-window --remote "ssh-remote+$host" "$remote_path"
