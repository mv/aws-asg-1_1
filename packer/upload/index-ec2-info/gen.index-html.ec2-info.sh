#!/bin/bash

set -e


##
## EC2 info
##
_ec2_metadata="http://169.254.169.254"

## MacOS: use Mock
[[ $(uname -s) == "Darwin" ]] && _ec2_metadata="http://localhost:1338"

## Docker:testing
[[ ${DOCKER} == "true" ]] && _ec2_metadata="http://localhost:1338"
[[ -f /.dockerenv      ]] && _ec2_metadata="http://localhost:1338"

_token=$(      curl -s -X PUT "${_ec2_metadata}/latest/api/token" -H "X-aws-ec2-metadata-token-ttl-seconds: 21600")

  _instance_id=$(curl -sH "X-aws-ec2-metadata-token: ${_token}" ${_ec2_metadata}/latest/meta-data/instance-id)
_instance_type=$(curl -sH "X-aws-ec2-metadata-token: ${_token}" ${_ec2_metadata}/latest/meta-data/instance-type)
_local_ip=$(     curl -sH "X-aws-ec2-metadata-token: ${_token}" ${_ec2_metadata}/latest/meta-data/local-ipv4)
_az=$(           curl -sH "X-aws-ec2-metadata-token: ${_token}" ${_ec2_metadata}/latest/meta-data/placement/availability-zone)


##
## Host info
##
_hostname=$(hostname)
_generated=$(date -u '+%FT%X.000Z')


# BOOT_TIME=$(who -b)
if [[ $(uname -s) == "Darwin" ]]
then _boot_epoch=$( gdate -d "$(gwho -b | awk '{print $3,$4}')" +%s )  # Mac/brew
else _boot_epoch=$(  date -d "$( who -b | awk '{print $3,$4}')" +%s )  # Linux
fi

##
## Page
##
_color=$(printf "#%06x" $((RANDOM*RANDOM)))

# cat <<EOF > /var/www/html/index.html
#     color: #e2e8f0;
#     background: #0f172a;
cat <<EOF > index.html
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>EC2 Instance Info</title>
  <style>
    body {
      font-family: system-ui, -apple-system, Arial;
      background: ${_color};
      color: #e2e8f0;
      display: flex;
      justify-content: center;  /* align center horizontal */
#     align-items: center;      /* align center vertical */
      align-items: flex-start;  /* align on top */
      padding-top: 40px;
      height: 100vh;
      margin: 0;
    }
    .card {
      background: #1e293b;
      padding: 2rem;
      border-radius: 12px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.4);
      width: 420px;
    }
    h1 {
      margin-top: 0;
      font-size: 1.5rem;
      color: #38bdf8;
    }
    .row {
      margin: 0.5rem 0;
      display: flex;
      justify-content: space-between;
#     font-size: 0.95rem;
      font-size: 0.80rem;
    }
    .label {
      color: #94a3b8;
    }
    .value {
      font-family: monospace;
    }
  </style>
</head>
<body>
  <div class="card">
    <h1>EC2 Instance</h1>
    <div class="row"><span class="label">Instance ID</span><span class="value">${_instance_id}</span></div>
    <div class="row"><span class="label">Instance type</span><span class="value">${_instance_type}</span></div>
    <div class="row"><span class="label">Hostname</span><span class="value">${_hostname}</span></div>
    <div class="row"><span class="label">Local IP</span><span class="value">${_local_ip}</span></div>
    <div class="row"><span class="label">AZ</span><span class="value">${_az}</span></div>
    <div class="row"><span class="label">Page Generated</span><span class="value">${_generated}</span></div>
    <div class="row"><span class="label">Boot Time</span><span class="value" id="bootTime"></span></div>
    <div class="row"><span class="label">Uptime</span><span class="value" id="uptime"></span></div>
  </div>

  <script>
    // Injected from server at boot
    const BOOT_EPOCH = ${_boot_epoch};

    function formatDuration(seconds) {
      const _days = String( Math.floor(seconds / 86400) ).padStart(2,'0'); seconds %= 86400;
      const _hour = String( Math.floor(seconds / 3600 ) ).padStart(2,'0'); seconds %=  3600;
      const _min  = String( Math.floor(seconds / 60   ) ).padStart(2,'0');
      const _sec  = String( Math.floor(seconds % 60   ) ).padStart(2,'0');

      return \`\${_days}d \${_hour}h \${_min}m \${_sec}s\`;
    }

    function update() {
      const now = Math.floor(Date.now() / 1000);
      const uptime = now - BOOT_EPOCH;

      document.getElementById("uptime").textContent = formatDuration(uptime);

      const bootDate = new Date(BOOT_EPOCH * 1000);
      document.getElementById("bootTime").textContent = bootDate.toISOString();
    }

    update();
    setInterval(update, 1000);
  </script>

</body>
</html>

EOF
