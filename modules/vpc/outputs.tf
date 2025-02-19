output vpcworkspace_id {  
    value = aws_vpc.workspaces_vpc.id
}

output "vpc_cidr_block_main" {
    value = aws_vpc.workspaces_vpc.cidr_block
}

#-------------------------------------------------------#

output "production_subnet"{
    value = [
        aws_subnet.workspaces_subnet_prod.id, 
    ]
}

output "vpc_cidr_block_prod"{
    value = var.vpc_cidr_block_prod
}

#-------------------------------------------------------#

output "test_subnet"{
    value = [
        aws_subnet.workspaces_subnet_test.id
    ]
}

output "vpc_cidr_block_test"{
    value = var.vpc_cidr_block_test
}