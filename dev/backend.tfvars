/*
backend_rg_name        = "deloitte-devops-rg-01"
backend_storage_name   = "deloittedevopsstorage01"
backend_container_name = "deloittedevopsstoragecontainer01"
backend_key            = "deloittecasefuncdev.terraform.tfstate"

resource_group_name  = "${var.backend_rg_name}"
storage_account_name = "${var.backend_storage_name}"
container_name       = "${var.backend_container_name}"
key                  = "${var.backend_key}"
*/


resource_group_name  = "deloitte-devops-rg-01"
storage_account_name = "deloittedevopsstorage01"
container_name       = "deloittedevopsstoragecontainer01"
key                  = "deloittecasefuncdev.terraform.tfstate"