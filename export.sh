#!/bin/bash

mongoexport --db prod --collection games --out games.json
mongoexport --db prod --collection rounds --out rounds.json
mongoexport --db prod --collection users --out users.json
mongoexport --db prod --collection packs --out packs.json
