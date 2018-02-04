module.exports = {
  apps : [{
    name   : "Todo List",
    script : "./server.js",
    watch: true,
    wait_ready: true,
    listen_timeout: 3000,
    watch_options : {"usePolling": true}
  }]
}
