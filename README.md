README.md

KVM Nested Lab Environment with Rocky Linux

This project automates the creation and configuration of a nested KVM lab environment using Rocky Linux. The lab consists of three virtual machines (workstation, servera, and serverb) connected to a virtual network. It uses Packer, Terraform, and Ansible for provisioning and configuration.

Table of Contents

	1.	Overview
	2.	Prerequisites
	3.	Setup Workflow
	4.	Tools and Technologies
	5.	Steps to Provision the Lab
	6.	Lab Configuration
	7.	Usage
	8.	Project Structure

Overview

The lab environment automates the provisioning of three VMs:
	•	Workstation: A central machine to manage servera and serverb.
	•	Servera: Used for user and group management tasks.
	•	Serverb: Used for file management, networking, and process monitoring.

All VMs are configured to:
	•	Use Rocky Linux 9.2.
	•	Be part of the 192.168.122.0/24 subnet.

Prerequisites

	1.	KVM/QEMU installed on the host system.
	2.	Packer, Terraform, and Ansible installed:
	•	Packer: Install Guide
	•	Terraform: Install Guide
	•	Ansible: Install Guide
	3.	The host system should support nested virtualization.

Setup Workflow

	1.	Packer: Creates a base Rocky Linux QCOW2 image.
	2.	Terraform: Provisions VMs (workstation, servera, serverb) from the base image.
	3.	Ansible: Configures the VMs for lab tasks.

Tools and Technologies

	•	Packer: Automates the creation of a base image with pre-installed software.
	•	Terraform: Automates the provisioning of VMs on KVM.
	•	Ansible: Automates the configuration of VMs.

Steps to Provision the Lab

1. Clone the Repository

git clone <repository-url>
cd <repository-directory>

2. Create the Base Image with Packer

packer build packer-rocky-linux.json

This creates the base Rocky Linux image in output-rocky-linux/.

3. Configure the Terraform Variables

Edit the main.tf file to specify the path to the base image:

variable "base_image" {
  default = "/absolute/path/to/output-rocky-linux/rocky-linux-kvm-image.qcow2"
}

4. Deploy the Lab with Terraform

	1.	Initialize Terraform:

terraform init


	2.	Apply the Terraform configuration:

terraform apply


	3.	Confirm the VMs are created:
	•	Workstation: 192.168.122.100
	•	Servera: 192.168.122.101
	•	Serverb: 192.168.122.102

5. Configure VMs with Ansible

	1.	Update inventory.yml with the correct IPs:

all:
  hosts:
    workstation:
      ansible_host: 192.168.122.100
      ansible_user: root
    servera:
      ansible_host: 192.168.122.101
      ansible_user: root
    serverb:
      ansible_host: 192.168.122.102
      ansible_user: root


	2.	Run the playbooks:

ansible-playbook -i inventory.yml workstation.yml
ansible-playbook -i inventory.yml servera.yml
ansible-playbook -i inventory.yml serverb.yml

Lab Configuration

Network

	•	Subnet: 192.168.122.0/24
	•	NAT-based virtual network.

VMs

VM Name	Role	IP Address	RAM	CPU	Disk (QCOW2)
workstation	Management	192.168.122.100	1GB	1	10GB
servera	User Mgmt	192.168.122.101	1GB	1	10GB
serverb	File Mgmt	192.168.122.102	1GB	1	10GB

Usage

	1.	Connect to VMs via SSH:
From the KVM host, SSH into the VMs:

ssh root@192.168.122.100  # Workstation
ssh root@192.168.122.101  # Servera
ssh root@192.168.122.102  # Serverb


	2.	Run Grading Script:
Execute the grading script on the workstation:

./grade_lab.sh

Project Structure

.
├── packer-rocky-linux.json       # Packer configuration for Rocky Linux base image
├── output-rocky-linux/           # Directory for Packer's output image
├── main.tf                       # Terraform configuration
├── inventory.yml                 # Ansible inventory file
├── workstation.yml               # Ansible playbook for workstation setup
├── servera.yml                   # Ansible playbook for servera setup
├── serverb.yml                   # Ansible playbook for serverb setup
├── grade_lab.sh                  # Grading script for lab validation
└── README.md                     # Project documentation

Future Improvements

	•	Add more VM roles for advanced tasks.
	•	Integrate a CI/CD pipeline for automated testing of the lab environment.
	•	Add support for additional hypervisors or cloud providers.

Contributing

Contributions are welcome! Please fork the repository, create a feature branch, and submit a pull request.

License

This project is licensed under the MIT License.

Let me know if you need further adjustments!