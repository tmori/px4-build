# px4-build

PX4のシミュレータを単独で起動できる環境を docker でまとめています。

## 前提とする環境

* M1/M2 Mac & Docker Desktop
  * Macの場合は、dockerをRosettaで実行します
* Windows 10/11 WSL2
  * Windowsの場合は、WSL2上で実行します

## リポジトリをクローン

本リポジトリーをクローンします。

```
 git clone --recursive git@github.com:tmori/px4-build.git
```

## Mac版

### docker コンテナ起動方法


docker イメージを作成します。

```
bash docker/create-image.bash 
```

成功するとこうなります。

```
% docker images
REPOSITORY                            TAG       IMAGE ID       CREATED          SIZE
px4-build                             v1.0.0    65d500b2847b   51 minutes ago   1.11GB
```

イメージ作成時に、PX4のビルドは終わっています。

### docker コンテナ起動方法

docker コンテナを起動すると、ホストPCの 4560 ポートにTCP接続します。

```
bash docker/run.bash
```

成功すると、こうなります。

```
arm64
Darwin
[0/1] launching px4 none_iris (SYS_AUTOSTART=10016)

______  __   __    ___ 
| ___ \ \ \ / /   /   |
| |_/ /  \ V /   / /| |
|  __/   /   \  / /_| |
| |     / /^\ \ \___  |
\_|     \/   \/     |_/

px4 starting.

INFO  [px4] startup script: /bin/sh etc/init.d-posix/rcS 0
env SYS_AUTOSTART: 10016
INFO  [param] selected parameter default file parameters.bson
INFO  [param] selected parameter backup file parameters_backup.bson
  SYS_AUTOCONFIG: curr: 0 -> new: 1
  SYS_AUTOSTART: curr: 0 -> new: 10016
  CAL_ACC0_ID: curr: 0 -> new: 1310988
  CAL_GYRO0_ID: curr: 0 -> new: 1310988
  CAL_ACC1_ID: curr: 0 -> new: 1310996
  CAL_GYRO1_ID: curr: 0 -> new: 1310996
  CAL_ACC2_ID: curr: 0 -> new: 1311004
  CAL_GYRO2_ID: curr: 0 -> new: 1311004
  CAL_MAG0_ID: curr: 0 -> new: 197388
  CAL_MAG0_PRIO: curr: -1 -> new: 50
  CAL_MAG1_ID: curr: 0 -> new: 197644
  CAL_MAG1_PRIO: curr: -1 -> new: 50
* SENS_BOARD_X_OFF: curr: 0.0000 -> new: 0.0000
* SENS_DPRES_OFF: curr: 0.0000 -> new: 0.0010
INFO  [dataman] data manager file './dataman' size is 7866640 bytes
etc/init.d-posix/rcS: 39: [: Illegal number: 
INFO  [init] PX4_SIM_HOSTNAME: 192.168.65.254
INFO  [simulator_mavlink] using TCP on remote host 192.168.65.254 port 4560
```

この状態で、シミュレータを立ち上げれば動き始めます。

## Windows版

### PX4のビルド方法

```
cd PX4-Autopilot
```

ubuntu向けのセットアップをします。

```
./Tools/setup/ubuntu.sh --no-nuttx --no-sim-tools
```

エラー等が出ていなければ成功です。

### px4 起動方法

PX4-Autopilot　に移動し、以下のコマンドを実行します。

```
make px4_sitl none_iris
```

