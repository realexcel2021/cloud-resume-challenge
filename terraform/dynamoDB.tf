resource "aws_dynamodb_table" "veiw_count_table" {
    name = "veiw_count_terraform"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "id"

    attribute {
      name = "id"
      type = "S"
    }
}

resource "aws_dynamodb_table_item" "veiw_table_item" {
    table_name = aws_dynamodb_table.veiw_count_table.name
    hash_key = aws_dynamodb_table.veiw_count_table.hash_key
    item = <<ITEM
    {
        "id" : { "S": "0" },
        "veiw_count": { "N": "1" }
    }
    ITEM
}