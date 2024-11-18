# recipe-az-openai-public

Recipe to create an Azure OpenAI service within a resource group on Azure.

> Note: The OpenAI service has public access so it is not recommended for production environments.

# env vars

Environment variables used to configure the recipe.

Modify as per your requirement.

```bash
export TF_VAR_app='{ prefix="mrss", name = "", env="sbx", location_primary= "East US"}'
```