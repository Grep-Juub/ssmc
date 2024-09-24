
# `ssmc` - AWS SSM Session Helper

## Overview

`ssmc` is a command-line utility that simplifies connecting to AWS EC2 instances using AWS Systems Manager (SSM). It allows you to quickly start an SSM session with an EC2 instance or set up a port forwarding session. The utility is optimized for performance with caching mechanisms to reduce delays and supports AWS Single Sign-On (SSO) configurations.

## Features

- **Interactive Instance Selection**: Use `fzf` to interactively select an instance from a list of running instances.
- **Port Forwarding**: Easily set up port forwarding to connect to services running on your instances.
- **Caching**: Caches instance details for faster repeated execution.
- **AWS Profile Validation**: Automatically checks for a valid AWS profile configuration.
- **SSO Support**: Works seamlessly with AWS SSO.

## Requirements

- [AWS CLI](https://aws.amazon.com/cli/)
- [fzf](https://github.com/junegunn/fzf)
- Properly configured AWS credentials/profile (supports SSO)

## Installation

1. **Install via the `install.sh` script**:
   ```bash
   bash -c "$(curl -fsSL https://raw.githubusercontent.com/Grep-Juub/ssmc/main/install.sh)"
   ```

   This will:
   - Download the `ssmc` binary and place it in `/usr/local/bin`.
   - Install `fzf` if not already installed.

2. **Verify Installation**:
   ```bash
   ssmc --help
   ```

## Usage

### Basic Usage

```bash
ssmc
```
This command will interactively prompt you to select a running instance from your AWS account.

### Start a Session with a Specific Instance

```bash
ssmc i-0123456789abcdef0
```
Directly start an SSM session with the specified instance ID.

### Port Forwarding

```bash
ssmc -f 8080:80
```
Select an instance interactively and set up port forwarding from your local port `8080` to the instance's port `80`.

### Start a Session with Port Forwarding

```bash
ssmc i-0123456789abcdef0 -f 8080:80
```
Start a session with the specified instance and set up port forwarding.

### Display Help

```bash
ssmc --help
```
or
```bash
ssmc -h
```

### Example AWS SSO Setup

If you’re using AWS SSO, you need to configure your profile using the following command:

```bash
aws configure sso
```

Follow the prompts to set up your AWS SSO session.

Once configured, you can switch between profiles using:

```bash
export AWS_PROFILE=my-sso-profile
```

Now, you can use `ssmc` with your SSO profile without any additional setup.

## How It Works

1. **Instance Selection**:
   - When you run `ssmc`, it fetches all running instances from AWS and presents them using `fzf` for easy selection.
   
2. **Port Forwarding**:
   - The `-f` or `--port-forward` option allows you to forward a local port to a remote port on the selected instance. This is useful for connecting to web servers, databases, etc., running on your EC2 instance.
   
3. **Caching**:
   - To improve performance, `ssmc` caches instance details for 60 seconds. This means repeated invocations within this time window will use cached data, speeding up the process. Cached data is stored in `/tmp/aws_instance_cache.txt`.
   - The cache automatically refreshes if it’s older than 60 seconds.

## Caching Details

The cache mechanism ensures that instance details are only fetched from AWS if they’re not already cached or if the cache has expired (default: 60 seconds). The cache is stored in a temporary file and is automatically refreshed.

### Manually Clearing the Cache

If you want to force a refresh, simply delete the cache file:

```bash
rm /tmp/aws_instance_cache.txt
```

## Performance Tips

- Since instance data is cached, subsequent `ssmc` calls are much faster.
- If you regularly use a large number of instances, the caching mechanism significantly reduces the delay in fetching instance data.

## Troubleshooting

- **No AWS Profile Found**:
  If you receive an error stating that no AWS profile is configured, ensure you've configured your AWS credentials using:
  ```bash
  aws configure
  ```
  or for SSO:
  ```bash
  aws configure sso
  ```

- **fzf Not Installed**:
  If `fzf` is not installed, the `install.sh` script will attempt to install it for you. You can also install it manually by following the instructions [here](https://github.com/junegunn/fzf).

## License

This project is licensed under the MIT License.

## Contributing

Feel free to submit issues or pull requests to improve `ssmc`.

