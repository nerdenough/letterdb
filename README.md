# LetterDB

## Introduction
This repository contains all the source code for my implementation of the
SWEN303 individual project. Based on the Colenso Project, I have named my
implementation "LetterDB" as the site is primarily about storing, accessing
and contributing to letters.

## Startup
The server can be started by running `npm start`. This will start the server
using `nodemon` with the config specified in `config.coffee`.

*Note that running the server requires the `nodemon` and `coffee-script`
npm packages to be installed globally.*

## Prerequisites
Stylesheets must be compiled using `gulp sass` before starting the server. If
this command is not run, the styling for the site will break.

A database for LetterDB must exist (recommended to name it `letterdb`) with data
from the Colenso Project.

The BaseX HTTP server must be running as the
[node-basex](https://www.npmjs.com/package/node-basex) package requires it to
access BaseX's REST API. Configuration for the database should be specified in
`config.coffee` along with the database name.

## Disclaimer
All images used in this project are licensed under the [Creative Commons
0](https://creativecommons.org/publicdomain/zero/1.0/) license.
