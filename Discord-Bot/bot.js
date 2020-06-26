'use strict';

const discord = require('discord.js');
const auth = require('./auth.json');
const fs = require('fs');
const path = require('path');

const client = new discord.Client();

let cache = ""
var ipChannel

client.login(auth.token);

client.on('ready', function() {
    ipChannel = client.channels.cache.get(auth.ip_channel);
    console.log('The bot is now active!');
    checkForStatusUpdate();
});

function onStatusUpdate(newStatus) {
    ipChannel.send('```\n' + newStatus + '\n```');
}

async function checkForStatusUpdate() {
    while (true) {
        await new Promise((resolve) => {setTimeout(resolve, 10000);});
        let contents = fs.readFileSync(path.resolve('../SERVER_STATUS')).toString()
        if (contents != cache) {
            console.log("IP message has changed. Sending the following message to the server:");
            console.log(contents)
            cache = contents;
            onStatusUpdate(contents);
        }
    }
}
