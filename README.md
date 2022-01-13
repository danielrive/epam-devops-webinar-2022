# epam-devops-webinar-2022
by Daniel Rivera

## General Information

This project deploys a few AWS resources to validate the Terraform-compliance framework, thre scenarios have been defined:

- **Tag validation:**  validate that the whole resources created with the terraform code have the following tags with the respective value:
    | tags | value |
    | Owner | DanielR |
    | Environment | develop |
- **S3 encryption validation:** validate if the s3 buckets created has encryption enabled using KMS
- **Secret Manager validation:** validate if the retention policy for secret manager is equal to 10.

## General Steps

There are general steps that you must follow to launch the resources.

Before launching a resource you need to have in mind  the following:

  - Install terraform, use Terraform v1.0.9, you can download it here 
     https://releases.hashicorp.com/terraform/1.0.9/
  - python
  - Install Terraform compliance framework, you can check the documentation here 
  https://terraform-compliance.com/pages/installation/
  - Configure the AWS credentials into your laptop(for Linux  ~/.aws/credentials), you need to use the following format:

            [PROFILE_NAME]
            aws_access_key_id = Replace_for_correct_Access_Key
            aws_secret_access_key = Replace_for_correct_Secret_Key

       If you have more AWS profiles feel free to add them.
  - Docker, you can check the documentation here
    https://docs.docker.com/engine/install/


## Usage

**1.** Clone the repository

**2.** Run terraform init command
```Terraform
 terraform init
```

**3.** run terraform plan 
 ```Terraform
 terraform plan -var region="SPECIFY_AN_AWS_REGION" -var profile_name="A_PROFILE_NAME_CREATE_STEP_BEFORE" -var environment="A_CUSTOME_NAME_FOR_ENV" -out=plan.out
```
**note** This command will create a file named plan.out that contains the plan for the resources to create.

**4.** Validate if the plan gather the compliance rules defined
```Terraform
terraform-compliance -f compliance/ -p plan.out
```