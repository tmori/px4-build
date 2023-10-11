# px4-build

PX4のシミュレータを単独で起動できる環境を docker でまとめています。

## 事前準備

本リポジトリーをクローンします。

```
 git clone --recursive git@github.com:tmori/px4-build.git
```

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

## docker コンテナ起動方法

```
bash docker/run.bash
```

成功すると、こうなります。

```
% bash docker/run.bash 
arm64
Darwin
root@docker-desktop:~/workspace#

root@docker-desktop:~/workspace# ls
LICENSE  PX4-Autopilot  README.md  docker
```

## ビルド方法

```
cd PX4-Autopilot
```

ubuntu向けのセットアップをします。

```
./Tools/setup/ubuntu.sh 
```

なぜか、以下のエラーログが出てきますが、シミュレータ向けなので、多分影響ないと思われます。。

```
Installing NuttX dependencies
Reading package lists...
Building dependency tree...
Reading state information...
Package gcc-multilib is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source

E: Unable to locate package g++-multilib
E: Couldn't find any package by regex 'g++-multilib'
E: Package 'gcc-multilib' has no installation candidate
```

ビルドします。

```
make px4_sitl_default
```

## px4 起動方法

docker コンテナを起動し、PX4-Autopilot　に移動し、以下のコマンドを実行します。

```
./build/px4_sitl_default/bin/px4
```

成功すると、以下のログが出力されます。

```
root@docker-desktop:~/workspace/PX4-Autopilot# ./build/px4_sitl_default/bin/px4

______  __   __    ___ 
| ___ \ \ \ / /   /   |
| |_/ /  \ V /   / /| |
|  __/   /   \  / /_| |
| |     / /^\ \ \___  |
\_|     \/   \/     |_/

px4 starting.

INFO  [px4] startup script: /bin/sh etc/init.d-posix/rcS 0
INFO  [param] selected parameter default file parameters.bson
INFO  [param] selected parameter backup file parameters_backup.bson
INFO  [dataman] data manager file './dataman' size is 7866640 bytes
INFO  [init] SIH simulator
INFO  [simulator_sih] Simulation loop with 250 Hz (4000 us sim time interval)
INFO  [simulator_sih] Simulation with 1.0x speedup. Loop with (4000 us wall time interval)
INFO  [lockstep_scheduler] setting initial absolute time to 4000 us
INFO  [commander] LED: open /dev/led0 failed (22)
No autostart ID found
INFO  [mavlink] mode: Normal, data rate: 4000000 B/s on udp port 18570 remote port 14550
INFO  [mavlink] mode: Onboard, data rate: 4000000 B/s on udp port 14580 remote port 14540
INFO  [mavlink] mode: Onboard, data rate: 4000 B/s on udp port 14280 remote port 14030
INFO  [mavlink] mode: Gimbal, data rate: 400000 B/s on udp port 13030 remote port 13280
INFO  [logger] logger started (mode=all)
INFO  [logger] Start file log (type: full)
INFO  [logger] [logger] ./log/2023-10-11/04_09_27.ulg
INFO  [logger] Opened full log file: ./log/2023-10-11/04_09_27.ulg
INFO  [mavlink] MAVLink only on localhost (set param MAV_{i}_BROADCAST = 1 to enable network)
INFO  [mavlink] MAVLink only on localhost (set param MAV_{i}_BROADCAST = 1 to enable network)
INFO  [px4] Startup script returned successfully
```

このあと、以下の警告メッセージが出てきますが、シミュレータ単独で起動しているためと思われます（調査中）

```
ARN  [health_and_arming_checks] Preflight Fail: Accel 0 uncalibrated
WARN  [health_and_arming_checks] Preflight Fail: barometer 0 missing
WARN  [health_and_arming_checks] Preflight Fail: Gyro 0 uncalibrated
WARN  [health_and_arming_checks] Preflight Fail: Compass Sensor 0 missing
WARN  [health_and_arming_checks] Preflight Fail: Accel 0 uncalibrated
WARN  [health_and_arming_checks] Preflight Fail: barometer 0 missing
WARN  [health_and_arming_checks] Preflight Fail: Gyro 0 uncalibrated
WARN  [health_and_arming_checks] Preflight Fail: Compass Sensor 0 missing
```
