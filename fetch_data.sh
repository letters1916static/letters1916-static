#!/bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/
curl -LO https://github.com/letters1916static/letters1916-data/archive/refs/heads/main.zip
unzip main

mv ./letters1916-data-main/data/ .

rm main.zip
rm -rf ./letters1916-data-main

echo "fetch imprint"
./shellscripts/dl_imprint.sh
