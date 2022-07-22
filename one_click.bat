@echo off
adb tcpip 5555
for /F "tokens=*" %%A in (DeviceIP.txt) do (
	adb connect %%A
	adb -s %%A install -r "PokemodAtlas-Public-v22071801.apk"
	adb -s %%A install -r "com.nianticlabs.pokemongo_0.243.0-2022070701_minAPI24(arm64-v8a)(nodpi)_apkmirror.com.apk"
	adb -s %%A push atlas_config.json /data/local/tmp/atlas_config.json
	adb -s %%A push emagisk.config /data/local/tmp/emagisk.config
	if exist authorized_keys (
		adb -s %%A push authorized_keys /sdcard/authorized_keys
	)
	if exist 45extra (
		adb -s %%A push 45extra.sh /sdcard/45extra.sh
		adb -s %%A shell mv /sdcard/45extra.sh /etc/init.d/45extra
	)
	adb -s %%A shell "/system/bin/curl -s -k -L https://raw.githubusercontent.com/Astu04/AtlasScripts/main/first_install.sh | su -c sh"
)
pause
