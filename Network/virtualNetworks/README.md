This template deploys a VNET with Subnets and NSG Rules. Template also creates VNET Peering across subscriptions. 

Template uses updated Nested Template Deployment functionality which allows us to deploy to another resource group or another subscription. 

I have also used "Template" property object which allows us to specify nested template content within the master template. 
more info - https://docs.microsoft.com/en-us/azure/templates/microsoft.resources/deployments
