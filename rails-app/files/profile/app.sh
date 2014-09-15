export RAILS_ENV=production
export SERVER_HOSTNAME={{grains['id']}}
export ALERT_REPICIPIENTS="{{pillar['mail_alert']['users'] | join(', ')}}"
