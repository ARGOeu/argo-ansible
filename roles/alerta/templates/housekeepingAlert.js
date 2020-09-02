// housekeepingAlerts.js
//
 now = new Date();
//
// // mark timed out alerts as EXPIRED and update alert history
 db.alerts.aggregate([
     { $project: { event: 1, status: 1, lastReceiveId: 1, timeout: 1, expireTime: { $add: [ "$lastReceiveTime", { $multiply: [ "$timeout", 1000 ]} ]} } },
         { $match: { status: { $ne: 'expired' }, expireTime: { $lt: now }, timeout: { $ne: 0 }}}
         ]).forEach( function(alert) {
          db.alerts.update(
            { _id: alert._id },
                   {
                         $set: { status: 'expired' },
                         $push: {
                           history: {
                                       event: alert.event,
                                       status: 'expired',
                                       text: "alert timeout status change",
                                       id: alert.lastReceiveId,
                                       updateTime: now
                          }
                        }
          }, false, true);
  })

db.alerts.remove({'status':'expired'});
