#!/bin/sh

set -e

if [ -z "$RAILWAY_VOLUME_MOUNT_PATH" ]; then
    echo no volume attached, please attach a volume.
    echo upon attaching a volume let this service rebuild
    exit 0
fi

if [ -z "$WEB_USERNAME" ]; then
    echo missing the WEB_USERNAME variable, please add it to continue
    exit 0
fi

if [ -z "$WEB_PASSWORD" ]; then
    echo missing the WEB_PASSWORD variable, please add it to continue
    exit 0
fi

if [ -f "/.filebrowser.json" ]; then
  rm /.filebrowser.json
fi

FILEBROWSER_DATA_PATH=$RAILWAY_VOLUME_MOUNT_PATH/appdata/filebrowser

DATABASE_PATH=$FILEBROWSER_DATA_PATH/filebrowser.db

FILEBROWSER_USERNAME_PATH=$FILEBROWSER_DATA_PATH/username
rm -f $DATABASE_PATH
rm -f $FILEBROWSER_USERNAME_PATH

# if [ "$USE_VOLUME_ROOT" == "1" ]; then
#     echo using volume root as storage location
#     FILEBROWSER_STORAGE_PATH=$RAILWAY_VOLUME_MOUNT_PATH
# else
#     FILEBROWSER_STORAGE_PATH=$RAILWAY_VOLUME_MOUNT_PATH/storage
#     if [ ! -d $FILEBROWSER_STORAGE_PATH ]; then
#         mkdir $FILEBROWSER_STORAGE_PATH
#     fi
# fi

# if [ -f "$DATABASE_PATH" ]; then
#     if [ -f "$FILEBROWSER_USERNAME_PATH" ]; then
#         FILEBROWSER_CURRENT_USERNAME=$(cat $FILEBROWSER_USERNAME_PATH)

#         if [[ -n "$FILEBROWSER_CURRENT_USERNAME" && "$FILEBROWSER_CURRENT_USERNAME" != "$WEB_USERNAME" ]]; then
#             echo new username was set in the service variables, changing username: $FILEBROWSER_CURRENT_USERNAME "->" $WEB_USERNAME
#             /filebrowser users update $FILEBROWSER_CURRENT_USERNAME --username $WEB_USERNAME --database $DATABASE_PATH > /dev/null
#             echo $WEB_USERNAME >| $FILEBROWSER_USERNAME_PATH
#             echo username updated
#         fi
#     fi
# else
#     echo first start, creating database
#     /filebrowser config init --database $DATABASE_PATH > /dev/null

#     echo setting configurations
#     /filebrowser config set --address "0.0.0.0" --database $DATABASE_PATH > /dev/null

#     /filebrowser users add $WEB_USERNAME $WEB_PASSWORD --database $DATABASE_PATH > /dev/null
# fi

# echo $DATABASE_PATH
# echo $WEB_USERNAME > $FILEBROWSER_USERNAME_PATH

# /filebrowser users update $WEB_USERNAME --password $WEB_PASSWORD --database $DATABASE_PATH > /dev/null

# /filebrowser config set --port $PORT --database $DATABASE_PATH > /dev/null
# /filebrowser config set --root $FILEBROWSER_STORAGE_PATH --database $DATABASE_PATH > /dev/null
# /filebrowser config set --commands zip,unzip,ls,bash --database $DATABASE_PATH > /dev/null
# /filebrowser config set --shell 'bash -c' --database $DATABASE_PATH > /dev/null

# /filebrowser version

# /filebrowser --database $DATABASE_PATH 2>&1