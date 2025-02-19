import json
import boto3
import os

workspaces_client = boto3.client("workspaces")


def lambda_handler(event, context):
    try:
        response = client.describe_workspaces(
        WorkspaceIds=[
        'string',
    ],
    DirectoryId='string',
    UserName='string',
    BundleId='string',
    Limit=123,
    NextToken='string',
    WorkspaceName='string'
)