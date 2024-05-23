# Icinga Summit 2024

## Setup

The practical exercises are divided into two sections. The first can be followed with an x86_64 virtual machine with 2 GB RAM (Debian, Ubuntu or Enterprise Linux) with an installed Puppet agent. The second section requires a Puppet server with PuppetDB running and two or three x86_64 VMs (Debian, Ubuntu or Enterprise Linux) one with 2 GB RAM, 512MB is sufficient for the others. All VMs require a Puppet agents communicating with the Puppet server. In addition, communication between the VMs must not be restricted.

At the top below the puppetserver directory there is a docker compose file for the required Puppetserver, PuppetDB and Postgresql database. Required main memory about 4 GB.

For all VMs the port 80 has to be available or forworded.
