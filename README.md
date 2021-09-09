# Vimcar-Infrastructure-Challenge by Carlos Montesinos Estrada

In this repo we will find all the needed files to assolite the desired goal settled by this challenge. The main focus has been to keep a modular dessign and create a reusuble infrastracture for future projects, as we will see this can be heavely increase in the future with the usuage of a couple of different suggestions.

For the continous deployment pipeline I've used github_actions since it could be easely integrated with the repository and enabled me an extra tool for the automazition and management of the infrastructure. Not only gave me a centralized resource for my control management and pipelines, but also a secret management tool, this way i have kept the infrastructure repo free of any  need of hardcoding-credentials.

On the IaaC resource I felt more inclined towards Terraform since it enables you a fast an reliable way to manage your infrastructure on different workspaces and environments depending on your life-cycle , and also , keeps you agnostic to the cloud provider in case of a future migration.

## The Solution

The approach towards this solution has been as minimal as possible on the resource usage and alocation, more focused on try to show a good approach to this kind of situation/necessity.

The structure is defined between 3 major sections: files, modules and main:

- files : The source-code for the lambdas and the configuration needed for the json check. In this space is where all the "static" files/configurations should be, to be retrieved by the modules
- main: Central section of the terraform , where all the different modules are being called, the idea is to keep it only for high-level operations (enviornment definitons, workspaces, etc.)
- modules: The bread and butter of this project; here all the different services are being called and define with the differentent relationships between them.


## How-to
In order to execute this repository you would only need to follow two steps:

1. Go to Settings -> Secrets, and change the two variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY for the key_id and secret_access_key of the user you choose for this task (Note, the user should have enough permissions to manage the desired infrastructure , since this will be the user we will use for the terraform)
2. Launch a commit, and that's it !. In the .github/workflows you will find the terraform action configuration, here we have all the different definitions and steps that checks before launching the apply.

Of course all this logic can be re-used for future scenarios keeping a consistent work logic

## Future Improvements 

Of course this is a first stage and only a challenge, for a full production environment a couple of things should be considered to addopt:

- Environments control: This solution does not take into consideration stages of development, such as dev , int or such. A proper solution should be settled around those principles with different considerations for each and every one. For this porpuse I would propouse a tool called [Terragrunt](https://terragrunt.gruntwork.io/ "Terragrunt") which would enable us to keep our terraform code dry and reusable for differente applications and environments.
- Secret management: With only two secrets and the scope of this exercise , Github was more than enough, but if this should be take into consideration for future environments , a great tool to keep secrets would be [Vault](hhttps://www.vaultproject.io/ttp:// "Vault")
- Observiability: The terraform cloudwatch dashboard definitions still needs to be improved, and it could show insufficient for a proper solution in the future, for that there are projects like [Prometheus with Grafana](https://prometheus.io/docs/visualization/grafana/ "Prometheus with Grafana")that could provide us an autonomiy and configuration beyond of the scope of the managed service.

## Conclusions

It has been a fun challenge, I tried to show the principles regarding the infrastructure definition, that I like to follow and share  I would be more than happy to discuss with you any doubts that you have regarding this challenge and really hope to hear from you soon!
