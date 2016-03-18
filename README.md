# GGUniqueDeviceIdentifier
iOS设备ID，在单台设备上唯一

## 第一台机器
* 首次安装
	* uniqueDeviceIdentifier = a180bd4c-8f42-4d65-9540-e9a060bb35cb
* 卸载后重装
	* uniqueDeviceIdentifier = a180bd4c-8f42-4d65-9540-e9a060bb35cb
* 抹掉设备后，设置为新设备
	* uniqueDeviceIdentifier = 8c43cf72-bb01-481c-a3ed-06ec1fda550d
* 备份该设备，抹掉设备后再从备份中恢复
	* uniqueDeviceIdentifier = 8c43cf72-bb01-481c-a3ed-06ec1fda550d

## 第二台设备
* 首次安装
	* uniqueDeviceIdentifier = 09ddef07-bba8-4995-9271-5642a5c35530
* 抹掉设备后，从**《第一台设备》**的备份中恢复
	* uniqueDeviceIdentifier = 960784dd-2b20-468b-af95-c41f71ad0f40
* 抹掉设备后，使用跟**《第一台设备》**相同的iCloud账号登录，并设置为同步keychain
	* uniqueDeviceIdentifier = fa5ba418-f3c6-4e70-a35a-796424ec1c21