if (!process.env.NGROK_AUTH) {
  console.error('NGROK_AUTH environment variable is missing');
  console.error('  go to https://ngrok.com/ to get a key');
  process.exit(1);
}

module.exports = {
  queue: { port: 8314 },
  provisioner: { port: 3000 },
  rabbitmq: {
    port: 5672, proto: 'tcp', authtoken: process.env.NGROK_AUTH
  }
};
