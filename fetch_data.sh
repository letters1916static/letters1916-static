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

uv run add-attributes -g "./data/editions/*.xml" -b "https://id.acdh.oeaw.ac.at/letters1916"
uv run denormalize-indices -f "./data/editions/*.xml" -i "./data/indices/*.xml" -m ".//*[@key]/@key" -x ".//tei:title[@type='main']/text()"