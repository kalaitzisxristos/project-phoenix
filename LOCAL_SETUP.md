# Local Development Setup Guide

This guide provides step-by-step instructions to set up a complete, production-grade local development environment for Project Phoenix on a **Windows machine using Docker Desktop and Git Bash**.

## Prerequisites

* **Docker Desktop**: Ensure Docker Desktop is installed and running.
* **Git Bash**: All commands should be run from a Git Bash terminal.

---

## Step 1: Install Command-Line Tools

We will manually download the required tools into a dedicated folder and add that folder to the Windows System PATH.

1.  **Create a Tools Directory**
    In Git Bash, run the following command to create a folder at `C:\personal\bin`.
    ```bash
    mkdir -p /c/personal/bin
    ```

2.  **Add the Directory to the Windows PATH**
    * Press the **Windows Key** on your keyboard.
    * Type `Edit the system environment variables` and press Enter.
    * Click the **Environment Variables...** button.
    * In the "System variables" section, find and select the variable named **`Path`**, then click **Edit...**.
    * Click **New** and enter the path: `C:\personal\bin`
    * Click **OK** on all windows to save the changes.

3.  **Download the Tools**
    **Open a new Git Bash terminal** for the PATH changes to take effect. Run the following commands to download `kubectl`, `kind`, and `helm`.

    * **Download `kubectl`:**
        ```bash
        curl -o /c/personal/bin/kubectl.exe -L "[https://dl.k8s.io/release/$(curl](https://dl.k8s.io/release/$(curl) -L -s [https://dl.k8s.io/release/stable.txt)/bin/windows/amd64/kubectl.exe](https://dl.k8s.io/release/stable.txt)/bin/windows/amd64/kubectl.exe)"
        ```
    * **Download `kind`:**
        ```bash
        curl -o /c/personal/bin/kind.exe -L [https://kind.sigs.k8s.io/dl/v0.29.0/kind-windows-amd64](https://kind.sigs.k8s.io/dl/v0.29.0/kind-windows-amd64)
        ```
    * **Download and Extract `helm`:**
        ```bash
        # Download the ZIP file to your home directory
        curl -o ~/helm.zip -L [https://get.helm.sh/helm-v3.15.2-windows-amd64.zip](https://get.helm.sh/helm-v3.15.2-windows-amd64.zip)

        # Manually extract the ZIP file using Windows Explorer
        # Then, move helm.exe from the extracted 'windows-amd64' folder to your bin folder
        mv ~/windows-amd64/helm.exe /c/personal/bin/

        # Clean up the temporary files
        rm ~/helm.zip
        rm -r ~/windows-amd64
        ```

4.  **Verify the Installation**
    In your new terminal, run the following commands to ensure all tools are working correctly:
    ```bash
    kubectl version --client
    helm version
    kind version
    ```

---

## Step 2: Create the Local Kubernetes Cluster

1.  **Create the Cluster Configuration File** at `infra/clusters/kind-config.yaml` with the following content:
    ```yaml
    kind: Cluster
    apiVersion: kind.x-k8s.io/v1alpha4
    name: phoenix-cluster
    nodes:
    - role: control-plane
      kubeadmConfigPatches:
      - |
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
      extraPortMappings:
      - containerPort: 80
        hostPort: 8088
        protocol: TCP
      - containerPort: 443
        hostPort: 8443
        protocol: TCP
    - role: worker
    - role: worker
    ```

2.  **Run the Creation Command** from the root of the project directory (`/c/personal/project-phoenix`):
    ```bash
    kind create cluster --config infra/clusters/kind-config.yaml
    ```