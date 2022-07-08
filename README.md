## TL;DR
```sh
docker build -t sendmail-sgx
docker-compose up -d
```
This starts the sendmail daemon inside a docker container. It will listen to incoming emails and deliver them.

<b>WARNING:</b> To make the sendmail daemon actually work for receiving emails you have to configure it properly. [This site](https://tldp.org/LDP/lame/LAME/linux-admin-made-easy/sendmail-upgrades.html) might help.

## What is Sendmail?

> Sendmail sends a message to one or more recipients, routing the message over whatever networks are necessary. Sendmail does internetwork forwarding as necessary to deliver the message to the correct place.

[Sendmail man page](https://linux.die.net/man/8/sendmail.sendmail)

Sendmail can be used to send emails directly via commandline or it can be run as a daemon for managing incoming remote emails.

> Intel Security Guard Extension (SGX) delivers advanced hardware and RAM security encryption features, so called enclaves, in order to isolate code and data that are specific to each application. When data and application code run in an enclave additional security, privacy and trust guarantees are given, making the container an ideal choice for (untrusted) cloud environments.

[Overview of Intel SGX](https://www.intel.com/content/www/us/en/developer/tools/software-guard-extensions/overview.html)

## Why run Sendmail in an enclave?
Benefits of running Sendmail-SGX:

* Sendmail-SGX provides effective protection against kernel-space exploits like Spektre/Meltdown, container escalations, insider attacks, Firmware Exploits and other "root" attacks.

* At any time, the daemon running in the container processing the data is protected thanks to hardware-based memory protection that comes with the Intel SGX technology. 

## Getting started
### Platform requirements
To run Sendmail-SGX your cpu has to support Intel SGX. Check the presence of <i>Intel Security Guard Extension (SGX)</i> by running
```sh
grep sgx /proc/cpuinfo
```
In addition to that your hardware must support FSGSBASE. 

### Software requirements
Install Docker by running 
```sh
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER    # manage docker as non-root user (obsolete as of docker 19.3) 
```
## Build the docker image
To build the docker image yourself you need to run 
```sh
docker build -t sendmail-sgx .
```

## Spin up the docker-compose
To spin up the docker-compose for sendmail-sgx run 
```
docker-compose up -d
```

## Check if the sendmail daemon is running
To test if the sendmail daemon runs and listens for emails, we have to enter the container and check the used ports. To do so you have to run 

```sh
docker exec -it sendmail-sgx /bin/bash
```
In the container you have to run 

```sh
netstat -tulpn | grep LISTEN
```
and check if the process `loader` listens to port 25 and 587. If it does, the daemon is running and listening for emails.

## Contributing
If you want to contribute to this project, follow these steps: <br>
1. Fork the project
2. Create your Feature Branch (git checkout -b feature/AmazingFeature)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## Support
If you want to support this project, feel free to give it a star and spread the word on social media, thanks!

## Licence
Distributed under the Apache License 2.0 License. See `LICENSE` for more information.

## Contact
info[at]thilovoss.de

## Acknowledgments
This project greatly celebrates all contributions from the open source community. 

* [Gramine Project](https://github.com/gramineproject)
* [Intel SGX](https://github.com/intel/linux-sgx-driver)