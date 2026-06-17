#!/usr/bin/env bash
# shellcheck disable=SC1091,2154

set -e

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  cp -rp src/insider/* vscode/
else
  cp -rp src/stable/* vscode/
fi

cp -f LICENSE vscode/LICENSE.txt

cd vscode || { echo "'vscode' dir not found"; exit 1; }

# rm -rf extensions/copilot

{ set +x; } 2>/dev/null

# {{{ product.json
cp product.json{,.bak}

setpath() {
  local jsonTmp
  { set +x; } 2>/dev/null
  jsonTmp=$( jq --arg 'value' "${3}" "setpath(path(.${2}); \$value)" "${1}.json" )
  echo "${jsonTmp}" > "${1}.json"
  set -x
}

setpath_json() {
  local jsonTmp
  { set +x; } 2>/dev/null
  jsonTmp=$( jq --argjson 'value' "${3}" "setpath(path(.${2}); \$value)" "${1}.json" )
  echo "${jsonTmp}" > "${1}.json"
  set -x
}

setpath "product" "checksumFailMoreInfoUrl" "https://go.microsoft.com/fwlink/?LinkId=828886"
setpath "product" "documentationUrl" "https://go.microsoft.com/fwlink/?LinkID=533484#vscode"
setpath_json "product" "extensionsGallery" '{"serviceUrl": "https://open-vsx.org/vscode/gallery", "itemUrl": "https://open-vsx.org/vscode/item", "latestUrlTemplate": "https://open-vsx.org/vscode/gallery/{publisher}/{name}/latest", "controlUrl": "https://raw.githubusercontent.com/EclipseFdn/publish-extensions/refs/heads/master/extension-control/extensions.json"}'

setpath "product" "introductoryVideosUrl" "https://go.microsoft.com/fwlink/?linkid=832146"
setpath "product" "keyboardShortcutsUrlLinux" "https://go.microsoft.com/fwlink/?linkid=832144"
setpath "product" "keyboardShortcutsUrlMac" "https://go.microsoft.com/fwlink/?linkid=832143"
setpath "product" "keyboardShortcutsUrlWin" "https://go.microsoft.com/fwlink/?linkid=832145"
setpath "product" "licenseUrl" "https://github.com/VSCodium/vscodium/blob/master/LICENSE"
setpath_json "product" "linkProtectionTrustedDomains" '["https://open-vsx.org"]'
setpath "product" "releaseNotesUrl" "https://go.microsoft.com/fwlink/?LinkID=533483#vscode"
setpath "product" "reportIssueUrl" "https://github.com/VSCodium/vscodium/issues/new"
setpath "product" "requestFeatureUrl" "https://go.microsoft.com/fwlink/?LinkID=533482"
setpath "product" "tipsAndTricksUrl" "https://go.microsoft.com/fwlink/?linkid=852118"
setpath "product" "twitterUrl" "https://go.microsoft.com/fwlink/?LinkID=533687"

if [[ "${DISABLE_UPDATE}" != "yes" ]]; then
  setpath "product" "updateUrl" "https://raw.githubusercontent.com/VSCodium/versions/refs/heads/master"

  if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
    setpath "product" "downloadUrl" "https://github.com/VSCodium/vscodium-insiders/releases"
  else
    setpath "product" "downloadUrl" "https://github.com/VSCodium/vscodium/releases"
  fi

  # if [[ "${OS_NAME}" == "windows" ]]; then
  #   setpath_json "product" "win32VersionedUpdate" "true"
  # fi
fi

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  setpath "product" "nameShort" "RasterAndonConfigurator - Insiders"
  setpath "product" "nameLong" "RasterAndonConfigurator - Insiders"
  setpath "product" "applicationName" "rasterandonconfigurator-insiders"
  setpath "product" "dataFolderName" ".rasterandonconfigurator-insiders"
  setpath "product" "linuxIconName" "rasterandonconfigurator-insiders"
  setpath "product" "quality" "insider"
  setpath "product" "urlProtocol" "rasterandonconfigurator-insiders"
  setpath "product" "serverApplicationName" "rasterandonconfigurator-server-insiders"
  setpath "product" "serverDataFolderName" ".rasterandonconfigurator-server-insiders"
  setpath "product" "darwinBundleIdentifier" "com.rasterandonconfigurator.RasterAndonConfiguratorInsiders"
  setpath "product" "win32AppUserModelId" "RasterAndonConfigurator.RasterAndonConfiguratorInsiders"
  setpath "product" "win32DirName" "RasterAndonConfigurator Insiders"
  setpath "product" "win32MutexName" "rasterandonconfiguratorinsiders"
  setpath "product" "win32NameVersion" "RasterAndonConfigurator Insiders"
  setpath "product" "win32RegValueName" "RasterAndonConfiguratorInsiders"
  setpath "product" "win32ShellNameShort" "RasterAndonConfigurator Insiders"
  setpath "product" "win32AppId" "{{D9963823-AD1F-45C1-8395-C6CE5F040FDB}"
  setpath "product" "win32x64AppId" "{{ACC6B920-C621-4607-8D0B-1AA067EC15B8}"
  setpath "product" "win32arm64AppId" "{{BED11FD7-0F3F-42B7-B607-BC4C50B9D1CB}"
  setpath "product" "win32UserAppId" "{{C4EDD06C-7E37-42DF-8785-23F64F10ACF0}"
  setpath "product" "win32x64UserAppId" "{{036417C0-486B-4CEA-8934-9C51182F88B5}"
  setpath "product" "win32arm64UserAppId" "{{8CCAA1F0-A16C-4D2A-B2FD-C61E85792439}"
  setpath "product" "tunnelApplicationName" "rasterandonconfigurator-insiders-tunnel"
  setpath "product" "win32TunnelServiceMutex" "rasterandonconfiguratorinsiders-tunnelservice"
  setpath "product" "win32TunnelMutex" "rasterandonconfiguratorinsiders-tunnel"
  setpath "product" "win32ContextMenu.x64.clsid" "08C3ACD8-34E9-419A-A259-EDF3B90310F3"
  setpath "product" "win32ContextMenu.arm64.clsid" "B15020C7-9019-48CE-B40B-669F02CD9685"
else
  setpath "product" "nameShort" "RasterAndonConfigurator"
  setpath "product" "nameLong" "RasterAndonConfigurator"
  setpath "product" "applicationName" "rasterandonconfigurator"
  setpath "product" "dataFolderName" ".rasterandonconfigurator"
  setpath "product" "linuxIconName" "rasterandonconfigurator"
  setpath "product" "quality" "stable"
  setpath "product" "urlProtocol" "rasterandonconfigurator"
  setpath "product" "serverApplicationName" "rasterandonconfigurator-server"
  setpath "product" "serverDataFolderName" ".rasterandonconfigurator-server"
  setpath "product" "darwinBundleIdentifier" "com.rasterandonconfigurator"
  setpath "product" "win32AppUserModelId" "RasterAndonConfigurator.RasterAndonConfigurator"
  setpath "product" "win32DirName" "RasterAndonConfigurator"
  setpath "product" "win32MutexName" "rasterandonconfigurator"
  setpath "product" "win32NameVersion" "RasterAndonConfigurator"
  setpath "product" "win32RegValueName" "RasterAndonConfigurator"
  setpath "product" "win32ShellNameShort" "RasterAndonConfigurator"
  setpath "product" "win32AppId" "{{54385D9A-9ECE-4F60-A20A-C38A92B11281}"
  setpath "product" "win32x64AppId" "{{5201E380-29C6-484A-A143-A71F5B910F09}"
  setpath "product" "win32arm64AppId" "{{047326A4-63E3-4582-BC60-7575D071E978}"
  setpath "product" "win32UserAppId" "{{6728B226-8402-49EC-8252-10D9B9023C73}"
  setpath "product" "win32x64UserAppId" "{{2BC2C6D0-C1CD-4872-B056-B9BB28582FB3}"
  setpath "product" "win32arm64UserAppId" "{{C4E9C4A3-C157-4FB2-BB73-E6297B88F958}"
  setpath "product" "tunnelApplicationName" "rasterandonconfigurator-tunnel"
  setpath "product" "win32TunnelServiceMutex" "rasterandonconfigurator-tunnelservice"
  setpath "product" "win32TunnelMutex" "rasterandonconfigurator-tunnel"
  setpath "product" "win32ContextMenu.x64.clsid" "82A8E46E-D8D8-4E4A-8049-188C0EB756A2"
  setpath "product" "win32ContextMenu.arm64.clsid" "593D48D1-E424-4F2D-A450-5FA884878C47"
fi

setpath_json "product" "tunnelApplicationConfig" '{}'

jsonTmp=$( jq -s '.[0] * .[1]' product.json ../product.json )
echo "${jsonTmp}" > product.json && unset jsonTmp

cat product.json
# }}}

# include common functions
. ../utils.sh

# {{{ apply patches

echo "APP_NAME=\"${APP_NAME}\""
echo "APP_NAME_LC=\"${APP_NAME_LC}\""
echo "ASSETS_REPOSITORY=\"${ASSETS_REPOSITORY}\""
echo "BINARY_NAME=\"${BINARY_NAME}\""
echo "GH_REPO_PATH=\"${GH_REPO_PATH}\""
echo "GLOBAL_DIRNAME=\"${GLOBAL_DIRNAME}\""
echo "ORG_NAME=\"${ORG_NAME}\""
echo "TUNNEL_APP_NAME=\"${TUNNEL_APP_NAME}\""

if [[ "${DISABLE_UPDATE}" == "yes" ]]; then
  mv ../patches/00-update-disable.patch.yet ../patches/00-update-disable.patch
fi

for file in ../patches/*.json; do
  if [[ -f "${file}" ]]; then
    apply_actions "${file}"
  fi
done

for file in ../patches/*.patch; do
  if [[ -f "${file}" ]]; then
    apply_patch "${file}"
  fi
done

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  for file in ../patches/insider/*.patch; do
    if [[ -f "${file}" ]]; then
      apply_patch "${file}"
    fi
  done
fi

if [[ -d "../patches/${OS_NAME}/" ]]; then
  for file in "../patches/${OS_NAME}/"*.patch; do
    if [[ -f "${file}" ]]; then
      apply_patch "${file}"
    fi
  done
fi

for file in ../patches/user/*.patch; do
  if [[ -f "${file}" ]]; then
    apply_patch "${file}"
  fi
done
# }}}

set -x

# {{{ install dependencies
export ELECTRON_SKIP_BINARY_DOWNLOAD=1
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1

if [[ "${OS_NAME}" == "linux" ]]; then
  export VSCODE_SKIP_NODE_VERSION_CHECK=1

   if [[ "${npm_config_arch}" == "arm" ]]; then
    export npm_config_arm_version=7
  fi
elif [[ "${OS_NAME}" == "windows" ]]; then
  if [[ "${npm_config_arch}" == "arm" ]]; then
    export npm_config_arm_version=7
  fi
else
  if [[ "${CI_BUILD}" != "no" ]]; then
    clang++ --version
  fi
fi

node build/npm/preinstall.ts

if [[ "${OS_NAME}" == "windows" ]]; then
  node <<'NODE'
const fs = require('fs');
const path = require('path');

function replace(file, search, replacement) {
  let contents = fs.readFileSync(file, 'utf8');
  if (!contents.includes(search)) {
    if (!contents.includes(replacement)) {
      throw new Error(`Expected text not found in ${file}`);
    }
    return;
  }
  contents = contents.replace(search, replacement);
  fs.writeFileSync(file, contents);
}

const gypRoot = path.join('build', 'npm', 'gyp', 'node_modules', 'node-gyp');

replace(
  path.join(gypRoot, 'lib', 'find-visualstudio.js'),
  `    } else if (versionYear === 2022) {
      return 'v143'
    }`,
  `    } else if (versionYear === 2022 && process.env.VCToolsVersion?.startsWith('14.50.')) {
      return 'v145'
    } else if (versionYear === 2022) {
      return 'v143'
    }`
);

replace(
  path.join(gypRoot, 'gyp', 'pylib', 'gyp', 'generator', 'msvs.py'),
  `        spectre_mitigation = msbuild_attributes.get('SpectreMitigation')
        if spectre_mitigation:
            _AddConditionalProperty(properties, condition, "SpectreMitigation",
                                    spectre_mitigation)
`,
  `        # This local Windows build uses VS 2026 v145 without the optional
        # Spectre-mitigated MSVC libraries installed.
`
);
NODE

  export npm_config_node_gyp="${PWD}/build/npm/gyp/node_modules/.bin/node-gyp.cmd"
fi

mv .npmrc .npmrc.bak
cp ../npmrc .npmrc

for i in {1..5}; do # try 5 times
  if [[ "${CI_BUILD}" != "no" && "${OS_NAME}" == "osx" ]]; then
    CXX=clang++ npm ci && break
  else
    npm ci && break
  fi

  if [[ $i == 5 ]]; then
    echo "Npm install failed too many times" >&2
    exit 1
  fi
  echo "Npm install failed $i, trying again..."

  sleep $(( 15 * (i + 1)))
done

mv .npmrc.bak .npmrc
# }}}

# package.json
cp package.json{,.bak}

setpath "package" "version" "${RELEASE_VERSION%-insider}"

replace 's|Microsoft Corporation|VSCodium|' package.json

cp resources/server/manifest.json{,.bak}

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  setpath "resources/server/manifest" "name" "RasterAndonConfigurator - Insiders"
  setpath "resources/server/manifest" "short_name" "RasterAndonConfigurator - Insiders"
else
  setpath "resources/server/manifest" "name" "RasterAndonConfigurator"
  setpath "resources/server/manifest" "short_name" "RasterAndonConfigurator"
fi

# announcements
replace "s|\\[\\/\\* BUILTIN_ANNOUNCEMENTS \\*\\/\\]|$( tr -d '\n' < ../announcements-builtin.json )|" src/vs/workbench/contrib/welcomeGettingStarted/browser/gettingStarted.ts

../undo_telemetry.sh

replace 's|Microsoft Corporation|VSCodium|' build/lib/electron.ts
replace 's|([0-9]) Microsoft|\1 VSCodium|' build/lib/electron.ts

if [[ "${OS_NAME}" == "linux" ]]; then
  # microsoft adds their apt repo to sources
  # unless the app name is code-oss
  # as we are renaming the application to vscodium
  # we need to edit a line in the post install template
  if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
    sed -i "s/code-oss/codium-insiders/" resources/linux/debian/postinst.template
  else
    sed -i "s/code-oss/codium/" resources/linux/debian/postinst.template
  fi

  # fix the packages metadata
  # code.appdata.xml
  sed -i 's|Visual Studio Code|VSCodium|g' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/VSCodium/vscodium#download-install|' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com/home/home-screenshot-linux-lg.png|https://vscodium.com/img/vscodium.png|' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com|https://vscodium.com|' resources/linux/code.appdata.xml

  # control.template
  sed -i 's|Microsoft Corporation <vscode-linux@microsoft.com>|VSCodium Team https://github.com/VSCodium/vscodium/graphs/contributors|'  resources/linux/debian/control.template
  sed -i 's|Visual Studio Code|VSCodium|g' resources/linux/debian/control.template
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/VSCodium/vscodium#download-install|' resources/linux/debian/control.template
  sed -i 's|https://code.visualstudio.com|https://vscodium.com|' resources/linux/debian/control.template

  # code.spec.template
  sed -i 's|Microsoft Corporation|VSCodium Team|' resources/linux/rpm/code.spec.template
  sed -i 's|Visual Studio Code Team <vscode-linux@microsoft.com>|VSCodium Team https://github.com/VSCodium/vscodium/graphs/contributors|' resources/linux/rpm/code.spec.template
  sed -i 's|Visual Studio Code|VSCodium|' resources/linux/rpm/code.spec.template
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/VSCodium/vscodium#download-install|' resources/linux/rpm/code.spec.template
  sed -i 's|https://code.visualstudio.com|https://vscodium.com|' resources/linux/rpm/code.spec.template

  # snapcraft.yaml
  sed -i 's|Visual Studio Code|VSCodium|' resources/linux/rpm/code.spec.template
elif [[ "${OS_NAME}" == "windows" ]]; then
  # code.iss
  sed -i 's|https://code.visualstudio.com|https://vscodium.com|' build/win32/code.iss
  sed -i 's|Microsoft Corporation|RasterAndonConfigurator|' build/win32/code.iss
fi

cd ..
