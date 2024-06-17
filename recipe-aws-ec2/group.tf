resource "aws_resourcegroups_group" "test" {
    name = "test-group"
    resource_query {
      query = <<JSON
      {
        "ResourceTypeFilters": ["AWS::AllSupported"],
        "TagFilters": [
          {
            "Key": "App",
            "Values": ["${var.app.name}"]
          }
        ]
      }
      JSON
    }
}
