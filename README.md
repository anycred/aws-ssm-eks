# aws-ssm-eks docker action

This action connects to eks with private endpoint using ssm session on bastion server

## Prerequisites

```yaml
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "ssm",
            "Effect": "Allow",
            "Action": [
                "ssm:StartSession",
                "ssm:TerminateSession"
            ],
            "Resource": "*"
        },
        {
            "Sid": "eks",
            "Effect": "Allow",
            "Action": [
                "eks:DescribeCluster",
                "eks:ListClusters"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ec2",
            "Effect": "Allow",
            "Action": [
               "ec2:DescribeInstances",
               "ec2:DescribeTags"
            ],
            "Resource": "*"
       }
    ]
}
```

## Inputs

| Input                 | Description | Default |
|-----------------------| ----------- | ------- |
| CLUSTER_NAME          | The name of eks cluster. | **Required** |
| BASTION_NAME          | The bastion instance name | **Required** or BASTION_ID |
| BASTION_ID            | The bastion instance id | **Required** or BASTION_NAME |
| AWS_ACCESS_KEY_ID     |  | None |
| AWS_SECRET_ACCESS_KEY |  | None |
| AWS_REGION            |  | None |
| SSM_PORT              | SSM local port | None |
| kubectl_cmd           |The arguments that you want to pass through to the kubectl command| |
| run                   | Bash script commands to run on cluster| |

## Outputs

## `cmd output`

The kubectl command / run  output.

## Example usage
```yaml
  - name: Configure AWS credentials
    uses: aws-actions/configure-aws-credentials@67fbcbb121271f7775d2e7715933280b06314838 # v1.7.0
    with:
      aws-access-key-id: ${{ secrets.AWS_ACCESS_KEY_ID }}
      aws-secret-access-key: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      aws-region: ${{ env.region }}

  - name: List pods
    uses: gkirok/aws-ssm-eks@9c037ac58f2ac4ddfdc5d13333e98b0ff4f2e54d # v2
    env:
      CLUSTER_NAME: "my-cluster"
      BASTION_NAME: "my-bastion"
      kubectl_cmd: "get pods -A"
```
### Set BASTION_ID
```yaml
  - name: List pods
    uses: gkirok/aws-ssm-eks@9c037ac58f2ac4ddfdc5d13333e98b0ff4f2e54d # v2
    env:
      AWS_ACCESS_KEY_ID: ${{ secrets.AWS_ACCESS_KEY_ID }}
      AWS_SECRET_ACCESS_KEY: ${{ secrets.AWS_SECRET_ACCESS_KEY }}
      AWS_REGION: ${{ secrets.AWS_REGION }}
      CLUSTER_NAME: my-cluster
      BASTION_ID: id-98h3tboagua94gboa
      SSM_PORT: 8443
      kubectl_cmd: "get pods -A"
```

### Upload to GitHub Container Registry
1. [Login to GHCR](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry)
2. docker push ghcr.io/anycred/aws-ssm-eks:latest
3. See it [here](https://github.com/orgs/anycred/packages/container/package/aws-ssm-eks)
