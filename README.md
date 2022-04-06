<div align="center">

<img src="https://camo.githubusercontent.com/5b298bf6b0596795602bd771c5bddbb963e83e0f/68747470733a2f2f692e696d6775722e636f6d2f7031527a586a512e706e67" align="center" width="144px" height="144px"/>

### My home operations repository :octocat:

_... managed with Ansible, Terraform and Flux_

</div>

<div align="center">

[![k3s](https://img.shields.io/badge/k3s-v1.23.4-brightgreen?style=for-the-badge&logo=kubernetes&logoColor=white)](https://k3s.io/)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white&style=for-the-badge)](https://github.com/pre-commit/pre-commit)

</div>

---

## 📖 Overview

This is a mono repository for my home infrastructure and Kubernetes cluster. I try to adhere to Infrastructure as Code (IaC) and GitOps practices using the tools like [Ansible](https://www.ansible.com/), [Terraform](https://www.terraform.io/), [Kubernetes](https://kubernetes.io/), [Flux](https://github.com/fluxcd/flux2), [Renovate](https://github.com/renovatebot/renovate) and [GitHub Actions](https://github.com/features/actions).

---

## ⛵ Kubernetes

There's an excellent template over at [k8s-at-home/template-cluster-k3s](https://github.com/k8s-at-home/template-cluster-k3s) if you wanted to try and follow along with some of the practices I use here.

### Installation

My cluster is [k3s](https://k3s.io/) provisioned overtop bare-metal Ubuntu 20.04 using the [Ansible](https://www.ansible.com/) galaxy role [ansible-role-k3s](https://github.com/PyratLabs/ansible-role-k3s). This is a semi hyper-converged cluster, workloads and block storage are sharing the same available resources on my nodes while I have a separate server for (NFS) file storage. I also use my Synology NAS with the [Synology CSI](https://github.com/SynologyOpenSource/synology-csi), which provisions iSCSI Volumes to some of my deployments.

🔸 _[Click here](./ansible/) to see my Ansible playbooks and roles._

### Core Components

- [mozilla/sops](https://toolkit.fluxcd.io/guides/mozilla-sops/): Manages secrets for Kubernetes
- [kubernetes/ingress-nginx](https://github.com/kubernetes/ingress-nginx/): Ingress controller to expose HTTP traffic to pods over DNS.
- [jetstack/cert-manager](https://cert-manager.io/docs/): Creates SSL certificates for services in my Kubernetes cluster.
- [cloudflare/cloudflared](https://github.com/cloudflare/cloudflared): Provides a secure network tunnel to expose some of my services to the internet.
- [kubernetes-sigs/external-dns](https://github.com/kubernetes-sigs/external-dns): Automatically manages DNS records from my cluster in a cloud DNS provider.

### GitOps

[Flux](https://github.com/fluxcd/flux2) watches my [cluster](./cluster/) folder (see Directories below) and makes the changes to my cluster based on the YAML manifests.

[Renovate](https://github.com/renovatebot/renovate) watches my **entire** repository looking for dependency updates, when they are found a PR is automatically created. When some PRs are merged [Flux](https://github.com/fluxcd/flux2) applies the changes to my cluster.

### Directories

The Git repository contains the following directories under [cluster](./cluster/) and are ordered below by how [Flux](https://github.com/fluxcd/flux2) will apply them.

- **base**: directory is the entrypoint to [Flux](https://github.com/fluxcd/flux2).
- **crds**: directory contains custom resource definitions (CRDs) that need to exist globally in your cluster before anything else exists.
- **core**: directory (depends on **crds**) are important infrastructure applications (grouped by namespace) that should never be pruned by [Flux](https://github.com/fluxcd/flux2).
- **apps**: directory (depends on **core**) is where your common applications (grouped by namespace) could be placed, [Flux](https://github.com/fluxcd/flux2) will prune resources here if they are not tracked by Git anymore.

---

## 🔧 Hardware

| Device                    | Hostname          | Disk Size    | Ram  | Operating System      | Purpose                              |
|---------------------------|-------------------|--------------|------|-----------------------|--------------------------------------|
| Lenovo Thinkcentre M72e   | dca-k3s-server-01 | 120GB        | 8GB  | Ubuntu Server 20.04.4 | Kubernetes Control Plane,etcd,worker |
| Lenovo Thinkcentre M72e   | dca-k3s-server-02 | 120GB        | 8GB  | Ubuntu Server 20.04.4 | Kubernetes Control Plane,etcd,worker |
| Lenovo Thinkcentre M72e   | dca-k3s-server-03 | 120GB        | 8GB  | Ubuntu Server 20.04.4 | Kubernetes Control Plane,etcd,worker |
| Lenovo Thinkcentre M72e   | dca-k3s-server-04 | 120GB        | 8GB  | Ubuntu Server 20.04.4 | Kubernetes Control Plane,etcd,worker |
| Synology DS418 Play       | dca-nas-server-01 | 32TB         | 4GB  | N/A                   | NAS                                  |

---
