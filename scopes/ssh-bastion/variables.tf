
variable "project_id" {
  description = "Project ID to apply and identify infrastructure code"
  type        = string
}

variable "gcp_region" {
  description = "Region the infrastructure should be deployed in"
  type        = string
  default     = "europe-west1"
}

variable "vpc_name" {
  description = "VPC Name"
  type        = string
  default     = "simple-autopilot-private-network"
}

variable "subnet_name" {
  description = "Subnet Name"
  type        = string
  default     = "simple-autopilot-private-subnet"
}


variable "ssh_pub" {
  description = "VPC ID"
  type        = string
  default     = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDD7/3NuwKwsZpNZUAq5tWDluX6KaLRq50W8CzWC83zzjS0wjswKUJRUZQy/RQRjQaOmtbnIh30buXGveUSV+pMkkTYLnZii7G3GmXnthDHRk3AhS+SirkhRwMCVeexRrQa+ezq0NVxxpAMGCChtWYO4EQ5ehjI858wnEai+fYm+imOsREt6QOPVbFMvOz1SytpHKG2d0De4+rC/hMToWZ5HED5Ib2o7CtgcdHyPESAYQmSMjt2ZMtOON3RqVdkQNRn+iETWEIDvvSfauDl2tGxUmomLTI8g4JnjGxWGfLTQ0zjXDeNuY4EameWXnZ9mxRJEo2iC5c1DyDPecO3JI4QCWw5sB6nAcaZjTnKi3n0t1Mz3rCUhrjCHCY+7QBVslri+XpB/RqXs359Qifv6CNGFz3JWI9KBr4CDapxF0DN71G9WsiH0HAXUasDmMjP4gVxnkhnED5xgndXWurVuhqIf0E/Q46rRCG1YpyN1exkEwaxC/V0i6zprFGrHymJ5Bs= lpt-workflow-automation@senacor.com"
}