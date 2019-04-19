# MONGO LOG ROTATE SCRIPT
#
# This script is meant to run daily with cron
# Old log is compressed in tar.gz format
# Remove archived files older than a week

TODAY=`date +%Y-%m-%d`
# Change to mongodb log folder
cd /var/log/mongodb/

# Execute a database admin command by using eval in mongo client
echo "rotate mongodb log (var/log/mongodb/mongod.log)"
mongo admin --eval "db.adminCommand( { logRotate : 1 } )"

# Construct file patterns for today's logs, tar and gzipped tar
TODAYLOGS="mongod.log.${TODAY}T*"
TARFILE="mongod.log.$TODAY.tar"
GZTAR="mongod.log.$TODAY.tar.gz"

# If tar is present add log file to tar
# If tar not present create it
echo "archiving today's rotated logs"
if [ -f "$GZTAR" ]
then
	echo "adding to ${GZTAR}"
	gunzip $GZTAR
	tar -uvf $TARFILE $TODAYLOGS
	gzip $TARFILE
else
	echo "creating ${GZTAR}"
	tar -czvf $GZTAR $TODAYLOGS
fi

# remove if any todays rotated logs
rm -f $TODAYLOGS

# remove older than a month archives
echo "Removing archives older than a month, if any"
find /var/log/mongodb/*.gz -mtime +31 -type f -delete