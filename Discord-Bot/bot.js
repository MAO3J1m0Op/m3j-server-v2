'use strict';

const discord = require('discord.js');
const auth = require('./auth.json');
const fs = require('fs');
const path = require('path');

const client = new discord.Client();

let cache = ""
let message = null
var ipChannel

client.login(auth.token);

client.on('ready', function() {
    ipChannel = client.channels.cache.get(auth.ip_channel);
    console.log('The bot is now active!');
    checkForStatusUpdate();
});

function onStatusUpdate(newStatus) {
    let text = '```\n' + newStatus + '\n```'
    if (message === null) {
        console.log('Could not find previous message. Sending new one.');
        ipChannel.send(text).then(msg => { message = msg; })
    } else message.edit(text);
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
