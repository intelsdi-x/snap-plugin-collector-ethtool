# Snap collector plugin - ethtool

This plugin uses ethtool to gather interface statistics. 																						Current version exposes stats available using ethtool given by below commands:
* `ethtool -S`, interface statistics
* `ethtool -d`, register dump
* `ethtool -m`, digital optical monitoring

It's used in the [Snap framework](http://github.com:intelsdi-x/snap).

1. [Getting Started](#getting-started)
  * [System Requirements](#system-requirements)
  * [Installation](#installation)
  * [Configuration and Usage](#configuration-and-usage)
2. [Documentation](#documentation)
  * [Collected Metrics](#collected-metrics)
  * [Examples](#examples)
  * [Roadmap](#roadmap)
3. [Community Support](#community-support)
4. [Contributing](#contributing)
5. [License](#license)
6. [Acknowledgements](#acknowledgements)

## Getting Started

The plugin is ready to use out of the box by following the system requirements. You don't have to perform any configuration or installation steps.

### System Requirements

* ethtool available under `$PATH` or `/sbin/`
* [golang 1.5+](https://golang.org/dl/) (needed only for building)
* Root privileges are required

### Operating systems
All OSs currently supported by plugin:
* Linux/amd64

## Installation
#### Download the plugin binary:

You can get the pre-built binaries for your OS and architecture from the plugin's [GitHub Releases](https://github.com/intelsdi-x/snap-plugin-collector-ethtool/releasess) page. Download the plugin from the latest release and load it into `snapd` (`/opt/snap/plugins` is the default location for snap packages).

#### To build the plugin binary:

Fork https://github.com/intelsdi-x/snap-plugin-collector-ethtool
Clone repo into `$GOPATH/src/github.com/intelsdi-x/`:

```
$ git clone https://github.com/<yourGithubID>/snap-plugin-collector-ethtool.git
```

Build the snap ethtool plugin by running make within the cloned repo:
```
$ make
```
This builds the plugin in `./build/`


## Documentation

You can learn about some of the exposed metrics [here](https://www.myricom.com/software/myri10ge/397-could-you-explain-the-meanings-of-the-myri10ge-counters-reported-in-the-output-of-ethtool.html).

### Collected Metrics
This plugin allows to collect interface network statistics such like received|transmitted bytes|packets and  more.                                                                                                    
List of metrics for each device is dependent on its driver.

This plugin has the ability to gather the following metrics (driver specific):
* [for driver E1000E](METRICS_E1000E.md)
* [for driver IXGBE](METRICS_IXGBE.md)
* [for driver FM10K](METRICS_FM10K.md)
* [for driver TG3](METRICS_TG3.md)


A few drivers such as IXGBE support exposing optical transceivers (SFP, SFP+, or XFP) information too. The information is known as [digital optical monitoring (DOM)] (METRICS_DOM.md#digital-optical-monitoring) information.

Metrics are available in namespace:
*	`/intel/net/<driver name>/<device name>/nic/<metric name>` (from cmd `ethtool -S`, interface statistics)
*	`/intel/net/<driver name>/<device name>/reg/<metric name>` (from cmd `ethtool -d`, register dump)
*	`/intel/net/<driver name>/<device name>/dom/<metric name>` (from cmd `ethtool -m`, digital optical monitoring)

### Examples

Example of running snap ethtool collector and writing data to file.

Ensure [snap daemon is running](https://github.com/intelsdi-x/snap#running-snap):
* initd: `service snap-telemetry start`
* systemd: `systemctl start snap-telemetry`
* command line: `snapd -l 1 -t 0 &`

Download and load snap plugins:
```
$ wget http://snap.ci.snap-telemetry.io/plugins/snap-plugin-collector-ethtool/latest/linux/x86_64/snap-plugin-collector-ethtool
$ wget http://snap.ci.snap-telemetry.io/plugins/snap-plugin-publisher-file/latest/linux/x86_64/snap-plugin-publisher-file
$ chmod 755 snap-plugin-*
$ snapctl plugin load snap-plugin-collector-ethtool
$ snapctl plugin load snap-plugin-publisher-file
```

See all available metrics:
```
$ snapctl metric list
```

Download an [example task file](https://github.com/intelsdi-x/snap-plugin-collector-ethtool/blob/master/examples/tasks/) and load it:
```
$ curl -sfLO https://raw.githubusercontent.com/intelsdi-x/snap-plugin-collector-ethtool/master/examples/tasks/ethtool-file.json
$ snapctl task create -t ethtool-file.json
Using task manifest to create task
Task created
ID: 480323af-15b0-4af8-a526-eb2ca6d8ae67
Name: Task-480323af-15b0-4af8-a526-eb2ca6d8ae67
State: Running
```

See realtime output from `snapctl task watch <task_id>` (CTRL+C to exit)
```
$ snapctl task watch 480323af-15b0-4af8-a526-eb2ca6d8ae67
```

This data is published to a file `/tmp/published_netstats` per task specification

Stop task:
```
$ snapctl task stop 480323af-15b0-4af8-a526-eb2ca6d8ae67
Task stopped:
ID: 480323af-15b0-4af8-a526-eb2ca6d8ae67
```

### Roadmap
As we launch this plugin, we have a few items in mind for the next release:

- [ x ] Metrics from device's registry dump when using IXGBE driver
- [ x ] Expose pluggable optics (SFP & SFP+) information

If you have a feature request, please add it as an [issue](https://github.com/intelsdi-x/snap-plugin-collector-ethtool/issues).

## Community Support
This repository is one of **many** plugins in **Snap**, a powerful telemetry framework. The full project is at http://github.com:intelsdi-x/snap.
To reach out on other use cases, visit [Slack](http://slack.snap-telemetry.io).

## Contributing
We love contributions!

There's more than one way to give back, from examples to blogs to code updates. See our recommended process in [CONTRIBUTING.md](CONTRIBUTING.md).

And **thank you!** Your contribution, through code and participation, is incredibly important to us.us.

## License
[Snap](http://github.com:intelsdi-x/snap), along with this plugin, is an Open Source software released under the Apache 2.0 [License](LICENSE).

## Acknowledgements

* Author: [Lukasz Mroz](https://github.com/lmroz)
* Co-author: [Izabella Raulin](https://github.com/IzabellaRaulin)
