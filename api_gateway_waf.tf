
# resource "aws_wafv2_web_acl" "api_gateway_waf" {
#   name  = "api_gateway-${var.stage_name}"
#   scope = "REGIONAL"

#   default_action {
#     allow {}
#   }

#   rule {
#     name     = "Domain-Restriction"
#     priority = 0

#     action {
#       block {}
#     }

#     statement {


#       byte_match_statement {

#         positional_constraint = "EXACTLY"
#         search_string         = "https://${var.LISTING_URL}/"

#         field_to_match {
#           single_header {
#             name = "referer"
#           }
#         }

#         text_transformation {
#           priority = 0
#           type     = "NONE"
#         }

#       }


#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "api-waf-${var.stage_name}-log"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesCommonRuleSet"
#     priority = 1

#     override_action {
#       count {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesCommonRuleSet"
#         vendor_name = "AWS"
#         excluded_rule {
#           name = "SizeRestrictions_BODY"
#         }
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesCommonRuleSet"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
#     priority = 2

#     override_action {
#       count {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesKnownBadInputsRuleSet"
#         vendor_name = "AWS"
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesKnownBadInputsRuleSet"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesAnonymousIpList"
#     priority = 3

#     override_action {
#       count {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesAnonymousIpList"
#         vendor_name = "AWS"
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesAnonymousIpList"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesAmazonIpReputationList"
#     priority = 4

#     override_action {
#       count {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesAmazonIpReputationList"
#         vendor_name = "AWS"
#       }

#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesAmazonIpReputationList"
#       sampled_requests_enabled   = true
#     }
#   }

#   rule {
#     name     = "AWS-AWSManagedRulesSQLiRuleSet"
#     priority = 5

#     override_action {
#       count {}
#     }

#     statement {
#       managed_rule_group_statement {
#         name        = "AWSManagedRulesSQLiRuleSet"
#         vendor_name = "AWS"
#       }
#     }

#     visibility_config {
#       cloudwatch_metrics_enabled = true
#       metric_name                = "AWS-AWSManagedRulesSQLiRuleSet"
#       sampled_requests_enabled   = true
#     }
#   }

#   visibility_config {
#     cloudwatch_metrics_enabled = true
#     metric_name                = "auth-waf-${var.stage_name}-log"
#     sampled_requests_enabled   = true
#   }
# }

# resource "aws_wafv2_web_acl_association" "auth_waf" {
#   resource_arn = aws_api_gateway_stage.api_gateway_stg_main.arn
#   web_acl_arn  = aws_wafv2_web_acl.api_gateway_waf.arn
# }
