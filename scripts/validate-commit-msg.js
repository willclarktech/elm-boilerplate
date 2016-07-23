#!/usr/bin/env node
/* eslint-disable prefer-rest-params */

require('./pretty-error');
const fs = require('fs');
const util = require('util');

const MAX_LENGTH = 76;
const PATTERN = /^(?:fixup!\s*)?(?:(:\w*:)|(\w*)) ([\w\$\.\*/-]*): (.*)$/;
const IGNORED = /^WIP:/;
const TYPES = {
  feat: true,
  fix: true,
  docs: true,
  style: true,
  refactor: true,
  test: true,
  chore: true,
};
const EMOJIS = [
  ':seedling:',
  ':wrench:',
  ':books:',
  ':lipstick:',
  ':scissors:',
  ':vertical_traffic_light:',
  ':house_with_garden:',
];
const EMOJIMAP = [
  [/^feat/, EMOJIS[0]],
  [/^fix/, EMOJIS[1]],
  [/^docs/, EMOJIS[2]],
  [/^style/, EMOJIS[3]],
  [/^refactor/, EMOJIS[4]],
  [/^test/, EMOJIS[5]],
  [/^chore/, EMOJIS[6]],
];

const error = function invalidCommitMsgError() {
  throw new Error(`INVALID COMMIT MSG: ${util.format.apply(null, arguments)}`);
};

const validateMessage = function validateMessage(message) {
  if (IGNORED.test(message)) {
    console.info('Commit message validation ignored.');
    return true;
  }

  if (message.length > MAX_LENGTH) {
    error('is longer than %d characters !', MAX_LENGTH);
    return false;
  }

  const match = PATTERN.exec(message);

  if (! match) {
    error(`does not match "<type> <scope>: <subject>" ! was: ${message}`);
    return false;
  }

  const emoji = match[1];
  const type = match[2];
  // const scope = match[3];
  // const subject = match[4];

  if (! TYPES.hasOwnProperty(type) && EMOJIS.indexOf(emoji) === -1) {
    error('"%s" is not an allowed type!', type || emoji);
    return false;
  }

  return true;
};

const giveEmojiToMsg = function giveEmojiToMsg(msg) {
  for (const replacement of EMOJIMAP) {
    const r = replacement[0];
    if (r.test(msg)) {
      return {
        msg: msg.replace(r, replacement[1]),
        replaced: true,
      };
    }
  }
  return {
    msg,
    replaced: false,
  };
};

const firstLineFromBuffer = function firstLineFromBuffer(buffer) {
  return buffer.toString().split('\n').shift();
};

const commitMsgFile = '.git/COMMIT_EDITMSG';
const incorrectLogFile = commitMsgFile.replace('COMMIT_EDITMSG', 'logs/incorrect-commit-msgs');

fs.readFile(commitMsgFile, (err, buffer) => {
  const msg = firstLineFromBuffer(buffer);

  if (! validateMessage(msg)) {
    fs.appendFile(incorrectLogFile, `${msg}\n`, () => {
      process.exit(1);
    });
  } else {
    const emojified = giveEmojiToMsg(buffer.toString());
    if (emojified.replaced) fs.writeFileSync(commitMsgFile, emojified.msg);
    process.exit(0);
  }
});
