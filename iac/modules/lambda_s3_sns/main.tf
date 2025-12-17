# Criação do Bucket S3
resource "aws_s3_bucket" "bucket_s3" {
  bucket = var.bucket_name

  force_destroy = true

  tags = merge(var.tags, {
    name = "tf-bucket"
  })
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  bucket = aws_s3_bucket.bucket_s3.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Criação da "pasta" lambda dentro do bucket
resource "aws_s3_object" "lambda_folder" {
  bucket = aws_s3_bucket.bucket_s3.bucket
  key    = "lambda/"

}

# Criação da "pasta" report dentro do bucket
resource "aws_s3_object" "report_folder" {
  bucket = aws_s3_bucket.bucket_s3.bucket
  key    = "report/"

}
# Zipando arquivo python delete ebs
data "archive_file" "delete_ebs_zip" {
  type        = "zip"
  source_file = var.delete_ebs_python_path
  output_path = var.delete_ebs_zip_path
}

data "archive_file" "estimate_ebs_zip" {
  type        = "zip"
  source_file = var.estimate_ebs_python_path
  output_path = var.estimate_ebs_zip_path
}

# Upload dos scripts Python para a pasta "lambda" no Bucket S3
resource "aws_s3_object" "delete_ebs_file" {
  bucket = aws_s3_bucket.bucket_s3.id
  key    = "lambda/${var.delete_ebs_zip_name}"
  source = var.delete_ebs_zip_path
  etag   = filemd5(var.delete_ebs_zip_path)

  depends_on = [aws_s3_object.lambda_folder]
}

resource "aws_s3_object" "estimate_ebs_file" {
  bucket = aws_s3_bucket.bucket_s3.id
  key    = "lambda/${var.estimate_ebs_zip_name}"
  source = var.estimate_ebs_zip_path
  etag   = filemd5(var.estimate_ebs_zip_path)

  depends_on = [aws_s3_object.lambda_folder]
}

# Criação do topico SNS
resource "aws_sns_topic" "sns_topic" {
  name = var.sns_topic_name

  tags = merge(var.tags, {
    name = "tf-sns-topic"
  })
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "email"
  endpoint  = var.sns_email_endpoint
}

# Criação da Role IAM para a função Lambda
resource "aws_iam_role" "iam_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      },
    ]
  })

  tags = merge(var.tags, {
    name = "tf-role"
  })
}

#Criação da Policy IAM
resource "aws_iam_role_policy" "iam_role_policy" {
  name = var.iam_role_policy_name
  role = aws_iam_role.iam_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = "iam:ListAccountAliases",
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:*"
      },
      {
        Action = [
          "ec2:DescribeVolumes",
          "ec2:DescribeVolumeAttribute",
          "ec2:DescribeVolumeStatus",
          "ec2:DescribeTags",
          "ec2:DescribeInstances",
          "ec2:DeleteVolume",
        ],
        Effect   = "Allow",
        Resource = "*"
      },
      {
        Action = [
          "s3:ListBucket",
          "s3:PutObject",
          "s3:GetObject",
        ],
        Effect = "Allow",
        Resource = [aws_s3_bucket.bucket_s3.arn,
          "${aws_s3_bucket.bucket_s3.arn}/*"
        ]
      },
      {
        Action = [
          "sns:Publish"
        ],
        Effect   = "Allow",
        Resource = aws_sns_topic.sns_topic.arn
      },
      {
        Action = [
          "ce:GetCostAndUsage",
          "ce:GetCostAndUsageWithResources",
        ],
        Effect   = "Allow",
        Resource = "*"
      }
    ]
  })
}

data "aws_ecr_repository" "repo_ecr" {
  name = var.ecr_repository_name
}


# Criação das Funções Lambdas
resource "aws_lambda_function" "delete_ebs_function" {
  function_name = "${var.lambda_delete_ebs_function}-${var.environment}"
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout
  role          = aws_iam_role.iam_role.arn
  package_type  = "Image"
  image_uri    = "${data.aws_ecr_repository.repo_ecr.repository_url}:${var.container_image_tag}"

  # Criando variaveis de ambiente que vão ser usadas pelo codigo python também
  environment {
    variables = {
      TARGET_BUCKET_S3 = aws_s3_bucket.bucket_s3.id
      SNS_TOPIC_ARN    = aws_sns_topic.sns_topic.arn
      TARGET_REGIONS   = jsonencode(var.regions)
    }
  }

  tags = merge(var.tags, {
    name = "tf-lambda"
  })

  depends_on = [
    aws_sns_topic.sns_topic
  ]
}

resource "aws_cloudwatch_event_rule" "daily_trigger" {
  name                = "daily_trigger"
  description         = "Executa a Lambda diariamente"
  schedule_expression = "cron(0 8 * * ? *)" # Executa todo dia às 10:00 UTC (07:00 BRT)
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.daily_trigger.name
  target_id = "lambdaTarget"
  arn       = aws_lambda_function.delete_ebs_function.arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.delete_ebs_function.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.daily_trigger.arn
}


resource "aws_lambda_function" "estimate_ebs_function" {
  function_name = var.lambda_estimate_ebs_function
  runtime       = var.lambda_runtime
  handler       = var.estimate_ebs_handler
  memory_size   = var.lambda_memory_size
  timeout       = var.lambda_timeout
  role          = aws_iam_role.iam_role.arn
  s3_bucket     = aws_s3_bucket.bucket_s3.id
  s3_key        = aws_s3_object.estimate_ebs_file.key

  # Criando variaveis de ambiente que vão ser usadas pelo codigo python também
  environment {
    variables = {
      TARGET_BUCKET_S3        = aws_s3_bucket.bucket_s3.id
      TARGET_BUCKET_S3_FOLDER = "report/"
    }
  }

  tags = merge(var.tags, {
    name = "tf-lambda"
  })

  depends_on = [aws_s3_object.estimate_ebs_file]
}

resource "aws_lambda_permission" "allow_s3_to_invoke_lambda" {
  statement_id  = "AllowS3InvokeLambda"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.estimate_ebs_function.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.bucket_s3.arn
}

# Isso configura o bucket para enviar eventos para a Lambda
resource "aws_s3_bucket_notification" "s3_to_lambda_notification" {
  bucket = aws_s3_bucket.bucket_s3.id

  lambda_function {
    lambda_function_arn = aws_lambda_function.estimate_ebs_function.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "report/"
    filter_suffix       = ".csv"
  }

  # Depende da permissão ser criada antes da notificação
  depends_on = [aws_lambda_permission.allow_s3_to_invoke_lambda]
}

data "aws_region" "current" {}
data "aws_caller_identity" "current" {}

## Removendo os arquivos zips criados
resource "null_resource" "remove_zip_files" {
  provisioner "local-exec" {
    # Comando utilizado no Linux ou MacOS para remoção dos zips
    command = "rm -f ${data.archive_file.delete_ebs_zip.output_path} ${data.archive_file.estimate_ebs_zip.output_path}"

    # Comando utilizado no Windows, para remoção dos zips:
    # command = "del ${data.archive_file.delete_ebs_zip.output_path} ${data.archive_file.estimate_ebs_zip.output_path}"
  }

  depends_on = [
    aws_s3_object.delete_ebs_file,
    aws_s3_object.estimate_ebs_file
  ]
}