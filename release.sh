#!/usr/bin/env bash
set -e

while getopts v: flag
do
    case "${flag}" in
        v) version=${OPTARG};;
    esac
done

echo $version

./build.sh -c ./config/prod.json

rm -rf ./package
mkdir -p package

echo "{
  \"name\": \"@maplelabs/late-fee-calculator\",
  \"version\": \"${version}\",
  \"description\": \"Late Fee Calculator Artifacts and ABIs\",
  \"author\": \"Maple Labs\",
  \"license\": \"AGPLv3\",
  \"repository\": {
    \"type\": \"git\",
    \"url\": \"https://github.com/maple-labs/late-fee-calculator.git\"
  },
  \"bugs\": {
    \"url\": \"https://github.com/maple-labs/late-fee-calculator/issues\"
  },
  \"homepage\": \"https://github.com/maple-labs/late-fee-calculator\"
}" > package/package.json

mkdir -p package/artifacts
mkdir -p package/abis

cat ./out/dapp.sol.json | jq '.contracts | ."contracts/LateFeeCalc.sol" | .LateFeeCalc' > package/artifacts/LateFeeCalc.json
cat ./out/dapp.sol.json | jq '.contracts | ."contracts/LateFeeCalc.sol" | .LateFeeCalc | .abi' > package/abis/LateFeeCalc.json

npm publish ./package --access public

rm -rf ./package
